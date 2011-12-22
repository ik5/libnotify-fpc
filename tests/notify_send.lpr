program notify_send;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  CustApp, Classes, SysUtils, LCLProc, libnotify;
  { you can add units after this };

type
  TApplication = class(TCustomApplication)

  end;

var
  App : TApplication;

begin
  App       := TApplication.Create(nil);
  App.Title := 'notify send';
  App.Initialize;
  FreeThenNil(App);

end.

