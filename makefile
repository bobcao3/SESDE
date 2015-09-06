SESDE: ALaunch.vala APanel.vala SESDE.vala
	valac ALaunch.vala APanel.vala SESDE.vala -o SESDE --pkg gtk+-3.0 --thread

all: clean SESDE

clean:
	rm -f SESDE
	
install: all
	./install.sh
