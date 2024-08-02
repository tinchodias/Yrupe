Class {
	#name : #YrCommitRoundTripTest,
	#superclass : #TestCase,
	#instVars : [
		'reader',
		'writer',
		'repositoryForReading',
		'repositoryForWriting'
	],
	#category : #'Yrupe-Tests'
}

{ #category : #running }
YrCommitRoundTripTest >> assertRoundTripEquals: anObject [

	| written read |
	written := writer commit: anObject.
	read := reader readFromCommit: written.
	
	self assert: read equals: anObject.
]

{ #category : #running }
YrCommitRoundTripTest >> repositoryDirectory [

	^ FileSystem workingDirectory / 'yrupeTests'
]

{ #category : #running }
YrCommitRoundTripTest >> setUp [

	self setUpGitRepository.
	self setUpWriter.
	self setUpReader.
]

{ #category : #running }
YrCommitRoundTripTest >> setUpGitRepository [

	| directory |
	directory := self repositoryDirectory.
	directory ensureDeleteAllChildren.
	directory ensureDelete.	

	repositoryForWriting := 
		(LGitRepository on: directory)
			create;
			init;
			yourself.
			
	repositoryForReading := 
		(LGitRepository on: directory)
			open;
			yourself

]

{ #category : #running }
YrCommitRoundTripTest >> setUpReader [

	YrReadCache reset.
	YrWriteCache reset.

	reader := 
		YrCommitReader new
			repository: repositoryForReading;
			yourself
]

{ #category : #running }
YrCommitRoundTripTest >> setUpWriter [

	YrReadCache reset.
	YrWriteCache reset.

	writer := 
		YrCommitWriter new
			repository: repositoryForWriting;
			reference: 'refs/heads/master';
			userName: 'Bart Simpson';
			userEmail: 'bartman@gotham.com';
			message: ':)';
			yourself.

]

{ #category : #tests }
YrCommitRoundTripTest >> testSmallInteger [

	self assertRoundTripEquals: 42
]

{ #category : #tests }
YrCommitRoundTripTest >> testString [

	self assertRoundTripEquals: '42'
]
