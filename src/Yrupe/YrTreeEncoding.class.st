"
I implement an encoding for arbitrary objects which may point to other objects, so I do apply recursion into other encodings.
"
Class {
	#name : #YrTreeEncoding,
	#superclass : #YrEncoding,
	#category : #'Yrupe-Encodings'
}

{ #category : #accessing }
YrTreeEncoding class >> id [

	^ 'tree'
]

{ #category : #testing }
YrTreeEncoding class >> isAbstract [

	^ false
]

{ #category : #private }
YrTreeEncoding >> classNamed: aString [

	^ self class environment at: aString asSymbol
]

{ #category : #reading }
YrTreeEncoding >> read: anObject on: aReader [

	| theClass keysAndValues aLGitTree |
	theClass := nil.
	keysAndValues := SmallDictionary new.
	
	aLGitTree := aReader readAsTree: anObject childrenDo: [ :filename :child |
		filename = '@.string'
			ifTrue: [ 
				theClass := self classNamed: (aReader read: child with: YrStringEncoding new) ]
			ifFalse: [ 
				| fileBasename extension encoding |
				extension := filename copyAfterLast: $..
				fileBasename := filename copyUpToLast: $..

				encoding := YrEncoding encodingFor: extension.
				
				keysAndValues 
					at: fileBasename yrupeFileBasenameDecoded
					put: (aReader read: child with: encoding) ].
		 ].
	
	theClass ifNil: [ self error: 'Should declare class in @.string' ].
	
	^ theClass yrupeNewFromKeysAndValues: keysAndValues
]

{ #category : #writing }
YrTreeEncoding >> write: anObject at: basename on: aWriter [

	^ aWriter 
		at: (self filenameFor: basename)
		writeAsTree: [ :nestedWriter |
			nestedWriter
				write: anObject className
				with: YrStringEncoding new
				at: #@.

			anObject yrupeKeysAndValuesDo: [ :nestedBasename :value |
				nestedWriter
					write: value
					with: (anObject yrupeEncoderFor: nestedBasename)
					at: nestedBasename ] 
			]

]
