Extension { #name : #SerialPort }

{ #category : #'*SerialStream' }
SerialPort >> isOpen [
	^ port isNotNil
]

{ #category : #'*SerialStream' }
SerialPort >> readStream [
	^ self isOpen
		ifTrue: [ SerialStream defaultFor: self ]
		ifFalse: [ self error: 'Port is not yet open' ]
]
