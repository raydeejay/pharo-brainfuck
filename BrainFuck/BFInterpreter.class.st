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
		'tape',
		'program',
		'output',
		'index',
		'cycles',
		'input',
		'commandSet'
	],
	#category : #BrainFuck
}

{ #category : #interpreting }
BFInterpreter >> commandSet [
	^ commandSet ifNil: [ commandSet := BFStandardCommandSet new ]
]

{ #category : #interpreting }
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

{ #category : #accessing }
BFInterpreter >> index [
	^ index ifNil: [ index := 1 ]
]

{ #category : #'private - accessing' }
BFInterpreter >> index: anObject [
	index := anObject
]

{ #category : #'input/output' }
BFInterpreter >> input [
	^ input
]

{ #category : #'input/output' }
BFInterpreter >> input: aString [ 
	input := aString readStream 
]

{ #category : #interpreting }
BFInterpreter >> interpret [
	self index: 1.
	[ self index <= self program size ]
		whileTrue: [
			| each |
			
			each := self program at: index.
			self commandSet commands
				at: each
				ifPresent: [ :cmd | cmd value: self ].
			index := index + 1.
			self cycles: self cycles + 1 ]
]

{ #category : #interpreting }
BFInterpreter >> interpret: aString [
	self program: aString.
	self index: 1.
	self interpret
]

{ #category : #jumping }
BFInterpreter >> jumpIfNotZero [
	"skip backwards through the program until the matching closing bracket"
	| pairs |
	
	pairs := 1.
	self tape atHead isZero ifTrue: [ ^ self ].
	self index: self index - 1.
	[ pairs > 0 ]
		whileTrue: [
			(self program at: self index) = $] ifTrue: [ pairs := pairs + 1 ].
			(self program at: self index) = $[ ifTrue: [ pairs := pairs - 1 ].
			self index: self index - 1 ].
	self index: self index + 1
]

{ #category : #jumping }
BFInterpreter >> jumpIfZero [
	"skip forward through the program until the matching closing bracket"
	| pairs |
	
	pairs := 1.
	self tape atHead isZero ifFalse: [ ^ self ].
	self index: self index + 1.
	[ pairs > 0 ]
		whileTrue: [
			(self program at: self index) = $[ ifTrue: [ pairs := pairs + 1 ].
			(self program at: self index) = $] ifTrue: [ pairs := pairs - 1 ].
			self index: self index + 1 ].
	self index: self index - 1
]

{ #category : #'input/output' }
BFInterpreter >> output [
	^ output ifNil: [ output := String new writeStream ]
]

{ #category : #accessing }
BFInterpreter >> program [
	^ program ifNil: [ program := String empty ]
]

{ #category : #accessing }
BFInterpreter >> program: anObject [
	program := anObject
]

{ #category : #accessing }
BFInterpreter >> programCounter [
	^ self index - 1
]

{ #category : #accessing }
BFInterpreter >> tape [
	^ tape
]

{ #category : #accessing }
BFInterpreter >> tape: aBFTape [ 
	tape := aBFTape.
	tape rewind
]
