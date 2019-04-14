Class {
	#name : #BFAbstractMedium,
	#superclass : #Object,
	#instVars : [
		'name',
		'contents'
	],
	#category : #BrainFuck
}

{ #category : #'as yet unclassified' }
BFAbstractMedium class >> headClass [
	"each subclass should provide the required Head class"
	self subclassResponsibility 
]

{ #category : #'private - accessing' }
BFAbstractMedium >> contents [
	^ contents
]

{ #category : #accessing }
BFAbstractMedium >> name [
	^ name
]

{ #category : #accessing }
BFAbstractMedium >> name: anObject [
	name := anObject
]

{ #category : #'instance creation' }
BFAbstractMedium >> newHead: aSymbol [
	^ (self class headClass on: self)
		name: aSymbol;
		yourself
]
