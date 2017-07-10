unit CalcUnit;
 
 interface
 
 type
 
 { TCalc }
 
   TCalc = class
   public
     function Adicao(Value1, Value2: Real): Real;
     function Subtracao(Value1, Value2: Real): Real;
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
 
 end.