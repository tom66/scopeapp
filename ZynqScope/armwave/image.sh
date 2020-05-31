(echo 'P5\n512 512 255\n' ; cat "$1") |DISPLAY=:0 xli -gamma 2.2 stdin;
