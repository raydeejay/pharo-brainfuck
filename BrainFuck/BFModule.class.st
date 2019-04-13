Class {
	#name : #BFModule,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #BrainFuck
}

{ #category : #accessing }
BFModule >> name [
	^ name
]

{ #category : #accessing }
BFModule >> name: anObject [
	name := anObject
]
