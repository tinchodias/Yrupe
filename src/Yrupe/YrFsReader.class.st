Class {
	#name : #YrFsReader,
	#superclass : #YrReader,
	#category : #'Yrupe-ReadWrite'
}

{ #category : #reading }
YrFsReader >> readAsLeaf: anObject [
	
	^ anObject contents
]

{ #category : #reading }
YrFsReader >> readAsTree: anObject childrenDo: aBlock [
	
	anObject entries 
		reject: [ :entry | entry basename first = $. ]
		thenDo: [ :entry |
			aBlock
				value: entry basename
				value: entry asFileReference ]
]
