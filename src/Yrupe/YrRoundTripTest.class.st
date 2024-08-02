"
I hold common test cases for Yrupe read/writing.
"
Class {
	#name : #YrRoundTripTest,
	#superclass : #TestCase,
	#instVars : [
		'reader',
		'writer'
	],
	#category : #'Yrupe-Tests'
}

{ #category : #testing }
YrRoundTripTest class >> isAbstract [

	^ self = YrRoundTripTest
]

{ #category : #running }
YrRoundTripTest >> assertRoundTripEquals: anObject [

	| written read encoder |
	encoder := anObject yrupeDefaultEncoder.

	written := 
		encoder 
			write: anObject
			at: #root "FIX?"
			on: writer.
			
	read := reader read: written with: encoder.
	
	self assert: read equals: anObject.
]

{ #category : #running }
YrRoundTripTest >> directoryForTests [

	^ FileSystem workingDirectory / 'yrupeTests'
]

{ #category : #running }
YrRoundTripTest >> setUp [

	self setUpWriter.	
	self setUpReader.
]

{ #category : #running }
YrRoundTripTest >> setUpReader [

	self subclassResponsibility 
]

{ #category : #running }
YrRoundTripTest >> setUpWriter [

	self subclassResponsibility 
]

{ #category : #running }
YrRoundTripTest >> tearDown [

	super tearDown.

	self directoryForTests
		ensureDeleteAllChildren;
		ensureDelete.	

]

{ #category : #tests }
YrRoundTripTest >> testSmallInteger [

	self assertRoundTripEquals: 42
]

{ #category : #tests }
YrRoundTripTest >> testString [

	self assertRoundTripEquals: '42'
]
