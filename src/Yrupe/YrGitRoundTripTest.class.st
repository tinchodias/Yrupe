Class {
	#name : #YrGitRoundTripTest,
	#superclass : #YrRoundTripTest,
	#instVars : [
		'repositoryForWriting'
	],
	#category : #'Yrupe-Tests'
}

{ #category : #testing }
YrGitRoundTripTest class >> shouldInheritSelectors [

	^ true
]

{ #category : #running }
YrGitRoundTripTest >> setUpReader [

	YrReadCache reset.
	YrWriteCache reset.
	reader := YrGitReader new
]

{ #category : #running }
YrGitRoundTripTest >> setUpWriter [

	YrReadCache reset.
	YrWriteCache reset.

	repositoryForWriting := 
		(LGitRepository on: self directoryForTests)
			create;
			init;
			yourself.
			
	writer := YrGitWriter newWithRepository: repositoryForWriting
]
