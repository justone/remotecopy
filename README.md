# Remote Copy

## Overview

Taking something from a remote shell and copying into your local pasteboard
would be very useful.  This blog post details one solution:

http://seancoates.com/blogs/remote-pbcopy

The big caveat at the bottom is that this particular solution is not secure.
Anyone who figure out the port and writes to it puts something in your
pasteboard.

This project aims to address that problem with a little extra logic.  See
[ARCH.md](ARCH.md) for details.

## Installation

### Step 1. Run the remotecopyserver script on your local laptop or desktop.

> NOTE: Be sure to run remotecopyserver outside of a tmux session.  Unless you've patched it to work around the [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard) issue, remotecopyserver won't work correctly.

This can either be done manually:

```
$ remotecopyserver &
```

Or you can use the built-in LaunchAgent support.  This will start the
remotecopyserver process and make sure it's started whenever you reboot:

```
$ remotecopyserver -x start
```

### Step 2. Configure SSH to forward the remotecopyserver port to your remote machine.

The default port is 12345 (see [Configuration](#configuration) on how to change
that). Remotecopy works by connecting to the (localhost) port on the remote
machine, so it is necessary to forward the local port over your SSH connection.

To forward for a single session:

```
$ ssh server.com -R 12345:localhost:12345
```

Or, to forward for all sessions to that server, put a snippet like this into your `.ssh/config` file:

```
Host server.com
    RemoteForward 12345 localhost:12345
```

### Step 3. Test out the remote copy connection

After connecting to the remote machine, run `remotecopy foo` to ensure that the
port forward and `remotecopyserver` are running correctly.  If everything is
working, you should be prompted for the secret.  Just paste and 'foo' will be
copied into your clipboard.

```
$ remotecopy foo
Input secret:
rc-aa474a07fbb93fe29450b6618110bdc2
$
```

If it doesn't work, try running `telnet localhost 12345` on your remote machine
to make sure the port is forwarded correctly.  It should look like this (see
the "HELLO 0.1" at the bottom?):

```
$ telnet localhost 12345
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
HELLO 0.1
```

## Configuration

To change the port that remotecopyserver listens on and remotecopy connects to,
just put this into `~/.remotecopyrc`:

```
port = 52413
```

Note: this file should be present on both ends so that they agree on the port.
This is easy if you manage your dotfiles with git.  I suggest using
[dfm](https://github.com/justone/dfm), and here is a [starter repository](https://github.com/justone/dotfiles).

## More information

First, there's the [introductory blog post](http://endot.org/2011/12/04/remotecopy-copy-from-remote-terminals-into-your-local-clipboard/), and then a [follow up a while later](http://endot.org/2013/06/09/remotecopy-two-years-later/).
