Class {
	#name : #BFStandardCommandSet,
	#superclass : #BFCommandSet,
	#category : #BrainFuck
}

{ #category : #initialization }
BFStandardCommandSet >> initialize [
	commands := { 
		$> -> [ :vm | (vm module: #mainStorage) moveHeadForwards ].
		$< -> [ :vm | (vm module: #mainStorage) moveHeadBackwards ].
		$+ -> [ :vm | (vm module: #mainStorage) incrementAtHead ].
		$- -> [ :vm | (vm module: #mainStorage) decrementAtHead ].
		$. -> [ :vm | vm output << (vm module: #mainStorage) atHead asCharacter ].
		$, -> [ :vm | (vm module: #mainStorage) atHeadPut: vm input next charCode ].
		$[ -> [ :vm | vm jumpIfZero ].
		$] -> [ :vm | vm jumpIfNotZero ]
		} asDictionary
]
