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
		'heads'
	],
	#category : #BrainFuck
}

{ #category : #'instance creation' }
BFInterpreter class >> bfstack [
	| vm |

	vm := self new.
	^ vm
		addModule: BFStack;
		mainStorage: (vm module: #stack);
		commandSet: BFStandardCommandSet new;
		yourself
]

{ #category : #'instance creation' }
BFInterpreter class >> drawfuck [
	| vm |

	vm := self new.
	vm
		addModule: BFTape;
		addModule: BFDisplay;
		mainStorage: (vm module: #tape);
		commandSet: BFStandardCommandSet new << BFDrawCommandSet new.
	(vm module: #display) show.
	^ vm
]

{ #category : #'instance creation' }
BFInterpreter class >> standard [
	| vm |

	vm := self new.
	^ vm
		addModule: BFTape;
		mainStorage: (vm module: #tape);
		commandSet: BFStandardCommandSet new;
		yourself
]

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

{ #category : #accessing }
BFInterpreter >> heads [
	^ heads ifNil: [ heads := Dictionary new ]
]

{ #category : #'private - accessing' }
BFInterpreter >> heads: anObject [
	heads := anObject
]

{ #category : #interpreting }
BFInterpreter >> interpretOne [
	| each |

	each := self vm program at: self vm index - 1. "take preincrement into account"
	self commandSet commands
		at: each
		ifPresent: [ :cmd | cmd value: self vm ].
	self cycles: self cycles + 1
]

{ #category : #accessing }
BFInterpreter >> vm [
	^ vm
]

{ #category : #'private - accessing' }
BFInterpreter >> vm: aBFMachine [
	vm := aBFMachine
]
