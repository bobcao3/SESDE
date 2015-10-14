using Gtk;

namespace Preference {

	class PreferenceMan {
		
		public bool dark_theme = false;
		
		private Gtk.Settings gtkst = Gtk.Settings.get_default ();
		
		public void dark_theme_toggle () {
			this.dark_theme = !this.dark_theme;
			gtkst.gtk_application_prefer_dark_theme = this.dark_theme;
		}
		
		public PreferenceMan () {
			
		}
		
	}

	class PreferenceWin : Gtk.Window {

		private Preference.PreferenceMan prman = new Preference.PreferenceMan ();

		public void appear () {
			this.show_all ();
		}

		public void vanish () {
			this.hide ();
		}

		public PreferenceWin () {
			Button dark_toggle = new Button ();
			dark_toggle.set_label ("Toggle Dark Theme");
			dark_toggle.clicked.connect(this.prman.dark_theme_toggle);
			this.deletable = false;
			this.title = "SESDE Preferences";
			this.add (dark_toggle);
			
		}
	
	}

}
