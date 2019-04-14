Class {
	#name : #BFTextualOutputHead,
	#superclass : #BFAbstractHead,
	#category : #BrainFuck
}

{ #category : #'write and read' }
BFTextualOutputHead >> decrement [
	self shouldNotImplement
]

{ #category : #'write and read' }
BFTextualOutputHead >> increment [
	self shouldNotImplement
]

{ #category : #seeking }
BFTextualOutputHead >> moveBackwards [
	self shouldNotImplement
]

{ #category : #seeking }
BFTextualOutputHead >> moveBy: anInteger [
	self shouldNotImplement
]

{ #category : #seeking }
BFTextualOutputHead >> moveForwards [
	self shouldNotImplement
]

{ #category : #seeking }
BFTextualOutputHead >> moveTo: anInteger [
	self shouldNotImplement
]

{ #category : #accessing }
BFTextualOutputHead >> position [
	self shouldNotImplement
]

{ #category : #'write and read' }
BFTextualOutputHead >> read [
	self shouldNotImplement
]

{ #category : #'write and read' }
BFTextualOutputHead >> write: anInteger [
	self storage contents << anInteger asCharacter
]
