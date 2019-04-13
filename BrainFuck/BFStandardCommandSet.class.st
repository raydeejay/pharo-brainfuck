Class {
	#name : #BFStandardCommandSet,
	#superclass : #BFCommandSet,
	#category : #BrainFuck
}

{ #category : #initialization }
BFStandardCommandSet >> initialize [
	commands := { 
		$> -> [ :interp | (interp vm module: #mainStorage) moveHeadForwards ].
		$< -> [ :interp | (interp vm module: #mainStorage) moveHeadBackwards ].
		$+ -> [ :interp | (interp vm module: #mainStorage) incrementAtHead ].
		$- -> [ :interp | (interp vm module: #mainStorage) decrementAtHead ].
		$. -> [ :interp | interp vm output << (interp vm module: #mainStorage) atHead asCharacter ].
		$, -> [ :interp | (interp vm module: #mainStorage) atHeadPut: interp vm input next charCode ].
		$[ -> [ :interp | interp vm jumpIfZero ].
		$] -> [ :interp | interp vm jumpIfNotZero ]
		} asDictionary
]
