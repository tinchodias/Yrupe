Extension { #name : #String }

{ #category : #'*Yrupe' }
String >> yrupeFileBasenameDecoded [
	
	^ (self replaceAll: $# with: $%) urlDecoded 
]

{ #category : #'*Yrupe' }
String >> yrupeFileBasenameEncoded [
	"Encode self as a valid filename. 
	In the special case of '@', I'm not transformed: see YrTreeEncoding."

	^ self = #@
		ifTrue: [ ^ self ]
		ifFalse: [ self urlEncoded replaceAll: $% with: $# ]
]
