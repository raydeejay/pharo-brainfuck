"
A BFInterpreterTest is a test class for testing the behavior of BFInterpreter
"
Class {
	#name : #BFInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'bfInterpreter',
		'bfTape'
	],
	#category : #'BrainFuck-Tests'
}

{ #category : #running }
BFInterpreterTest >> setUp [
	super setUp.
	bfInterpreter := BFInterpreter new.
	bfTape := BFTape new
]

{ #category : #tests }
BFInterpreterTest >> testChangingTheTapeRewindsIt [
	| result |
	
	bfTape moveHeadForwards.
	bfInterpreter tape: bfTape.
	result := bfTape head.
	self assert: result equals: 0
]

{ #category : #tests }
BFInterpreterTest >> testEmptyProgramDoesNothing [
	| result |
	
	result := bfInterpreter
		tape: bfTape;
		cycles.
	self assert: result equals: 0
]

{ #category : #tests }
BFInterpreterTest >> testOneInstructionConsumesOneCycle [
	| result |
	
	result := bfInterpreter
		tape: bfTape;
		interpret: '+';
		cycles.
	self assert: result equals: 1
]

{ #category : #tests }
BFInterpreterTest >> testStopsAtTheEndOfTheProgram [
	| result |
	
	result := bfInterpreter
		tape: bfTape;
		interpret: '+++';
		programCounter.
	self assert: result equals: 3
]
