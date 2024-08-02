"
I implement an encoding for objects which at leaves, i.e., that do not point to other objects.
"
Class {
	#name : #YrLeafEncoding,
	#superclass : #YrEncoding,
	#category : #'Yrupe-Encodings'
}

{ #category : #writing }
YrLeafEncoding >> objectFrom: aString [

	^ self subclassResponsibility 
]

{ #category : #reading }
YrLeafEncoding >> read: anObject on: aReader [

	^ self objectFrom: (aReader readAsLeaf: anObject)
]

{ #category : #private }
YrLeafEncoding >> stringFor: anObject [

	^ self subclassResponsibility 
]

{ #category : #writing }
YrLeafEncoding >> write: anObject at: basename on: aWriter [

	^ aWriter 
		at: (self filenameFor: basename)
		writeAsLeaf: (self stringFor: anObject)

]
