Class {
	#name : #YrCommitWriter,
	#superclass : #Object,
	#instVars : [
		'repository',
		'reference',
		'message',
		'userName',
		'userEmail',
		'parents',
		'signatureDateAndTime'
	],
	#category : #'Yrupe-Commits'
}

{ #category : #writing }
YrCommitWriter >> commit: anObject [

	| tree signature |
	tree := self rootTreeFor: anObject.
	signature := self freshSignature.

	^ (LGitCommitBuilder of: repository)
		tree: tree;
		message: message;
		parents: self parents;
		updateReference: self reference;
		author: signature;
		committer: signature;
		writeCommit;
		writtenCommit.

]

{ #category : #private }
YrCommitWriter >> freshSignature [

	^ LGitSignature new
		name: userName;
		email: userEmail;
		dateAndTime: self signatureDateAndTime;
		yourself.
]

{ #category : #accessing }
YrCommitWriter >> message [
	
	^ message
]

{ #category : #accessing }
YrCommitWriter >> message: anObject [
	
	message := anObject
]

{ #category : #private }
YrCommitWriter >> parents [

	^ parents ifNil: [
		[ {repository head object} ]
			on: Error 
			do: [ :error | #() ] ]
]

{ #category : #accessing }
YrCommitWriter >> parents: aCollection [ 

	parents := aCollection
]

{ #category : #private }
YrCommitWriter >> readmeString [
	
	^ 'Automatically created by Yrupe.'
]

{ #category : #accessing }
YrCommitWriter >> reference [
	
	^ reference ifNil: [ NBExternalAddress null ]
]

{ #category : #accessing }
YrCommitWriter >> reference: anObject [
	
	reference := anObject
]

{ #category : #accessing }
YrCommitWriter >> repository [
	
	^ repository
]

{ #category : #accessing }
YrCommitWriter >> repository: anObject [
	
	repository := anObject
]

{ #category : #private }
YrCommitWriter >> rootTreeFor: anObject [

	| writer |
	writer := YrGitWriter newWithRepository: repository.
	
	"create contents"
	anObject yrupeDefaultEncoder 
		write: anObject
		at: 'contents'
		on: writer.

	"create readme"
	writer
		at: 'README.md' 
		writeAsLeaf: self readmeString.

	^ writer newTree
]

{ #category : #accessing }
YrCommitWriter >> signatureDateAndTime [
		
	^ signatureDateAndTime ifNil: [ 
		signatureDateAndTime := DateAndTime now ]
]

{ #category : #accessing }
YrCommitWriter >> signatureDateAndTime: aDateAndTime [
		
	signatureDateAndTime := aDateAndTime
]

{ #category : #accessing }
YrCommitWriter >> userEmail [
	
	^ userEmail
]

{ #category : #accessing }
YrCommitWriter >> userEmail: anObject [
	
	userEmail := anObject
]

{ #category : #accessing }
YrCommitWriter >> userName [
	
	^ userName
]

{ #category : #accessing }
YrCommitWriter >> userName: anObject [
	
	userName := anObject
]
