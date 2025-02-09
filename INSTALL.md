# Instructions

These instructions explain how to set up the tools required to build **pokefirered**, which assembles the source files into a ROM.

These instructions come with notes which can be expanded by clicking the "<i>Note...</i>" text.
In general, you should not need to open these unless if you get an error or if you need additional clarification.

If you run into trouble, ask for help on Discord or IRC (see [README.md](README.md)).

## macOS
1. If the Xcode Command Line Tools are not installed, download the tools [here](https://developer.apple.com/xcode/resources/), open your Terminal, and run the following command:

    ```bash
    xcode-select --install
    ```

2.  - If libpng is **not installed**, then go to [Installing libpng (macOS)](#installing-libpng-macos).
- If devkitARM is **not installed**, then go to [Installing devkitARM (macOS)](#installing-devkitarm-macos).
- Otherwise, **open the Terminal** and go to [Choosing where to store pokefirered (macOS)](#choosing-where-to-store-pokefirered-macos)

### Installing libpng (macOS)
<details>
    <summary><i>Note for advanced users...</i></summary>

>   This guide installs libpng via Homebrew as it is the easiest method, however advanced users can install libpng through other means if they so desire.
</details>
<details>
    <summary><i><strong>Note for Apple Silicon (M1) Mac users...</strong></i></summary>

>   Currently, Homebrew and libng must be installed via Rosetta on Apple Silicon Macs. Before continuing, create a [Terminal shell profile with Rosetta](https://www.astroworldcreations.com/blog/apple-silicon-and-legacy-command-line-software). Be sure to run the commands corresponding to Apple Silicon (M1).
</details>

1. Open the Terminal.
2. If Homebrew is not installed, then install [Homebrew](https://brew.sh/) by following the instructions on the website.

#### Apple Silicon Install homebrew for rosetta profile:
```bash
arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

3. Run the following command to install libpng.

    ```bash
/usr/local/bin/brew install libpng
    ```
   libpng is now installed.

   Continue to [Installing devkitARM (macOS)](#installing-devkitarm-macos) if **devkitARM is not installed**, otherwise, go to [Choosing where to store pokefirered (macOS)](#choosing-where-to-store-pokefirered-macos).

### Installing devkitARM (macOS)
1. Download the `devkitpro-pacman-installer.pkg` package from [here](https://github.com/devkitPro/pacman/releases).
2. Open the package to install devkitPro pacman.
3. In the Terminal, run the following commands to install devkitARM:

    ```bash
    sudo dkp-pacman -Sy
    sudo dkp-pacman -S gba-dev
    sudo dkp-pacman -S devkitarm-rules
    ```

   The command with gba-dev will ask for the selection of packages to install. Just press Enter to install all of them, followed by entering Y to proceed with the installation.

4. After the tools are installed, devkitARM must now be made accessible from anywhere by the system. To do so, run the following commands:

    ```bash
    export DEVKITPRO=/opt/devkitpro
    echo "export DEVKITPRO=$DEVKITPRO" >> ~/.zshrc
    export DEVKITARM=$DEVKITPRO/devkitARM
    echo "export DEVKITARM=$DEVKITARM" >> ~/.zshrc
    echo "if [ -f ~/.zshrc ]; then . ~/.zshrc; fi" >> ~/.zprofile
    ```

### Choosing where to store pokefirered (macOS)
At this point, you can choose a folder to store pokefirered into. If you're okay with storing pokefirered in the user folder, then proceed to [Installation](#installation). Otherwise, you'll need to account for where pokefirered is stored when changing directory to the pokefirered folder.

For example, if you want to store pokefirered (and agbcc) in **~/Desktop/decomps**, enter this command to **change directory** to the desired folder:
```bash
cd Desktop/decomps
```
Note that the directory **must exist** in the folder system. If you want to store pokefirered in a dedicated folder that doesn't exist (e.g. the example provided above), then create the folder (e.g. using Finder) before executing the `cd` command.

<details>
    <summary><i>Note..</i>.</summary>

>   Note: If the path has spaces, then the path must be wrapped with quotations, e.g. `cd "Desktop/decomp folder"`
</details>

If this works, then proceed to [Installation](#installation). Otherwise, ask for help on Discord or IRC (see [README.md](README.md)).

## Installation

<details>
    <summary><i>Note for Windows users...</i></summary>

>   Consider adding an exception for the `pokefirered` and/or `decomps` folder in Windows Security using
>   [these instructions](https://support.microsoft.com/help/4028485). This prevents Microsoft Defender from
>   scanning them which might improve performance while building.
</details>

1. If pokefirered is not already downloaded (some users may prefer to download pokefirered via a git client like GitHub Desktop), run:

    ```bash
    git clone https://github.com/pret/pokefirered
    ```

2. Install agbcc into pokefirered. The commands to run depend on certain conditions. **You should only follow one of the listed instructions**:
- If agbcc has **not been built before** in the folder where you chose to store pokefirered, run the following commands to build and install it into pokefirered:

    ```bash
    git clone https://github.com/pret/agbcc
    cd agbcc
    ./build.sh
    ./install.sh ../pokefirered
    ```

- **Otherwise**, if agbcc has been built before (e.g. if the git clone above fails), but was **last built on a different terminal** than the one currently used (only relevant to Windows, e.g. switching from msys2 to WSL1), then run the following commands to build and install it into pokefirered:

    ```bash
    cd agbcc
    git clean -fX
    ./build.sh
    ./install.sh ../pokefirered
    ```

- **Otherwise**, if agbcc has been built before on the same terminal, run the following commands to install agbcc into pokefirered:

    ```bash
    cd agbcc
    ./install.sh ../pokefirered
    ```

    <details>
        <summary><i>Note...</i></summary>

        > If building agbcc or pokefirered results in an error, try deleting the agbcc folder and re-installing agbcc as if it has not been built before.
    </details>

3. Once agbcc is installed, change directory back to the base directory where pokefirered and agbcc are stored:

    ```bash
    cd ..
    ```

Now you're ready to [build **pokefirered**](#build-pokefirered)
## Build pokefirered
If you aren't in the pokefirered directory already, then **change directory** to the pokefirered folder:
```bash
cd pokefirered
```
To build **pokefirered.gba** (Note: to speed up builds, see [Parallel builds](#parallel-builds)):
```bash
make
```
If it has built successfully you will have the output file **pokefirered.gba** in your project folder.

## Build pokeleafgreen and REV1
Pokemon FireRed and LeafGreen were both released together. As such, this project is capable of building both ROMs. To do so, simply run
```bash
make leafgreen
```

This project can also build the version 1.1 ROMs of both FireRed and LeafGreen. To build each, run
```bash
make firered_rev1  # for FireRed 1.1
make leafgreen_rev1  # for LeafGreen 1.1
```

# Building guidance

## Parallel builds

See [the GNU docs](https://www.gnu.org/software/make/manual/html_node/Parallel.html) and [this Stack Exchange thread](https://unix.stackexchange.com/questions/208568) for more information.

To speed up building, first get the value of `nproc` by running the following command:
```bash
nproc
```
Builds can then be sped up by running the following command:
```bash
make -j<output of nproc>
```
Replace `<output of nproc>` with the number that the `nproc` command returned.

`nproc` is not available on macOS. The alternative is `sysctl -n hw.ncpu` ([relevant Stack Overflow thread](https://stackoverflow.com/questions/1715580)).