function zbm_cmdline() {
	if [ "$#" = 0 ]; then
		zfs get org.zfsbootmenu:commandline
		return
	fi

	local dataset="$1"
	local cmdline="$2"

	zfs set org.zfsbootmenu:commandline="$cmdline" "$dataset"
}
