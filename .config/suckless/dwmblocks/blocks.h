//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
//{"  ", "/home/thesynthax/dotfiles/.config/suckless/dwmblocks/scripts/audio",                          1,      0},

    {"", "/home/thesynthax/dotfiles/.config/suckless/dwmblocks/scripts/volume",                           1,     3},
	
    {" ", "/home/thesynthax/dotfiles/.config/suckless/dwmblocks/scripts/battery",                          5,      0},

    {"  ", "/home/thesynthax/dotfiles/.config/suckless/dwmblocks/scripts/clock",                          30,      0},

    {"  ", "/home/thesynthax/dotfiles/.config/suckless/dwmblocks/scripts/pacupdate",					            3600,		9},
    
    {" ", "/home/thesynthax/dotfiles/.config/suckless/dwmblocks/scripts/web",                             30,      0},

};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = ' ';
