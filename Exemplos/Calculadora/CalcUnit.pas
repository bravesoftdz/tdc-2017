unit CalcUnit;
 
 interface
 
 uses Math;
 
 type
   TCalc = class
   public
     function Adicao(Value1, Value2: Real): Real;
     function Subtracao(Value1, Value2: Real): Real;
	    function Multiplicacao(Value1, Value2: Real): Real;
	    function Divisao(Value1, Value2: Real): Real;
   end;

 implementation

 { TCalc }

 function TCalc.Adicao(Value1, Value2: Real): Real;
 begin
   Result := Value1 + Value2;
 end;
 
 function TCalc.Subtracao(Value1, Value2: Real): Real;
 begin
   Result := Value1 - Value2;
 end;
 
 function TCalc.Multiplicacao(Value1, Value2: Real): Real;
 begin
   Result := Value1 * Value2;
 end;

 function TCalc.Divisao(Value1, Value2: Real): Real;
 begin
   try
     SetRoundMode(rmNearest);
     Result := RoundTo((Value1 / Value2), -2);
   except
     Result := 0;
   end;
 end;

 end.