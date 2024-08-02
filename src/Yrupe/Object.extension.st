Extension { #name : #Object }

{ #category : #'*Yrupe' }
Object >> yrupeDefaultEncoder [

	^ self yrupeLeafEncoder
]

{ #category : #'*Yrupe' }
Object >> yrupeLeafEncodedSHA1 [
	"Compute the SHA1 of self as computed by git. Used to prefill read cache."

	| rawContents gitSha1Contents |
	rawContents := self yrupeLeafEncoder stringFor: self.
	gitSha1Contents := 'blob ', rawContents size asString, Character null asString, rawContents.
	^ SHA1 new hashMessage: gitSha1Contents
]

{ #category : #'*Yrupe' }
Object >> yrupeLeafEncoder [

	^ YrStonEncoding new
]
