Class {
	#name : #YrReadCache,
	#superclass : #Object,
	#instVars : [
		'hitCount',
		'internalDictionary'
	],
	#classInstVars : [
		'defaultByEncodingClass'
	],
	#category : #'Yrupe-ReadWrite'
}

{ #category : #accessing }
YrReadCache class >> defaultAtEncodingClass: key [
	
	^ self defaultByEncodingClass 
		at: key
		ifAbsentPut: [ self new ]
]

{ #category : #accessing }
YrReadCache class >> defaultByEncodingClass [
	
	^ defaultByEncodingClass 
		ifNil: [ defaultByEncodingClass := Dictionary new ]
]

{ #category : #accessing }
YrReadCache class >> reset [
	"
	self reset
	"
	
	^ defaultByEncodingClass := nil
]

{ #category : #accessing }
YrReadCache >> at: key ifAbsent: absentBlock [

	^ self 
		at: key 
		ifPresent: [ :value | value ]
		ifAbsent: absentBlock
]

{ #category : #accessing }
YrReadCache >> at: key ifPresent: presentBlock ifAbsent: absentBlock [

	^ internalDictionary
		at: key 
		ifPresent: [ :value | 
			value 
				ifNil: absentBlock
				ifNotNil: [ 
					hitCount := hitCount + 1.
					presentBlock cull: value ] ]
		ifAbsent: absentBlock
]

{ #category : #accessing }
YrReadCache >> at: key put: aValue [

	self assert: aValue isNil not.

	^ internalDictionary
		at: key 
		put: aValue
]

{ #category : #accessing }
YrReadCache >> hitCount [

	^ hitCount
]

{ #category : #initialization }
YrReadCache >> initialize [

	super initialize.
	
	self resetDictionary.
	
	hitCount := 0.
]

{ #category : #initialization }
YrReadCache >> resetDictionary [
	
	internalDictionary := WeakValueDictionary new.
]
