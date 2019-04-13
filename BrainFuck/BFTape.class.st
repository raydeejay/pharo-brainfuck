Class {
	#name : #BFTape,
	#superclass : #BFModule,
	#instVars : [
		'head'
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
	^ self contents at: anInteger + 1 put: aValue % 256
]

{ #category : #'private - accessing' }
BFTape >> contents [
	^ contents
]

{ #category : #initialization }
BFTape >> initialize [
	super initialize.
	contents := Array new: 30000 withAll: 0
]
