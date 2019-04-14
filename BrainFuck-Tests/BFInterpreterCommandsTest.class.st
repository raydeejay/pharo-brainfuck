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
	bfHead := bfTape newHead: #storage.
	bfInterpreter := BFInterpreter new
		addHead: bfHead;
		addHead: (BFTextualInput new newHead: #input);
		addHead: (BFTextualOutput new newHead: #output);
		yourself.
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
	
	(bfInterpreter head: #input) storage contents: '0'.
	bfVM interpret: ','.
	result := bfHead read asCharacter.
	self assert: result equals: $0
]

{ #category : #tests }
BFInterpreterCommandsTest >> testFullTest [
	| result program |
	
	program := '+++++++++++++++[>++++>+++++++>+++++<<<-][>.SKIP.]>>>--.<+++++.<--.<,.'.
	(bfInterpreter head: #input) storage contents: 'A'.
	bfVM interpret: program.
	result := (bfInterpreter head: #output) storage render.
	self assert: result equals: 'In:', 'A'
]

{ #category : #tests }
BFInterpreterCommandsTest >> testHelloWorldOutputsHelloWorld [
	| result program |
	
	program := '
		++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.'.
	bfVM interpret: program.
	result := (bfInterpreter head: #output) storage render.
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
	bfVM interpret: program.
	result := (bfInterpreter head: #output) storage render.
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
	
	bfVM
		interpret: (String new: 48 withAll: $+);
		interpret: '.'.
	result := (bfInterpreter head: #output) storage render.
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
