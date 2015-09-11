using Wnck;

namespace ATaskl {

class MainWindow : Gtk.Window {
	
	private Wnck.Screen scr = Wnck.Screen.get_default ();
	private Wnck.Workspace wrksp;
	
	public GLib.List<Wnck.Window> winlist = new GLib.List<Wnck.Window> ();
	
	private void window_closed (Wnck.Window win) {
		stdout.printf ("[WindowList] \"%s\" closed\n", win.get_name ());
		winlist.remove (win);
	}
	
	private void window_opened (Wnck.Window win) {
		stdout.printf ("[WindowList] \"%s\" opened\n", win.get_name ());
		winlist.prepend (win);
	}
	
	private void prl () {
		winlist.foreach ( (win) => {
			stdout.printf (" %s\n", win.get_name ());
		});
	}
	
	public MainWindow () {
		wrksp = scr.get_active_workspace ();
		scr.window_closed.connect (this.window_closed);
		scr.window_opened.connect (this.window_opened);
	}
	
}

}

