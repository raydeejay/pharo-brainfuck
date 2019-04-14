Class {
	#name : #BFTextualInputHead,
	#superclass : #BFAbstractHead,
	#category : #BrainFuck
}

{ #category : #'write and read' }
BFTextualInputHead >> decrement [
	self shouldNotImplement
]

{ #category : #'write and read' }
BFTextualInputHead >> increment [
	self shouldNotImplement
]

{ #category : #seeking }
BFTextualInputHead >> moveBackwards [
	self shouldNotImplement
]

{ #category : #seeking }
BFTextualInputHead >> moveBy: anInteger [
	self shouldNotImplement
]

{ #category : #seeking }
BFTextualInputHead >> moveForwards [
	self shouldNotImplement
]

{ #category : #seeking }
BFTextualInputHead >> moveTo: anInteger [
	self shouldNotImplement
]

{ #category : #accessing }
BFTextualInputHead >> position [
	self shouldNotImplement
]

{ #category : #'write and read' }
BFTextualInputHead >> read [
	^ self storage contents next charCode
]

{ #category : #'write and read' }
BFTextualInputHead >> write: anInteger [
	self shouldNotImplement
]
