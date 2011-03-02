# Overview #

More detail to come later, but the gist of it is that instead of just sending
the copy data to the remote end, an authentication string is sent.

If the authentication is OK, then copy data is sent and piped to pbcopy.  If it
isn't, the secret key is copied onto the clipboard so that it will be easy to
paste it into whatever terminal window needs to send data.
