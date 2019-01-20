Class {
	#name : #SSIOStrategy,
	#superclass : #Object,
	#instVars : [
		'port'
	],
	#category : #SerialStream
}

{ #category : #'as yet unclassified' }
SSIOStrategy class >> for: aPort [
	^ self new port: aPort ; configure; yourself.
]

{ #category : #'as yet unclassified' }
SSIOStrategy >> becomeMonothread [ 
	^ SSMonoThreadStrategy for: port.
]

{ #category : #'as yet unclassified' }
SSIOStrategy >> cleanUpBuffer [
	
]

{ #category : #'as yet unclassified' }
SSIOStrategy >> configure [
]

{ #category : #'as yet unclassified' }
SSIOStrategy >> nextPut: aCharacter [
	^ port nextPut: aCharacter.
]

{ #category : #'as yet unclassified' }
SSIOStrategy >> nextPutAll: anArrayOfCharacters [
	^ port nextPutAll: anArrayOfCharacters.
]

{ #category : #'as yet unclassified' }
SSIOStrategy >> port: aSerialPort [
	port := aSerialPort 
]

{ #category : #'as yet unclassified' }
SSIOStrategy >> read [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
SSIOStrategy >> readPort [
	^ port readString
	
]
