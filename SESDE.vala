using Gtk;

public void main (string[] args) {
	Gtk.init (ref args);
	Panel.MainWindow win = new Panel.MainWindow ();
	win.show_all ();
	Gtk.main ();
}
