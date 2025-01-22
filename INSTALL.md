Install TeXLive and local build the book
====

### Install TeXLive

In Linux/Unix like environment, do **NOT** install the TeXLive through package manager (e.g. apt-get or apk). Go to TeXLive [official site](https://tug.org/texlive/) to download the setup script. In Windows, TeXLive provides a [gui based installer](https://tug.org/texlive/windows.html), in Mac OS X, there's a [MacTeX](https://www.tug.org/mactex/).

### Others

You need the GNU make tool, in Debian/Ubuntu like Linux, it can be installed through:

```bash
$ sudo apt-get install build-essential
```

In Windows, you can use WSL or MSYS. In Mac OS X, please install the developer tool from this command line:

```bash
$ xcode-select --install
```

### Font setting

The default build supports Linux, Mac OS X, and Windows. You can install additional font (like [Noto CJK](https://github.com/notofonts/noto-cjk/)) typesetting (see `prelude.sty`). Some system fonts, e.g. STKaiti, were moved to `/System/Library/AssetsV2/com_apple_MobileAsset_Font7` in Mac OS X from 2022, you need add the path to the local TeXLive configuration:

```bash
sudo tlmgr conf texmf OSFONTDIR /System/Library/AssetsV2/com_apple_MobileAsset_Font7
```

### Build the book PDF

enter the folder contains the book TeX manuscript, run

```bash
$ make
```

This will generate algoxy-en.pdf and algoxy-zh-cn.pdf. If you only need the Chinese version for example, you can run `make cn` instead. Run `make force-cn` or `make force-en` to force build the book.
