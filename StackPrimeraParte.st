!classDefinition: #StackTest category: 'StackPrimeraParte'!
TestCase subclass: #StackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackTest methodsFor: 'testing' stamp: 'IL 10/1/2022 19:24:17'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := Stack new.
	
	self assert: stack isEmpty! !

!StackTest methodsFor: 'testing' stamp: 'rf 10/13/2022 21:15:05'!
test02WeCanAddAnElementToStack

	| stack |
	
	stack := Stack new.
	
	stack push: 5.
	
	self deny: stack isEmpty.
	self assert: (stack size) equals: 1.! !

!StackTest methodsFor: 'testing' stamp: 'rf 10/6/2022 03:48:07'!
test03WeCanRemoveAnElementFromStack

	| stack |
	
	stack := Stack new.
	
	stack push: 5.
	
	stack pop.
	
	self assert: stack isEmpty.! !

!StackTest methodsFor: 'testing' stamp: 'rf 10/6/2022 03:51:02'!
test04RemovingAnElementFromStackReturnsLastElementAdded

	| stack lastElement |
	
	stack := Stack new.
	
	stack push: 5.
	stack push: 6.
	
	lastElement := stack pop.
	
	self assert: lastElement equals: 6.
	
	! !

!StackTest methodsFor: 'testing' stamp: 'rf 10/6/2022 11:40:15'!
test05StackTopIsTheLastAddedElement

	| stack lastElement |
	
	stack := Stack new.
	
	stack push: 5.
	stack push: 6.
	
	lastElement := stack top.
	
	self assert: lastElement equals: 6.
	
	! !


!classDefinition: #Stack category: 'StackPrimeraParte'!
Object subclass: #Stack
	instanceVariableNames: 'elementos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Stack methodsFor: 'initialization' stamp: 'rf 10/6/2022 03:39:35'!
initialize
	elementos := OrderedCollection new.! !


!Stack methodsFor: 'operations' stamp: 'rf 10/6/2022 03:40:19'!
isEmpty
	^elementos isEmpty.! !

!Stack methodsFor: 'operations' stamp: 'rf 10/6/2022 03:46:37'!
pop
	^elementos removeLast ! !

!Stack methodsFor: 'operations' stamp: 'rf 10/6/2022 03:48:37'!
push: anElement
	elementos addLast: anElement ! !

!Stack methodsFor: 'operations' stamp: 'rf 10/13/2022 21:15:05'!
size
	^elementos size ! !

!Stack methodsFor: 'operations' stamp: 'rf 10/6/2022 11:41:44'!
top
	^elementos last.! !
