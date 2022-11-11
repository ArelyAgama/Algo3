!classDefinition: #PortfolioTests category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTests methodsFor: 'tests' stamp: 'rf 11/11/2022 16:05:40'!
test01CanAddAccountWithNoTransactionsMadeToPortfolioAndAskForItsBalance
	|portfolio receptiveAccount|
	
	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	portfolio add: receptiveAccount.
	self assert: 0*peso equals: portfolio balance! !

!PortfolioTests methodsFor: 'tests' stamp: 'rf 11/11/2022 16:04:52'!
test02CanAddAnAccountWithARegisteredTransactionAndAskForItsBalance
	|portfolio receptiveAccount|
	
	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	Deposit register: 200 * peso on: receptiveAccount. 
	portfolio add: receptiveAccount.
	self assert: 200*peso equals: portfolio balance! !

!PortfolioTests methodsFor: 'tests' stamp: 'rf 11/11/2022 16:04:47'!
test03CanAddMoreThanOneAccountAndAskForBalance
	|portfolio firstReceptiveAccount secondReceptiveAccount|
	
	portfolio := Portfolio new.
	firstReceptiveAccount := ReceptiveAccount new.
	Deposit register: 200 * peso on: firstReceptiveAccount. 
	secondReceptiveAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: secondReceptiveAccount.
	portfolio add: firstReceptiveAccount.
	portfolio add: secondReceptiveAccount.
	self assert: 300*peso equals: portfolio balance! !

!PortfolioTests methodsFor: 'tests' stamp: 'rf 11/11/2022 16:04:42'!
test04CanAskForBalanceWhenAPortfolioIncludesAnotherPortfolio
	|parentPortfolio sonPortfolio majorPortfolioReceptiveAccount minorPortfolioReceptiveAccount |
	
	parentPortfolio := Portfolio new.
	sonPortfolio := Portfolio new.
	majorPortfolioReceptiveAccount := ReceptiveAccount new.
	Deposit register: 300 * peso on: majorPortfolioReceptiveAccount. 
	minorPortfolioReceptiveAccount := ReceptiveAccount new.
	Deposit register: 200 * peso on: minorPortfolioReceptiveAccount.	
	parentPortfolio add: majorPortfolioReceptiveAccount.
	sonPortfolio add: minorPortfolioReceptiveAccount.
	parentPortfolio add: sonPortfolio. 
	self assert: 500*peso equals: parentPortfolio balance! !

!PortfolioTests methodsFor: 'tests' stamp: 'rf 11/11/2022 16:04:38'!
test05CanAskForTransactions
	|portfolio receptiveAccount transactions|
	
	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	portfolio add: receptiveAccount.
	transactions := portfolio transactions.
	self assert: 0 equals: transactions size.
	
	! !

!PortfolioTests methodsFor: 'tests' stamp: 'rf 11/11/2022 16:04:29'!
test06CanGetTransactionsFromAccountsWithRegisteredTransactions
	|portfolio receptiveAccount transactions deposit|
	
	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: receptiveAccount.
	portfolio add: receptiveAccount.
	transactions := portfolio transactions.
	self assert: 1 equals: transactions size.
	self assert: (transactions includes: deposit)
	
	! !

!PortfolioTests methodsFor: 'tests' stamp: 'rf 11/11/2022 16:04:24'!
test07CanGetTransactionsWhenPortfolioIncludesAnotherPortfolio
	|parentPortfolio sonPortfolio parentPortfolioReceptiveAccount sonPortfolioReceptiveAccount  depositParentPortfolio depositSonPortfolio|
	
	parentPortfolio := Portfolio new.
	sonPortfolio := Portfolio new.
	parentPortfolioReceptiveAccount := ReceptiveAccount new.
	depositParentPortfolio := Deposit register: 300 * peso on: parentPortfolioReceptiveAccount. 
	parentPortfolio add: parentPortfolioReceptiveAccount.
	sonPortfolioReceptiveAccount := ReceptiveAccount new.
	depositSonPortfolio := Deposit register: 200 * peso on: sonPortfolioReceptiveAccount.	
	sonPortfolio add: sonPortfolioReceptiveAccount.
	parentPortfolio add: sonPortfolio. 
	self assert: 2 equals: parentPortfolio transactions size.
	self assert: (parentPortfolio transactions includes: depositParentPortfolio ).
	self assert: (parentPortfolio transactions includes: depositSonPortfolio ).
	! !

!PortfolioTests methodsFor: 'tests' stamp: 'rf 11/11/2022 16:03:22'!
test08CanAskForRegisteredTransactionsFromAccountsInsidePortfolio
	|portfolio receptiveAccount extraction deposit|
	
	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	extraction := Withdraw register: 100 * peso on: receptiveAccount.	
	portfolio add: receptiveAccount. 
	deposit := Deposit register: 200*peso on: ReceptiveAccount new.
	self assert: (portfolio  hasRegistered: extraction).
	self deny: (portfolio hasRegistered: deposit)
	
	! !

!PortfolioTests methodsFor: 'tests' stamp: 'rf 11/11/2022 16:03:26'!
test09CanAskForRegisteredTransactionsFromAccountsInsidePortfolioIncludingAnotherPortfolios
	|parentPortfolio sonPortfolio parentPortfolioReceptiveAccount sonPortfolioReceptiveAccount deposit|
	
	parentPortfolio := Portfolio new.
	sonPortfolio := Portfolio new.
	parentPortfolioReceptiveAccount := ReceptiveAccount new.
	sonPortfolioReceptiveAccount := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: sonPortfolioReceptiveAccount.	
	parentPortfolio add: parentPortfolioReceptiveAccount.
	sonPortfolio add: sonPortfolioReceptiveAccount.
	parentPortfolio add: sonPortfolio. 
	self assert: (parentPortfolio  hasRegistered: deposit)
	
	! !

!PortfolioTests methodsFor: 'tests' stamp: 'rf 11/11/2022 16:03:37'!
test10CannotAddAnAccountToAPortfolioThatAlreadyHasThatAccount
	|portfolio receptiveAccount|
	
	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	portfolio add: receptiveAccount.
	self should: [ portfolio add: receptiveAccount. ]
	 raise: Error
	 withExceptionDo: [ :anError | self assert: Portfolio canNotAddAnAccountAlreadyAdded equals: anError messageText ]
	
	
	! !

!PortfolioTests methodsFor: 'tests' stamp: 'rf 11/11/2022 16:03:59'!
test11CannotAddItself
	|portfolio receptiveAccount|
	
	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	portfolio add: receptiveAccount.
	self should: [ portfolio add: portfolio ]
	 raise: Error
	 withExceptionDo: [ :anError | self assert: Portfolio canNotAddAnAccountAlreadyAdded equals: anError messageText ]
	
	
	! !

!PortfolioTests methodsFor: 'tests' stamp: 'rf 11/11/2022 16:04:06'!
test12CannotAddAnAccountThatWasIncludedInAPortfolioPreviuslyAdded
	|portfolio portfolioParent receptiveAccount|
	
	portfolio := Portfolio new.
	portfolioParent := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	portfolio add: receptiveAccount.
	portfolioParent add: portfolio.
	self should: [ portfolioParent add: receptiveAccount .]
	 raise: Error
	 withExceptionDo: [ :anError | self assert: Portfolio canNotAddAnAccountAlreadyAdded equals: anError messageText ]
	
	
	! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TrasnferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TrasnferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TrasnferTest methodsFor: 'tests' stamp: 'rf 11/11/2022 13:41:19'!
test01CanRegisterATransferenceWithInfluenceInAccountsBalances
	
	| originAccount destinationAccount transferencia |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	transferencia  := Transfer from: originAccount to: destinationAccount on: 100*peso.
	self assert: 100*peso equals: transferencia value.
	self assert: -100*peso equals: originAccount balance.
	self assert: 100*peso equals: destinationAccount balance
	! !

!TrasnferTest methodsFor: 'tests' stamp: 'rf 11/11/2022 13:41:10'!
test02PataExtractionCounterPartIsExpectedDeposit

	| originAccount destinationAccount transferencia |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	transferencia  := Transfer from: originAccount to: destinationAccount on: 50*peso.
	self assert: 50*peso equals: transferencia value.
	self assert: destinationAccount transactions last equals: transferencia extraccionCounterPart.
	
	! !

!TrasnferTest methodsFor: 'tests' stamp: 'rf 11/11/2022 13:39:27'!
test03PataDepositCounterPartIsExpectedExtraction
	
	| originAccount destinationAccount transferencia|
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	transferencia  := Transfer from: originAccount to: destinationAccount on: 50*peso.
	self assert: 50*peso equals: transferencia value.
	self assert: originAccount transactions last equals: transferencia depositCounterPart.
	
	! !

!TrasnferTest methodsFor: 'tests' stamp: 'rf 11/11/2022 13:41:01'!
test04CannotMakeATransferFor0Pesos

	| originAccount destinationAccount|
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	"self should:  raise:  withExceptionDo: "
	self should: [ Transfer from: originAccount to: destinationAccount on: 0*peso. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Transfer canNotMakeATransferWithZeroPesosError equals: anError messageText ]
	! !

!TrasnferTest methodsFor: 'tests' stamp: 'rf 11/11/2022 13:41:06'!
test05CanNotMakeATransferForNegativeValues

	| originAccount destinationAccount|
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	"self should:  raise:  withExceptionDo: "
	self should: [ Transfer from: originAccount to: destinationAccount on: -1*peso. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Transfer canNotMakeATransferWithNegativePesosError equals: anError messageText ]
	! !


!classDefinition: #Account category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'main protocol' stamp: 'rf 11/11/2022 15:55:41'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'rf 11/11/2022 15:55:36'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'rf 11/11/2022 15:55:32'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'receptiveAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'rf 11/10/2022 17:36:30'!
initialize
	receptiveAccounts := Set new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'rf 11/11/2022 13:31:35'!
add: anAccount 
	
	((receptiveAccounts includes: anAccount )or: (self = anAccount)) ifTrue: [self error: self class canNotAddAnAccountAlreadyAdded].
	
	(receptiveAccounts do:[:account| (account includes: anAccount) ifTrue: [self error: self class canNotAddAnAccountAlreadyAdded]]).
	
	receptiveAccounts add: anAccount. 
	! !

!Portfolio methodsFor: 'main protocol' stamp: 'rf 11/11/2022 15:55:50'!
balance

	^receptiveAccounts sum: [:account | account balance] ifEmpty: [^0*peso]! !

!Portfolio methodsFor: 'main protocol' stamp: 'rf 11/11/2022 15:58:47'!
hasRegistered: aTransaction 

	receptiveAccounts do: [:account | (account hasRegistered: aTransaction) ifTrue: [ ^true ]].
	^false
	! !

!Portfolio methodsFor: 'main protocol' stamp: 'rf 11/11/2022 16:08:39'!
transactions
	| totalTransactions |
	
	totalTransactions := OrderedCollection new.
	receptiveAccounts do: [:account | account transactions do: [:transaction | totalTransactions add: transaction ] ].
	^totalTransactions! !


!Portfolio methodsFor: 'testing' stamp: 'rf 11/11/2022 13:29:15'!
includes:anAccount
	^receptiveAccounts includes: anAccount.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error' stamp: 'rf 11/9/2022 16:34:30'!
canNotAddAnAccountAlreadyAdded
	^'cannot add an account already added'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'rf 11/11/2022 16:01:30'!
balance
	| aBalance |
	
	aBalance := 0.
	transactions do: [ :aTransaction |
		aBalance := aTransaction appliedTo: aBalance.
		].
	^aBalance! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'auxiliar' stamp: 'rf 11/11/2022 13:29:26'!
includes: aReceptiveAccount 

	^false
! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'operations' stamp: 'rf 11/11/2022 16:01:43'!
appliedTo: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'initialization' stamp: 'rf 11/11/2022 16:09:37'!
initializeFor: aValue
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'operations' stamp: 'rf 11/11/2022 13:44:40'!
appliedTo: aBalance
 
	^aBalance  + value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'operations' stamp: 'rf 11/11/2022 13:45:01'!
appliedTo: aBalance 

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'pataExtraction pataDeposit value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'testing' stamp: 'rf 11/11/2022 16:10:40'!
value

	^value! !


!Transfer methodsFor: 'operations' stamp: 'rf 11/11/2022 16:10:27'!
depositCounterPart

	^pataExtraction ! !

!Transfer methodsFor: 'operations' stamp: 'rf 11/11/2022 16:10:31'!
extraccionCounterPart

	^pataDeposit ! !


!Transfer methodsFor: 'initialization' stamp: 'rf 11/11/2022 16:10:20'!
initializeWith: extraction And: deposit on: aMoneyAmount 

	pataExtraction := extraction.
	pataDeposit := deposit.
	value := aMoneyAmount .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'initialization' stamp: 'rf 11/11/2022 13:50:52'!
from: anOriginAccount to: aDestinationAccount on: aMoneyAmount
	|extraction deposit|
	
	(aMoneyAmount = 0) ifTrue: [self error: self canNotMakeATransferWithZeroPesosError].
	(aMoneyAmount < 0) ifTrue: [self error: self canNotMakeATransferWithNegativePesosError].
	
	extraction := Withdraw register: aMoneyAmount on: anOriginAccount.
	deposit  := Deposit register: aMoneyAmount on: aDestinationAccount.
	
	^self new initializeWith: extraction And: deposit on: aMoneyAmount.
! !


!Transfer class methodsFor: 'error' stamp: 'rf 11/9/2022 16:24:44'!
canNotMakeATransferWithNegativePesosError
	^ 'Cannot make a transfer with negative pesos'! !

!Transfer class methodsFor: 'error' stamp: 'rf 11/9/2022 16:24:28'!
canNotMakeATransferWithZeroPesosError
	^'Cannot make a transfer with 0 pesos'! !
