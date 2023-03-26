# Dustman - A safer `rm`

A simple tool to make `rm` a little more safe.

It puts files in the user's trash instead of deleting them immediately.
It is not a one-to-one drop in for `rm` and for now, only supports Darwin.

## Build

1. Install Swift
2. Clone this Repository
3. Run `swift build -c release`
4. Copy the binary from `.build/release/Dustman` to a directory in your `$PATH`
   1. This could be `/usr/local/bin` or `~/.local/bin`

## Notes

Build with ❤️ by [Jan Fooken](https://git.bode.fun)
