"
I am an abstract Yrupe reader.
"
Class {
	#name : #YrReader,
	#superclass : #Object,
	#category : #'Yrupe-ReadWrite'
}

{ #category : #reading }
YrReader >> read: anObject with: aYrEncoding [ 

	^ aYrEncoding read: anObject on: self
]

{ #category : #reading }
YrReader >> readAsLeaf: anObject [
	"Read anObject as if it was written as a leaf"
	
	^ self subclassResponsibility
]

{ #category : #reading }
YrReader >> readAsTree: anObject childrenDo: aBlock [
	"Read anObject as if it was written as a tree. The block will be executed with chidren information."
	
	^ self subclassResponsibility
]
