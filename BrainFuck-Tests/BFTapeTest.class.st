Class {
	#name : #BFTapeTest,
	#superclass : #TestCase,
	#instVars : [
		'bfInterpreter',
		'bfTape'
	],
	#category : #'BrainFuck-Tests'
}

{ #category : #running }
BFTapeTest >> setUp [
	super setUp.
	bfTape := BFTape new.
]

{ #category : #tests }
BFTapeTest >> testTapeAdvancesByOne [
	| result |
	
	result := bfTape moveHeadForwards head.
	self assert: result equals: 1
]

{ #category : #tests }
BFTapeTest >> testTapeCellsHoldIntegers [
	| result |
	
	result := bfTape incrementAtHead atHead.
	self assert: result equals: 1
]

{ #category : #tests }
BFTapeTest >> testTapeCellsHoldUnsigned8BitIntegers [
	| result |
	
	result := bfTape decrementAtHead atHead.
	self assert: result equals: 255
]

{ #category : #tests }
BFTapeTest >> testTapeCellsHoldZeroByDefault [
	| result |
	
	result := bfTape atHead.
	self assert: result equals: 0
]

{ #category : #tests }
BFTapeTest >> testTapeDoesNotWrap [
	| result |
	
	self
		should: [ result := bfTape moveHeadBackwards head ]
		raise: Error
		whoseDescriptionIncludes: 'Head attempted to move past the beginning of the tape'
		description: 'Should get the proper error'
]

{ #category : #tests }
BFTapeTest >> testTapeDoesNotWrapAtTheEnd [
	| result |
	
	self
		should: [ result := bfTape moveHeadTo: (bfTape contents size) ]
		raise: Error
		whoseDescriptionIncludes: 'Head attempted to move past the end of the tape'
		description: 'Should get the proper error'
]

{ #category : #tests }
BFTapeTest >> testTapeDoesNotWrapAtTheEndTwo [
	| result |
	
	self
		should: [ result := bfTape moveHeadTo: bfTape contents size - 1; moveHeadForwards ]
		raise: Error
		whoseDescriptionIncludes: 'Head attempted to move past the end of the tape'
		description: 'Should get the proper error'
]

{ #category : #tests }
BFTapeTest >> testTapeHeadCanBeAtTheEnd [
	| result |
	
	result := bfTape moveHeadTo: bfTape contents size - 1; atHead.
	self assert: result equals: 0
]
