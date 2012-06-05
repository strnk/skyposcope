= skyposcope

Real-time oscilloscope application for embedded Linux


== Install

=== Bleeding-edge version from the GIT repository

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


=== Latest "stable" version

Pick the latest stable bootstrapping executable from 
[the download page](https://github.com/strnk/skyposcope/downloads "download page"),
follow step 4 from the previous section (bootstrap from GIT repository), and voilà !
