"
A BFInterpreterTest is a test class for testing the behavior of BFInterpreter
"
Class {
	#name : #BFInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'bfInterpreter',
		'bfTape',
		'bfHead',
		'bfVM'
	],
	#category : #'BrainFuck-Tests'
}

{ #category : #running }
BFInterpreterTest >> setUp [
	super setUp.
	bfTape := BFTape new.
	bfHead := bfTape newHead: #storage.
	bfInterpreter := BFInterpreter new
		addHead: bfHead;
		addCommandSet: BFStandardCommandSet new;
		yourself.
	bfVM := BFMachine new addInterpreter: bfInterpreter
]

{ #category : #tests }
BFInterpreterTest >> testEmptyProgramDoesNothing [
	| result |
	
	result := bfInterpreter cycles.
	self assert: result equals: 0
]

{ #category : #tests }
BFInterpreterTest >> testOneInstructionConsumesOneCycle [
	| result |
	
	bfVM interpret: '+'.
	result := bfInterpreter cycles.
	self assert: result equals: 1
]

{ #category : #tests }
BFInterpreterTest >> testStopsAtTheEndOfTheProgram [
	| result |
	
	bfVM interpret: '+++'.
	result := bfInterpreter index.
	self assert: result equals: 4
]
