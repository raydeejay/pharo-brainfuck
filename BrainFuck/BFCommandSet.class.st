Class {
	#name : #BFCommandSet,
	#superclass : #Object,
	#instVars : [
		'commands'
	],
	#category : #BrainFuck
}

{ #category : #accessing }
BFCommandSet class >> canonicalOrder [
	^ '><+-.,[]'
]

{ #category : #streaming }
BFCommandSet >> << aCommandSet [
	commands addAll: aCommandSet commands
]

{ #category : #accessing }
BFCommandSet >> commands [
	^ commands
]
