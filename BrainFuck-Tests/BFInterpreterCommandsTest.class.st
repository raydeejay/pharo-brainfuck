Class {
	#name : #BFInterpreterCommandsTest,
	#superclass : #TestCase,
	#instVars : [
		'bfInterpreter',
		'bfTape'
	],
	#category : #'BrainFuck-Tests'
}

{ #category : #running }
BFInterpreterCommandsTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	bfInterpreter := BFInterpreter new.
	bfTape := BFTape new.
]

{ #category : #tests }
BFInterpreterCommandsTest >> testCloseBracketClosesInnerLoop [
	| result |
	
	bfInterpreter tape: bfTape; interpret: '++++[>++[>+<-]<-]>>'.
	result := bfTape atHead.
	self assert: result equals: 8
]

{ #category : #tests }
BFInterpreterCommandsTest >> testCloseBracketClosesLoop [
	| result |
	
	bfInterpreter tape: bfTape; interpret: '++++[>+<-]>'.
	result := bfTape atHead.
	self assert: result equals: 4
]

{ #category : #tests }
BFInterpreterCommandsTest >> testCommaReadsInputAndReplacesTheValueAtHead [
	| result |
	
	bfInterpreter tape: bfTape; input: '0'; interpret: ','.
	result := bfTape atHead asCharacter.
	self assert: result equals: $0
]

{ #category : #tests }
BFInterpreterCommandsTest >> testFullTest [
	| result program char |
	
	program := '+++++++++++++++[>++++>+++++++>+++++<<<-][>.SKIP.]>>>--.<+++++.<--.<,.'.
	char := 'A'.
	result := (bfInterpreter
		tape: bfTape;
		input: char;
		interpret: program;
		output) contents.
	self assert: result equals: 'In:', char
]

{ #category : #tests }
BFInterpreterCommandsTest >> testHelloWorldOutputsHelloWorld [
	| result program |
	
	program := '
		++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.'.
	result := (bfInterpreter
		tape: bfTape;
		interpret: program;
		output) contents.
	self assert: result equals: 'Hello World!', Character lf asString
]

{ #category : #tests }
BFInterpreterCommandsTest >> testLeftMovesTheHeadBackwards [
	| result |
	
	bfInterpreter tape: bfTape; interpret: '>><'.
	result := bfTape head.
	self assert: result equals: 1
]

{ #category : #tests }
BFInterpreterCommandsTest >> testMinusDecrementsTheCurrentCell [
	| result |
	
	bfInterpreter tape: bfTape; interpret: '--'.
	result := bfTape atHead.
	self assert: result equals: 254
]

{ #category : #tests }
BFInterpreterCommandsTest >> testNoOutputCommandsProducesNoOutput [
	| result program |
	
	program := '+++++'.
	result := (bfInterpreter
		tape: bfTape;
		interpret: program;
		output) contents.
	self assert: result equals: String empty
]

{ #category : #tests }
BFInterpreterCommandsTest >> testOpenBracketSkipsToTheMatchingCloseBracketIfZero [
	| result |
	
	bfInterpreter tape: bfTape; interpret: '[[+++]++++]+'.
	result := bfTape atHead.
	self assert: result equals: 1
]

{ #category : #tests }
BFInterpreterCommandsTest >> testPeriodOutputsTheValueAtHead [
	| result |
	
	result := (bfInterpreter
		tape: bfTape;
		interpret: (String new: 48 withAll: $+);
		interpret: '.';
		output) contents.
	self assert: result equals: '0'
]

{ #category : #tests }
BFInterpreterCommandsTest >> testPlusIncrementsTheCurrentCell [
	| result |
	
	bfInterpreter tape: bfTape; interpret: '++'.
	result := bfTape atHead.
	self assert: result equals: 2
]

{ #category : #tests }
BFInterpreterCommandsTest >> testRightAdvancesTheHead [
	| result |
	
	bfInterpreter tape: bfTape; interpret: '>>'.
	result := bfTape head.
	self assert: result equals: 2
]

{ #category : #tests }
BFInterpreterCommandsTest >> testUndefinedCharactersAreIgnored [
	| result |
	
	bfInterpreter tape: bfTape; interpret: 'Loops four times increment twice by one
	++++ [            increment the value at cell 0 by 4 and loop until 0
		> ++ [         increment the value at cell 1 by 2 and loop until 0
			> + < - ]   increment the value at cell 2 and decrement the value at cell 1
		< - ]          decrement the value at cell 0
	>>                move the head to cell 2'.
	result := bfTape atHead.
	self assert: result equals: 8
]
