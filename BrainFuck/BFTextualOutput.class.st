Class {
	#name : #BFTextualOutput,
	#superclass : #BFAbstractMedium,
	#category : #BrainFuck
}

{ #category : #'as yet unclassified' }
BFTextualOutput class >> headClass [
	^ BFTextualOutputHead
]

{ #category : #'as yet unclassified' }
BFTextualOutput class >> identifier [
	^ #tape
]

{ #category : #'private - accessing' }
BFTextualOutput >> at: anInteger [
	self shouldNotImplement
]

{ #category : #'private - accessing' }
BFTextualOutput >> at: anInteger put: aValue [
	self shouldNotImplement
]

{ #category : #initialization }
BFTextualOutput >> initialize [
	super initialize.
	contents := String new writeStream
]

{ #category : #initialization }
BFTextualOutput >> render [
	^ self contents contents
]
