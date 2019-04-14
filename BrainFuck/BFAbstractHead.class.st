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
	#name : #BFAbstractHead,
	#superclass : #Object,
	#instVars : [
		'position',
		'storage',
		'name'
	],
	#category : #BrainFuck
}

{ #category : #'instance creation' }
BFAbstractHead class >> on: aStorage [
	^ self new
		storage: aStorage;
		yourself
]

{ #category : #'write and read' }
BFAbstractHead >> decrement [
	self subclassResponsibility
]

{ #category : #'write and read' }
BFAbstractHead >> increment [
	self subclassResponsibility
]

{ #category : #seeking }
BFAbstractHead >> moveBackwards [
	self subclassResponsibility
]

{ #category : #seeking }
BFAbstractHead >> moveBy: anInteger [
	self subclassResponsibility
]

{ #category : #seeking }
BFAbstractHead >> moveForwards [
	self subclassResponsibility
]

{ #category : #seeking }
BFAbstractHead >> moveTo: anInteger [
	self subclassResponsibility
]

{ #category : #accessing }
BFAbstractHead >> name [
	^ name
]

{ #category : #accessing }
BFAbstractHead >> name: anObject [
	name := anObject
]

{ #category : #accessing }
BFAbstractHead >> position [
	self subclassResponsibility
]

{ #category : #accessing }
BFAbstractHead >> position: anObject [
	position := anObject
]

{ #category : #'write and read' }
BFAbstractHead >> read [
	self subclassResponsibility
]

{ #category : #accessing }
BFAbstractHead >> storage [
	^ storage
]

{ #category : #accessing }
BFAbstractHead >> storage: aStorage [
	storage := aStorage
]

{ #category : #'write and read' }
BFAbstractHead >> write: anInteger [
	self subclassResponsibility
]
