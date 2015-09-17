using Gtk;

public static int runmode = 0; // 0 -> Desktop, 1 -> Tablet

public void main (string[] args) {
	Gtk.init (ref args);
	
	foreach(string arg in args) {
		stdout.printf("Argument : %s\n",arg);
		if(arg == "tablet") {
			stdout.printf("Entering Tablet Mode.\n");
			runmode = 1;
		}
	}

	Gtk.Window taskl;
	if (runmode == 1) {
		taskl = new ATaskl.TabletWindow  ();
	} else {
		taskl = new ATaskl.MainWindow  ();
		taskl.show_all ();
	}
	
	int hx, hy;
	taskl.get_size (out hx, out hy);
	
	Panel.MainWindow win;
	if (runmode == 1) {
		win = new Panel.MainWindow (0, runmode, taskl);
	} else {
		win = new Panel.MainWindow (hy, runmode, taskl);
	}
	win.show_all ();
	
	Gtk.main ();
}
