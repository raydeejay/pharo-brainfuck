Class {
	#name : #TrivialBrainfuckSubstitution,
	#superclass : #BFSubstitution,
	#instVars : [
		'characters'
	],
	#category : #BrainFuck
}

{ #category : #'instance creation' }
TrivialBrainfuckSubstitution class >> with: aString [
	aString size = 8 ifFalse: [ self error: 'a ', self name, ' requires 8 characters' ].
	^ self new
		characters: aString;
		yourself
]

{ #category : #configuring }
TrivialBrainfuckSubstitution >> characters: aString [ 
	characters := aString
]

{ #category : #translating }
TrivialBrainfuckSubstitution >> translate: aString [
	"As per https://esolangs.org/wiki/TrivialBrainfuckSubstitution"
	
	^ aString collect: [ :char | 
		| idx |
		idx := BFCommandSet canonicalOrder indexOf: char ifAbsent: [ 0 ].
		idx isZero ifTrue: [ char ] ifFalse: [ characters at: idx ] ]
]

{ #category : #translating }
TrivialBrainfuckSubstitution >> translateCommandSet: aDictionary [
	"As per https://esolangs.org/wiki/TrivialBrainfuckSubstitution"

	^ (characters asOrderedCollection
		with: BFCommandSet canonicalOrder asOrderedCollection
		collect: [ :char :std | char -> (aDictionary at: std) ])
		asDictionary
]
