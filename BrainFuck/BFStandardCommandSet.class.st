Class {
	#name : #BFStandardCommandSet,
	#superclass : #BFCommandSet,
	#category : #BrainFuck
}

{ #category : #initialization }
BFStandardCommandSet >> initialize [
	commands := { 
		$+ -> [ :vm | vm tape incrementAtHead ].
		$- -> [ :vm | vm tape decrementAtHead ].
		$< -> [ :vm | vm tape moveHeadBackwards ].
		$> -> [ :vm | vm tape moveHeadForwards ].
		$, -> [ :vm | vm tape atHeadPut: vm input next charCode ].
		$. -> [ :vm | vm output << vm tape atHead asCharacter ].
		$[ -> [ :vm | vm jumpIfZero ].
		$] -> [ :vm | vm jumpIfNotZero ]
		 } asDictionary
]
