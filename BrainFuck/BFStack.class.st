Class {
	#name : #BFStack,
	#superclass : #BFAbstractMedium,
	#category : #BrainFuck
}

{ #category : #'as yet unclassified' }
BFStack class >> headClass [
	^ BFStackHead
]

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

{ #category : #initialization }
BFStack >> initialize [
	super initialize.
	contents := Stack new
]
