unit Projeto.Teste.Pricipal;

interface

uses
  DUnitX.TestFramework, Pessoa, PessoaDAO;

type
  [TestFixture]
  TMyTestObject = class
  private
    FPessoa : TPessoa;
    FPessoaDAO : TPessoaDAO;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TesteTratarCPFCNPJ;

    [Test]
    [TestCase('CaseCPF', '123.123.123-12,12312312312')]
    [TestCase('CaseCNPJ', '12.123.123/0001-12,12123123000112')]
    procedure TratarCPFCNPJ(aValue : string; aResult : string);

    [Test]
    procedure ValidaNome;

    [Test]
    procedure ValidarCampos;

    [Test]
    procedure Insert;
  end;

implementation

uses
  System.SysUtils, Delphi.Mocks;

procedure TMyTestObject.Insert;
begin
  try
    FPessoaDAO.Entidade.GUUID := '999999';
    FPessoaDAO.Entidade.NOME := '999999';
    FPessoaDAO.Entidade.SENHA := '999999';
    FPessoaDAO.Entidade.TIPO := 9;
    FPessoaDAO.Entidade.STATUS := 9;
    FPessoaDAO.Entidade.DATACADASTRO := now;
    FPessoaDAO.Entidade.DATAALTERACAO := now;
    FPessoaDAO.Insert;

    FPessoaDAO.BuscarId('999999');

    Assert.IsTrue(FPessoaDAO.Entidade.GUUID = '999999', 'FPessoaDAO.Insert erro no inserir GUUID');
    Assert.IsTrue(FPessoaDAO.Entidade.NOME = '999999', 'FPessoaDAO.Insert erro no inserir NOME');
    Assert.IsTrue(FPessoaDAO.Entidade.SENHA = '999999', 'FPessoaDAO.Insert erro no inserir SENHA');
    Assert.IsTrue(FPessoaDAO.Entidade.TIPO = 9 , 'FPessoaDAO.Insert erro no inserir TIPO');
    Assert.IsTrue(FPessoaDAO.Entidade.STATUS = 9, 'FPessoaDAO.Insert erro no inserir STATUS');
    Assert.IsNotNull(FPessoaDAO.Entidade.DATACADASTRO, 'FPessoaDAO.Insert erro no inserir DATACADASTRO');
    Assert.IsNotNull(FPessoaDAO.Entidade.DATAALTERACAO, 'FPessoaDAO.Insert erro no inserir DATAALTERACAO');
  finally
    FPessoaDAO.Entidade.GUUID := '999999';
    FPessoaDAO.Delete;
  end;
end;

procedure TMyTestObject.Setup;
var
  Mock : TMock<iSession>;
begin
  Mock := TMock<iSession>.Create;
  Mock.Setup.WillReturn('UserTest');

  FPessoa := TPessoa.Create;
  FPessoaDAO := TPessoaDAO.Create(Tstub<iLog>.Create, Mock);
end;

procedure TMyTestObject.TearDown;
begin
  FPessoa.Free;
  FPessoaDAO.Free;
end;

procedure TMyTestObject.TesteTratarCPFCNPJ;
var
  Resultado: string;
begin
  Resultado := FPessoa.TratarCPFCNPJ('123.123.123-12');
  Assert.IsTrue(Resultado = '12312312312', 'TPESSOA.TratarCPFCNPJ retornou um erro');
end;

procedure TMyTestObject.TratarCPFCNPJ(aValue, aResult: string);
var
  Resultado : string;
begin
  Resultado := FPessoa.TratarCPFCNPJ(aValue);
//  Assert.IsTrue(Resultado = aResult, 'TPESSOA.TratarCPFCNPJ');
  Assert.AreEqual(Resultado, aResult);
end;

procedure TMyTestObject.ValidaNome;
begin
  FPessoa.NOME := 'Gabriel';
  Assert.IsNotEmpty(FPessoa.NOME, 'TPESSOA.NOME está vazio');
end;

procedure TMyTestObject.ValidarCampos;
begin
  FPessoa.NOME := '';
  Assert.WillRaise(FPessoa.ValidarCampos, nil, 'TPESSOA.ValidarCampos');
end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);

end.
