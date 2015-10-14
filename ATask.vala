using Gtk;
using Wnck;

namespace ATaskl {

public class SApplication {

	public Gtk.Image image = new Gtk.Image ();
	public Wnck.Window app;
	public GLib.List<Gtk.Button> winbtnlist = new GLib.List<Gtk.Button> ();
	public Gtk.Dialog dialog = new Gtk.Dialog ();
	public Gdk.Pixbuf icon_px;
	public string name;
	public Gtk.Button btn = new Gtk.Button ();
	
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

	public void flash_state () {
		if (app.is_skip_tasklist ()) {
			this.btn.hide ();
		} else {
			this.btn.show_all ();
		}
		if (app.is_active ()) {
	//		this.btn.active = true;
		} else {
	//		this.btn.active = false;
		}
		workspace_changed ();
	}

	private void state_change (WindowState changed_mask, WindowState new_state) {
		flash_state ();
	}

	private void actions_changed (WindowActions changed_mask, WindowActions new_actions) {
		flash_state ();
	}
	
	private void workspace_changed () {
	}

	public void btn_clicked () {
		this.app.activate (0);
	}
	
	public SApplication () {
		app.icon_changed.connect (icon_change);
		app.name_changed.connect (name_change);
		app.state_changed.connect (state_change);
		app.actions_changed.connect (actions_changed);
		btn.clicked.connect (btn_clicked);
	}
	
}

public class ATaskContext {

	public Wnck.Screen scr = Wnck.Screen.get_default ();
	public Wnck.Workspace wrksp;
	
	public Gtk.Box tskl = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
	
	public GLib.List<ATaskl.SApplication> applist = new GLib.List<ATaskl.SApplication> ();
	
	static SApplication nullSAPP = new SApplication ();
	
	public void remove_by_wapp (Wnck.Window wapp) {
		SApplication foobar = nullSAPP;
		applist.foreach ( (aapp) => {
			if (((SApplication) aapp).app == wapp) {
				foobar = aapp;
			}
		});
		tskl.remove (foobar.btn);
		applist.remove (foobar);
	}
	
	private void window_closed (Wnck.Window app) {
		stdout.printf ("[WindowList] \"%s\" closed\n", app.get_name ());
		this.remove_by_wapp (app);
	}
	
	private void window_opened (Wnck.Window app) {
		string name = app.get_name ();
		stdout.printf ("[WindowList] \"%s\" opened\n", name);
		
		ATaskl.SApplication aapp = new ATaskl.SApplication ();
		aapp.load_pixbuf (app.get_icon());
		aapp.app = app;
		aapp.name = name;
		aapp.flash_state ();
		applist.prepend (aapp);
		
		tskl.pack_start(aapp.btn, false, true);
		tskl.show();
	}

	public ATaskContext () {
		this.wrksp = scr.get_active_workspace ();
		this.scr.window_closed.connect (this.window_closed);
		this.scr.window_opened.connect (this.window_opened);
	}
	
}

public class MainWindow : Gtk.Window {
	
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

public class TabletWindow : Gtk.Window {
	
	private ATaskContext ctx = new ATaskContext ();
	
	public Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL,2);
	
	public void appear () {
		this.show_all ();
	}
	
	public void vanish () {
		this.hide ();
	}
	
	public TabletWindow () {
		
		this.window_position = Gtk.WindowPosition.CENTER;
		
		this.set_decorated (false);
		this.set_skip_pager_hint (true);
		this.set_skip_taskbar_hint (true);
		this.set_keep_above (true);
		this.stick ();

		ctx.tskl.set_orientation (Gtk.Orientation.VERTICAL);
		
		box.pack_start (ctx.tskl);
		this.add (box);
	}
	
}

}

