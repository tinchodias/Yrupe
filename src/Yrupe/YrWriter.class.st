"
I am an abstract Yrupe writer.
"
Class {
	#name : #YrWriter,
	#superclass : #Object,
	#category : #'Yrupe-ReadWrite'
}

{ #category : #writing }
YrWriter >> at: filename writeAsLeaf: aString [

	^ self subclassResponsibility
]

{ #category : #writing }
YrWriter >> at: filename writeAsTree: aBlock [

	^ self subclassResponsibility
]

{ #category : #writing }
YrWriter >> newTree [

	^ self subclassResponsibility 
]

{ #category : #writing }
YrWriter >> write: anObject with: aYrEncoding at: basename [

	^ aYrEncoding
		write: anObject 
		at: basename 
		on: self
]
