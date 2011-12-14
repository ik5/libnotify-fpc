{ Hello World for libnotify

  Copyright (C) 2011 Ido Kanner idokan at@at gmail dot.dot com

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
}
program test_notify;
{.$codepage UTF8}
{$mode fpc}

uses
  libnotify, gtk2;

var
  hello : PNotifyNotification;

begin
  gtk_init(@argc, @argv);
  // Unique name for the notification, this app name :)
  notify_init(argv[0]);

  hello := notify_notification_new (
             // Title
             'Example for libnotify',
             // Content
             'This is a simple example how to use libnotify.',
             // Icon
             'dialog-information');
  // Lets display it, but we will not handle any errors ...
  notify_notification_show (hello, nil);
  // That's all folks :)
  notify_uninit;
end.

