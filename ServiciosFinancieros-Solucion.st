!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'rf 11/16/2022 16:22:39'!
test01CanGenerateASummaryForADeposit
	|anAccount summary expectedSummary| 
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount .
	summary := AccountSummary of: anAccount.  
	
	expectedSummary := OrderedCollection with:'Deposito por 100 * pesos' with: 'Balance = 100 * pesos'.
	self assert: expectedSummary equals: summary summary.

	
! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'rf 11/16/2022 16:22:34'!
test02CanGenerateASummaryForAWithdraw
	|anAccount summary expectedReport|
	
	anAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: anAccount .
	summary := AccountSummary of: anAccount .
	
	expectedReport := OrderedCollection with:'Extraccion por 50 * pesos' with: 'Balance = -50 * pesos'.
	self assert: (summary summary) equals: expectedReport .
	
! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'rf 11/16/2022 16:22:45'!
test03CanGenerateASummaryForATransferWithdraw
	|anAccount anotherAccount summary expectedReport|
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer amount: 20* peso from: anAccount to: anotherAccount .
	summary := AccountSummary of: anAccount .
	
	expectedReport := OrderedCollection with: 'Salida por transferencia de 20 * pesos' with: 'Balance = -20 * pesos'.
	self assert: (summary summary) equals: expectedReport.
	
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'rf 11/16/2022 01:47:20'!
test04CanGenerateASummaryFromTransferDeposit
	|anAccount anotherAccount summary expectedReport|
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer amount: 30* peso from: anAccount to: anotherAccount .
	
	summary := AccountSummary of: anotherAccount .
	expectedReport := OrderedCollection with: 'Entrada por transferencia de 30 * pesos' with:'Balance = 30 * pesos'.
	self assert: (summary summary) equals: expectedReport
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'rf 11/16/2022 16:22:50'!
test05CanGenerateACompleteSummaryForAnAccount
	|anAccount anotherAccount summary expectedReport|
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100*peso on: anAccount .
	Withdraw register: 50*peso on: anAccount .
	Transfer amount: 20* peso from: anAccount to: anotherAccount .
	Transfer amount: 30* peso from: anotherAccount to: anAccount .
	summary := AccountSummary of: anAccount .
	
	expectedReport:= OrderedCollection with: 'Deposito por 100 * pesos' with:'Extraccion por 50 * pesos' with:'Salida por transferencia de 20 * pesos' with: 'Entrada por transferencia de 30 * pesos' with: 'Balance = 60 * pesos'.
	
	self assert: (summary summary) equals: expectedReport .
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'rf 11/16/2022 16:22:54'!
test06CanGenerateASummaryForADepositOfAccountInPortfolio
	|anAccount anotherAccount summary expectedReport portfolio |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100*peso on: anAccount .
	Deposit register: 100*peso on: anotherAccount.
	portfolio := Portfolio with: anAccount with: anotherAccount.
	summary := AccountSummary of: portfolio.
	
	expectedReport := OrderedCollection with: 'Deposito por 100 * pesos' with: 'Deposito por 100 * pesos' with: 'Balance = 200 * pesos'.
	self assert: (summary summary) equals: expectedReport.

	
! !


!classDefinition: #PortfolioDetailedTreePrinterTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioDetailedTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'rf 11/18/2022 12:38:24'!
test01DetailedTreeWithOneAccount

	|myAccount portfolio myDetailedTree|
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	Deposit register: 50 * peso on: myAccount .
	Withdraw register: 20*peso on: myAccount .
	portfolio := Portfolio named: 'Portfolio de la familia' with: myAccount .
	myDetailedTree:= PortfolioDetailedTreePrinter for: portfolio.
	self assert: (OrderedCollection with: 'Portfolio de la familia' with: ' Cuenta mia' with: '  Deposito por 50 * pesos' with: '  Extraccion por 20 * pesos' with: '  Balance = 30 * pesos') equals: myDetailedTree.
	
	! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #PortfolioTreePrinterTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'rf 11/18/2022 12:38:24'!
test01EmptyPortfolioTree
	|aPortfolio myTree|
	
	aPortfolio := Portfolio named: 'Portfolio de la familia' .

	myTree := PortfolioTreePrinter for: aPortfolio .
	
	self assert: (OrderedCollection with:'Portfolio de la familia') equals: myTree. 
	
	
	
	! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'rf 11/18/2022 12:38:24'!
test02PortfolioTreeWithAnAccount
	|anAccount aPortfolio myTree|
	
	anAccount := ReceptiveAccount named: 'Cuenta mia'.
	aPortfolio := Portfolio named: 'Portfolio de la familia' with: anAccount .

	myTree := PortfolioTreePrinter for: aPortfolio .
	
	self assert: (OrderedCollection with:'Portfolio de la familia' with: ' Cuenta mia' ) equals: myTree. 
	
	
	
	! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'rf 11/18/2022 12:38:24'!
test03TreeWithPortfolioAndAccount
	|myPortfolio myAccount myTree childPortfolio |

	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	childPortfolio := Portfolio named: 'Portfolio hijo'.
	myPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childPortfolio .

	myTree := PortfolioTreePrinter for: myPortfolio .
	
	self assert: (OrderedCollection with:'Portfolio de la familia' with: ' Cuenta mia' with:' Portfolio hijo' )   equals: myTree  
	
	
	
	! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'rf 11/18/2022 12:38:24'!
test04MultipleIndentationTree
	|myPortfolio myAccount myTree childPortfolio childAccount angieAccount|

	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	childAccount := ReceptiveAccount named:'Cuenta de Juan'.
	angieAccount :=ReceptiveAccount named:'Cuenta de Angie'.
	childPortfolio := Portfolio named: 'Portfolio hijo' with: childAccount with: angieAccount .
	myPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with:childPortfolio .
	
	myTree := PortfolioTreePrinter for: myPortfolio .
	
	self assert: (OrderedCollection with:'Portfolio de la familia' with: ' Cuenta mia' with:' Portfolio hijo' with:'  Cuenta de Juan' with:'  Cuenta de Angie')   equals: myTree   
	
	
	
	! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

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


!classDefinition: #TransferNetTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNetTest methodsFor: 'tests' stamp: 'rf 11/18/2022 12:35:35'!
test01TransferNetFromOutgoingTransfer
	| anAccount anotherAccount transferNet |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 20*peso from: anAccount to: anotherAccount.
	
	transferNet := TransferNet newFrom: anAccount.
	
	self assert: -20*peso equals: (transferNet value).! !

!TransferNetTest methodsFor: 'tests' stamp: 'rf 11/18/2022 12:35:39'!
test02TransferNetFromIncommingTransfer
	| anAccount anotherAccount transferNet |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 20*peso from: anotherAccount to: anAccount .
	
	transferNet := TransferNet newFrom: anAccount.
	
	self assert: 20*peso equals: transferNet value
	! !

!TransferNetTest methodsFor: 'tests' stamp: 'rf 11/18/2022 12:35:43'!
test03DepositDoesNotAffectTransferNet
	| anAccount transferNet |
	
	anAccount := ReceptiveAccount new.
	
	Deposit register: 100*peso on: anAccount.
	
	transferNet := TransferNet newFrom: anAccount.
	
	self assert: 0*peso equals: transferNet value! !

!TransferNetTest methodsFor: 'tests' stamp: 'rf 11/18/2022 12:35:56'!
test04WithdrawDoesNotAffectTransferNet
	| anAccount transferNet |
	
	anAccount := ReceptiveAccount new.
	
	Withdraw register: 100*peso on: anAccount.
	
	transferNet := TransferNet newFrom: anAccount.
	
	self assert: 0*peso equals: transferNet value
	
! !

!TransferNetTest methodsFor: 'tests' stamp: 'rf 11/18/2022 12:36:01'!
test05TransferNetFromVariousOperations
	| anAccount anotherAccount transferNet |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 100*peso on: anAccount.
	Withdraw register: 50*peso on: anAccount.
	
	Transfer amount: 20*peso from: anAccount  to: anotherAccount.
	Transfer amount: 30*peso from: anotherAccount to: anAccount.
	
	transferNet := TransferNet newFrom: anAccount.
	
	self assert: 10*peso equals: transferNet value.! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'rf 11/16/2022 16:19:16'!
addTransactionsTo: aCollectionOfTransactions
	self subclassResponsibility ! !


!Account methodsFor: 'setters' stamp: 'rf 11/16/2022 16:20:30'!
name: aName
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'rf 11/16/2022 15:44:40'!
initializeWithName: aName
	name := aName ! !


!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'xx 11/17/2022 02:49:26'!
accountsDo:aBlock
	accounts do:aBlock! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'setters' stamp: 'rf 11/16/2022 16:08:32'!
name: aName
	name := aName
! !


!Portfolio methodsFor: 'reports' stamp: 'xx 11/17/2022 12:31:51'!
getReportTo: aTreeReport
	aTreeReport addPortfolio: self.! !

!Portfolio methodsFor: 'reports' stamp: 'xx 11/17/2022 02:39:18'!
name
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'rf 11/16/2022 15:44:23'!
named: aName
	^self new initializeWithName: aName 
	! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'rf 11/16/2022 16:09:00'!
named: aName with: anAccount
	^self new
		add: anAccount;
		name: aName;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'rf 11/16/2022 16:08:16'!
named: aName with: anAccount with: anotherAccount
	^self new
		add: anAccount;
		add: anotherAccount;
		name: aName;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'xx 11/12/2022 20:10:36'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
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

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'xx 11/17/2022 12:29:11'!
transactionsDo: aBlock
	transactions do: aBlock .
	! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'setters' stamp: 'rf 11/16/2022 16:13:31'!
name: aName
	name := aName! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'xx 11/17/2022 04:36:39'!
getReportTo: aTreeReport
	aTreeReport addReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'xx 11/17/2022 02:49:59'!
name
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'rf 11/16/2022 16:12:54'!
named: aName
	^self new
	name: aName;
	yourself! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'rf 11/16/2022 01:19:50'!
getReportTo: aSummary
	aSummary addDeposit: self.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'reports' stamp: 'rf 11/16/2022 01:19:50'!
getReportTo: anAccountSummary 
	anAccountSummary addTransferDepositLeg: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'reports' stamp: 'rf 11/16/2022 01:19:51'!
getReportTo: anAccountSummary 
	anAccountSummary addTransferWithdrawLeg:self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'rf 11/16/2022 01:19:51'!
getReportTo: anAccountSummary 
	anAccountSummary addWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #PortfolioTree category: 'ServiciosFinancieros-Solucion'!
Object subclass: #PortfolioTree
	instanceVariableNames: 'portfolioTree identation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTree methodsFor: 'operations' stamp: 'rf 11/18/2022 12:07:17'!
addPortfolio: aPortfolio
	self subclassResponsibility ! !

!PortfolioTree methodsFor: 'operations' stamp: 'rf 11/18/2022 12:07:42'!
addReceptiveAccount: aReceptiveAccount
	self subclassResponsibility ! !

!PortfolioTree methodsFor: 'operations' stamp: 'xx 11/18/2022 10:05:22'!
increaseIdentation
	identation := identation ,' '.! !


!PortfolioTree methodsFor: 'instance creation' stamp: 'rf 11/18/2022 12:38:24'!
for: aPortfolio
	aPortfolio getReportTo:self .
	^portfolioTree! !

!PortfolioTree methodsFor: 'instance creation' stamp: 'xx 11/18/2022 10:04:58'!
initialize
	portfolioTree := OrderedCollection new.
	identation := ''.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTree class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTree class
	instanceVariableNames: ''!

!PortfolioTree class methodsFor: 'instance creation' stamp: 'rf 11/18/2022 12:38:24'!
for: aPortfolio
	^self new for:aPortfolio.! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros-Solucion'!
PortfolioTree subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinter methodsFor: 'operations' stamp: 'xx 11/18/2022 11:25:02'!
addDeposit: aDeposit

	portfolioTree add: identation ,'Deposito por ', aDeposit value asString.! !

!PortfolioDetailedTreePrinter methodsFor: 'operations' stamp: 'xx 11/18/2022 11:24:43'!
addPortfolio: aPortfolio
	portfolioTree add: identation, aPortfolio name.
	self increaseIdentation .
	aPortfolio accountsDo:[ :account| account getReportTo:self].
	portfolioTree add:identation, 'Balance = ', aPortfolio balance asString .! !

!PortfolioDetailedTreePrinter methodsFor: 'operations' stamp: 'xx 11/18/2022 11:44:38'!
addReceptiveAccount: aReceptiveAccount
	portfolioTree add: identation, aReceptiveAccount name.
	self increaseIdentation .
	aReceptiveAccount transactionsDo: [:aTransaction | aTransaction getReportTo: self].! !

!PortfolioDetailedTreePrinter methodsFor: 'operations' stamp: 'xx 11/18/2022 11:25:16'!
addWithdraw: aWithdraw 

	portfolioTree add: identation, 'Extraccion por ', aWithdraw value asString.! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
PortfolioTree subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'operations' stamp: 'xx 11/18/2022 10:06:45'!
addPortfolio: aPortfolio
	portfolioTree add:identation ,aPortfolio name.
	self increaseIdentation .
	aPortfolio accountsDo:[ :account| account getReportTo:self].
	! !

!PortfolioTreePrinter methodsFor: 'operations' stamp: 'xx 11/18/2022 10:07:34'!
addReceptiveAccount: aReceptiveAccount
	portfolioTree add:identation, aReceptiveAccount name.! !


!classDefinition: #Report category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Report methodsFor: 'operations' stamp: 'rf 11/16/2022 01:08:27'!
addDeposit: aDeposit
	self subclassResponsibility.
	
	! !

!Report methodsFor: 'operations' stamp: 'xx 11/15/2022 21:17:30'!
addTransferDepositLeg: aTransferDepositLeg 
	self subclassResponsibility .
! !

!Report methodsFor: 'operations' stamp: 'xx 11/15/2022 21:17:41'!
addTransferWithdrawLeg:aWithdrawLeg
	self subclassResponsibility .
	! !

!Report methodsFor: 'operations' stamp: 'xx 11/15/2022 21:17:49'!
addWithdraw: aWithdraw 
	self subclassResponsibility ! !


!Report methodsFor: 'instance creation' stamp: 'rf 11/16/2022 01:08:38'!
createReportFor: anAccount
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'ServiciosFinancieros-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'rf 11/16/2022 01:36:41'!
transferNetFrom: anAccount 
	^self new createReportFor: anAccount ! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'operations' stamp: 'rf 11/16/2022 01:46:55'!
addDeposit: aDeposit

	summary add: 'Deposito por ', aDeposit value asString.! !

!AccountSummary methodsFor: 'operations' stamp: 'rf 11/16/2022 01:46:52'!
addTransferDepositLeg: aTransferDepositLeg 

	summary add: 'Entrada por transferencia de ', aTransferDepositLeg value asString.
! !

!AccountSummary methodsFor: 'operations' stamp: 'rf 11/16/2022 01:46:49'!
addTransferWithdrawLeg:aWithdrawLeg

	summary add: 'Salida por transferencia de ',aWithdrawLeg value asString.
	! !

!AccountSummary methodsFor: 'operations' stamp: 'rf 11/16/2022 01:46:46'!
addWithdraw: aWithdraw 

	summary add: 'Extraccion por ', aWithdraw value asString.! !

!AccountSummary methodsFor: 'operations' stamp: 'rf 11/16/2022 01:47:20'!
summary
	^summary ! !


!AccountSummary methodsFor: 'instance creation' stamp: 'rf 11/16/2022 01:46:43'!
createReportFor: anAccount

	anAccount transactions do:[:transaction | transaction getReportTo: self].
	summary add: 'Balance = ',anAccount balance asString.! !

!AccountSummary methodsFor: 'instance creation' stamp: 'xx 11/15/2022 21:16:53'!
initialize
	summary := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'rf 11/16/2022 01:17:03'!
of: anAccount 
	^self new createReportFor: anAccount! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNet methodsFor: 'operations' stamp: 'rf 11/16/2022 01:34:13'!
addDeposit: aDeposit
	! !

!TransferNet methodsFor: 'operations' stamp: 'rf 11/16/2022 01:34:10'!
addTransferDepositLeg: aTransferDepositLeg 
	value := value + aTransferDepositLeg value! !

!TransferNet methodsFor: 'operations' stamp: 'rf 11/16/2022 01:34:03'!
addTransferWithdrawLeg:aWithdrawLeg
	value := value - aWithdrawLeg value! !

!TransferNet methodsFor: 'operations' stamp: 'rf 11/16/2022 01:34:17'!
addWithdraw: aWithdraw 
! !

!TransferNet methodsFor: 'operations' stamp: 'rf 11/16/2022 01:11:42'!
value
	^value! !


!TransferNet methodsFor: 'instance creation' stamp: 'rf 11/16/2022 01:36:41'!
createReportFor: anAccount 

	value := 0.
	anAccount transactions do: [:transaction |	
		transaction getReportTo: self]
	! !

!TransferNet methodsFor: 'instance creation' stamp: 'rf 11/16/2022 01:22:35'!
initialize
	value := 0 * peso.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'ServiciosFinancieros-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'rf 11/16/2022 01:36:41'!
newFrom: anAccount
	^self new createReportFor: anAccount! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
