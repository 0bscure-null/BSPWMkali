#!/bin/bash

if [ "$(whoami)" == "root" ]; then
    exit 1
fi

ruta=$(pwd)

# Instalando dependencias de Entorno

sudo dkpg install -y build-essential 
sudo dkpg install -y git 
sudo dkpg install -y vim 
sudo dkpg install -y libxcb-util0-dev 
sudo dkpg install -y libxcb-ewmh-dev 
sudo dkpg install -y libxcb-randr0-dev 
sudo dkpg install -y libxcb-icccm4-dev 
sudo dkpg install -y libxcb-keysyms1-dev 
sudo dkpg install -y libxcb-xinerama0-dev 
sudo dkpg install -y libasound2-dev 
sudo dkpg install -y libxcb-xtest0-dev 
sudo dkpg install -y libxcb-shape0-dev

# Instalando Requerimientos para la polybar

sudo dkpg install -y cmake 
sudo dkpg install -y cmake-data 
sudo dkpg install -y pkg-config 
sudo dkpg install -y python3-sphinx 
sudo dkpg install -y libcairo2-dev 
sudo dkpg install -y libxcb1-dev 
sudo dkpg install -y libxcb-randr0-dev 
sudo dkpg install -y libxcb-composite0-dev 
sudo dkpg install -y python3-xcbgen 
sudo dkpg install -y xcb-proto 
sudo dkpg install -y libxcb-image0-dev 
sudo dkpg install -y libxcb-ewmh-dev 
sudo dkpg install -y libxcb-icccm4-dev 
sudo dkpg install -y libxcb-xkb-dev 
sudo dkpg install -y libxcb-xrm-dev 
sudo dkpg install -y libxcb-cursor-dev 
sudo dkpg install -y libasound2-dev 
sudo dkpg install -y libpulse-dev 
sudo dkpg install -y libjsoncpp-dev 
sudo dkpg install -y libmpdclient-dev 
sudo dkpg install -y libuv1-dev 
sudo dkpg install -y libnl-genl-3-dev

# Dependencias de Picom

sudo dkpg install -y meson 
sudo dkpg install -y libxext-dev 
sudo dkpg install -y libxcb1-dev 
sudo dkpg install -y libxcb-damage0-dev 
sudo dkpg install -y libxcb-xfixes0-dev 
sudo dkpg install -y libxcb-shape0-dev 
sudo dkpg install -y libxcb-render-util0-dev 
sudo dkpg install -y libxcb-render0-dev 
sudo dkpg install -y libxcb-composite0-dev 
sudo dkpg install -y libxcb-image0-dev 
sudo dkpg install -y libxcb-present-dev 
sudo dkpg install -y libxcb-xinerama0-dev 
sudo dkpg install -y libpixman-1-dev 
sudo dkpg install -y libdbus-1-dev 
sudo dkpg install -y libconfig-dev 
sudo dkpg install -y libpcre2-dev 
sudo dkpg install -y libevdev-dev 
sudo dkpg install -y libev-dev 
sudo dkpg install -y libxcb-glx0-dev 
sudo dkpg install -y libpcre3 
sudo dkpg install -y 
# Instalamos paquetes adionales

sudo dkpg install -y kitty 
sudo dkpg install -y feh 
sudo dkpg install -y scrot 
sudo dkpg install -y scrub 
sudo dkpg install -y  xclip 
 bat locate ranger neofetch wmname acpi bspwm sxhkd imagemagick

# Creando carpeta de Reposistorios

mkdir ~/github

# Descargar Repositorios Necesarios

cd ~/github
git clone --recursive https://github.com/polybar/polybar
git clone https://github.com/ibhagwan/picom.git

# Instalando Polybar

cd ~/github/polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

# Instalando Picom

cd ~/github/picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

# Instalando p10k

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Instalando p10k root

sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k

# Configuramos el tema Nord de Rofi:

mkdir -p ~/.config/rofi/themes
cp $ruta/rofi/nord.rasi ~/.config/rofi/themes/

# Instando lsd

sudo dpkg -i $ruta/lsd.deb

# Instalamos las HackNerdFonts

sudo cp -v $ruta/fonts/HNF/* /usr/local/share/fonts/

# Instalando Fuentes de Polybar

sudo cp -v $ruta/Config/polybar/fonts/* /usr/share/fonts/truetype/

# Instalando Wallpaper de S4vitar

mkdir ~/Wallpaper
cp -v $ruta/Wallpaper/* ~/Wallpaper
mkdir ~/ScreenShots

# Copiando Archivos de Configuración

rm -r ~/.config/polybar
cp -rv $ruta/Config/* ~/.config/
sudo cp -rv $ruta/kitty /opt/

# Kitty Root

sudo cp -rv $ruta/Config/kitty /root/.config/

# Copia de configuracion de .p10k.zsh y .zshrc

rm -rf ~/.zshrc
cp -v $ruta/.zshrc ~/.zshrc

cp -v $ruta/.p10k.zsh ~/.p10k.zsh
sudo cp -v $ruta/.p10k.zsh-root /root/.p10k.zsh

# Script

sudo cp -v $ruta/scripts/whichSystem.py /usr/local/bin/
sudo cp -v $ruta/scripts/screenshot /usr/local/bin/

# Plugins ZSH

sudo apt install -y zsh-syntax-highlighting zsh-autosuggestions
sudo mkdir /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

# Cambiando de SHELL a zsh

sudo ln -s -fv ~/.zshrc /root/.zshrc

# Asignamos Permisos a los Scritps

chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/bspwm_resize
chmod +x ~/.config/bin/ethernet_status.sh
chmod +x ~/.config/bin/htb_status.sh
chmod +x ~/.config/bin/htb_target.sh
chmod +x ~/.config/polybar/launch.sh
sudo chmod +x /usr/local/bin/whichSystem.py
sudo chmod +x /usr/local/bin/screenshot

# Configuramos el Tema de Rofi

rofi-theme-selector

# Removiendo Repositorio

rm -rf ~/github
rm -rfv $ruta

# Instalando docker.ps & compose

sudo apt install -y docker.ps && sudo apt install docker-compose 

# Mensaje de Instalado

notify-send "BSPWM INSTALADO"
