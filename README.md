# Mandelbrot with Raylib and Gambit Scheme

This is a simple Mandelbort implementation with [raylib][1] and [Gambit Scheme][2]. **Highly inefficient and slow, I made this some time ago as an experiment**. I'm cleaning out my home directory, so this is going on Github for posterity :)

It comes with a simply CMake-based language configuration for Gambit Scheme.

These are the tools you need to use the code in this repository:

* [CMake][3]
* [make][4] (or any build system you prefer, like Ninja, etc.)
* [Gambit Scheme][2]
* Optional: [Raylib][1] (if you want to use a system-wide installation instead of the submodule provided here)

## Warning About Gambit Scheme Naming

Because I'm using Arch Linux, there's a bit of a naming conflict when installing Gambit Scheme. So the Gambit compiler `gsc` is called `gambitc` on my system. To avoid this problem, there are two options:

1. If you already have Gambit Scheme compiler installed as `gsc` on your system, change all occurences of `gambitc` into `gsc` in all files in the `cmake` subdirectory.
2. If you build Gambit Scheme from source, use the `--enable-interpreter-name` and `--enable-compiler-name` options during the configuration step to rename `gsc` into `gambitc`.

It's a bit annoying, but this will be fixed when I improve the CMake language definition (see #-)

## Usage

This repository comes with raylib already integrated as a git submodule. This reflects my personal preferences, if you prefer to use CMake's `FetchPackage`, it should be easy enough to modify the main `CMakeLists.txt` to do that (I haven't tested it, though).

So start writing code, clone this repository and make sure all submodules are downloaded too:

```bash
git clone --recursive https://github.com/georgjz/mandelbrot-gambit-scheme-raylib.git mandelbrot
```

To build the example code found in `src/main.scm`, just execute:

```bash
cd mandelbrot 
cmake -S . -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -B build
cmake --build build
./build/mandelbrot
```

If you wish to change the name of the output binary, just edit line 14 of `CMakeLists.txt`.

## License

Everything in this repository is released under the [MIT License][5] (see `LICENSE`). For the raylib license, [go here][6].

[1]: https://www.raylib.com/index.html
[2]: https://github.com/gambit/gambit
[3]: https://cmake.org
[4]: https://www.gnu.org/software/make/manual/html_node/index.html
[5]: https://opensource.org/licenses/MIT
[6]: https://github.com/raysan5/raylib/blob/master/LICENSE
