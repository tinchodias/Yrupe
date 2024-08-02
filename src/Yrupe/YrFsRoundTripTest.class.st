Class {
	#name : #YrFsRoundTripTest,
	#superclass : #YrRoundTripTest,
	#category : #'Yrupe-Tests'
}

{ #category : #testing }
YrFsRoundTripTest class >> shouldInheritSelectors [

	^ true
]

{ #category : #running }
YrFsRoundTripTest >> setUpReader [

	reader := YrFsReader new
]

{ #category : #running }
YrFsRoundTripTest >> setUpWriter [

	writer := YrFsWriter newWithFileReference: self directoryForTests.
]
