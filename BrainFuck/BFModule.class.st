Class {
	#name : #BFModule,
	#superclass : #Object,
	#instVars : [
		'name',
		'contents'
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
