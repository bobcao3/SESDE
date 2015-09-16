using Wnck;
using Gtk;

namespace Panel {

public class ActionMenu : Gtk.Window {
	
	private Box box = new Box (Orientation.VERTICAL, 3);
	private Button btn_shutdown = new Button ();
	private Button btn_reboot = new Button ();
	private Button btn_cancel = new Button ();
	private Label label = new Label ("Actions .. ");
	private GLib.SubprocessLauncher processL = new GLib.SubprocessLauncher (GLib.SubprocessFlags.NONE);
	
	private void cancel () {
		this.destroy ();
	}
	
	private void shutdown () {
		try {
			processL.spawnv ({"shutdown","-P","now",null});
		} catch (Error e) {
			stderr.printf ("Failed to shutdown: %s\n", e.message);
		}
	}
	
	private void reboot () {
		try {
			processL.spawnv ({"shutdown","-r","now",null});
		} catch (Error e) {
			stderr.printf ("Failed to reboot: %s\n", e.message);
		}
	}
	
	public ActionMenu () {
		btn_shutdown.set_label ("Shutdown");
		btn_shutdown.clicked.connect (shutdown);
		btn_reboot.set_label ("Reboot");
		btn_reboot.clicked.connect (reboot);
		btn_cancel.set_label ("Cancel");
		btn_cancel.clicked.connect (cancel);
		
		box.pack_start (label, true, true, 0);
		box.pack_start (btn_shutdown, true, true, 0);
		box.pack_start (btn_reboot, true, true, 0);
		box.pack_start (btn_cancel, true, true, 0);
	
		this.add (box);
		this.window_position = Gtk.WindowPosition.CENTER_ALWAYS;
		this.border_width = 3;
		this.set_decorated (false);
	}

}

public class MainWindow : Gtk.Window {
	
	private Box box = new Box (Orientation.HORIZONTAL, 2);
	private ToggleButton button_launcher = new ToggleButton ();
	private Button button_action = new Button ();
	private Label time_dis = new Label ("0:0:0");
	
	private Wnck.Pager pgr = new Wnck.Pager ();
	
	public ALaunch.MainWindow l_win = new ALaunch.MainWindow ();

	private void Launcher () {
		if (l_win.visible) {
			l_win.vanish ();
		} else {
			l_win.appear ();
		}
	}
	
	private void Action () {
		ActionMenu action = new ActionMenu ();
		action.show_all ();
	}
	
	private void timer () {
		GLib.DateTime now = new GLib.DateTime.now_local ();
		string t = now.format("%H:%M:%S");
		time_dis.label = t;
	}
	
	public MainWindow () {
		this.title = "APanel";
		this.set_type_hint (Gdk.WindowTypeHint.DOCK);
		
		Gdk.Screen screen = Gdk.Screen.get_default ();
		this.set_default_size (screen.get_width (), 32);
		
		button_launcher.set_label ("Launch");
		button_launcher.toggled.connect (Launcher);
		button_action.set_label ("Action");
		button_action.clicked.connect (Action);
		
		pgr.set_display_mode (Wnck.PagerDisplayMode.CONTENT);
		
		box.pack_start (button_launcher, false, true, 0);
		box.pack_start (button_action, false, true, 0);
		box.pack_start (pgr, false, false, 0);
		box.pack_end (time_dis, false, true, 0);
		
		this.set_decorated (false);
		this.set_skip_pager_hint (true);
		this.set_skip_taskbar_hint (true);
		
		GLib.Timeout.add (1000, (GLib.SourceFunc) timer);
		timer ();
		
		this.add(box);
	}
	
}

}
