"
I am a virtual machine in with Brainfuck-related languages can run.

I know about the hardware of the machine, and allow my modules to access it.

I use one or more storage modules, input/output modules, CommandSets, and interpreters.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	commandSet:		<Object>
	cycles:		<Object>
	index:		<Object>
	input:		<Object>
	modules:		<Object>
	output:		<Object>
	program:		<Object>


    Implementation Points
"
Class {
	#name : #BFMachine,
	#superclass : #Object,
	#instVars : [
		'modules',
		'input',
		'output',
		'program',
		'index',
		'loopStack',
		'interpreter',
		'cycles'
	],
	#category : #BrainFuck
}

{ #category : #modules }
BFMachine >> addInterpreter: aBFInterpreter [ 
	interpreter := aBFInterpreter vm: self; yourself
]

{ #category : #modules }
BFMachine >> addModule: aModuleClass [
	self modules at: aModuleClass identifier put: aModuleClass new
]

{ #category : #accessing }
BFMachine >> cycles [
	^ cycles ifNil: [ cycles := 0 ]
]

{ #category : #'private - accessing' }
BFMachine >> cycles: anObject [
	cycles := anObject
]

{ #category : #accessing }
BFMachine >> index [
	^ index ifNil: [ index := 1 ]
]

{ #category : #'private - accessing' }
BFMachine >> index: anObject [
	index := anObject
]

{ #category : #'input/output' }
BFMachine >> input [
	^ input
]

{ #category : #'input/output' }
BFMachine >> input: aString [ 
	input := aString readStream 
]

{ #category : #interpreting }
BFMachine >> interpret: aString [
	self program: aString.
	self index: 1.
	interpreter interpret
]

{ #category : #jumping }
BFMachine >> jumpIfNotZero [
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
BFMachine >> jumpIfZero [
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

{ #category : #modules }
BFMachine >> mainStorage: aBFStorage [ 
	self modules at: #mainStorage put: aBFStorage
]

{ #category : #modules }
BFMachine >> module: aSymbol [
	^ self modules at: aSymbol ifAbsent: [ self error: 'The VM lacks module ', aSymbol printString ]
]

{ #category : #modules }
BFMachine >> modules [
	^ modules ifNil: [ modules := Dictionary new ]
]

{ #category : #'input/output' }
BFMachine >> output [
	^ output ifNil: [ output := String new writeStream ]
]

{ #category : #accessing }
BFMachine >> program [
	^ program ifNil: [ program := String empty ]
]

{ #category : #accessing }
BFMachine >> program: anObject [
	program := anObject.
	self index: 1
]

{ #category : #accessing }
BFMachine >> programCounter [
	^ self index - 1
]
