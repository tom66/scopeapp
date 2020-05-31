import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib, Gio, Gdk, GdkPixbuf, GObject, Pango

import time
import armwave

print("create window")

wnd = Gtk.Window()
#wnd.show_all()

#img = Gtk.Image()
#wnd.add(img)

#Gtk.main()

print("test_init()")

width = 2048
height = 1024

armwave.test_init()
armwave.test_create_am_sine(0.5f)

img = Gtk.Image()

wnd.add(img)
wnd.show_all()
wnd.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.2, 0.2, 0.2, 1.0))

#Glib.timeout_add(
#Gtk.main()

Gtk.main_iteration()

ts = time.time()
f = 0
mod = 0.0
total_time = 0.0
total_frames = 0

while True:
	t0 = time.time()
	pbuf = GdkPixbuf.Pixbuf.new(GdkPixbuf.Colorspace.RGB, True, 8, width, height)
	t1 = time.time()
	print("GdkPixbuf new:           %5.1f ms" % ((t1 - t0) * 1000))

	t0 = time.time()
	armwave.test_generate()
	t1 = time.time()
	print("test_generate:           %5.1f ms" % ((t1 - t0) * 1000))

	t0 = time.time()
	buf = armwave.test_fill_gdkbuf(pbuf)
	t1 = time.time()
	print("test_fill_gdkbuf:        %5.1f ms" % ((t1 - t0) * 1000))

	#if f > 20:
	#	mod += 0.025
	#	armwave.test_init(mod)
	#	if mod > 0.5:
	#		mod = 0
	#	f = 0
	#	print("New mod: %5.3f" % mod)

	#print(buf, type(buf))

	"""
	t0 = time.time()
	bybuf = buf.tobytes()
	t1 = time.time()
	print("buf_tobytes:             %5.1f ms" % ((t1 - t0) * 1000))

	t0 = time.time()
	gbytes = GLib.Bytes.new(bybuf)
	t1 = time.time()
	print("Glib_bytes_new:          %5.1f ms" % ((t1 - t0) * 1000))
	"""

	#stream = Gio.MemoryInputStream.new_from_data(buf)
	#pbuf = GdkPixbuf.Pixbuf.new_from_bytes(gbytes, GdkPixbuf.Colorspace.RGB, True, 8, 256, 2048, 1024)
	"""
	t0 = time.time()
	pbuf = GdkPixbuf.Pixbuf.new_from_bytes(gbytes, GdkPixbuf.Colorspace.RGB, True, 8, width, height, 2048 * 4)
	t1 = time.time()
	print("GdkPixbuf new_from_bytes:%5.1f ms" % ((t1 - t0) * 1000))
	"""

	#t0 = time.time()
	#pbuf = pbuf.scale_simple(2048, 1024, GdkPixbuf.InterpType.TILES)
	#t1 = time.time()
	#print("GdkPixbuf scaling:       %5.1f ms" % ((t1 - t0) * 1000))

	#pbuf = GdkPixbuf.Pixbuf.new_from_stream(
	#pbuf = pbuf.rotate_simple(90)
	
	t0 = time.time()
	img.set_from_pixbuf(pbuf)
	t1 = time.time()
	print("img set_from_pixbuf:     %5.1f ms" % ((t1 - t0) * 1000))

	t0 = time.time()
	Gtk.main_iteration()
	t1 = time.time()
	print("Gtk.main_iteration():    %5.1f ms" % ((t1 - t0) * 1000))

	# total time
	t = time.time()
	total_time += t - ts
	total_frames += 1
	print("Frame time: %7.3f ms (%5.1f fps)" % ((t - ts) * 1000, total_frames / (total_time)))
	ts = t
	f = f + 1

	print("\n\n\n\n")

#wnd.add(img)
#wnd.show_all()

#print(buf)
#print(bytes(buf))

print("dump buffer to ppm")
armwave.test_dump_buffer_to_ppm("test_python.ppm")

print("cleanup")
armwave.cleanup()

Gtk.main()

