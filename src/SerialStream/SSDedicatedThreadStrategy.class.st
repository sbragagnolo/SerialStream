Class {
	#name : #SSDedicatedThreadStrategy,
	#superclass : #SSIOStrategy,
	#instVars : [
		'buffer',
		'reader',
		'mutex'
	],
	#category : #SerialStream
}

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> becomeMonothread [ 
	self stopReader.
	^ super becomeMonothread.
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> cleanUpBuffer [ 
	buffer peekAll.
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> close [
	self stopReader.
	super close.
	
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> configure [
	buffer := SharedQueue new.
	mutex := Mutex new.
	self startReader.
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> consumePort [
	| read |
	mutex critical: [ read := self readPort ].
	(read isNil or: [ read isEmpty ])
		ifFalse: [ buffer nextPut: read ].
	(Delay forMilliseconds: 300) wait
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> nextPut: aCharacter [
	mutex critical: [ super nextPut: aCharacter ]
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> nextPutAll: anArrayOfCharacters [
	mutex critical: [ super nextPutAll: anArrayOfCharacters ]
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> read [
	| next read |
	read := OrderedCollection new.
	[ (next := buffer nextOrNil) isNotNil ] whileTrue: [ read add: next ].
	^ '' join: (read select: [ :c | c isNotNil and: [ c isEmpty not ] ])
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> startReader [
	reader := TKTParameterizableService new.
	reader name: 'Stream Reader on' , port printString, ' ', self hash asString .
	reader step: [ self consumePort ].
	reader onStoppedDo: [ self halt ].
	reader start
]

{ #category : #'as yet unclassified' }
SSDedicatedThreadStrategy >> stopReader [
	reader
		ifNotNil: [ 
			| proc |
			proc := reader.
			reader := nil.
			proc stop ]
]
