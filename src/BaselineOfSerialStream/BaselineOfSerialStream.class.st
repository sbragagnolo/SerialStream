Class {
	#name : #BaselineOfSerialStream,
	#superclass : #BaselineOf,
	#category : #BaselineOfSerialStream
}

{ #category : #baselines }
BaselineOfSerialStream >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec
				baseline: 'TaskIt'
				with: [ spec repository: 'github://sbragagnolo/taskit/src' ].
			spec package: #SerialStream with: [ spec requires: #(TaskIt) ] ]
]
