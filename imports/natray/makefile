nop:
	gcc --shared -fPIC *.c -o na-tray.so `pkg-config --cflags --libs gtk+-x11-3.0 x11`
	cp *.h /usr/include/
	cp na-tray.so /usr/lib
