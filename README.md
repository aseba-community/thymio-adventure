# Thymio Programming Adventure

An interactive tutoring to learning programming using the [Thymio robot](http://thymio.org) and Augmented Reality.

## Authors and liencense

Please see the files [AUTHORS.md](AUTHORS.md) and [LICENSE.md](LICENSE.md).

## Understanding the source tree

This repository makes heavy use of [git submodule](https://git-scm.com/docs/git-submodule) to include its dependencies:
```
. – this tutorial
├── assets – visual assets for this game
└── thymio-ar – augmented reality support for Thymio on mobile
	├── thymio-tracker – tracking library using OpenCV
	└── thymio-vpl2 – Visual Programming Language for Thymio on mobile
		├── aseba – the Aseba framework
		└── dashel – the Dashel communication framework
```

When you clone this repository with a modern git, the submodules will be fetched.
If you want to update them, we provide the script `submodule-update.sh`.

## Linux and Android Compilation

This guide assumes a basic knowledge of Linux development tools.

### Pre-requisites

This documentation assumes you are using Ubuntu 16.04.
If you use another version, some packages might have different names or the compilation might not work at all (especially on older systems).

First, install a development environment.
In a terminal, type:
```sh
sudo apt-get install build-essential cmake-gui mesa-common-dev libglu1-mesa-dev git gitk libeigen3-dev
```

Then, install Qt 5 and Qt creator.
Go on the [QT5 open source download page](https://www.qt.io/download-open-source/), and download the installer.
Run it in a terminal:
```sh
chmod +x qt-unified-linux-x64-online.run
./qt-unified-linux-x64-online.run
```

Then, install and compile OpenCV.
Go on the [OpenCV download page](http://opencv.org/downloads.html), and download the Linux archive for version 3.X.
Unzip and compile it; in a terminal:
```sh
cmake . && make
```

You now have a development environment ready to compile Thymio Programming Adventure on Ubuntu.

### Download

Download it with git and update submodules:
```sh
git clone https://github.com/aseba-community/thymio-adventure.git
cd thymio-adventure
./submodule-update.sh
```

### Compile

Launch Qt Creator and open `thymio-adventure.pro`.

Go to the _Projects_ tab, go to _Desktop [...]_, select _Build_.
In _Build Steps_, click _Details_ on the _qmake_ pane.

In the additional arguments field, add:
```
"OPENCV_SRC=YOUR_OPENCV_SRC" "OPENCV_BIN=YOUR_OPENCV_BIN" "EIGEN_INCLUDE=/usr/include/eigen3/"
```

where `YOUR_OPENCV_SRC` is where you have unzipped OpenCV, and `YOUR_OPENCV_BIN` is where you have built it.
By default, `YOUR_OPENCV_BIN` is `YOUR_OPENCV_SRC/build`.

You can now run the app on your computer by clicking on the green run button at the bottom-left of the Qt Creator window.

### Android

First install the Ubuntu environment as described above.
Then, install the Android environment as [explained in the Qt5 documentation](http://doc.qt.io/qt-5/androidgs.html).

Then, go to the [OpenCV download page](http://opencv.org/downloads.html), and download the Android archive for version 3.X.

Launch Qt Creator and open `thymio-adventure.pro`.

Go to the _Projects_ tab, go to _Android [...]_, select _Build_.
In _Build Steps_, click _Details_ on the _qmake_ pane.

In the additional arguments field, add:
```
"OPENCV_SDK=YOUR_OPENCV_SDK" "EIGEN_INCLUDE=/usr/include/eigen3/" 
```

where `YOUR_OPENCV_SDK` is the directory where you unziped the OpenCV archive.

You can now deploy the app on your Android device by selecting the Android target in the bottom-left of the Qt Creator window, and then clicking the green run button.
