Class {
	#name : #BFStandardCommandSet,
	#superclass : #BFCommandSet,
	#category : #BrainFuck
}

{ #category : #initialization }
BFStandardCommandSet >> initialize [
	commands := { 
		$> -> [ :interp | (interp head: #storage) moveForwards ].
		$< -> [ :interp | (interp head: #storage) moveBackwards ].
		$+ -> [ :interp | (interp head: #storage) increment ].
		$- -> [ :interp | (interp head: #storage) decrement ].
		$. -> [ :interp | interp vm output << (interp head: #storage) read asCharacter ].
		$, -> [ :interp | (interp head: #storage) write: interp vm input next charCode ].
		$[ -> [ :interp | interp jumpIfZero ].
		$] -> [ :interp | interp jumpIfNotZero ]
		} asDictionary.
	pairs := { $[ -> $]. $] -> $[ } asDictionary 
]
