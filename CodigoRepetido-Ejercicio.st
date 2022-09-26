!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'rf 9/25/2022 16:44:31'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook executionTime|
	
	customerBook := CustomerBook new.
	
	executionTime := self calculateTimeFor: [customerBook addCustomerNamed: 'John Lennon'.].
	
	self assertExecutionTime: executionTime LessThan: (50 * millisecond).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rf 9/25/2022 16:44:45'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney executionTime |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	executionTime := self calculateTimeFor: [customerBook removeCustomerNamed: paulMcCartney.].
	
	self assertExecutionTime: executionTime LessThan: (100 * millisecond).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rf 9/25/2022 16:43:45'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self should: [ customerBook addCustomerNamed: '' ] raise: Error withExceptionDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rf 9/25/2022 16:43:36'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self should: [ customerBook removeCustomerNamed: 'Paul McCartney' . ] raise: NotFound withExceptionDo: [:anError | self assert: customerBook onlyHas: johnLennon].
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rf 9/25/2022 16:43:21'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: customerBook hasActiveCustomers: 0 andSuspended: 1. 
	self assert: customerBook onlyHas: paulMcCartney.
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rf 9/25/2022 16:31:16'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	
	self assert: customerBook hasActiveCustomers: 0 andSuspended: 0. 
	self deny: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rf 9/25/2022 16:30:59'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self should: [ customerBook suspendCustomerNamed: 'Ringo Starr'. ] raise: CantSuspend withExceptionDo: [:anError | self assert: customerBook onlyHas: johnLennon].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rf 9/25/2022 16:30:39'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self should: [ customerBook suspendCustomerNamed: johnLennon . ] raise: CantSuspend withExceptionDo: [:anError | self assert: customerBook onlyHas: johnLennon].
! !



!CustomerBookTest methodsFor: 'auxiliar' stamp: 'rf 9/25/2022 16:32:05'!
assert: aCustomerBook hasActiveCustomers: numberOfActiveCustomers andSuspended: numberOfSuspendedCustomers
	self assert: (aCustomerBook numberOfActiveCustomers = numberOfActiveCustomers ).
	self assert: (aCustomerBook numberOfSuspendedCustomers = numberOfSuspendedCustomers ). 
	self assert: (aCustomerBook numberOfCustomers = (numberOfActiveCustomers + 	numberOfSuspendedCustomers)).! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'rf 9/24/2022 14:43:08'!
assert: aCustomerBook onlyHas: aCustomer
	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: aCustomer).! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'rf 9/25/2022 15:56:37'!
assertExecutionTime: executionTime LessThan: aTime
	self assert: executionTime < aTime! !

!CustomerBookTest methodsFor: 'auxiliar' stamp: 'rf 9/25/2022 15:54:49'!
calculateTimeFor: aClosureToTime 
	|timeBeforeExecution timeAfterExecution |
	timeBeforeExecution := Time millisecondClockValue * millisecond.
	aClosureToTime value.
	timeAfterExecution := Time millisecondClockValue * millisecond.
	^timeAfterExecution - timeBeforeExecution.
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'rf 9/25/2022 16:47:26'!
removeCustomerNamed: aName 	
	active remove: aName ifAbsent: [suspended remove: aName ifAbsent: [^NotFound signal]].
	^aName.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
