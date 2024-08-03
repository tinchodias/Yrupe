Class {
	#name : #YrGitReader,
	#superclass : #YrReader,
	#category : #'Yrupe-ReadWrite'
}

{ #category : #reading }
YrGitReader >> read: anObject with: aYrEncoding [ 

	| cache key |
	cache := YrReadCache defaultAtEncodingClass: aYrEncoding class.
	key := anObject id asByteArray.
	
	^ cache 
		at: key
		ifAbsent: [ 
			| result |
			result := aYrEncoding read: anObject on: self.

			cache
				at: key
				put: result.
				
			result ]
]

{ #category : #reading }
YrGitReader >> readAsLeaf: anObject [
	
	^ anObject rawBuffer utf8StringFromCString
]

{ #category : #reading }
YrGitReader >> readAsTree: anObject childrenDo: aBlock [
	
	anObject entries do: [ :anEntry |
		aBlock 
			value: anEntry filename
			value: anEntry object ]
]
