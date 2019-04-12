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
		'program',
		'output',
		'index',
		'cycles',
		'input',
		'commandSet',
		'modules'
	],
	#category : #BrainFuck
}

{ #category : #commands }
BFInterpreter >> addCommandSet: aCommandSetClass [ 
	self commandSet: aCommandSetClass
]

{ #category : #modules }
BFInterpreter >> addModule: aModuleClass [
	self modules at: aModuleClass identifier put: aModuleClass new
]

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
	[ self index <= self program size ] whileTrue: [ self interpretOne ]
]

{ #category : #interpreting }
BFInterpreter >> interpret: aString [
	self program: aString.
	self index: 1.
	self interpret
]

{ #category : #interpreting }
BFInterpreter >> interpretOne [
	| each |

	each := self program at: index.
	self commandSet commands
		at: each
		ifPresent: [ :cmd | cmd value: self ].
	index := index + 1.
	^ self cycles: self cycles + 1
]

{ #category : #jumping }
BFInterpreter >> jumpIfNotZero [
	"skip backwards through the program until the matching closing bracket"
	| pairs |
	
	pairs := 1.
	(self module: #mainStorage) atHead isZero ifTrue: [ ^ self ].
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
	(self module: #mainStorage) atHead isZero ifFalse: [ ^ self ].
	self index: self index + 1.
	[ pairs > 0 ]
		whileTrue: [
			(self program at: self index) = $[ ifTrue: [ pairs := pairs + 1 ].
			(self program at: self index) = $] ifTrue: [ pairs := pairs - 1 ].
			self index: self index + 1 ].
	self index: self index - 1
]

{ #category : #'as yet unclassified' }
BFInterpreter >> mainStorage: aBFStorage [ 
	self modules at: #mainStorage put: aBFStorage
]

{ #category : #modules }
BFInterpreter >> module: aSymbol [
	^ self modules at: aSymbol ifAbsent: [ self error: 'The VM lacks module ', aSymbol printString ]
]

{ #category : #modules }
BFInterpreter >> modules [
	^ modules ifNil: [ modules := Dictionary new ]
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
	program := anObject.
	self index: 1
]

{ #category : #accessing }
BFInterpreter >> programCounter [
	^ self index - 1
]
