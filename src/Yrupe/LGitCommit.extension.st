Extension { #name : #LGitCommit }

{ #category : #'*Yrupe' }
LGitCommit >> lookupByPath: aFilePath type: aLGitObjectTypeEnum ifPresent: presentBlock ifAbsent: absentBlock [

	| aLGitObject lookupResult |
	aLGitObject := LGitObject of: repository.

	lookupResult := aLGitObject
		object_lookup_bypath: aLGitObject
		treeish: self tree
		path: aFilePath
		type: aLGitObjectTypeEnum.

	^ LGitReturnCodeEnum GIT_OK = lookupResult
		ifTrue: [ presentBlock cull: aLGitObject concreteObject ]
		ifFalse: [ 
			LGitReturnCodeEnum GIT_ENOTFOUND = lookupResult
				ifTrue: [ absentBlock value ]
				ifFalse: [ self error: 'Unexpected result' ] ]
]
