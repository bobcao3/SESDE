using Wnck;

namespace ATaskl {

class MainWindow : Gtk.Window {
	
	private Wnck.Screen scr = Wnck.Screen.get_default ();
	private Wnck.Workspace wrksp;
	
	private Wnck.Tasklist tskl = new Wnck.Tasklist ();
	
	private Gtk.ButtonBox btnbox = new Gtk.ButtonBox (Gtk.Orientation.HORIZONTAL);
	
	public GLib.List<Wnck.Application> applist = new GLib.List<Wnck.Application> ();
	
	private void application_closed (Wnck.Application app) {
		stdout.printf ("[ApplicationList] \"%s\" closed\n", app.get_name ());
		applist.remove (app);
	}
	
	private void application_opened (Wnck.Application app) {
		stdout.printf ("[ApplicationList] \"%s\" opened\n", app.get_name ());
		applist.prepend (app);
	}

	private void prl () {
		applist.foreach ( (win) => {
			stdout.printf ("[WindowList] all: %s\n", win.get_name ());
		});
	}
	
	public MainWindow () {
		Gdk.Screen scrn = Gdk.Screen.get_default ();
		this.set_default_size (scrn.get_width (), 32);
		this.move (0, scrn.get_height ());
		this.set_decorated (false);
		this.set_skip_pager_hint (true);
		this.set_skip_taskbar_hint (true);
		this.set_keep_above (true);
		this.stick ();
		
		this.add (tskl);
		
		wrksp = scr.get_active_workspace ();
		scr.application_closed.connect (this.application_closed);
		scr.application_opened.connect (this.application_opened);
	}
	
}

}

