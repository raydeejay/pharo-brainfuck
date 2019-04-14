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
		$. -> [ :interp | (interp head: #output) write: (interp head: #storage) read ].
		$, -> [ :interp | (interp head: #storage) write: (interp head: #input) read ].
		$[ -> [ :interp | interp jumpIfZero ].
		$] -> [ :interp | interp jumpIfNotZero ]
		} asDictionary.
	pairs := { $[ -> $]. $] -> $[ } asDictionary 
]
