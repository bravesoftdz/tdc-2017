unit UAccount;

interface

uses
  System.SysUtils;

type
  EOverdraftLimitExceeded = class(Exception);

  TAccount = class(TObject)
  private
    FBalance: Currency;
  public
    constructor Create(const InitialBalance: Currency = 0.00);
    function Deposit(const Amount: Currency): Currency;
    function Withdraw(const Amount: Currency): Currency;
    property Balance: Currency read FBalance;
  end;

implementation

const
  cOverdraftLimit = -500.00;

{ TAccount }

constructor TAccount.Create(const InitialBalance: Currency);
begin
  FBalance := InitialBalance;
end;

function TAccount.Deposit(const Amount: Currency): Currency;
begin
  Assert(Amount >= 0, 'Amount needs to be positive');
  FBalance := FBalance + Amount;
  Result := FBalance;
end;

function TAccount.Withdraw(const Amount: Currency): Currency;
begin
  Assert(Amount >= 0, 'Amount needs to be positive');
  if FBalance - Amount < cOverdraftLimit then
    raise EOverdraftLimitExceeded.Create('Overdraft limit exceeded');
  FBalance := FBalance - Amount;
  Result := FBalance;
end;

end.
