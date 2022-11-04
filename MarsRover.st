!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 21:31:37'!
test01MovingMarsRoverWithInvalidCommandKeepsItInItsInitialPosition

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionNorth new) inPosition: 0@0.
	marsRover moveUsing: 'ñ'.	
	self assert: marsRover isFacing: MarsRoverDirectionNorth inPosition: 0@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 14:24:02'!
test02MovingMarsRoverFacingNorthForwardMovesItUp

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionNorth new) inPosition: 0@0.
	marsRover moveUsing: ('f').
	self assert: marsRover isFacing: MarsRoverDirectionNorth inPosition: 0@1.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 14:24:02'!
test03MovingMarsRoverFacingNorthBackwardsMovesItDown

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionNorth new) inPosition: 0@0.
	marsRover moveUsing: ('b').
	self assert: marsRover isFacing: MarsRoverDirectionNorth inPosition: 0@-1.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 14:24:02'!
test04MovingMarsRoverFacingNorthRightMakesItFaceEast

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionNorth new) inPosition: 0@0.
	marsRover moveUsing: ('r').
	self assert: marsRover isFacing: MarsRoverDirectionEast inPosition: 0@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 21:27:45'!
test05MovingMarsRoverFacingNorthLeftMakesItFaceWest

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionNorth new) inPosition: 0@0.
	marsRover moveUsing: ('l').
	self assert: marsRover isFacing: MarsRoverDirectionWest inPosition: 0@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 14:22:23'!
test06MovingMarsRoverFacingEastForwardMovesItRight

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionEast new) inPosition: 0@0.
	marsRover moveUsing: ('f').
	self assert: marsRover isFacing: MarsRoverDirectionEast inPosition: 1@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 14:22:23'!
test07MovingMarsRoverFacingEastBackwardsMovesItLeft

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionEast new) inPosition: 0@0.
	marsRover moveUsing: ('b').
	self assert: marsRover isFacing: MarsRoverDirectionEast inPosition: -1@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 14:23:03'!
test08MovingMarsRoverFacingEastRightMakesItFaceSouth

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionEast new) inPosition: 0@0.
	marsRover moveUsing: ('r').
	self assert: marsRover isFacing: MarsRoverDirectionSouth inPosition: 0@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 14:24:02'!
test09MovingMarsRoverFacingEastLeftMakesItFaceNorth

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionEast new) inPosition: 0@0.
	marsRover moveUsing: ('l').
	self assert: marsRover isFacing: MarsRoverDirectionNorth inPosition: 0@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 21:28:03'!
test10MovingMarsRoverFacingWestForwardMovesItLeft

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionWest new) inPosition: 0@0.
	marsRover moveUsing: ('f').
	self assert: marsRover isFacing: MarsRoverDirectionWest inPosition: -1@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 21:28:19'!
test11MovingMarsRoverFacingWestBackwardsMovesItRight

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionWest new) inPosition: 0@0.
	marsRover moveUsing: ('b').
	self assert: marsRover isFacing: MarsRoverDirectionWest inPosition: 1@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 21:28:26'!
test12MovingMarsRoverFacingWestRightMakesItFaceNorth

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionWest new) inPosition: 0@0.
	marsRover moveUsing: ('r').
	self assert: marsRover isFacing: MarsRoverDirectionNorth inPosition: 0@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 21:28:35'!
test13MovingMarsRoverFacingWestLeftMakesItFaceSouth

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionWest new) inPosition: 0@0.
	marsRover moveUsing: ('l').
	self assert: marsRover isFacing: MarsRoverDirectionSouth inPosition: 0@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 14:23:03'!
test14MovingMarsRoverFacingSouthForwardMovesItDown

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionSouth new) inPosition: 0@0.
	marsRover moveUsing: ('f').
	self assert: marsRover isFacing: MarsRoverDirectionSouth inPosition: 0@-1.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 14:23:03'!
test15MovingMarsRoverFacingSouthBackwardsMovesItUp

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionSouth new) inPosition: 0@0.
	marsRover moveUsing: ('b').
	self assert: marsRover isFacing: MarsRoverDirectionSouth inPosition: 0@1.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 21:28:47'!
test16MovingMarsRoverFacingSouthRightMakesItFaceWest

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionSouth new) inPosition: 0@0.
	marsRover moveUsing: ('r').
	self assert: marsRover isFacing: MarsRoverDirectionWest inPosition: 0@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 14:23:03'!
test17MovingMarsRoverFacingSouthLeftMakesItFaceEast

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionSouth new) inPosition: 0@0.
	marsRover moveUsing: ('l').
	self assert: marsRover isFacing: MarsRoverDirectionEast inPosition: 0@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 14:24:02'!
test18MakingVariousMovesMovesMarsRoverAccordingly

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionNorth new) inPosition: 0@0.
	marsRover moveUsing: ('fr').
	self assert: marsRover isFacing: MarsRoverDirectionEast inPosition: 0@1.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 14:24:02'!
test19GivingAnInvalidCommandInTheMiddleOfTheSetOfInstructionsStopsMarsRoverMovement

	|marsRover|
	marsRover := MarsRover facing: (MarsRoverDirectionNorth new) inPosition: 0@0.
	marsRover moveUsing: ('frñb').
	self deny: (marsRover isInPosition: -1@1).
	self assert: marsRover isFacing: MarsRoverDirectionEast inPosition: 0@1.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'rf 11/3/2022 13:40:16'!
test20InitializingMarsRoverFacingInvalidDirectionRaisesError
	self 
		should: [ MarsRover facing: (35) inPosition: 0@0 ]
		raise: Error
		withExceptionDo: [ :anError | self assert: MarsRover canNotFaceInvalidDirectionError equals: anError messageText ]! !


!MarsRoverTest methodsFor: 'auxiliar' stamp: 'rf 11/1/2022 13:58:50'!
assert: aMarsRover isFacing: aCardinalPoint inPosition: aPoint
	self assert: (aMarsRover isInPosition: aPoint).
	self assert: (aMarsRover isFacing: aCardinalPoint). ! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'rf 10/31/2022 11:10:04'!
initializeWith: aCardinalPoint and: aPosition 
	direction := aCardinalPoint.
	position := aPosition.! !


!MarsRover methodsFor: 'testing' stamp: 'rf 11/1/2022 13:58:36'!
isFacing: aCardinalPoint
	^direction class = aCardinalPoint! !

!MarsRover methodsFor: 'testing' stamp: 'rf 10/31/2022 11:10:40'!
isInPosition: aPoint 
	^aPoint = position ! !


!MarsRover methodsFor: 'operations' stamp: 'rf 11/4/2022 15:29:28'!
moveUsing: commands 
	
	commands do: [ :aCommand |
			
			(self validCommands includes: aCommand) ifTrue: [
				self moveAccordingTo: aCommand.
				] ifFalse: [
					^self.
			].
		
		]! !


!MarsRover methodsFor: 'change directions or position' stamp: 'rf 11/3/2022 14:22:23'!
faceEast
	direction := MarsRoverDirectionEast new.! !

!MarsRover methodsFor: 'change directions or position' stamp: 'rf 11/3/2022 14:24:02'!
faceNorth
	direction := MarsRoverDirectionNorth new! !

!MarsRover methodsFor: 'change directions or position' stamp: 'rf 11/3/2022 14:23:03'!
faceSouth
	direction := MarsRoverDirectionSouth new.! !

!MarsRover methodsFor: 'change directions or position' stamp: 'rf 11/3/2022 21:29:25'!
faceWest
	direction := MarsRoverDirectionWest new.! !

!MarsRover methodsFor: 'change directions or position' stamp: 'rf 11/1/2022 12:52:29'!
moveDown
	position := position translatedBy: 0@-1! !

!MarsRover methodsFor: 'change directions or position' stamp: 'rf 11/1/2022 12:52:59'!
moveLeft
	position := position translatedBy: -1@0! !

!MarsRover methodsFor: 'change directions or position' stamp: 'rf 10/31/2022 21:59:25'!
moveRight
	position := position translatedBy: 1@0! !

!MarsRover methodsFor: 'change directions or position' stamp: 'rf 10/31/2022 22:00:24'!
moveUp
	position := position translatedBy: 0@1! !


!MarsRover methodsFor: 'private' stamp: 'rf 10/31/2022 21:52:08'!
moveAccordingTo: aCommand 
	
	direction changeRover: self positionFrom: aCommand ! !

!MarsRover methodsFor: 'private' stamp: 'rf 11/2/2022 00:48:23'!
validCommands
	^ 'rlbf'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'rf 11/3/2022 14:21:58'!
facing: aCardinalPoint inPosition: aPosition
	|marsRover|
	
	(aCardinalPoint isKindOf: MarsRoverFacingDirection) ifFalse: [ self error: self canNotFaceInvalidDirectionError ].

	marsRover := MarsRover new.
	^marsRover initializeWith: aCardinalPoint and: aPosition.
	 ! !


!MarsRover class methodsFor: 'error' stamp: 'rf 11/3/2022 13:44:40'!
canNotFaceInvalidDirectionError
	^ 'the given direction is invalid'! !


!classDefinition: #MarsRoverFacingDirection category: 'MarsRover'!
Object subclass: #MarsRoverFacingDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverFacingDirection methodsFor: 'mars rover directioning' stamp: 'rf 11/3/2022 14:39:47'!
changeRover: aMarsRover positionFrom: aCharacter 
	self subclassResponsibility ! !


!classDefinition: #MarsRoverDirectionEast category: 'MarsRover'!
MarsRoverFacingDirection subclass: #MarsRoverDirectionEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverDirectionEast methodsFor: 'mars rover directioning' stamp: 'rf 10/31/2022 21:58:48'!
changeRover: aMarsRover positionFrom: aCharacter 
	(aCharacter	 = $f) ifTrue: [ aMarsRover moveRight ].
	(aCharacter = $b) ifTrue: [ aMarsRover moveLeft ].
	(aCharacter = $r) ifTrue: [ aMarsRover faceSouth ].
	(aCharacter = $l) ifTrue: [ aMarsRover faceNorth ].! !


!classDefinition: #MarsRoverDirectionNorth category: 'MarsRover'!
MarsRoverFacingDirection subclass: #MarsRoverDirectionNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverDirectionNorth methodsFor: 'mars rover directioning' stamp: 'rf 11/1/2022 13:11:14'!
changeRover: aMarsRover positionFrom: aCharacter 
	(aCharacter	 = $f) ifTrue: [ aMarsRover moveUp ].
	(aCharacter = $b) ifTrue: [  aMarsRover moveDown ].
	(aCharacter = $r) ifTrue: [ aMarsRover faceEast].
	(aCharacter = $l) ifTrue: [ aMarsRover faceWest].! !


!classDefinition: #MarsRoverDirectionSouth category: 'MarsRover'!
MarsRoverFacingDirection subclass: #MarsRoverDirectionSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverDirectionSouth methodsFor: 'mars rover directioning' stamp: 'rf 11/1/2022 12:51:37'!
changeRover: aMarsRover positionFrom: aCharacter 
	(aCharacter	 = $f) ifTrue: [  aMarsRover moveDown ].
	(aCharacter = $b) ifTrue: [  aMarsRover moveUp ].
	(aCharacter = $r) ifTrue: [  aMarsRover faceWest ].
	(aCharacter = $l) ifTrue: [  aMarsRover faceEast ].! !


!classDefinition: #MarsRoverDirectionWest category: 'MarsRover'!
MarsRoverFacingDirection subclass: #MarsRoverDirectionWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverDirectionWest methodsFor: 'mars rover directioning' stamp: 'rf 11/3/2022 21:26:43'!
changeRover: aMarsRover positionFrom: aCharacter 
	(aCharacter	 = $f) ifTrue: [  aMarsRover moveLeft ].
	(aCharacter = $b) ifTrue: [  aMarsRover moveRight ].
	(aCharacter = $r) ifTrue: [  aMarsRover faceNorth ].
	(aCharacter = $l) ifTrue: [  aMarsRover faceSouth ].! !
