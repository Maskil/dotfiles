# CUBE
## `username` is not in sudoers file
  ```bash
  su root
  sudo adduser <username> sudo
  ```
  will take effect after restart
## install drivers
replace original `/etc/apt/sources.list` with
```
deb http://deb.debian.org/debian bullseye main contrib non-free
deb-src http://deb.debian.org/debian bullseye main contrib non-free
deb http://deb.debian.org/debian-security bullseye-security main contrib non-fr>
deb-src http://deb.debian.org/debian-security bullseye-security main contrib no>
deb http://deb.debian.org/debian bullseye-updates main contrib non-free
deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free
```
add backports repository \
`sudo nano /etc/apt/sources.list.d/bullseye-backports.list`\
then add\
`http://http.debian.net/debian bullseye-backports main contrib non-free`\
then
```bash
sudo apt update
sudo apt bullseye-backports install linux-image-amd64
sudo apt install -t bullseye-backports firmware-linux
```

## for wacom tablet
`xsetwacom --set "Wacom One by Wacom M Pen stylus" MapToOutput HEAD-0`
`xsetwacom --set "Wacom One by Wacom M Pen eraser" MapToOutput HEAD-0`\
monitors(displays) are listed in numbers HEAD-n (n>=0)

`xsetwacom --set "Wacom One by Wacom M Pen stylus" Rotate ccw`
`xsetwacom --set "Wacom One by Wacom M Pen stylus" Rotate half`\
try either/both of the commands to rotate
