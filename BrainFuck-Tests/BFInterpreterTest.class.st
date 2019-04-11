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
	bfInterpreter := BFInterpreter new
]

{ #category : #tests }
BFInterpreterTest >> testEmptyProgramDoesNothing [
	| result |
	
	result := bfInterpreter
		addModule: BFTape;
		cycles.
	self assert: result equals: 0
]

{ #category : #tests }
BFInterpreterTest >> testOneInstructionConsumesOneCycle [
	| result |
	
	result := bfInterpreter
		addModule: BFTape;
		interpret: '+';
		cycles.
	self assert: result equals: 1
]

{ #category : #tests }
BFInterpreterTest >> testStopsAtTheEndOfTheProgram [
	| result |
	
	result := bfInterpreter
		addModule: BFTape;
		interpret: '+++';
		programCounter.
	self assert: result equals: 3
]
