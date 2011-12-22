program notify_send;

{$mode objfpc}{$H+}
{$IFDEF WINODWS}{$console on}{$ENDIF}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  CustApp, Classes, SysUtils, LCLProc, libnotify;

type

  { TApplication }

  TApplication = class(TCustomApplication)
  private
    FUrgency: Byte;
  protected
    procedure DoRun; override;
    procedure WriteHelp;
  published
    property Urgency : Byte read FUrgency write FUrgency;
  end;

var
  App : TApplication;

{ TApplication }

procedure TApplication.DoRun;
var
  tmpi : Int64;
begin
{  if HasOption('u','urgency') then
    begin
      FUrgency := NOTIFY_URGENCY_NORMAL;
      if TryStrToInt64(GetOptionValue('u','urgency'), tmpi) then
        if (tmpi in [NOTIFY_URGENCY_LOW..NOTIFY_URGENCY_CRITICAL]) then
           FUrgency := tmpi;
    end
  else begin
        FUrgency := NOTIFY_URGENCY_NORMAL;
       end;
}
  if HasOption('?', 'help') then
    begin
      WriteHelp;
      Terminate;
      exit;
    end;

  Terminate;
end;

procedure TApplication.WriteHelp;
begin
  writeln;
  Writeln('Usage: ');
  writeln(#9,App.ExeName, '[OPTION...] <SUMMARY> [BODY] - create a notification');
  writeln;
  writeln('Help Options:');
  writeln(#9, '-?, --help',#9, '  Show help options');
  writeln;
  writeln('Application Options:');
  writeln(#9, '-u, --urgency=LEVEL', #9, 'Specifies the urgency level (low, normal, critical).');
  writeln(#9, '-t, --expire-time=TIME', #9, 'Specifies the timeout in milliseconds at which to expire the notification.');
  writeln(#9, '-i, --icon=ICON[,ICON...]', #9, 'Specifies an icon filename or stock icon to display.');
  writeln(#9, '-c, --category=TYPE[,TYPE...]', #9, 'Specifies the notification category.');
  writeln(#9, '-h, --hint=TYPE:NAME:VALUE', #9, 'pecifies basic extra data to pass. Valid types are int, double, string and byte.');
  writeln(#9, '-v, --version', #9, 'Version of the package.');
  writeln;
end;

begin
  App       := TApplication.Create(nil);
  App.Title := 'notify send';
  App.Initialize;
  App.Run;

  FreeThenNil(App);
end.

