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
	super setUp.
	bfInterpreter := BFInterpreter new
]

{ #category : #tests }
BFInterpreterCommandsTest >> testCloseBracketClosesInnerLoop [
	| result head |
	
	head := (BFHead on: bfTape) name: #storage; yourself..
	bfInterpreter addHead: head; interpret: '++++[>++[>+<-]<-]>>'.
	result := (bfInterpreter head: #storage) read.
	self assert: result equals: 8
]

{ #category : #tests }
BFInterpreterCommandsTest >> testCloseBracketClosesLoop [
	| result |
	
	bfInterpreter addModule: BFTape; interpret: '++++[>+<-]>'.
	result := (bfInterpreter module: #tape) atHead.
	self assert: result equals: 4
]

{ #category : #tests }
BFInterpreterCommandsTest >> testCommaReadsInputAndReplacesTheValueAtHead [
	| result |
	
	bfInterpreter addModule: BFTape; input: '0'; interpret: ','.
	result := (bfInterpreter module: #tape) atHead asCharacter.
	self assert: result equals: $0
]

{ #category : #tests }
BFInterpreterCommandsTest >> testFullTest [
	| result program char |
	
	program := '+++++++++++++++[>++++>+++++++>+++++<<<-][>.SKIP.]>>>--.<+++++.<--.<,.'.
	char := 'A'.
	result := (bfInterpreter
		addModule: BFTape;
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
		addModule: BFTape;
		interpret: program;
		output) contents.
	self assert: result equals: 'Hello World!', Character lf asString
]

{ #category : #tests }
BFInterpreterCommandsTest >> testLeftMovesTheHeadBackwards [
	| result |
	
	bfInterpreter addModule: BFTape; interpret: '>><'.
	result := (bfInterpreter module: #tape) head.
	self assert: result equals: 1
]

{ #category : #tests }
BFInterpreterCommandsTest >> testMinusDecrementsTheCurrentCell [
	| result |
	
	bfInterpreter addModule: BFTape; interpret: '--'.
	result := (bfInterpreter module: #tape) atHead.
	self assert: result equals: 254
]

{ #category : #tests }
BFInterpreterCommandsTest >> testNoOutputCommandsProducesNoOutput [
	| result program |
	
	program := '+++++'.
	result := (bfInterpreter
		addModule: BFTape;
		interpret: program;
		output) contents.
	self assert: result equals: String empty
]

{ #category : #tests }
BFInterpreterCommandsTest >> testOpenBracketSkipsToTheMatchingCloseBracketIfZero [
	| result |
	
	bfInterpreter addModule: BFTape; interpret: '[[+++]++++]+'.
	result := (bfInterpreter module: #tape) atHead.
	self assert: result equals: 1
]

{ #category : #tests }
BFInterpreterCommandsTest >> testPeriodOutputsTheValueAtHead [
	| result |
	
	result := (bfInterpreter
		addModule: BFTape;
		interpret: (String new: 48 withAll: $+);
		interpret: '.';
		output) contents.
	self assert: result equals: '0'
]

{ #category : #tests }
BFInterpreterCommandsTest >> testPlusIncrementsTheCurrentCell [
	| result |
	
	bfInterpreter addModule: BFTape; interpret: '++'.
	result := (bfInterpreter module: #tape) atHead.
	self assert: result equals: 2
]

{ #category : #tests }
BFInterpreterCommandsTest >> testRightAdvancesTheHead [
	| result |
	
	bfInterpreter addModule: BFTape; interpret: '>>'.
	result := (bfInterpreter module: #tape) head.
	self assert: result equals: 2
]

{ #category : #tests }
BFInterpreterCommandsTest >> testUndefinedCharactersAreIgnored [
	| result |
	
	bfInterpreter addModule: BFTape; interpret: 'Loops four times increment twice by one
	++++ [            increment the value at cell 0 by 4 and loop until 0
		> ++ [         increment the value at cell 1 by 2 and loop until 0
			> + < - ]   increment the value at cell 2 and decrement the value at cell 1
		< - ]          decrement the value at cell 0
	>>                move the head to cell 2'.
	result := (bfInterpreter module: #tape) atHead.
	self assert: result equals: 8
]
