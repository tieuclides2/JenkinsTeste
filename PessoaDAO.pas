unit PessoaDAO;

interface

{$M+}

uses
  Pessoa, FireDAC.Comp.Client;
type
  iLog = interface
    ['{2FBABF04-873A-486A-A213-9464F4F131DC}']
   procedure GravarLog(aLog : string);
   end;

   iSession = interface
     ['{F541AA19-31F0-40F1-BB04-8661AA6DAC1A}']
     function User : string;
  end;

  TPessoaDAO = class
    private
      FLog : iLog;
      FSession : iSession;
      FPESSOA : TPessoa;
      FQuery : TFDQuery;
    public
      constructor Create(aLog : iLog; aSession : iSession);
      destructor Destroy; override;
      function Entidade : TPessoa;
      procedure ValidarCampos;
      procedure Insert;
      procedure Update;
      procedure Delete;
      procedure BuscarId(aId : string);
  end;

implementation

uses
  System.SysUtils, Conexao;

{ TPessoaDAO }

procedure TPessoaDAO.BuscarId(aId: string);
begin
  FQuery.Open('SELECT * FROM USUARIO WHERE GUUID = ' + QuotedStr(FPESSOA.GUUID));
  FQuery.First;
  FPESSOA.GUUID := FQuery.FieldByName('GUUID').AsString;
  FPESSOA.NOME := FQuery.FieldByName('NOME').AsString;
  FPESSOA.SENHA := FQuery.FieldByName('SENHA').AsString;
  FPESSOA.TIPO := FQuery.FieldByName('TIPO').AsInteger;
  FPESSOA.STATUS := FQuery.FieldByName('STATUS').AsInteger;
  FPESSOA.DATACADASTRO := FQuery.FieldByName('DATACADASTRO').AsDateTime;
  FPESSOA.DATAALTERACAO := FQuery.FieldByName('DATAALTERACAO').AsDateTime;
end;

constructor TPessoaDAO.Create(aLog : iLog; aSession : iSession);
begin
  FLog := aLog;
  FSession := aSession;

  FLog.GravarLog('User:'  + aSession.User);

  FPESSOA := TPessoa.Create;

  if not Assigned(DataModule1) then
    DataModule1 := TDataModule1.Create(nil);

  FQuery := DataModule1.FDQuery1;
end;

procedure TPessoaDAO.Delete;
begin
  FQuery.Open('SELECT * FROM USUARIO WHERE GUUID = ' + QuotedStr(FPESSOA.GUUID));
  FQuery.Delete;
  FQuery.ApplyUpdates(0);
end;

destructor TPessoaDAO.Destroy;
begin
  FreeAndNil(FPESSOA);
  inherited;
end;

function TPessoaDAO.Entidade: TPessoa;
begin
  Result := FPESSOA;
end;

procedure TPessoaDAO.Insert;
begin
  FQuery.Open('SELECT * FROM USUARIO WHERE 1=2');     // retorna o dataset vazio para preechimento com os dados a baixo
  FQuery.Append;
  FQuery.FieldByName('GUUID').Value := FPESSOA.GUUID;
  FQuery.FieldByName('NOME').Value := FPESSOA.NOME;
  FQuery.FieldByName('SENHA').Value := FPESSOA.SENHA;
  FQuery.FieldByName('TIPO').Value := FPESSOA.TIPO;
  FQuery.FieldByName('STATUS').Value := FPESSOA.STATUS;
  FQuery.FieldByName('DATACADASTRO').Value := FPESSOA.DATACADASTRO;
  FQuery.FieldByName('DATAALTERACAO').Value := FPESSOA.DATAALTERACAO;

  FQuery.Post;
  FQuery.ApplyUpdates(0);
end;

procedure TPessoaDAO.Update;
begin
  FQuery.Open('SELECT * FROM USUARIO WHERE GUUID = ' + QuotedStr(FPESSOA.GUUID));
  FQuery.Edit;
  FQuery.FieldByName('GUUID').Value := FPESSOA.GUUID;
  FQuery.FieldByName('NOME').Value := FPESSOA.NOME;
  FQuery.FieldByName('SENHA').Value := FPESSOA.SENHA;
  FQuery.FieldByName('TIPO').Value := FPESSOA.TIPO;
  FQuery.FieldByName('STATUS').Value := FPESSOA.STATUS;
  FQuery.FieldByName('DATACADASTRO').Value := FPESSOA.DATACADASTRO;
  FQuery.FieldByName('DATAALTERACAO').Value := FPESSOA.DATAALTERACAO;

  FQuery.Post;
  FQuery.ApplyUpdates(0);
end;

procedure TPessoaDAO.ValidarCampos;
begin
  if FPESSOA.NOME = '' then
  raise Exception.Create('O campo nome não pode ser vazio.');
end;

end.
