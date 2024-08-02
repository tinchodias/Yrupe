Class {
	#name : #YrGitWriter,
	#superclass : #YrWriter,
	#instVars : [
		'repository',
		'treeBuilder'
	],
	#category : #'Yrupe-ReadWrite'
}

{ #category : #'instance creation' }
YrGitWriter class >> new [

	^ self shouldNotImplement "use #newWithRepository:"
]

{ #category : #'instance creation' }
YrGitWriter class >> newWithRepository: gitRepository [ 

	^ self basicNew
		initializeWithRepository: gitRepository
		yourself
]

{ #category : #private }
YrGitWriter >> at: aFileName write: aLGitObject [ 

	^ self treeBuilder 
		addEntry: aLGitObject
		filename: aFileName
]

{ #category : #writing }
YrGitWriter >> at: filename writeAsLeaf: aString [

	| newBlob |
	self assert: aString isByteString.

	newBlob := LGitBlob of: repository fromString: aString.

	self at: filename write: newBlob.
		
	^ newBlob
]

{ #category : #writing }
YrGitWriter >> at: filename writeAsTree: aBlock [

	| nestedWriter newTree |
	nestedWriter := self species newWithRepository: repository.

	aBlock value: nestedWriter.	

	newTree := nestedWriter newTree.
		
	self at: filename write: newTree.
		
	^ newTree
]

{ #category : #initialization }
YrGitWriter >> initializeWithRepository: gitRepository [

	self initialize.
	
	repository := gitRepository.

]

{ #category : #writing }
YrGitWriter >> newTree [

	^ self treeBuilder newTree
]

{ #category : #private }
YrGitWriter >> treeBuilder [
	
	^ treeBuilder ifNil: [
		treeBuilder := LGitTreeBuilder of: repository.
		treeBuilder 
			createNew;
			yourself ].

]

{ #category : #writing }
YrGitWriter >> write: anObject with: aYrEncoding at: basename [

	| cache |
	cache := YrWriteCache defaultAtEncodingClass: aYrEncoding class.

	self flag: #fix. "Ugly code"
	
	^ cache 
		at: anObject
		ifPresent: [ :hexString |
			| gitObject |
			gitObject := [ repository revparse: hexString ]
				on: Error
				do: [ self error: 'Run again after a "YrWriteCache reset".' ].
			self 
				at: (aYrEncoding filenameFor: basename) 
				write: gitObject 
			]
		ifAbsent: [ 
			| result |
			result := 
				aYrEncoding
					write: anObject 
					at: basename 
					on: self.
				
			cache
				at: anObject
				put: result id hexString.
				
			result ]

]
