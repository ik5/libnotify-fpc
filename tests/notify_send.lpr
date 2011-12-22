program notify_send;

{$mode objfpc}{$H+}
{$IFDEF WINODWS}{$console on}{$ENDIF}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  CustApp, Classes, SysUtils, LCLProc;

type

  { TApplication }

  TApplication = class(TCustomApplication)
  private
    FUrgency: Byte;
  protected
    procedure DoRun; override;
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
  if HasOption('u','urgency') then
    begin
      FUrgency := NOTIFY_URGENCY_NORMAL;
      if TryStrToInt64(GetOptionValue('u','urgency'), tmpi) then
        if (tmpi in [NOTIFY_URGENCY_LOW..NOTIFY_URGENCY_CRITICAL]) then
           FUrgency := tmpi;
    end
  else begin
        FUrgency := NOTIFY_URGENCY_NORMAL;
       end;

  Terminate;
end;

begin
  App       := TApplication.Create(nil);
  App.Title := 'notify send';
  App.Initialize;
  App.Run;

  FreeThenNil(App);
end.

