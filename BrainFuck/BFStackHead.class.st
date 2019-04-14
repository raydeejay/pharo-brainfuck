Class {
	#name : #BFStackHead,
	#superclass : #BFAbstractHead,
	#category : #BrainFuck
}

{ #category : #'write and read' }
BFStackHead >> decrement [
	self storage contents push: self storage contents pop - 1 % 256
]

{ #category : #'write and read' }
BFStackHead >> increment [
	self storage contents push: self storage contents pop + 1 % 256
]

{ #category : #seeking }
BFStackHead >> moveBackwards [
	self storage contents pop
]

{ #category : #seeking }
BFStackHead >> moveBy: anInteger [
	self storage contents size + anInteger < 0
		ifTrue: [ self error: 'Head attempted to move past the beginning of the tape' ].
	self storage contents size + anInteger >= self storage contents size
		ifTrue: [ self error: 'Head attempted to move past the end of the tape' ].
	"TODO: push 0s or pop elements as needed"
]

{ #category : #seeking }
BFStackHead >> moveForwards [
	self storage contents push: 0
]

{ #category : #seeking }
BFStackHead >> moveTo: anInteger [
	anInteger < 0
		ifTrue: [ self error: 'Head attempted to move past the beginning of the tape' ].
	anInteger >= self storage contents size
		ifTrue: [ self error: 'Head attempted to move past the end of the tape' ].
	"TODO push or pop elements as needed"
]

{ #category : #accessing }
BFStackHead >> position [
	^ self contents size
]

{ #category : #'write and read' }
BFStackHead >> read [
	self storage contents top
]

{ #category : #'write and read' }
BFStackHead >> write: anInteger [
	self storage contents
		pop;
		push: anInteger % 256
]
