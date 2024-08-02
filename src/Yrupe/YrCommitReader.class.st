Class {
	#name : #YrCommitReader,
	#superclass : #Object,
	#instVars : [
		'repository'
	],
	#category : #'Yrupe-Commits'
}

{ #category : #reading }
YrCommitReader >> readFromCommit: aLGitCommit [ 

	| contents extension encoding |
	contents := 
		aLGitCommit tree entries 
			detect: [ :entry | entry filename beginsWith: 'contents' ]
			ifNone: [ self error: 'Invalid Yrupe commit' ].

	extension := contents filename copyAfterLast: $..
	encoding := extension isEmpty
		ifFalse: [ YrEncoding encodingFor: extension ]
		ifTrue: [ YrTreeEncoding new ].

	self flag: #todo.	"^^^ Remove special case of 'contents' without extension: just backward compatibility during tests."
		
	^ YrGitReader new read: contents object with: encoding.
]

{ #category : #reading }
YrCommitReader >> readFromCommitSHA: aString [ 

	^ self readFromCommit: (repository revparse: aString)

]

{ #category : #reading }
YrCommitReader >> readFromCommitTaggedAs: aTagName [ 

	^ self readFromCommit: (repository revparse: 'refs/tags/', aTagName)

]

{ #category : #accessing }
YrCommitReader >> repository [
	
	^ repository
]

{ #category : #accessing }
YrCommitReader >> repository: anObject [
	
	repository := anObject
]
