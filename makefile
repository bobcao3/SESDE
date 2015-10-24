CC = "clang"
XCC = "-D WNCK_I_KNOW_THIS_IS_UNSTABLE"

SESDE: Preference.vala ALaunch.vala APanel.vala SESDE.vala ATask.vala
	sudo make -C imports/natray
	valac --cc=${CC} --Xcc=${XCC} Preference.vala ALaunch.vala ATask.vala APanel.vala SESDE.vala -o SESDE --pkg libwnck-3.0 --pkg dconf --vapidir=./imports/natray --pkg natray-1.0 -X "-lna-tray"

all: clean SESDE

clean:
	rm -f SESDE
	
install: all
	./install.sh
