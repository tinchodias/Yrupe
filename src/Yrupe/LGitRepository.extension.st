Extension { #name : #LGitRepository }

{ #category : #'*Yrupe' }
LGitRepository >> branch_create: out repo: repo branch_name: branch_name target: target force: force signature: signature log_message: log_message [ 
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^self call: #(LGitReturnCodeEnum git_branch_create(LGitReference * out, self, String branch_name, LGitCommit target, int force, LGitSignature * signature, String log_message)) options: #(  )
]
