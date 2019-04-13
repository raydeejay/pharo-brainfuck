Class {
	#name : #BFDrawCommandSet,
	#superclass : #BFCommandSet,
	#category : #BrainFuck
}

{ #category : #initialization }
BFDrawCommandSet >> initialize [
	commands := { 
		$r -> [ :interp | (interp vm module: #display) headR: (interp vm module: #mainStorage) atHead ].
		$g -> [ :interp | (interp vm module: #display) headG: (interp vm module: #mainStorage) atHead ].
		$b -> [ :interp | (interp vm module: #display) headB: (interp vm module: #mainStorage) atHead ].
		$x -> [ :interp | (interp vm module: #display) headX: (interp vm module: #mainStorage) atHead ].
		$y -> [ :interp | (interp vm module: #display) headY: (interp vm module: #mainStorage) atHead ].		

		$n -> [ :interp | (interp vm module: #display) headDecreaseY ].
		$s -> [ :interp | (interp vm module: #display) headIncreaseY ].
		$w -> [ :interp | (interp vm module: #display) headDecreaseX ].
		$e -> [ :interp | (interp vm module: #display) headIncreaseX ].

		"override the standard output command"
		$. -> [ :interp | (interp vm module: #display) headWrite ].
		
		} asDictionary
]
