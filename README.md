# skyposcope

Real-time oscilloscope application for embedded Linux


## Install
***
  Please note that the full bootstrapped development environment takes approx. 4GB
of disk space. There is 230 MB of source files to download during the bootstrap
process with buildroot and the whole thing can take up to 40 min on recent hardware,
make sure you have sufficient free disk space before launching the bootstrap script !

  When the bootstrap scripts is running buildroot, it is possible to interrupt it and
to continue the installation without losing previously build packages by running

```
    ./bootstrap.sh --root=<location of the dev. dir> --install buildroot
```

directly, which skips the installation of development files and 3rd party programs.


### Bleeding-edge version from the GIT repository

In order to test the latest development version of skyposcope, you'll have to
rool your own bootstrapping executable through a "bootstrap from source" process
(as opposed to bootstrapping from a complete & working development environment).

1. Clone this repository
    
    ```
    git clone git://github.com/strnk/skyposcope.git skyposcope
    ```

2. Enter a development shell which initialize the environment variables
and `cd` to the right directory
    
    ```
    ./skyposcope/scripts/mini2440_sh
    ```

3. Generate the bootstrap script from source

    ```
    ./bootstrap/mkbootstrap bootstrap.sh
    ```

4. Create your development directory and bootstrap the whole thing
    
    ```
    mkdir ~/mini2440
    ./bootstrap.sh --root="~/mini2440"
    ```


### Latest "stable" version

Pick the latest stable bootstrapping executable from 
[the download page](https://github.com/strnk/skyposcope/downloads "download page"),
follow step 4 from the previous section (bootstrap from GIT repository), and voilà !



## Updating the development files
***

It is possible (but not thoroughly tested) to only update the development files and thus
skipping the toolchain build and saving a lot of time. For this to work you have to build
or download a bootstrap executable (see previous part) and run the following command

```
    ./bootstrap.sh --root <location of the dev. dir> --install devfiles
```


## Using the development environment
***

  The development environment configures itself for proper work. Simply run the script located
in `<skyposcope>/scripts/mini2440_sh`. This launch a new shell so the mini2440 dev. scripts won't 
mess your user's environment.


### NOR initialization
  The first thing to do (when buildroot has finished generating the root filesystem) is to initialize
the NOR memory file. It has to be executed only once and allows the boot script to find it. Skyposcope
doen't use the NOR in the emulation environment ATM, so we will fill it with zeroes 

```
   update-nor --zero
```


### Kernel and/or bootloader update
   Upon **every successful buildroot bootloader (u-boot) and/or kernel generation**, you'll also have to
regenerate the NAND memory file loaded by Qemu.

```
   update-nand
```


### System boot
  And voilà ! You can now boot the virtual mini2440

```
   boot -1
```

  The `-1` switch stands for "boot on the NAND", because as stated before we don't use the NOR yet.

### u-boot configuration
  If you just updated the NAND, you certainly have to initialize the bootloader. Type the following
commands at the u-boot prompt to initialize it properly

```
    dynenv set env
    saveenv
    setenv bootcmd nboot kernel\; bootm
    setenv bootargs root=/dev/mmcblk0 rootfstype=ext2 console=ttySAC0,115200
    saveenv
    reset
```
  
  The first command `dynenv set env` tells u-boot to use the partition _env_ to store its environment
variables. The first `saveenv` allows to initialize this partition with u-boot data. The two following
`setenv` calls defines environment variables values : `bootcmd` is the command executed by default by
u-boot after `bootdelay` seconds, this enables auto-boot. Our boot command tells in face u-boot to load
our kernel uImage (`nboot`) from the `kernel` partition into the memory, `bootm` then execute this part
of the memory. 

  The arguments passed to the kernel upon execution are stored into the `bootargs` environment variable,
we tell the kernel to look to the root file-system on the /dev/mmcblk0 device which is the SD card device.
Our SD card is not partitioned, we only have the whole rootfs partition on it so we dont specify any 
partition : if it was not the case, /dev/mmcblk0pN where N is the partition number would do the trick. The
rootfstype is optional (the kernel can guess it himself), but accelerate a bit the boot process. The last
argument is **very** important, it tells the kernel to use the main UART of the S3C2440 chip (ttySAC0) as
its console output, allowing us to view the boot process in detail and to debug it if necessary.
