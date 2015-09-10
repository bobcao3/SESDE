using Wnck;

namespace ATaskl {

class MainWindow : Gtk.Window {
	
	private Wnck.Screen scr = Wnck.Screen.get_default ();
	private Wnck.Workspace wrksp;
	
	public List<Wnck.Window> winlist = new List<Wnck.Window> ();
	
	private void window_closed (Wnck.Window win) {
		stdout.printf ("[WindowList] \"%s\" closed\n", win.get_name ());
		this.winlist.prepend (win);
		prl ();
	}
	
	private void window_opened (Wnck.Window win) {
		stdout.printf ("[WindowList] \"%s\" opened\n", win.get_name ());
		this.winlist.remove (win);
		prl ();
	}
	
	private void prl () {
		this.winlist.foreach ((a) => {
			stdout.puts(a.get_name ());
		});
	}
	
	public MainWindow () {
		wrksp = scr.get_active_workspace ();
		scr.window_closed.connect (this.window_closed);
		scr.window_opened.connect (this.window_opened);
	}
	
}

}

