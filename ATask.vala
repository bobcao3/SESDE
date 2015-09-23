using Gtk;
using Wnck;

namespace ATaskl {

class ATaskContext {

	public Wnck.Screen scr = Wnck.Screen.get_default ();
	public Wnck.Workspace wrksp;
	
	public Wnck.Tasklist tskl = new Wnck.Tasklist ();
	
	public Gtk.ButtonBox btnbox = new Gtk.ButtonBox (Gtk.Orientation.HORIZONTAL);
	
	public GLib.List<Wnck.Application> applist = new GLib.List<Wnck.Application> ();
	
	private void application_closed (Wnck.Application app) {
		stdout.printf ("[ApplicationList] \"%s\" closed\n", app.get_name ());
		applist.remove (app);
	}
	
	private void application_opened (Wnck.Application app) {
		stdout.printf ("[ApplicationList] \"%s\" opened\n", app.get_name ());
		applist.prepend (app);
	}

	public void prl () {
		applist.foreach ( (win) => {
			stdout.printf ("[WindowList] all: %s\n", win.get_name ());
		});
	}
	
	public ATaskContext () {
		this.wrksp = scr.get_active_workspace ();
		this.scr.application_closed.connect (this.application_closed);
		this.scr.application_opened.connect (this.application_opened);
		this.tskl.set_grouping (Wnck.TasklistGroupingType.ALWAYS_GROUP);
	}
	
}

class MainWindow : Gtk.Window {
	
	private ATaskContext ctx = new ATaskContext ();
	
	public MainWindow () {
		Gdk.Screen scrn = Gdk.Screen.get_default ();
		this.set_default_size (scrn.get_width (), 32);
		this.move (0, scrn.get_height ());
		this.set_decorated (false);
		this.set_skip_pager_hint (true);
		this.set_skip_taskbar_hint (true);
		this.set_keep_above (true);
		this.stick ();
		
		this.add (ctx.tskl);
	}
	
}

class TabletWindow : Gtk.Window {
	
	private ATaskContext ctx = new ATaskContext ();
	
	public void appear () {
		this.show_all ();
	}
	
	public void vanish () {
		this.hide ();
	}
	
	public TabletWindow () {
		Gdk.Screen scrn = Gdk.Screen.get_default ();
		this.set_default_size (300, 500);

		this.window_position = Gtk.WindowPosition.CENTER;

		this.set_decorated (false);
		this.set_skip_pager_hint (true);
		this.set_skip_taskbar_hint (true);
		this.set_keep_above (true);
		this.stick ();
		
		ctx.tskl.set_orientation (Gtk.Orientation.VERTICAL);
		
		this.add (ctx.tskl);
	}
	
}

}

