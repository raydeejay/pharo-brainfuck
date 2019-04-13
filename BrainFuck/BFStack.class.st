Class {
	#name : #BFStack,
	#superclass : #BFModule,
	#category : #BrainFuck
}

{ #category : #'as yet unclassified' }
BFStack class >> identifier [
	^ #stack
]

{ #category : #'private - accessing' }
BFStack >> at: anInteger [
	^ self contents at: anInteger + 1
]

{ #category : #'private - accessing' }
BFStack >> at: anInteger put: aValue [
	^ self contents at: anInteger + 1 put: aValue
]

{ #category : #'write and read' }
BFStack >> atHead [
	^ self contents top
]

{ #category : #'write and read' }
BFStack >> atHeadPut: anInteger [
	self contents push: anInteger % 256
]

{ #category : #'private - accessing' }
BFStack >> contents [
	^ contents
]

{ #category : #'write and read' }
BFStack >> decrementAtHead [
	self contents push: self contents pop - 1 % 256
]

{ #category : #accessing }
BFStack >> head [
	^ self contents size
]

{ #category : #accessing }
BFStack >> head: anInteger [
	self shouldNotImplement
]

{ #category : #'write and read' }
BFStack >> incrementAtHead [
	self contents push: self contents pop + 1 % 256
]

{ #category : #initialization }
BFStack >> initialize [
	super initialize.
	contents := Stack new
]

{ #category : #seeking }
BFStack >> moveHeadBackwards [
	self contents pop
]

{ #category : #seeking }
BFStack >> moveHeadBy: anInteger [
	self contents size + anInteger < 0
		ifTrue: [ self error: 'Head attempted to move past the beginning of the tape' ].
	self head + anInteger >= self contents size
		ifTrue: [ self error: 'Head attempted to move past the end of the tape' ].
	self head: self head + anInteger
]

{ #category : #seeking }
BFStack >> moveHeadForwards [
	self contents push: 0
]

{ #category : #seeking }
BFStack >> moveHeadTo: anInteger [
	anInteger < 0
		ifTrue: [ self error: 'Head attempted to move past the beginning of the tape' ].
	anInteger >= self contents size
		ifTrue: [ self error: 'Head attempted to move past the end of the tape' ].
	self head: self head + anInteger
]

{ #category : #seeking }
BFStack >> rewind [
	self head: 0
]
