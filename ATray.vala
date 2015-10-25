using Gtk;
using Na;

namespace ATray {

public class NTray : Gtk.Box {
	
	protected int icon_size = 24;
	protected Na.Tray? tray = null;
    
	public override void get_preferred_height(out int m, out int n)
    {
        m = icon_size;
        n = icon_size;
    }

    public override void get_preferred_height_for_width(int w, out int m, out int n)
    {
        m = icon_size;
        n = icon_size;
    }
    
    public NTray () {
    	tray = new Na.Tray.for_screen(get_screen(), Gtk.Orientation.HORIZONTAL);
        tray.set_icon_size(icon_size);
        tray.set_padding(5);
        add(tray);
	}
}

public class SysTray : Gtk.Window {
	private NTray nt = new NTray ();
	
	public void appear () {
		this.show_all ();
	}
	
	public void vanish () {
		this.hide ();
	}
	
	public SysTray () {
		this.add(nt);
		//this.show_all();
	}
}

}
