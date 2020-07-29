"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import gettext
gettext.bindtextdomain('yaosapp', '/lang')
gettext.textdomain('yaosapp')
_ = gettext.gettext

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

import time

# Y-offset for notifications
NOTIFY_YPOS = 0

# Supported notification classes
NOTIFY_WARNING = 2
NOTIFY_INFO = 1

# Notification show time & fadeout period.  
NOTIFY_SHOW_AGE = 5
NOTIFY_FADEOUT_TIME = 1

# Small notify widget filter
NOTIFY_SMALL_WIDGET = 16

# Load debug logger
import logging
log = logging.getLogger()

class NotifyController(object):
    def __init__(self):
        self.notifiers = [None, None]
        self.fixed = None
        self.cur_wdg = None
        self.last_computed_x = None
    
    def push_notification(self, notify):
        # We used to have a complex sorting logic that picked out the newest notification,
        # but this is better. We only show the newest notification, except if that notification
        # has a lower priority than the current notification.  If so, it gets put into slot 1
        # of the notification queue. 
        if self.notifiers[1] == None or notify.cls < self.notifiers[1].cls:
            log.info("Replacing secondary notification with %r" % notify)
            if self.notifiers[1] is not None:
                self.notifiers[1].destroy()
            self.notifiers[1] = notify
        else:
            log.info("Replacing current notification with %r" % notify)
            if self.notifiers[0] is not None:
                self.notifiers[0].destroy()
            self.notifiers[0] = notify
    
    def set_fixed_container(self, fixed):
        self.fixed = fixed
    
    def update_overlay(self, screen_width):
        wdg = self.get_next_notify_widget()
        if wdg == None:
            self.last_computed_x = None
            return
        
        # If allocated_width is small, hide the widget for now; we'll show it on the next frame
        # (This is used to avoid the widget snapping into place after it is attached to the GtkFixed)
        if wdg.get_allocated_width() <= NOTIFY_SMALL_WIDGET:
            wdg.set_opacity(0)
        
        computed_x = (screen_width / 2) - (wdg.get_allocated_width() / 2)
        
        if self.cur_wdg != wdg:
            if self.cur_wdg != None:
                self.fixed.remove(self.cur_wdg)

            self.fixed.put(wdg, computed_x, NOTIFY_YPOS)
        else:
            if computed_x != self.last_computed_x:
                self.fixed.move(wdg, computed_x, NOTIFY_YPOS)
        
        self.last_computed_x = computed_x
        self.cur_wdg = wdg
    
    def get_next_notify_widget(self):
        """Determines which notifier to show from the two available slots."""
        for n in range(2):
            if self.notifiers[n] != None:
                wdg = self.notifiers[n].get_widget()
                if wdg == False:
                    self.notifiers[n] = None
                else:
                    return wdg
        
        return None

class NotifyMessage(object):
    def __init__(self, cls_, message):
        self.cls = cls_
        self.message = message
        self.label = Gtk.Label()
        self.label.set_xalign(0.5)
        self.label.set_yalign(0.5)  
        self.label.set_hexpand(False)
        self.label.set_vexpand(False)
        self.label.set_opacity(1.0)
        self.last_opacity = None
        
        self.label_ctx = self.label.get_style_context()
        self.label_ctx.add_class("notify_global")
        
        self.t_created = time.time()
        self.t_started = None

        self.lbl_visible = False
    
    def __lt__(self, other):
        # Sort by priority first, then age
        #print("__lt__ %r %r" % (self, other))
        if self.cls == other.cls:
            # younger age wins?
            return self.t_created > other.t_created
        else:
            return self.cls > other.cls
    
    def get_widget(self):
        if self.t_started == None:
            self.t_started = time.time()
        
        if not self.lbl_visible:
            self.label.show_all()
            self.label.set_markup(self.message)
            self.lbl_visible = True
        
        self.label_ctx.remove_class("notify_info")
        self.label_ctx.remove_class("notify_warning")
        
        if self.cls == NOTIFY_WARNING:
            self.label_ctx.add_class("notify_warning")
            self.label_ctx.remove_class("notify_info")
        elif self.cls == NOTIFY_INFO:
            self.label_ctx.add_class("notify_info")
            self.label_ctx.remove_class("notify_warning")
        
        # once shown, opacity goes to 0 over course of NOTIFY_FADEOUT_TIME seconds
        age = time.time() - self.t_started
        if age >= NOTIFY_SHOW_AGE:
            age -= NOTIFY_SHOW_AGE
            fade = 1.0 - (age / NOTIFY_FADEOUT_TIME)
            #self.label.set_opacity(fade)
            self.last_opacity = fade
            
            if fade <= 0:
                self.label.destroy()   # Kill the widget
                self.self.lbl_visible = False
                return False
        else:
            #print("setOpacity...")
            self.label.set_opacity(1.0)
            self.last_opacity = 1.0
        
        return self.label
    
    def destroy(self):
        """Quick cleanup before we're killed."""
        self.label.set_opacity(0.0)
        