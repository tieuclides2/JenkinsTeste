unit Pessoa;

interface
type
  TPessoa = class
  private
    FNOME: string;
    FDATAALTERACAO: TDateTime;
    FSTATUS: Integer;
    FSENHA: string;
    FDATACADASTRO: TDateTime;
    FGUUID: string;
    FTIPO: Integer;
    procedure SetNOME(const Value: string);
    procedure SetDATAALTERACAO(const Value: TDateTime);
    procedure SetDATACADASTRO(const Value: TDateTime);
    procedure SetGUUID(const Value: string);
    procedure SetSENHA(const Value: string);
    procedure SetSTATUS(const Value: Integer);
    procedure SetTIPO(const Value: Integer);
  public
    procedure ValidarCampos;
  published
    function TratarCPFCNPJ (aValue: string) : string;
    property NOME : string read FNOME write SetNOME;
    property GUUID :string read FGUUID write SetGUUID;
    property SENHA : string read FSENHA write SetSENHA;
    property TIPO : Integer read FTIPO write SetTIPO;
    property STATUS : Integer read FSTATUS write SetSTATUS;
    property DATACADASTRO : TDateTime read FDATACADASTRO write SetDATACADASTRO;
    property DATAALTERACAO : TDateTime read FDATAALTERACAO write SetDATAALTERACAO;
  end;

implementation

uses
  System.SysUtils;

{ TPessoa }

procedure TPessoa.SetDATAALTERACAO(const Value: TDateTime);
begin
  FDATAALTERACAO := Value;
end;

procedure TPessoa.SetDATACADASTRO(const Value: TDateTime);
begin
  FDATACADASTRO := Value;
end;

procedure TPessoa.SetGUUID(const Value: string);
begin
  FGUUID := Value;
end;

procedure TPessoa.SetNOME(const Value: string);
begin
  FNOME := Value;
end;

procedure TPessoa.SetSENHA(const Value: string);
begin
  FSENHA := Value;
end;

procedure TPessoa.SetSTATUS(const Value: Integer);
begin
  FSTATUS := Value;
end;

procedure TPessoa.SetTIPO(const Value: Integer);
begin
  FTIPO := Value;
end;

function TPessoa.TratarCPFCNPJ(aValue: string): string;
var
  I: Integer;
begin
  for I := 1 to length(aValue) do
  begin
    if aValue[I] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']  then
    Result := Result + aValue[i];
  end;
//  Result := Result + 'x';

end;

procedure TPessoa.ValidarCampos;
begin
  if FNOME = '' then
    raise Exception.Create('O nome não pode ser vazio.');
end;

end.
