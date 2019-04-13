Class {
	#name : #BFCommandSet,
	#superclass : #Object,
	#instVars : [
		'commands',
		'pairs'
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

{ #category : #accessing }
BFCommandSet >> matchingCharFor: aCharacter [
	^ pairs at: aCharacter 
]

{ #category : #accessing }
BFCommandSet >> pairs [
	^ pairs
]
