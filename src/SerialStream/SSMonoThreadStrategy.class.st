Class {
	#name : #SSMonoThreadStrategy,
	#superclass : #SSIOStrategy,
	#category : #SerialStream
}

{ #category : #'as yet unclassified' }
SSMonoThreadStrategy >> becomeMonothread [ 
	^ self.
]

{ #category : #'as yet unclassified' }
SSMonoThreadStrategy >> read [
	^ self readPort.
]
