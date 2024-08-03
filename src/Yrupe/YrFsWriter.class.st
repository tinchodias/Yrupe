Class {
	#name : #YrFsWriter,
	#superclass : #YrWriter,
	#instVars : [
		'treeBuilder',
		'fileReference'
	],
	#category : #'Yrupe-ReadWrite'
}

{ #category : #'instance creation' }
YrFsWriter class >> new [

	^ self shouldNotImplement "use #newWithRepository:"
]

{ #category : #'instance creation' }
YrFsWriter class >> newWithFileReference: aFileReference [

	^ self basicNew
		initializeWithFileReference: aFileReference;
		yourself
]

{ #category : #writing }
YrFsWriter >> at: filename writeAsLeaf: aString [

	^ (fileReference / filename) 
			binaryWriteStreamDo: [ :stream | 
				stream nextPutAll: aString ];
			yourself
]

{ #category : #writing }
YrFsWriter >> at: filename writeAsTree: aBlock [

	| nestedWriter |
	nestedWriter := self species newWithFileReference: (fileReference / filename).

	aBlock value: nestedWriter.	

	^ nestedWriter newTree
]

{ #category : #initialization }
YrFsWriter >> initializeWithFileReference: aFileReference [

	self initialize.
	
	fileReference := aFileReference.
	fileReference ensureCreateDirectory.
]

{ #category : #writing }
YrFsWriter >> newTree [

	^ fileReference 
]
