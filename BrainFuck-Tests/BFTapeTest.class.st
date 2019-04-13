Class {
	#name : #BFTapeTest,
	#superclass : #TestCase,
	#instVars : [
		'bfInterpreter',
		'bfTape',
		'bfHead'
	],
	#category : #'BrainFuck-Tests'
}

{ #category : #running }
BFTapeTest >> setUp [
	super setUp.
	bfTape := BFTape new.
	bfHead := (BFHead on: bfTape) name: #storage; yourself.
]

{ #category : #tests }
BFTapeTest >> testTapeAdvancesByOne [
	| result |
	
	result := bfHead moveForwards position.
	self assert: result equals: 1
]

{ #category : #tests }
BFTapeTest >> testTapeCellsHoldIntegers [
	| result |
	
	result := bfHead increment read.
	self assert: result equals: 1
]

{ #category : #tests }
BFTapeTest >> testTapeCellsHoldUnsigned8BitIntegers [
	| result |
	
	result := bfHead decrement read.
	self assert: result equals: 255
]

{ #category : #tests }
BFTapeTest >> testTapeCellsHoldZeroByDefault [
	| result |
	
	result := bfHead read.
	self assert: result equals: 0
]

{ #category : #tests }
BFTapeTest >> testTapeDoesNotWrap [
	| result |
	
	self
		should: [ result := bfHead moveBackwards position ]
		raise: Error
		whoseDescriptionIncludes: 'Head attempted to move past the beginning of the tape'
		description: 'Should get the proper error'
]

{ #category : #tests }
BFTapeTest >> testTapeDoesNotWrapAtTheEnd [
	| result |
	
	self
		should: [ result := bfHead moveTo: (bfTape contents size) ]
		raise: Error
		whoseDescriptionIncludes: 'Head attempted to move past the end of the tape'
		description: 'Should get the proper error'
]

{ #category : #tests }
BFTapeTest >> testTapeDoesNotWrapAtTheEndTwo [
	| result 	|
		
	self
		should: [ result := bfHead moveTo: bfTape contents size - 1; moveForwards ]
		raise: Error
		whoseDescriptionIncludes: 'Head attempted to move past the end of the tape'
		description: 'Should get the proper error'
]

{ #category : #tests }
BFTapeTest >> testTapeHeadCanBeAtTheEnd [
	| result |
	
	result := bfHead moveTo: bfTape contents size - 1; read.
	self assert: result equals: 0
]
