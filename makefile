CC = "clang"
XCC = "-D WNCK_I_KNOW_THIS_IS_UNSTABLE"

SRC = Preference.vala ALaunch.vala APanel.vala SESDE.vala ATask.vala ATray.vala

SESDE: ${SRC}
	valac --cc=${CC} --Xcc=${XCC} ${SRC} -o SESDE --pkg libwnck-3.0 --pkg dconf --vapidir=./imports/natray --vapidir=./imports/ --pkg natray-1.0 -X "-lna-tray" --pkg gvc-1.0

NaTray:
	sudo make -C imports/natray

all: clean SESDE

clean:
	rm -f SESDE
	
install: all
	./install.sh
