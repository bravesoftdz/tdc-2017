unit uCalculator;

interface

uses
  DateUtils;

type
  TCalculatorOperation = (coNone, coSubtraction, coAddition);

type
  TCalculator = class
  private
    FIsDirty: Boolean;
    FOperation: TCalculatorOperation;
    FState: integer;
    FDisplay: integer;
    procedure SetDisplay(const Value: integer);
  public
    procedure Clear;
    procedure Enter(aValue: integer);
    procedure PressPlus;
    procedure PressSubtract;
    procedure PressEquals;
    procedure Calculate;
    property Display: integer read FDisplay write SetDisplay;
  end;

implementation

{ TCalculator }

procedure TCalculator.Calculate;
begin
  case FOperation of
    coAddition:    Display := Display + FState;
    coSubtraction: Display := Display - FState;
  end;
  FIsDirty := False;
end;

procedure TCalculator.Clear;
begin
  Display := 0;
  FIsDirty := False;
  FOperation := coNone;
end;

procedure TCalculator.Enter(aValue: integer);
begin
  FState := aValue;
  FIsDirty := True;
end;

procedure TCalculator.PressEquals;
begin
  if FIsDirty then
    Calculate;
end;

procedure TCalculator.PressPlus;
begin
  FOperation := coAddition;
  if FIsDirty then
    Calculate;
end;

procedure TCalculator.PressSubtract;
begin
  FDisplay := FState;
  FOperation := coSubtraction;
end;

procedure TCalculator.SetDisplay(const Value: integer);
begin
  FDisplay := Value;
end;

end.