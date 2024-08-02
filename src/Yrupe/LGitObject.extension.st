Extension { #name : #LGitObject }

{ #category : #'*Yrupe' }
LGitObject >> object_lookup_bypath: out treeish: treeish path: path type: type [ 
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>

	^self call: #(LGitReturnCodeEnum git_object_lookup_bypath(LGitObject * out, LGitTree treeish, String path, LGitObjectTypeEnum type)) options: #(  )
]
