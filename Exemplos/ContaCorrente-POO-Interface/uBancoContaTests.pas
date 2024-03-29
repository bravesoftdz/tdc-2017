unit uBancoContaTests;

interface
uses
  DUnitX.TestFramework;

type

  [TestFixture]
  BancoContaTests = class(TObject)
  public
    [Test]
    procedure Returns_empty_balance_after_opening;

    [Test]
    procedure Check_basic_balance;

    [Test]
    procedure Balance_can_increment_and_decrement;

    [Test]
    procedure Closed_account_throws_exception_when_checking_balance;

    [Test]
    procedure Change_account_balance_from_multiple_threads;
  end;

implementation

uses System.SysUtils, System.Classes, System.SyncObjs, uBancoConta;

const HalfCentTolerance = 0.005;

procedure BancoContaTests.Returns_empty_balance_after_opening;
var account: IBankAccount;
begin
  account := TBankAccount.Create;
  account.Open;
  assert.AreEqual(0.00,account.Balance,HalfCentTolerance);
end;

procedure BancoContaTests.Check_basic_balance;
var account: IBankAccount;
    openingBalance: Double;
    updatedBalance: Double;
begin
  account := TBankAccount.Create;
  account.Open;

  openingBalance := account.Balance;
  account.UpdateBalance(10);

  updatedBalance := account.Balance;

  assert.AreEqual(0, openingBalance, HalfCentTolerance);
  assert.AreEqual(10, updatedBalance, HalfCentTolerance);
end;

procedure BancoContaTests.Balance_can_increment_and_decrement;
var account: IBankAccount;
    openingBalance: Double;
    addedBalance: Double;
    subtractedBalance: Double;
begin
  account := TBankAccount.Create;
  account.Open;

  openingBalance := account.Balance;

  account.UpdateBalance(10);
  addedBalance := account.Balance;

  account.UpdateBalance(-15);
  subtractedBalance := account.Balance;

  assert.AreEqual(0, openingBalance, HalfCentTolerance);
  assert.AreEqual(10, addedBalance, HalfCentTolerance);
  assert.AreEqual(-5, subtractedBalance, HalfCentTolerance);
end;

procedure BancoContaTests.Closed_account_throws_exception_when_checking_balance;
var MyProc: TTestLocalMethod;
begin
  MyProc := procedure
            var account: IBankAccount;
            begin
              account := TBankAccount.Create;
              account.Open;
              account.Close;
              account.Balance;
            end;

  assert.WillRaise(MyProc, EAccountNotOpen);
end;

procedure BancoContaTests.Change_account_balance_from_multiple_threads;
const threads = 500;
      iterations = 100;

var account: IBankAccount;
    activeThreadCount: integer;
    allthreadsDone: TEvent;
    i: integer;
begin
  activeThreadCount := threads;
  account := TBankAccount.Create;
  account.Open;

  allThreadsDone := TEvent.Create(nil, True, False,'AllThreadsDone');
  allThreadsDone.ResetEvent;
  for i := 1 to threads do
  begin
    TThread.CreateAnonymousThread(
      procedure
      var j: integer;
      begin
        try
          for j := 1 to iterations do
          begin
            account.UpdateBalance(1);
            account.UpdateBalance(-1);
          end;
        finally
          dec(activeThreadCount);
          if activeThreadCount <= 0 then
            allthreadsDone.SetEvent;
        end;
      end)
      .Start;
  end;

  assert.AreEqual(wrSignaled,allthreadsDone.WaitFor(60000), format('%d threads still active',[activeThreadCount]));
  assert.AreEqual(0, account.Balance, HalfCentTolerance);
end;

initialization
  TDUnitX.RegisterTestFixture(BancoContaTests);
end.
