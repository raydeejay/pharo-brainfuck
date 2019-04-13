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
		'cycles',
		'interpreters'
	],
	#category : #BrainFuck
}

{ #category : #modules }
BFMachine >> addInterpreter: aBFInterpreter [ 
	self interpreters add: (aBFInterpreter vm: self; yourself)
]

{ #category : #modules }
BFMachine >> addModule: aModule [
	self addModule: aModule withName: aModule name
]

{ #category : #modules }
BFMachine >> addModule: aModule withName: aSymbol [
	self modules at: aSymbol put: aModule
]

{ #category : #accessing }
BFMachine >> cycles [
	^ cycles ifNil: [ cycles := 0 ]
]

{ #category : #'private - accessing' }
BFMachine >> cycles: anObject [
	cycles := anObject
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
	self interpreters do: [ :each | each index: 1 ].
	[ self interpreters allSatisfy: #isHalted ]
		whileFalse: [ self interpreters
			do: [ :each | each interpretOne ] ]
]

{ #category : #accessing }
BFMachine >> interpreters [
	^ interpreters ifNil: [ interpreters := OrderedCollection new ]
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
	program := anObject
]
