using Gtk;
using Wnck;

namespace ATaskl {

class SApplication {

	public Gtk.Image image = new Gtk.Image ();
	public Wnck.Application app;
	public unowned List<Wnck.Window> wins;
	public Gdk.Pixbuf icon_px;
	public string name;
	public Gtk.ModelButton btn = new Gtk.ModelButton ();
	
	public void load_pixbuf (Gdk.Pixbuf pix) {
		this.icon_px = pix;
		this.image.set_from_pixbuf (pix);
		this.btn.set_image (image);
	}
	
	private void icon_change () {
		this.icon_px = app.get_icon  ();
		this.image.set_from_pixbuf (icon_px);
		this.btn.set_image (image);
	}
	
	private void name_change () {
		this.name = app.get_name ();
	}

	public void btn_clicked () {
		
	}
	
	public void init () {
		wins = app.get_windows ();
	}
		
	public SApplication () {
		app.icon_changed.connect (icon_change);
		app.name_changed.connect (name_change);
	}
	
}

class ATaskContext {

	public Wnck.Screen scr = Wnck.Screen.get_default ();
	public Wnck.Workspace wrksp;
	
	public Gtk.Box tskl = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
	
	public GLib.List<ATaskl.SApplication> applist = new GLib.List<ATaskl.SApplication> ();
	
	static SApplication nullSAPP = new SApplication ();
	
	public void remove_by_wapp (Wnck.Application wapp) {
		SApplication foobar = nullSAPP;
		applist.foreach ( (aapp) => {
			if (((SApplication) aapp).app == wapp) {
				foobar = aapp;
			}
		});
		tskl.remove (foobar.btn);
		applist.remove (foobar);
	}
	
	private void application_closed (Wnck.Application app) {
		stdout.printf ("[ApplicationList] \"%s\" closed\n", app.get_name ());
		this.remove_by_wapp (app);
	}
	
	private void application_opened (Wnck.Application app) {
		string name = app.get_name ();
		stdout.printf ("[ApplicationList] \"%s\" opened\n", name);
		
		ATaskl.SApplication aapp = new ATaskl.SApplication ();
		aapp.load_pixbuf (app.get_icon());
		aapp.app = app;
		aapp.name = name;
		aapp.init ():
		applist.prepend (aapp);
		
		tskl.pack_start(aapp.btn, false, true);
		tskl.show_all();
	}

	public ATaskContext () {
		this.wrksp = scr.get_active_workspace ();
		this.scr.application_closed.connect (this.application_closed);
		this.scr.application_opened.connect (this.application_opened);
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

