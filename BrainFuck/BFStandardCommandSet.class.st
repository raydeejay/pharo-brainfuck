Class {
	#name : #BFStandardCommandSet,
	#superclass : #BFCommandSet,
	#category : #BrainFuck
}

{ #category : #initialization }
BFStandardCommandSet >> initialize [
	commands := { 
		$+ -> [ :vm | (vm module: #tape) incrementAtHead ].
		$- -> [ :vm | (vm module: #tape) decrementAtHead ].
		$< -> [ :vm | (vm module: #tape) moveHeadBackwards ].
		$> -> [ :vm | (vm module: #tape) moveHeadForwards ].
		$, -> [ :vm | (vm module: #tape) atHeadPut: vm input next charCode ].
		$. -> [ :vm | vm output << (vm module: #tape) atHead asCharacter ].
		$[ -> [ :vm | vm jumpIfZero ].
		$] -> [ :vm | vm jumpIfNotZero ]
		 } asDictionary
]
