unit Unit1;

interface

uses
   SysUtils;

type
  ETestingException = class(Exception);


type
  TExceptionRaiser = class
    public
      procedure RaiseTestingException;
      function NoExceptionRaised(aString: string): string;
  end;

implementation

{ TExceptionRaiser }

function TExceptionRaiser.NoExceptionRaised(aString: string): string;
begin
  Result := aString + 'blahblahblah';
end;

procedure TExceptionRaiser.RaiseTestingException;
begin
  if True then
  begin
    raise ETestingException.Create('This exception is supposed to happen.');
  end;
end;

end.
