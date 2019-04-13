"
I represent a head on a storage device.
 
I move along the device, and can read and write its contents.

I collaborate with a storage device and one or more interpreters.

Public API and Key Messages

- read
- write
- position
- position:

How to create instances:

   BFHead on: aStorage
 
Internal Representation and Key Implementation Points.

    Instance Variables
	position:		<Object>

    Implementation Points
"
Class {
	#name : #BFHead,
	#superclass : #Object,
	#instVars : [
		'position',
		'storage',
		'name'
	],
	#category : #BrainFuck
}

{ #category : #'instance creation' }
BFHead class >> on: aStorage [
	^ self new
		storage: aStorage;
		yourself
]

{ #category : #'write and read' }
BFHead >> decrement [
	| val |
	
	val := self storage at: self position.
	self storage at: self position put: val - 1
]

{ #category : #'as yet unclassified' }
BFHead >> increment [
	| val |

	val := self storage at: self position.
	self storage at: self position put: val + 1
]

{ #category : #seeking }
BFHead >> moveBackwards [
	self moveBy: -1
]

{ #category : #seeking }
BFHead >> moveBy: anInteger [
	self position + anInteger < 0
		ifTrue: [ self error: 'Head attempted to move past the beginning of the tape' ].
	self position + anInteger >= self storage contents size
		ifTrue: [ self error: 'Head attempted to move past the end of the tape' ].
	self position: self position + anInteger
]

{ #category : #seeking }
BFHead >> moveForwards [
	self moveBy: 1
]

{ #category : #seeking }
BFHead >> moveTo: anInteger [
	anInteger < 0
		ifTrue: [ self error: 'Head attempted to move past the beginning of the tape' ].
	anInteger >= self storage contents size
		ifTrue: [ self error: 'Head attempted to move past the end of the tape' ].
	self position: self position + anInteger
]

{ #category : #accessing }
BFHead >> name [
	^ name
]

{ #category : #accessing }
BFHead >> name: anObject [
	name := anObject
]

{ #category : #accessing }
BFHead >> position [
	^ position ifNil: [ position := 0 ]
]

{ #category : #accessing }
BFHead >> position: anObject [
	position := anObject
]

{ #category : #'as yet unclassified' }
BFHead >> read [
	^ self storage at: self position
]

{ #category : #accessing }
BFHead >> storage [
	^ storage
]

{ #category : #accessing }
BFHead >> storage: aStorage [
	storage := aStorage
]

{ #category : #'as yet unclassified' }
BFHead >> write: anInteger [
	^ self storage at: self position put: anInteger
]
