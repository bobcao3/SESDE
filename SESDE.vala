using Gtk;

public void main (string[] args) {
	Gtk.init (ref args);
	Panel.MainWindow win = new Panel.MainWindow ();
	win.show_all ();
	
	ATaskl.MainWindow taskl = new ATaskl.MainWindow  ();
	taskl.show_all ();
	
	Gtk.main ();
}
