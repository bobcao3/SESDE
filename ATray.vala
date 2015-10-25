using Gtk;
using Na;

namespace ATray {

public class Tray : Gtk.Box {
	
	protected int icon_size = 32;
	protected Na.Tray? tray = null;
	Gtk.EventBox box;
    
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
    
    public Tray () {
    	box = new Gtk.EventBox();
        add(box);
        
        box.valign = Gtk.Align.CENTER;
        box.vexpand = false;
        
        if (tray != null) {
            return;
        }
    	tray = new Na.Tray.for_screen(get_screen(), Gtk.Orientation.HORIZONTAL);
        tray.set_icon_size(icon_size);
        tray.set_padding(0);
        box.add(tray);
		
		this.margin = 0;
		this.show_all();
	}
}

}
