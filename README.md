skyposcope
==========

Real-time oscilloscope application for embedded Linux


Install
-------
Clone this repository

``` sh
    git clone git://github.com/strnk/skyposcope.git skyposcope
```

Enter a development shell which initialize the environment variables
and `cd` to the right directory

    ./skyposcope/scripts/mini2440_sh

Generate the bootstrap script from source

    ./bootstrap/mkbootstrap bootstrap.sh

Create your development directory and bootstrap the whole thing

   mkdir ~/mini2440
   ./bootstrap.sh --root="~/mini2440"

