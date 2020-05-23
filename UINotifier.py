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
NOTIFY_YPOS = 50

# Supported notification classes
NOTIFY_WARNING = 2
NOTIFY_INFO = 1

# Notification show time & fadeout period.  
NOTIFY_SHOW_AGE = 5
NOTIFY_FADEOUT_TIME = 2

class NotifyController(object):
    def __init__(self):
        self.notifiers = []
        self.fixed = None
        self.cur_wdg = None
        self.last_computed_x = None
    
    def push_notification(self, notify):
        self.notifiers.append(notify)
    
    def set_fixed_container(self, fixed):
        self.fixed = fixed
    
    def update_overlay(self, screen_width):
        wdg = self.get_next_notify_widget()
        if wdg == None:
            self.last_computed_x = None
            return
        
        # If allocated_width is small, hide the widget for now; we'll show it on the next frame
        # (This is used to avoid the widget snapping into place after it is attached to the GtkFixed)
        if wdg.get_allocated_width() <= 1:
            print("allocWidthSmall")
            wdg.set_opacity(0)
        
        computed_x = (screen_width / 2) - (wdg.get_allocated_width() / 2)
        
        if self.cur_wdg != wdg:
            if self.cur_wdg != None:
                self.fixed.remove(self.cur_wdg)
            print("putWdg")
            self.fixed.put(wdg, computed_x, NOTIFY_YPOS)
        else:
            if computed_x != self.last_computed_x:
                #print("moveWdg")
                self.fixed.move(wdg, computed_x, NOTIFY_YPOS)
                self.last_computed_x = computed_x
        
        self.cur_wdg = wdg
    
    def get_next_notify_widget(self):
        """Searches the list of notifiers and finds the highest priority notification. If 
        one isn't available then it returns None.  Will delete any expired notifications."""
        wdg = None
        nsorted = sorted(self.notifiers)
        
        # process the first widget, only skipping onto the next one if it's a dud
        for ntf in nsorted:
            wdg = ntf.get_widget()
            if wdg == False:
                self.notifiers.remove(ntf)
                continue
            else:
                #print(wdg, time.time() - ntf.t_created, time.time() - ntf.t_started)
                break
        
        if wdg == False:
            wdg = None
        
        return wdg

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
    
    def __lt__(self, other):
        # Sort by priority first, then age
        #print("__lt__ %r %r" % (self, other))
        if self.cls == other.cls:
            # newer age wins
            return self.t_created > other.t_created
        else:
            return self.cls > other.cls
    
    def get_widget(self):
        if self.t_started == None:
            self.t_started = time.time()
        
        self.label.show_all()
        self.label.set_markup(self.message)
        
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
            self.label.set_opacity(fade)
            self.last_opacity = fade
            
            if fade <= 0:
                self.label.destroy()   # Kill the widget
                return False
        else:
            print("setOpacity...")
            self.label.set_opacity(1.0)
            self.last_opacity = 1.0
        
        return self.label
