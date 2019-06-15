# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Ne-San Kernel by Eko and Zul
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=X00T
device.name2=X00TD
device.name3=Asus Max Pro M1
device.name4=ASUS_X00T
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;


# Make a backup of vendor msm_irqbalance.conf
restore_file /vendor/etc/msm_irqbalance.conf;
backup_file /vendor/etc/msm_irqbalance.conf;

# Replace original irq balancer with custom
cp -rf /tmp/anykernel/patch/msm_irqbalance.conf /vendor/etc/msm_irqbalance.conf;
set_perm 0 0 0644 /vendor/etc/msm_irqbalance.conf;

# Make a backup of vendor build.prop
restore_file /vendor/build.prop;
backup_file /vendor/build.prop;

# Add performance tweaks
append_file /vendor/build.prop "WeebKernelProps" build.prop

## AnyKernel install
dump_boot;

# begin ramdisk changes

# end ramdisk changes

write_boot;
## end install
