"
I am an abstract encoding for objects. My subclasses implement APIfor writing and reading to/from ByteStrings.
"
Class {
	#name : #YrEncoding,
	#superclass : #Object,
	#category : #'Yrupe-Encodings'
}

{ #category : #accessing }
YrEncoding class >> encodingFor: id [

	self flag: #todo. "FIX: cache"

	self allSubclassesDo: [ :each | 
		(each isAbstract not and: [ each id = id ])
			ifTrue: [ ^ each new ] ].

	self error: 'invalid id'
]

{ #category : #accessing }
YrEncoding class >> encodingForFilePath: aFilePath [ 

	^ self encodingFor: (aFilePath copyAfterLast: $.)
]

{ #category : #accessing }
YrEncoding class >> id [

	^ self subclassResponsibility 
]

{ #category : #testing }
YrEncoding class >> isAbstract [

	^ true
]

{ #category : #convenience }
YrEncoding >> filenameFor: basename [

	^ basename yrupeFileBasenameEncoded, '.', self class id
]

{ #category : #reading }
YrEncoding >> read: anObject on: aReader [

	^ self subclassResponsibility 
]

{ #category : #writing }
YrEncoding >> write: anObject at: basename on: aWriter [

	^ self subclassResponsibility 
]
