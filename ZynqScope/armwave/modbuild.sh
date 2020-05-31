# no, I'm not sure why I need to build twice
git pull
make clean
make -j3
sudo python3.8 setup.py install

# generate sources
gcc -S -I/usr/local/include/python3.8 -fverbose-asm -lm -g -fwrapv -O3 armwave.c -o armwave.s
/usr/bin/as -alhnd armwave.s > armwave.lst

git add armwave.s armwave.lst
git commit -m "add armwave listing"
git push
