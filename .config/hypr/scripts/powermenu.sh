#!/bin/sh

case "$(echo -e "Shutdown\nReboot\nHibernate\nLogout\nSuspend\nLock\nKill-Wayland" | rofi -dmenu -p "POWER MENU:")" in
	Shutdown)
		case "$(echo -e "Yes\nNo" | rofi -dmenu -p "Are you sure?")" in
			Yes) shutdown now ;;
	  		No) exit ;;
	  	esac
	  	;;
	Reboot)
		case "$(echo -e "Yes\nNo" | rofi -dmenu -p "Are you sure?")" in
			Yes) reboot ;;
			No) exit ;;
		esac
		;;
	Hibernate)
		case "$(echo -e "Yes\nNo" | rofi -dmenu -p "Are you sure?")" in
			Yes) systemctl hibernate ;;
			No) exit ;;
		esac
		;;
	Logout)
		case "$(echo -e "Yes\nNo" | rofi -dmenu -p "Are you sure?")" in
			Yes) kill -9 -1 ;;
			No) exit ;;
		esac
		;;
	Suspend)
		hyprlock -q --no-fade-in & systemctl suspend
		;;
	Lock) 
		hyprlock -q --no-fade-in
		;;
	Kill-Wayland) 
		killall Hyprland
		;;
esac
