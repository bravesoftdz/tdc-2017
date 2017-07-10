unit UTestAccount;

interface
uses
  DUnitX.TestFramework,
  UAccount;

type

  [TestFixture]
  TestTAccount = class(TObject)
  strict private
    FAccount: TAccount;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure TestDeposit;
    // Test with TestCase Atribute to supply parameters.
    [Test]
    [TestCase('Test Small Withdrawal','50.00,-50.00')]
    [TestCase('Test Big Withdrawal','350.00,-350.00')]
    procedure TestWithdraw(const Amount, Balance: Currency);
    [Test]
    procedure TestExceedOverdraftLimit;
    [Test]
    [TestCase('Test Positive Initial Balance','100.00')]
    [TestCase('Test Negative Initial Balance','-100.00')]
    procedure TestBalance(const Amount: Currency);
    [Test]
    [Category('TestAssert')]
    procedure TestDepositNegativeAmount;
    [Test]
    [Category('TestAssert')]
    procedure TestWithdrawNegativeAmount;
  end;

implementation

uses
  System.SysUtils;

procedure TestTAccount.Setup;
begin
  FAccount := TAccount.Create;
end;

procedure TestTAccount.TearDown;
begin
  FAccount.Free;
  FAccount := nil;
end;

procedure TestTAccount.TestBalance(const Amount: Currency);
begin
  FAccount.Free;
  FAccount := TAccount.Create(Amount);
  Assert.AreEqual(Amount, FAccount.Balance, 'Balance');
end;

procedure TestTAccount.TestDeposit;
var
  ReturnValue: Currency;
  Amount: Currency;
begin
  Amount := 50.00;
  ReturnValue := FAccount.Deposit(Amount);
  Assert.AreEqual(Amount, ReturnValue, 'ReturnValue');
  Assert.AreEqual(Amount, FAccount.Balance, 'Balance');
end;

procedure TestTAccount.TestDepositNegativeAmount;
begin
  Assert.WillRaise(procedure begin FAccount.Deposit(-5.00); end, EAssertionFailed);
end;

procedure TestTAccount.TestExceedOverdraftLimit;
begin
  Assert.WillRaise(procedure begin FAccount.Withdraw(700.00); end, EOverdraftLimitExceeded);
end;

procedure TestTAccount.TestWithdraw(const Amount, Balance: Currency);
var
  ReturnValue: Currency;
begin
  ReturnValue := FAccount.Withdraw(Amount);
  Assert.AreEqual(Balance, ReturnValue, 'ReturnValue');
  Assert.AreEqual(Balance, FAccount.Balance, 'Balance');
end;

procedure TestTAccount.TestWithdrawNegativeAmount;
begin
  Assert.WillRaise(procedure begin FAccount.Withdraw(-5.00); end, EAssertionFailed);
end;

initialization
  TDUnitX.RegisterTestFixture(TestTAccount);
end.
