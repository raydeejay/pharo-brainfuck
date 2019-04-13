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
	| result head |
	
	head := BFHead on: (BFTape new name: #storage; yourself).
	result := bfInterpreter
		addHead: head;
		cycles.
	self assert: result equals: 0
]

{ #category : #tests }
BFInterpreterTest >> testOneInstructionConsumesOneCycle [
	| result head |
	
	head := (BFHead on: BFTape new) name: #storage; yourself.
	bfInterpreter addHead: head.
	BFMachine new
		addInterpreter: bfInterpreter;
		interpret: '+'.
	result := bfInterpreter cycles.
	self assert: result equals: 1
]

{ #category : #tests }
BFInterpreterTest >> testStopsAtTheEndOfTheProgram [
	| result head |
	
	head := (BFHead on: BFTape new) name: #storage; yourself.
	bfInterpreter addHead: head.
	BFMachine new
		addInterpreter: bfInterpreter;
		interpret: '+++'.
	result := bfInterpreter index.
	self assert: result equals: 4
]
