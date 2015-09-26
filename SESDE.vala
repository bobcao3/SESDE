using Gtk;

public static int runmode = 0; // 0 -> Desktop, 1 -> Tablet

namespace SESDE {

static Gtk.Window taskl;
static Panel.MainWindow win;
static Preference.PreferenceWin prwin;

public void main (string[] args) {
	Gtk.init (ref args);
	
	foreach(string arg in args) {
		stdout.printf("Argument : %s\n",arg);
		if(arg == "tablet") {
			stdout.printf("Entering Tablet Mode.\n");
			runmode = 1;
		}
	}

	if (runmode == 1) {
		taskl = new ATaskl.TabletWindow  ();
	} else {
		taskl = new ATaskl.MainWindow  ();
		taskl.show_all ();
	}

	prwin = new Preference.PreferenceWin ();
	
	int hx, hy;
	taskl.get_size (out hx, out hy);
	
	if (runmode == 1) {
		win = new Panel.MainWindow (0, runmode);//, taskl);
	} else {
		win = new Panel.MainWindow (hy, runmode);//, taskl);
	}
	win.show_all ();
	
	Gtk.main ();
}

}
