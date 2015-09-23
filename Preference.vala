using Gtk;

namespace Preference {

	class PreferenceWin : Gtk.Window {

		public void appear () {
			this.show_all ();
		}

		public void vanish () {
			this.hide ();
		}

		public PreferenceWin () {
			SESDE.taskl.destroy ();
		}
	
	}

}
