Class {
	#name : #BFDisplay,
	#superclass : #Object,
	#instVars : [
		'head',
		'contents',
		'headR',
		'headG',
		'headB'
	],
	#category : #BrainFuck
}

{ #category : #'as yet unclassified' }
BFDisplay class >> identifier [
	^ #display
]

{ #category : #'private - accessing' }
BFDisplay >> at: anInteger [
	^ self contents at: anInteger + 1
]

{ #category : #'private - accessing' }
BFDisplay >> at: anInteger put: aValue [
	^ self contents at: anInteger + 1 put: aValue
]

{ #category : #'write and read' }
BFDisplay >> atHead [
	^ self contents top
]

{ #category : #'write and read' }
BFDisplay >> atHeadPut: anInteger [
	self contents push: anInteger % 256
]

{ #category : #'private - accessing' }
BFDisplay >> contents [
	^ contents
]

{ #category : #accessing }
BFDisplay >> head [
	^ head ifNil: [ head := 0@0 ]
]

{ #category : #accessing }
BFDisplay >> head: aPoint [
	head := aPoint
]

{ #category : #seeking }
BFDisplay >> headB: anInteger [
	headB := anInteger
]

{ #category : #seeking }
BFDisplay >> headDecreaseX [
	self head: -1@0 + self head
]

{ #category : #seeking }
BFDisplay >> headDecreaseY [
	self head: 0@(-1) + self head
]

{ #category : #seeking }
BFDisplay >> headG: anInteger [
	headG := anInteger
]

{ #category : #seeking }
BFDisplay >> headIncreaseX [
	self head: 1@0 + self head
]

{ #category : #seeking }
BFDisplay >> headIncreaseY [
	self head: 0@1 + self head
]

{ #category : #seeking }
BFDisplay >> headR: anInteger [
	headR := anInteger
]

{ #category : #'write and read' }
BFDisplay >> headWrite [
	self contents form
		colorAt: self head + (1@1)
		put: (Color r: headR/255 g: headG/255 b: headB/255).
	self contents changed
]

{ #category : #seeking }
BFDisplay >> headX: anInteger [
	self head: (anInteger @ self head y)
]

{ #category : #seeking }
BFDisplay >> headY: anInteger [
	self head: (self head x @ anInteger)
]

{ #category : #initialization }
BFDisplay >> initialize [
	| form |
	
	super initialize.
	form := Form new setExtent: 256@256 depth: 32; yourself.
	contents := (ImageMorph withForm: form) resize: 256@256; yourself
]

{ #category : #seeking }
BFDisplay >> moveHeadBy: anInteger [
	self contents size + anInteger < 0
		ifTrue: [ self error: 'Head attempted to move past the beginning of the tape' ].
	self head + anInteger >= self contents size
		ifTrue: [ self error: 'Head attempted to move past the end of the tape' ].
	self head: self head + anInteger
]

{ #category : #seeking }
BFDisplay >> moveHeadTo: anInteger [
	anInteger < 0
		ifTrue: [ self error: 'Head attempted to move past the beginning of the tape' ].
	anInteger >= self contents size
		ifTrue: [ self error: 'Head attempted to move past the end of the tape' ].
	self head: self head + anInteger
]

{ #category : #seeking }
BFDisplay >> rewind [
	self head: 0@0
]

{ #category : #'write and read' }
BFDisplay >> show [
	contents openInWindow 
]
