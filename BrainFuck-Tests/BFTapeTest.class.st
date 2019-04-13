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
	| result head |
	
	head := BFHead on: bfTape.	
	result := head moveForwards position.
	self assert: result equals: 1
]

{ #category : #tests }
BFTapeTest >> testTapeCellsHoldIntegers [
	| result head |
	
	head := BFHead on: bfTape.	
	result := head increment read.
	self assert: result equals: 1
]

{ #category : #tests }
BFTapeTest >> testTapeCellsHoldUnsigned8BitIntegers [
	| result head |
	
	head := BFHead on: bfTape.	
	result := head decrement read.
	self assert: result equals: 255
]

{ #category : #tests }
BFTapeTest >> testTapeCellsHoldZeroByDefault [
	| result head |
	
	head := BFHead on: bfTape.
	result := head read.
	self assert: result equals: 0
]

{ #category : #tests }
BFTapeTest >> testTapeDoesNotWrap [
	| result head |
	
	head := BFHead on: bfTape.
	self
		should: [ result := head moveBackwards position ]
		raise: Error
		whoseDescriptionIncludes: 'Head attempted to move past the beginning of the tape'
		description: 'Should get the proper error'
]

{ #category : #tests }
BFTapeTest >> testTapeDoesNotWrapAtTheEnd [
	| result head |
	
	head := BFHead on: bfTape.
	self
		should: [ result := head moveTo: (bfTape contents size) ]
		raise: Error
		whoseDescriptionIncludes: 'Head attempted to move past the end of the tape'
		description: 'Should get the proper error'
]

{ #category : #tests }
BFTapeTest >> testTapeDoesNotWrapAtTheEndTwo [
	| result 	head |
		
	head := BFHead on: bfTape.
	self
		should: [ result := head moveTo: bfTape contents size - 1; moveForwards ]
		raise: Error
		whoseDescriptionIncludes: 'Head attempted to move past the end of the tape'
		description: 'Should get the proper error'
]

{ #category : #tests }
BFTapeTest >> testTapeHeadCanBeAtTheEnd [
	| result head |
	
	head := BFHead on: bfTape.
	result := head moveTo: bfTape contents size - 1; read.
	self assert: result equals: 0
]
