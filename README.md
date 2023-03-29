# Dustman - A safer `rm`

A simple tool to make `rm` a little more safe.

It puts files in the user's trash instead of deleting them immediately.
It is not a one-to-one drop in for `rm` and for now, only supports Darwin.

> **Note**
> Linux support is a WIP and if you want to help, feel free to join me.

## Build

1. Install Swift
2. Clone this Repository
3. Build the `Dustman` executable
   1. If you have [just](https://just.systems/) installed, run `just build`
   2. Otherwise, just run `swift build -c release --product Dustman`
4. Copy the executable from `.build/release/Dustman` to a directory in your `$PATH`
   1. On Darwin or Linux, this could be `/usr/local/bin` or `~/.local/bin`

## Notes

I would not recommend to alias `rm` to `Dustman` as the `Dustman` CLI is not flag-compatible to `rm`.
Therefore an alias could break some shell-scripts. Instead alias it to `trash` or just use it as `Dustman`.

## Current Limitations

Deleting files whose deletion would require root privileges is not supported,
because `Dustman` always reverts the `UID` to the user's own `UID`.
Otherwise, the deleted files would end up in the root's trash and therefore are not
recoverable by the user.

## One last thing

You're welcome to contribute to this project.

Licensed under the [MIT License](./LICENSE).

Build with ❤️ by [Jan Fooken](https://git.bode.fun)
