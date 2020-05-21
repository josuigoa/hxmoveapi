# hxmoveapi

Haxe binding for [psmoveapi](https://github.com/thp/psmoveapi). Powered by [ammer](https://github.com/Aurel300/ammer).

## WIP

This repository is not finished. It's only really tested on OSX. Compiles and starts on Linux (tested with docker, without connecting any PsMove). I could not get windows running.

The `container_volume/src/Demo.hx` application could not be tested at all, it only compiles.

## Prerequisites

Download the [binaries of psmoveapi](https://github.com/thp/psmoveapi/releases) and unzip them:

* The headers to `container_volume/native/include` directory
* The binaries files to `container_volume/native/lib/{desired_os}` directory. Where `desired_os` is the OS I'm creating the bindings for: `linux`, `win` or `osx`

# Build

I've used `lix` for versioning the project. So run `lix download` to get the dependencies. If you have no `lix` installed, you should install ammer using `haxelib git ammer https://github.com/Aurel300/ammer`.

Run the `tests/test-{desired_os}.[sh|bat]` script to build the library and run the test project. This sample project is in `container_volume/src/Main.hx`

## Why docker?

I've used docker containers to build the library in a reproducible way. If you execute the containers, they will download the required files and libraries.