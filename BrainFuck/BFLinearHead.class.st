Class {
	#name : #BFLinearHead,
	#superclass : #BFAbstractHead,
	#category : #BrainFuck
}

{ #category : #'write and read' }
BFLinearHead >> decrement [
	| val |
	
	val := self storage at: self position.
	self storage at: self position put: val - 1
]

{ #category : #'write and read' }
BFLinearHead >> increment [
	| val |

	val := self storage at: self position.
	self storage at: self position put: val + 1
]

{ #category : #seeking }
BFLinearHead >> moveBackwards [
	self moveBy: -1
]

{ #category : #seeking }
BFLinearHead >> moveBy: anInteger [
	self position + anInteger < 0
		ifTrue: [ self error: 'Head attempted to move past the beginning of the tape' ].
	self position + anInteger >= self storage contents size
		ifTrue: [ self error: 'Head attempted to move past the end of the tape' ].
	self position: self position + anInteger
]

{ #category : #seeking }
BFLinearHead >> moveForwards [
	self moveBy: 1
]

{ #category : #seeking }
BFLinearHead >> moveTo: anInteger [
	anInteger < 0
		ifTrue: [ self error: 'Head attempted to move past the beginning of the tape' ].
	anInteger >= self storage contents size
		ifTrue: [ self error: 'Head attempted to move past the end of the tape' ].
	self position: self position + anInteger
]

{ #category : #accessing }
BFLinearHead >> position [
	^ position ifNil: [ position := 0 ]
]

{ #category : #'write and read' }
BFLinearHead >> read [
	^ self storage at: self position
]

{ #category : #'write and read' }
BFLinearHead >> write: anInteger [
	^ self storage at: self position put: anInteger
]
