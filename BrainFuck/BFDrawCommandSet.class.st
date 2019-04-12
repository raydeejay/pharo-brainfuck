Class {
	#name : #BFDrawCommandSet,
	#superclass : #BFCommandSet,
	#category : #BrainFuck
}

{ #category : #initialization }
BFDrawCommandSet >> initialize [
	commands := { 
		$r -> [ :vm | (vm module: #display) headR: (vm module: #mainStorage) atHead ].
		$g -> [ :vm | (vm module: #display) headG: (vm module: #mainStorage) atHead ].
		$b -> [ :vm | (vm module: #display) headB: (vm module: #mainStorage) atHead ].
		$x -> [ :vm | (vm module: #display) headX: (vm module: #mainStorage) atHead ].
		$y -> [ :vm | (vm module: #display) headY: (vm module: #mainStorage) atHead ].		

		$n -> [ :vm | (vm module: #display) headDecreaseY ].
		$s -> [ :vm | (vm module: #display) headIncreaseY ].
		$w -> [ :vm | (vm module: #display) headDecreaseX ].
		$e -> [ :vm | (vm module: #display) headIncreaseX ].

		"override the standard output command"
		$. -> [ :vm | (vm module: #display) headWrite ].
		
		} asDictionary
]
