program Project2;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}

uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  DUnitX.Loggers.XML.NUnit,
  {$ENDIF}
  DUnitX.TestFramework,
  Projeto.Teste.Pricipal in 'Projeto.Teste.Pricipal.pas',
  PessoaDAO in 'PessoaDAO.pas',
  Conexao in 'Conexao.pas' {DataModule1: TDataModule};

{$IFNDEF TESTINSIGHT}
var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger: ITestLogger;
{$ENDIF}

begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    // valida argumentos (ex: --xmlfile:arquivo.xml)
    TDUnitX.CheckCommandLine;

    runner := TDUnitX.CreateRunner;
    runner.UseRTTI := True;
    runner.FailsOnNoAsserts := False;

    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;

    // NUnit XML (gera no caminho vindo da linha de comando)
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    results := runner.Execute;

    // ExitCode para CI
    if not results.AllPassed then
      ExitCode := 1
    else
      ExitCode := 0;

    {$IFNDEF CI}
    // Só pausa localmente (nunca no Jenkins)
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}

  except
    on E: Exception do
    begin
      System.Writeln(E.ClassName, ': ', E.Message);
      ExitCode := 1;
    end;
  end;
{$ENDIF}
end.

