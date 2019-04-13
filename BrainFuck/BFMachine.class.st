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

{ #category : #accessing }
BFMachine >> index [
	^ index ifNil: [ index := 1 ]
]

{ #category : #'private - accessing' }
BFMachine >> index: anInteger [
	index := anInteger
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
	[ self index <= self program size ]
		whileTrue: [
			self index: self index + 1.
			self interpreters
				do: [ :each | each interpretOne ] ]
]

{ #category : #accessing }
BFMachine >> interpreters [
	^ interpreters ifNil: [ interpreters := OrderedCollection new ]
]

{ #category : #jumping }
BFMachine >> jumpIfNotZero [
	"skip backwards through the program until the matching closing bracket"

	self loopStack isEmpty ifTrue: [ self error: 'Empty loop stack' ].
	(self module: #mainStorage) atHead isZero
		ifTrue: [ self loopStack pop ]
		ifFalse: [ self index: self loopStack top ]
	

]

{ #category : #jumping }
BFMachine >> jumpIfZero [
	"skip forward through the program until the matching closing bracket"

	(self module: #mainStorage) atHead isZero
		ifFalse: [ self loopStack push: self index ]
		ifTrue: [ [ (self program at: self index) = $] ]
			whileFalse: [ self index: self index + 1 ] ]
]

{ #category : #accessing }
BFMachine >> loopStack [
	^ loopStack ifNil: [ loopStack := Stack new ]
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
