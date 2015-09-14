using Wnck;

namespace ATaskl {

class AppIcon : Gtk.Box {

	private AppIcon (Gdk.Pixbuf icon_px, string name) {
		this.orientation = Gtk.Orientation.VERTICAL;
		
	}

}

class MainWindow : Gtk.Window {
	
	private Wnck.Screen scr = Wnck.Screen.get_default ();
	private Wnck.Workspace wrksp;
	private Gtk.FlowBox appflow = new Gtk.FlowBox();
	private Gtk.ScrolledWindow srl = new Gtk.ScrolledWindow(null, null);
	
	public GLib.List<Wnck.Window> winlist = new GLib.List<Wnck.Window> ();
	
	private void window_closed (Wnck.Window win) {
		stdout.printf ("[WindowList] \"%s\" closed\n", win.get_name ());
		winlist.remove (win);
	}
	
	private void window_opened (Wnck.Window win) {
		stdout.printf ("[WindowList] \"%s\" opened\n", win.get_name ());
		winlist.prepend (win);
		
		AppIcon fooicon = new AppIcon (null, null);
		
	}
	
	private void prl () {
		winlist.foreach ( (win) => {
			stdout.printf ("[WindowList] all: %s\n", win.get_name ());
		});
	}
	
	public MainWindow () {
		Gdk.Screen scrn = Gdk.Screen.get_default ();
		this.set_default_size (scrn.width (), 48);
	
		srl.add (appflow);
		this.add (appflow);
	
		wrksp = scr.get_active_workspace ();
		scr.window_closed.connect (this.window_closed);
		scr.window_opened.connect (this.window_opened);
	}
	
}

}

