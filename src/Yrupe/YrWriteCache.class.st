Class {
	#name : #YrWriteCache,
	#superclass : #YrReadCache,
	#category : #'Yrupe-ReadWrite'
}

{ #category : #initialization }
YrWriteCache >> resetDictionary [
	
	internalDictionary := WeakKeyDictionary new.
]
