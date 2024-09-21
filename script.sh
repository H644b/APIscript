pgrep chrome | while read pid; do
    args=$(cat /proc/$pid/cmdline | sed -e "s/\x00/ /g")
    name=$(echo $args | cut -c1-25)
    if echo $name | grep -E "\/opt\/google\/chrome\/chrome|google-chrome"; then
        parsed=$(echo $args | sed "s/--login-(user|profile|manager)[^ ]+/ /")
        pkill -9 chrome
        $parsed --login-manager --oobe-skip-to-login # You can use --oobe-skip-to-login 
        # but disabling rootfs verification and doing this is more reliable as powerwashing doesn't delete it.
        break
    fi
done
