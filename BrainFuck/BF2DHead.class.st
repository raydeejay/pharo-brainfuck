Class {
	#name : #BF2DHead,
	#superclass : #BFAbstractHead,
	#category : #BrainFuck
}

{ #category : #accessing }
BF2DHead >> position [
	^ position ifNil: [ position := 0 ]
]
