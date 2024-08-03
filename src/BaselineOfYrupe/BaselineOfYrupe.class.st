Class {
	#name : #BaselineOfYrupe,
	#superclass : #BaselineOf,
	#category : #BaselineOfYrupe
}

{ #category : #baselines }
BaselineOfYrupe >> baseline: spec [
	<baseline>

	spec for: #common do: [ spec package: #Yrupe ]
]
