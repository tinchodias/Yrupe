"
I implement an encoding for arbitrary objects, using Ston serializer.
"
Class {
	#name : #YrStonEncoding,
	#superclass : #YrLeafEncoding,
	#category : #'Yrupe-Encodings'
}

{ #category : #accessing }
YrStonEncoding class >> id [

	^ 'ston'
]

{ #category : #testing }
YrStonEncoding class >> isAbstract [

	^ false
]

{ #category : #private }
YrStonEncoding >> objectFrom: aString [

	^ [ STON fromString: aString ]
		on: Error
		do: [ '<YRUPE COULD NOT PARSE STON FORMAT>' ]
]

{ #category : #private }
YrStonEncoding >> stringFor: anObject [

	^ String streamContents: [ :stream |
		(STON writer on: stream)
			prettyPrint: true; 
			newLine: String lf; "Use default git EOL character"
			nextPut: anObject ]
]
