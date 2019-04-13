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

{ #category : #accessing }
BFHead >> storage [
	^ storage
]

{ #category : #accessing }
BFHead >> storage: aStorage [
	storage := aStorage
]
