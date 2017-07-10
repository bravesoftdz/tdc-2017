unit DM;

interface

uses
  System.SysUtils, System.Classes, uADStanIntf, uADStanOption,
  uADStanError, uADGUIxIntf, uADPhysIntf, uADStanDef, uADStanPool,
  uADStanAsync, uADPhysManager, uADGUIxFormsWait, uADCompGUIx,
  uADPhysODBCBase, uADPhysASA, Data.DB, uADCompClient, uADStanParam,
  uADDatSManager, uADDAptIntf, uADDAptManager, uADCompDataSet;

type
  TDataModule1 = class(TDataModule)
    conFiredac: TADConnection;
    asaLink: TADPhysASADriverLink;
    adgxwtcrsr: TADGUIxWaitCursor;
    ADQy: TADQuery;
    procedure DataModuleCreate(Sender: TObject);
  protected
  public
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
   try
      conFiredac.StartTransaction;

      ADQy.Close;
      ADQy.SQL.Clear;

      ADQy.SQL.Add('IF EXISTE_TABELA(''TBANIMAL'') = ''S'' THEN ');
      ADQy.SQL.Add('   DROP TABLE TBANIMAL; ');
      ADQy.SQL.Add('END IF;');

      ADQy.SQL.Add('IF EXISTE_TABELA(''TBANIMAL'') <> ''S'' THEN ');
      ADQy.SQL.Add('   CREATE TABLE TBANIMAL ( ');
      ADQy.SQL.Add('     ID INTEGER NOT NULL, ');
      ADQy.SQL.Add('     NOME VARCHAR(100) NOT NULL, ');
      ADQy.SQL.Add('     PRIMARY KEY (ID) ');
      ADQy.SQL.Add('   ); ');
      ADQy.SQL.Add('   INSERT INTO TBANIMAL VALUES(1,''Pitbull''); ');
      ADQy.SQL.Add('   INSERT INTO TBANIMAL VALUES(2,''Beagle''); ');
      ADQy.SQL.Add('   INSERT INTO TBANIMAL VALUES(3,''Boxer''); ');
      ADQy.SQL.Add('   INSERT INTO TBANIMAL VALUES(4,''Bulldog''); ');
      ADQy.SQL.Add('   INSERT INTO TBANIMAL VALUES(5,''Bullmastiff''); ');
      ADQy.SQL.Add('   INSERT INTO TBANIMAL VALUES(6,''Chow Chow''); ');
      ADQy.SQL.Add('END IF;');

      ADQy.SQL.Add('IF EXISTE_TABELA(''TBAVE'') = ''S'' THEN ');
      ADQy.SQL.Add('   DROP TABLE TBAVE; ');
      ADQy.SQL.Add('END IF;');

      ADQy.SQL.Add('IF EXISTE_TABELA(''TBAVE'') <> ''S'' THEN ');
      ADQy.SQL.Add('   CREATE TABLE TBAVE ( ');
      ADQy.SQL.Add('    ID INTEGER NOT NULL, ');
      ADQy.SQL.Add('    NOME VARCHAR(100) NOT NULL, ');
      ADQy.SQL.Add('    PRIMARY KEY (ID) ');
      ADQy.SQL.Add('   ); ');
      ADQy.SQL.Add('   INSERT INTO TBAVE VALUES(1,''Papagaio''); ');
      ADQy.SQL.Add('   INSERT INTO TBAVE VALUES(2,''Gavião''); ');
      ADQy.SQL.Add('   INSERT INTO TBAVE VALUES(3,''Biguá''); ');
      ADQy.SQL.Add('   INSERT INTO TBAVE VALUES(4,''Curió''); ');
      ADQy.SQL.Add('   INSERT INTO TBAVE VALUES(5,''Gralha''); ');
      ADQy.SQL.Add('END IF;');

      ADQy.ExecSQL;
      conFiredac.Commit;
   finally
      if conFiredac.InTransaction then
         conFiredac.Rollback;
   end;
end;

end.
