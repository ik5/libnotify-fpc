{ libnotify binding for Free Pascal

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

unit libnotify;

{$mode fpc}{$PACKRECORDS C}

interface
uses ctypes, glib2, gdk2pixbuf;

const
  NOTIFY_LIBRARY = 'libnotify.so';

{ notification.h }
const
 (**
 * NOTIFY_EXPIRES_DEFAULT:
 *
 * The default expiration time on a notification.
 *)
 NOTIFY_EXPIRES_DEFAULT = -1;

 (**
 * NOTIFY_EXPIRES_NEVER:
 *
 * The notification never expires. It stays open until closed by the calling API
 * or the user.
 *)
 NOTIFY_EXPIRES_NEVER   = 0;

type
  P_NotifyNotificationPrivate = ^T_NotifyNotificationPrivate;
  T_NotifyNotificationPrivate = record end;

  PNotifyNotificationPrivate = P_NotifyNotificationPrivate;
  NotifyNotificationPrivate  = T_NotifyNotificationPrivate;

  P_NotifyNotification = ^T_NotifyNotification;
  T_NotifyNotification = record
    parent_object : TGObject;
    priv          : PNotifyNotificationPrivate;
  end;

  PNotifyNotification = P_NotifyNotification;
  TNotifyNotification = T_NotifyNotification;

  TNotificationProc = procedure (Notification : PNotifyNotification); cdecl;

  P_NotifyNotificationClass = ^T_NotifyNotificationClass;
  T_NotifyNotificationClass = record
    parent_class : TGObjectClass;
    // Signals
    Notification : TNotificationProc;
  end;

  PNotifyNotificationClass = P_NotifyNotificationClass;
  TNotifyNotificationClass = T_NotifyNotificationClass;

function  notify_notification_get_type : GType; cdecl; external NOTIFY_LIBRARY;

function m_notify_type_notification : GType; cdecl; inline;
function M_NOTIFY_NOTIFICATION(o : pointer) : PGTypeInstance; cdecl; inline;
function M_NOTIFY_NOTIFICATION_CLASS(k : Pointer) : Pointer; cdecl; inline;
function M_NOTIFY_IS_NOTIFICATION(o : Pointer) : Boolean; cdecl; inline;
function M_NOTIFY_IS_NOTIFICATION_CLASS(k : pointer) : Boolean; cdecl; inline;
function M_NOTIFY_NOTIFICATION_GET_CLASS(o : Pointer) : PGTypeClass; cdecl; inline;

const
 (**
 * NotifyUrgency:
 * @NOTIFY_URGENCY_LOW: Low urgency. Used for unimportant notifications.
 * @NOTIFY_URGENCY_NORMAL: Normal urgency. Used for most standard notifications.
 * @NOTIFY_URGENCY_CRITICAL: Critical urgency. Used for very important notifications.
 *
 * The urgency level of the notification.
 *)
 NOTIFY_URGENCY_LOW      = 0;
 NOTIFY_URGENCY_NORMAL   = 1;
 NOTIFY_URGENCY_CRITICAL = 2;

type
  NotifyUrgency = cint;

 (**
 * NotifyActionCallback:
 * @notification:
 * @action:
 * @user_data:
 *
 * An action callback function.
 *)
 NotifyActionCallback = procedure(notification : PNotifyNotification;
                                  action       : PChar;
                                  user_data    : gpointer); cdecl;
(*
/**
 * NOTIFY_ACTION_CALLBACK:
 * @func: The function to cast.
 *
 * A convenience macro for casting a function to a #NotifyActionCallback. This
 * is much like G_CALLBACK().
 */
#define NOTIFY_ACTION_CALLBACK(func) ((NotifyActionCallback)(func))
*)

function notify_notification_new(constref summary, body, icon : PChar) : PNotifyNotification;
 cdecl; external NOTIFY_LIBRARY;

function notify_notification_update(notification : PNotifyNotification;
                                    constref summary, body, icon : PChar) : gboolean;
 cdecl; external NOTIFY_LIBRARY;


(*

gboolean            notify_notification_show                  (NotifyNotification *notification,
                                                               GError            **error);

void                notify_notification_set_timeout           (NotifyNotification *notification,
                                                               gint                timeout);

void                notify_notification_set_category          (NotifyNotification *notification,
                                                               const char         *category);

void                notify_notification_set_urgency           (NotifyNotification *notification,
                                                               NotifyUrgency       urgency);

void                notify_notification_set_icon_from_pixbuf  (NotifyNotification *notification,
                                                               GdkPixbuf          *icon);
void                notify_notification_set_image_from_pixbuf (NotifyNotification *notification,
                                                               GdkPixbuf          *pixbuf);

void                notify_notification_set_hint_int32        (NotifyNotification *notification,
                                                               const char         *key,
                                                               gint                value);
void                notify_notification_set_hint_uint32       (NotifyNotification *notification,
                                                               const char         *key,
                                                               guint               value);

void                notify_notification_set_hint_double       (NotifyNotification *notification,
                                                               const char         *key,
                                                               gdouble             value);

void                notify_notification_set_hint_string       (NotifyNotification *notification,
                                                               const char         *key,
                                                               const char         *value);

void                notify_notification_set_hint_byte         (NotifyNotification *notification,
                                                               const char         *key,
                                                               guchar              value);

void                notify_notification_set_hint_byte_array   (NotifyNotification *notification,
                                                               const char         *key,
                                                               const guchar       *value,
                                                               gsize               len);

void                notify_notification_set_hint              (NotifyNotification *notification,
                                                               const char         *key,
                                                               GVariant           *value);

void                notify_notification_set_app_name          (NotifyNotification *notification,
                                                               const char         *app_name);

void                notify_notification_clear_hints           (NotifyNotification *notification);

void                notify_notification_add_action            (NotifyNotification *notification,
                                                               const char         *action,
                                                               const char         *label,
                                                               NotifyActionCallback callback,
                                                               gpointer            user_data,
                                                               GFreeFunc           free_func);

void                notify_notification_clear_actions         (NotifyNotification *notification);
gboolean            notify_notification_close                 (NotifyNotification *notification,
                                                               GError            **error);

gint                notify_notification_get_closed_reason     (const NotifyNotification *notification);

*)
implementation

function m_notify_type_notification : GType; cdecl;
begin
  m_notify_type_notification := notify_notification_get_type;
end;

function M_NOTIFY_NOTIFICATION(o : pointer): PGTypeInstance; cdecl;
begin
//  #define NOTIFY_NOTIFICATION(o)           (G_TYPE_CHECK_INSTANCE_CAST ((o), NOTIFY_TYPE_NOTIFICATION, NotifyNotification))
  M_NOTIFY_NOTIFICATION := G_TYPE_CHECK_INSTANCE_CAST(o, m_notify_type_notification);
end;

function M_NOTIFY_NOTIFICATION_CLASS(k: Pointer): Pointer; cdecl;
begin
 //#define NOTIFY_NOTIFICATION_CLASS(k)     (G_TYPE_CHECK_CLASS_CAST((k), NOTIFY_TYPE_NOTIFICATION, NotifyNotificationClass))
 M_NOTIFY_NOTIFICATION_CLASS := G_TYPE_CHECK_CLASS_CAST(k, m_notify_type_notification);
end;

function M_NOTIFY_IS_NOTIFICATION(o: Pointer): Boolean; cdecl;
begin
  // #define NOTIFY_IS_NOTIFICATION(o)        (G_TYPE_CHECK_INSTANCE_TYPE ((o), NOTIFY_TYPE_NOTIFICATION))
  M_NOTIFY_IS_NOTIFICATION := G_TYPE_CHECK_INSTANCE_TYPE(o, m_notify_type_notification);
end;

function M_NOTIFY_IS_NOTIFICATION_CLASS(k: pointer): Boolean; cdecl;
begin
  // #define NOTIFY_IS_NOTIFICATION_CLASS(k)  (G_TYPE_CHECK_CLASS_TYPE ((k), NOTIFY_TYPE_NOTIFICATION))
  M_NOTIFY_IS_NOTIFICATION_CLASS := G_TYPE_CHECK_CLASS_TYPE(k, m_notify_type_notification);
end;

function M_NOTIFY_NOTIFICATION_GET_CLASS(o: Pointer): PGTypeClass; cdecl;
begin
  // #define NOTIFY_NOTIFICATION_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), NOTIFY_TYPE_NOTIFICATION, NotifyNotificationClass))
  M_NOTIFY_NOTIFICATION_GET_CLASS := G_TYPE_INSTANCE_GET_CLASS(o, m_notify_type_notification);
end;

end.

