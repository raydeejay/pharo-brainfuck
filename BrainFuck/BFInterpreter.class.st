"
I am a Brainfuck interpreter/VM

I interpret instructions, manage memory, do I/O

Public API and Key Messages

- interpret:

	BFInterpreter new interpret: ""++.""

"
Class {
	#name : #BFInterpreter,
	#superclass : #Object,
	#instVars : [
		'cycles',
		'commandSet',
		'vm',
		'heads',
		'index',
		'loopStack'
	],
	#category : #BrainFuck
}

{ #category : #configuring }
BFInterpreter >> addCommandSet: aCommandSetClass [ 
	self commandSet: aCommandSetClass
]

{ #category : #configuring }
BFInterpreter >> addHead: aBFHead [
	self heads
		at: aBFHead name
		put: aBFHead
]

{ #category : #accessing }
BFInterpreter >> commandSet [
	^ commandSet ifNil: [ commandSet := BFStandardCommandSet new ]
]

{ #category : #'private - accessing' }
BFInterpreter >> commandSet: anObject [
	commandSet := anObject
]

{ #category : #accessing }
BFInterpreter >> cycles [
	^ cycles ifNil: [ cycles := 0 ]
]

{ #category : #'private - accessing' }
BFInterpreter >> cycles: anObject [
	cycles := anObject
]

{ #category : #'as yet unclassified' }
BFInterpreter >> head: aSymbol [
	^ self heads at: aSymbol
]

{ #category : #accessing }
BFInterpreter >> heads [
	^ heads ifNil: [ heads := Dictionary new ]
]

{ #category : #accessing }
BFInterpreter >> index [
	^ index ifNil: [ index := 1 ]
]

{ #category : #'private - accessing' }
BFInterpreter >> index: anInteger [
	index := anInteger
]

{ #category : #interpreting }
BFInterpreter >> interpretOne [
	| each |

	self isHalted ifTrue: [ ^ self ].
	
	self index: self index + 1.
	each := self vm program at: self index - 1.	 "take preincrement into account"
	self commandSet commands
		at: each
		ifPresent: [ :cmd | cmd value: self ].
	self cycles: self cycles + 1
]

{ #category : #testing }
BFInterpreter >> isHalted [
	^ self index > self vm program size
]

{ #category : #jumping }
BFInterpreter >> jumpIfNotZero [
	"skip backwards through the program until the matching closing bracket"

	self loopStack isEmpty ifTrue: [ self error: 'Empty loop stack' ].
	(self head: #storage) read isZero
		ifTrue: [ self loopStack pop ]
		ifFalse: [ self index: self loopStack top first ]
]

{ #category : #jumping }
BFInterpreter >> jumpIfZero [
	"skip forward through the program until the matching closing bracket"
	| depth |

	self loopStack push: {
		self index.
		self vm program at: self index - 1.
		commandSet matchingCharFor: (self vm program at: self index - 1) }.
	(self head: #storage) read isZero ifFalse: [ ^ self ].
	
	depth := 1.	
	[ depth isZero ] whileFalse: [
		| char |
		
		char := (self vm program at: self index).
		char = (loopStack top second) ifTrue: [ depth := depth + 1 ].
		char = (loopStack top third) ifTrue: [ depth := depth - 1 ].
		self index: self index + 1 ]
]

{ #category : #accessing }
BFInterpreter >> loopStack [
	^ loopStack ifNil: [ loopStack := Stack new ]
]

{ #category : #accessing }
BFInterpreter >> vm [
	^ vm
]

{ #category : #'private - accessing' }
BFInterpreter >> vm: aBFMachine [
	vm := aBFMachine
]
