!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:02'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:57'!
test02PushAddElementsToTheStack

	| stack |
	stack := OOStack new.
	
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'rf 10/10/2022 19:09:36'!
test03PopRemovesElementsFromTheStack

	| stack |
	stack := OOStack new. 
	stack push: 'something'. 
	
	stack pop. 
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:43'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack pop! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:56:59'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: secondPushedObject equals: stack pop.
	self assert: firstPushedObject equals: stack pop.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:26'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack top.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:27'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: 1 equals: stack size.
	stack top.
	self assert: 1 equals: stack size.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:44'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:56'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:07'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'rf 10/13/2022 11:48:49'!
test01CannotUseFinderWithAnEmptyStack
	|sentenceFinder stack|
	stack := OOStack new.
	sentenceFinder := SentenceFinderByPrefix with: stack.
	self should: [ sentenceFinder find: 'holi' ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: SentenceFinderByPrefix stackEmptyErrorDescription equals: anError messageText ]
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'rf 10/13/2022 11:54:07'!
test02CannotFindEmptyPrefix
	|sentenceFinder stack|
	stack := OOStack new.
	stack push: 'holiwis'.
	sentenceFinder := SentenceFinderByPrefix with: stack.
	self should: [ sentenceFinder find: '' ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: SentenceFinderByPrefix emptyPrefixErrorDescription equals: anError messageText ]
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'rf 10/13/2022 12:24:17'!
test03CannotFindOnlySpacePrefix
	|sentenceFinder stack|
	stack := OOStack new.
	stack push: 'holiwis'.
	sentenceFinder := SentenceFinderByPrefix with: stack.
	self should: [ sentenceFinder find: ' ' ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: SentenceFinderByPrefix prefixContainsSpacesErrorDescription equals: anError messageText ]
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'rf 10/13/2022 12:30:21'!
test04CannotFindPrefixContainingSpaces
	|sentenceFinder stack|
	stack := OOStack new.
	stack push: 'holiwis'.
	sentenceFinder := SentenceFinderByPrefix with: stack.
	self should: [ sentenceFinder find: 'hola que tal todo bien? mi nombre es Ramiro y esta es mi compañera Arely' ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: SentenceFinderByPrefix prefixContainsSpacesErrorDescription equals: anError messageText ]
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'rf 10/13/2022 13:43:01'!
test05FindPrefixWithOnlyOneWord
	|sentenceFinder stack expectedCollection|
	stack := OOStack new.
	stack push: 'holiwis'.
	sentenceFinder := SentenceFinderByPrefix with: stack.
	expectedCollection := OrderedCollection new.
	expectedCollection add: 'holiwis'.
	self assert: (sentenceFinder find: 'holi') equals: expectedCollection.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'rf 10/13/2022 14:11:47'!
test06FindPrefixWithOnlyVariousWords
	|sentenceFinder stack expectedCollection|
	
	stack := OOStack new.
	
	stack push: 'holiwis'.
	stack push: 'si no te hubieras ido seria tan feliz'.
	stack push: 'si me debes plata, pagame'.
	stack push: 'Siendo sincero, me parece un tp bastante flojo, yo no lo aprobaria'.
	stack push: 'siempre que voy a plaza italia me paso por el jardin botánico :p'.
	
	sentenceFinder := SentenceFinderByPrefix with: stack.
	expectedCollection := OrderedCollection new.
	
	expectedCollection add: 'siempre que voy a plaza italia me paso por el jardin botánico :p'.
	expectedCollection add: 'si me debes plata, pagame'.
	expectedCollection add: 'si no te hubieras ido seria tan feliz'.
	
	self assert: (sentenceFinder find: 'si') equals: expectedCollection.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'rf 10/13/2022 23:13:24'!
test07TheStackOrderStaysTheSameAfterFindingElements
	|sentenceFinder stack expectedStack|
	
	stack := OOStack new.
	
	stack push: 'holiwis'.
	stack push: 'si no te hubieras ido seria tan feliz'.
	stack push: 'si me debes plata, pagame'.
	stack push: 'Siendo sincero, me parece un tp bastante flojo, yo no lo aprobaria'.
	stack push: 'siempre que voy a plaza italia me paso por el jardin botánico :p'.
	
	sentenceFinder := SentenceFinderByPrefix with: stack.
	expectedStack := OOStack new.
	
	expectedStack push: 'holiwis'.
	expectedStack push: 'si no te hubieras ido seria tan feliz'.
	expectedStack push: 'si me debes plata, pagame'.
	expectedStack push: 'Siendo sincero, me parece un tp bastante flojo, yo no lo aprobaria'.
	expectedStack push: 'siempre que voy a plaza italia me paso por el jardin botánico :p'.
	
	sentenceFinder find: 'si'.
	
	self assert: (sentenceFinder isStackEqualTo: expectedStack) 
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'rf 10/13/2022 14:51:59'!
test08IfNotFoundPrefixResultIsAnEmptyCollection
	|sentenceFinder stack expectedCollection|
	stack := OOStack new.
	stack push: 'holiwis'.
	stack push: 'hambre'.
	stack push: 'dolor de cabeza'.
	stack push: 'mi gato se llama charly :3'.
	sentenceFinder := SentenceFinderByPrefix with: stack.
	expectedCollection := OrderedCollection new.
	self assert: (sentenceFinder find: 'Holi') equals: expectedCollection.
	
	! !


!classDefinition: #EstadoDelStack category: 'Stack-Exercise'!
Object subclass: #EstadoDelStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EstadoDelStack methodsFor: 'operations-dd' stamp: 'rf 10/13/2022 19:22:08'!
pop: aStack
	
	"mensaje polimórfico que le indica al stack si debe eliminar y devolver su último elemento o elevar un error en caso de que este no sea accesible."
	
	self subclassResponsibility ! !

!EstadoDelStack methodsFor: 'operations-dd' stamp: 'rf 10/13/2022 19:21:56'!
top: aStack

	"mensaje polimórfico que le indica al stack si debe devolver su último elemento o elevar un error en caso de que el mismo no sea accesible."
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoDelStack class' category: 'Stack-Exercise'!
EstadoDelStack class
	instanceVariableNames: ''!

!EstadoDelStack class methodsFor: 'instance creation' stamp: 'rf 10/11/2022 20:59:30'!
with: aSize 
	^(self subclasses detect: [:subclase | subclase pertenece: aSize]) new.! !


!classDefinition: #EstadoStackConElementos category: 'Stack-Exercise'!
EstadoDelStack subclass: #EstadoStackConElementos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EstadoStackConElementos methodsFor: 'operations-dd' stamp: 'rf 10/13/2022 19:16:44'!
pop: aStack
	
	"ver superclase"
	
	^aStack popWhereNotEmpty.
	! !

!EstadoStackConElementos methodsFor: 'operations-dd' stamp: 'rf 10/13/2022 19:16:51'!
top: aStack

	"ver superclase"
	
	^aStack topWhereNotEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoStackConElementos class' category: 'Stack-Exercise'!
EstadoStackConElementos class
	instanceVariableNames: ''!

!EstadoStackConElementos class methodsFor: 'instance creation' stamp: 'rf 10/11/2022 20:51:30'!
pertenece: aSize
	^aSize ~= 0.! !


!classDefinition: #EstadoStackVacio category: 'Stack-Exercise'!
EstadoDelStack subclass: #EstadoStackVacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EstadoStackVacio methodsFor: 'operations-dd' stamp: 'rf 10/13/2022 19:16:19'!
pop: aStack

	"ver superclase"
	
	aStack raiseErrorWhereEmpty.
! !

!EstadoStackVacio methodsFor: 'operations-dd' stamp: 'rf 10/13/2022 19:16:31'!
top: aStack
	
	"ver superclase"
	
	aStack raiseErrorWhereEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoStackVacio class' category: 'Stack-Exercise'!
EstadoStackVacio class
	instanceVariableNames: ''!

!EstadoStackVacio class methodsFor: 'instance creation' stamp: 'rf 10/11/2022 20:51:50'!
pertenece: aSize	
	^aSize = 0.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elementos estado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'rf 10/13/2022 19:13:51'!
initialize

	"Se inicializa el stack sin elementos."
	
	estado := EstadoStackVacio new.
	elementos := OrderedCollection new.! !


!OOStack methodsFor: 'operations' stamp: 'rf 10/13/2022 19:08:22'!
isEmpty
	
	"responde si el stack esta vacío."
	
	^elementos isEmpty.! !

!OOStack methodsFor: 'operations' stamp: 'rf 10/13/2022 19:13:00'!
pop
	
	"remueve y devuelve el último elemento ingresado al stack.
	si no se puede acceder al tope (porque la pila no tiene elementos) se eleva un error."
	
	|elementoARemover|
	elementoARemover := estado pop: self.
	estado := EstadoDelStack with: (self size).
	^elementoARemover 
	 ! !

!OOStack methodsFor: 'operations' stamp: 'rf 10/13/2022 19:08:42'!
push: anElement
	
	"ingresa un elemento al stack."
	
	elementos addLast: anElement. 
	estado := EstadoStackConElementos new.! !

!OOStack methodsFor: 'operations' stamp: 'rf 10/13/2022 19:08:58'!
size
	
	"devuelve el tamaño del stack"
	
	^elementos size ! !

!OOStack methodsFor: 'operations' stamp: 'rf 10/13/2022 19:09:35'!
top
	
	"devuelve el último elemento ingresado al stack"
	
	^estado top: self.
	! !


!OOStack methodsFor: 'private-dd' stamp: 'rf 10/13/2022 19:23:49'!
popWhereNotEmpty

	"remueve y devuelve el último elemento"
	
	^elementos removeLast ! !

!OOStack methodsFor: 'private-dd' stamp: 'rf 10/13/2022 19:11:59'!
raiseErrorWhereEmpty
	
	"Tira error. Para ser usado cuando se quiere ingresar al tope de un stack vacío."
	
	self error: self class stackEmptyErrorDescription! !

!OOStack methodsFor: 'private-dd' stamp: 'rf 10/13/2022 19:24:04'!
topWhereNotEmpty

	"devuelve el último elemento."
	
	^elementos last! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'rf 10/13/2022 23:32:49'!
initializeWith: anStack 

	stack := anStack.! !


!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'rf 10/13/2022 23:34:25'!
isStackEqualTo: aStack

	"compara dos stacks"

	|myTop otherStackTop auxStack|
		
	(stack size) ~= (aStack size) ifTrue: [^false].
	
	auxStack := OOStack new.
	
	[stack isEmpty ] whileFalse: [
		myTop := stack pop.
		otherStackTop := aStack pop.
		
		(myTop ~= otherStackTop) ifTrue: [
				^false.
			].
		
		auxStack push: myTop.							
		
		].
		
	self fill: stack with: auxStack.
	
	^true
! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'rf 10/13/2022 22:58:53'!
find: aPrefix

	"devuelve una colección que contiene todos los elementos del stack que tienen el prefijo enviado al inicio de ellos."
	
	|stackAuxiliar resultado tope|
	 
	stack isEmpty ifTrue: [self error: self class stackEmptyErrorDescription].
	aPrefix isEmpty ifTrue: [self error: self class emptyPrefixErrorDescription].
	((aPrefix findString: ' ') > 0) ifTrue: [self error: self class prefixContainsSpacesErrorDescription].
	
	stackAuxiliar := OOStack new.
	resultado := OrderedCollection new.
	
	[stack isEmpty] whileFalse: [
		
		tope := stack pop.
		(tope is: aPrefix substringAt: 1) ifTrue: 	[resultado add: tope].		
		
		stackAuxiliar push: tope.
		
		].
	
	[stackAuxiliar isEmpty] whileFalse: [
		
		stack push: (stackAuxiliar pop).
		
		].	
	
	^resultado ! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'rf 10/13/2022 22:49:36'!
fill: aStack with: anotherStack 
	"llena un stack con una copia del contenido de otra"
	
	| stackAux |
	
	stackAux := OOStack new.
	
	[anotherStack isEmpty] whileFalse: [
			stackAux push: anotherStack pop.
		].
	
	[stackAux isEmpty] whileFalse: [ | tope |
			tope := stackAux pop.
			aStack push: tope.
			anotherStack push: tope.
		].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'rf 10/13/2022 11:39:18'!
with: anStack 
	^self new initializeWith: anStack ! !


!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'rf 10/13/2022 11:58:41'!
emptyPrefixErrorDescription
	^ 'Prefix is empty'! !

!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'rf 10/13/2022 12:24:53'!
prefixContainsSpacesErrorDescription
	^ 'Prefix contains spaces'! !

!SentenceFinderByPrefix class methodsFor: 'error' stamp: 'rf 10/13/2022 11:47:02'!
stackEmptyErrorDescription
	^ 'Stack is empty'! !
