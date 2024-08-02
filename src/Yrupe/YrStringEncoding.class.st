"
I implement a simple encoding for Strings.
"
Class {
	#name : #YrStringEncoding,
	#superclass : #YrLeafEncoding,
	#category : #'Yrupe-Encodings'
}

{ #category : #accessing }
YrStringEncoding class >> id [

	^ 'string'
]

{ #category : #testing }
YrStringEncoding class >> isAbstract [

	^ false
]

{ #category : #private }
YrStringEncoding >> objectFrom: aString [

	^ aString copy withSqueakLineEndings
]

{ #category : #private }
YrStringEncoding >> stringFor: aString [

	^ aString copy withUnixLineEndings
]
