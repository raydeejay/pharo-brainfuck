Class {
	#name : #BFInterpreterCommandsTest,
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
BFInterpreterCommandsTest >> setUp [
	super setUp.
	bfTape := BFTape new.
	bfHead := (BFHead on: bfTape) name: #storage; yourself.
	bfInterpreter := BFInterpreter new addHead: bfHead; yourself.
	bfVM := BFMachine new addInterpreter: bfInterpreter; yourself.
]

{ #category : #tests }
BFInterpreterCommandsTest >> testCloseBracketClosesInnerLoop [
	| result |
	
	bfVM interpret: '++++[>++[>+<-]<-]>>'.
	result := bfHead read.
	self assert: result equals: 8
]

{ #category : #tests }
BFInterpreterCommandsTest >> testCloseBracketClosesLoop [
	| result |
	
	bfVM interpret: '++++[>+<-]>'.
	result := bfHead read.
	self assert: result equals: 4
]

{ #category : #tests }
BFInterpreterCommandsTest >> testCommaReadsInputAndReplacesTheValueAtHead [
	| result |
	
	bfVM input: '0'; interpret: ','.
	result := bfHead read asCharacter.
	self assert: result equals: $0
]

{ #category : #tests }
BFInterpreterCommandsTest >> testFullTest [
	| result program char |
	
	program := '+++++++++++++++[>++++>+++++++>+++++<<<-][>.SKIP.]>>>--.<+++++.<--.<,.'.
	char := 'A'.
	result := (bfVM
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
	result := (bfVM
		interpret: program;
		output) contents.
	self assert: result equals: 'Hello World!', Character lf asString
]

{ #category : #tests }
BFInterpreterCommandsTest >> testLeftMovesTheHeadBackwards [
	| result |
	
	bfVM interpret: '>><'.
	result := bfHead position.
	self assert: result equals: 1
]

{ #category : #tests }
BFInterpreterCommandsTest >> testMinusDecrementsTheCurrentCell [
	| result |
	
	bfVM interpret: '--'.
	result := bfHead read.
	self assert: result equals: 254
]

{ #category : #tests }
BFInterpreterCommandsTest >> testNoOutputCommandsProducesNoOutput [
	| result program |
	
	program := '+++++'.
	result := (bfVM
		interpret: program;
		output) contents.
	self assert: result equals: String empty
]

{ #category : #tests }
BFInterpreterCommandsTest >> testOpenBracketSkipsToTheMatchingCloseBracketIfZero [
	| result |
	
	bfVM interpret: '[[+++]++++]+'.
	result := bfHead read.
	self assert: result equals: 1
]

{ #category : #tests }
BFInterpreterCommandsTest >> testPeriodOutputsTheValueAtHead [
	| result |
	
	result := (bfVM
		interpret: (String new: 48 withAll: $+);
		interpret: '.';
		output) contents.
	self assert: result equals: '0'
]

{ #category : #tests }
BFInterpreterCommandsTest >> testPlusIncrementsTheCurrentCell [
	| result |
	
	bfVM interpret: '++'.
	result := bfHead read.
	self assert: result equals: 2
]

{ #category : #tests }
BFInterpreterCommandsTest >> testRightAdvancesTheHead [
	| result |
	
	bfVM interpret: '>>'.
	result := bfHead position.
	self assert: result equals: 2
]

{ #category : #tests }
BFInterpreterCommandsTest >> testUndefinedCharactersAreIgnored [
	| result |
	
	bfVM interpret: 'Loops four times increment twice by one
	++++ [            increment the value at cell 0 by 4 and loop until 0
		> ++ [         increment the value at cell 1 by 2 and loop until 0
			> + < - ]   increment the value at cell 2 and decrement the value at cell 1
		< - ]          decrement the value at cell 0
	>>                move the head to cell 2'.
	result := bfHead read.
	self assert: result equals: 8
]
