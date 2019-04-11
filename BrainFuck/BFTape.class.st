Class {
	#name : #BFTape,
	#superclass : #Object,
	#instVars : [
		'head',
		'contents'
	],
	#category : #BrainFuck
}

{ #category : #'as yet unclassified' }
BFTape class >> identifier [
	^ #tape
]

{ #category : #'private - accessing' }
BFTape >> at: anInteger [
	^ self contents at: anInteger + 1
]

{ #category : #'private - accessing' }
BFTape >> at: anInteger put: aValue [
	^ self contents at: anInteger + 1 put: aValue
]

{ #category : #'write and read' }
BFTape >> atHead [
	^ self at: self head
]

{ #category : #'write and read' }
BFTape >> atHeadPut: anInteger [
	self at: self head put: anInteger % 256
]

{ #category : #'private - accessing' }
BFTape >> contents [
	^ contents
]

{ #category : #'write and read' }
BFTape >> decrementAtHead [
	| val |
	
	val := self at: self head.
	self at: self head put: val - 1 % 256
]

{ #category : #accessing }
BFTape >> head [
	^ head ifNil: [ head := 0 ]
]

{ #category : #accessing }
BFTape >> head: anInteger [ 
	head := anInteger
]

{ #category : #'write and read' }
BFTape >> incrementAtHead [
	| val |
	
	val := self at: self head.
	self at: self head put: val + 1 % 256
]

{ #category : #initialization }
BFTape >> initialize [
	super initialize.
	contents := Array new: 30000 withAll: 0
]

{ #category : #seeking }
BFTape >> moveHeadBackwards [
	self moveHeadBy: -1
]

{ #category : #seeking }
BFTape >> moveHeadBy: anInteger [
	self head + anInteger < 0
		ifTrue: [ self error: 'Head attempted to move past the beginning of the tape' ].
	self head + anInteger >= self contents size
		ifTrue: [ self error: 'Head attempted to move past the end of the tape' ].
	self head: self head + anInteger
]

{ #category : #seeking }
BFTape >> moveHeadForwards [
	self moveHeadBy: 1
]

{ #category : #seeking }
BFTape >> moveHeadTo: anInteger [
	anInteger < 0
		ifTrue: [ self error: 'Head attempted to move past the beginning of the tape' ].
	anInteger >= self contents size
		ifTrue: [ self error: 'Head attempted to move past the end of the tape' ].
	self head: self head + anInteger
]

{ #category : #seeking }
BFTape >> rewind [
	self head: 0
]
