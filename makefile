CC = "clang"
XCC = "-D WNCK_I_KNOW_THIS_IS_UNSTABLE"


SESDE: Preference.vala ALaunch.vala APanel.vala SESDE.vala ATask.vala
	valac -c --cc=${CC} --Xcc=${XCC} Preference.vala ALaunch.vala ATask.vala APanel.vala SESDE.vala -o SESDE --pkg libwnck-3.0

all: clean SESDE

clean:
	rm -f SESDE
	
install: all
	./install.sh
