Class {
	#name : #BFSubstitution,
	#superclass : #Object,
	#category : #BrainFuck
}

{ #category : #'instance creation' }
BFSubstitution >> commandSet [
	| cmdset newDict |
	
	cmdset := BFStandardCommandSet new.
	newDict := self translateCommandSet: cmdset commands.
	cmdset commands removeAll addAll: newDict.
	^ cmdset
]
