# build-archlinuxarm-pkg

Cross-compile and package an Arch Linux ARM kernel inside of a Docker containter.

This may work for other packages varying on dependencies if you change the contents of the ```package/``` directory.

## Usage

To build package run the following:
```
./scripts/run-docker-build
```

If you get the following error:

```
==> ERROR: The package group has already been built. (use -f to overwrite)
```

You should clear out the package products by running:
```
rm -rf package/*.tar.zst package/pkg
```

## Credits

Copied and tweaked files for PKGBUILD from: <br>
https://github.com/archlinuxarm/PKGBUILDs/blob/master/core/linux-aarch64-rc/PKGBUILD

Copied and tweaked files for Docker from: <br>
https://github.com/flaccid/docker-arch-pkgbuild

And some inspiration from: <br>
https://github.com/aarch64-laptops/build/blob/master/scripts/make-image.sh