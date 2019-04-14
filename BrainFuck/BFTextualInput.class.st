Class {
	#name : #BFTextualInput,
	#superclass : #BFAbstractMedium,
	#instVars : [
		'string'
	],
	#category : #BrainFuck
}

{ #category : #'as yet unclassified' }
BFTextualInput class >> headClass [
	^ BFTextualInputHead
]

{ #category : #'as yet unclassified' }
BFTextualInput class >> identifier [
	^ #tape
]

{ #category : #'instance creation' }
BFTextualInput class >> on: aString [
	^ self new
		contents: aString;
		yourself		
]

{ #category : #'private - accessing' }
BFTextualInput >> at: anInteger [
	self shouldNotImplement
]

{ #category : #'private - accessing' }
BFTextualInput >> at: anInteger put: aValue [
	self shouldNotImplement
]

{ #category : #accessing }
BFTextualInput >> contents: aString [
	contents := aString readStream
]
