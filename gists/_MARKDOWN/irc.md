# Register yourself

Choose a nick
```
/nick <newnick>
```

Register the nick
```
/msg NickServ REGISTER <password> <youremail@example.com>
```

Force login for your nick (to prevent potential abuse by others)
```
/msg NickServ SET ENFORCE ON
```

Login with your nick (or restart your IRC client)
```
/msg NickServ IDENTIFY <nick> <password>
```

# Register a channel

Create/join a channel
```
/join #channelname
```

Register the channel
```
/msg ChanServ REGISTER #channelname
```

Register as founder of the channel
```
/msg ChanServ SET #channelname FOUNDER <yournick>
```

Set ChanServ to guard the channel (so it never becomes empty and loses its settings)
```
/msg ChanServ SET #channelname GUARD ON
```

Lock down the channel
```
/msg Chanserv SET #channelname MLOCK +prsi
```

- `p` (paranoid): don't show channel membership and don't allow people to request invites
- `r` (block unidentified): only registered users can join
- `s` (secret): don't show the channel in the channel lists
- `i` (invite-only): only invited users can join

Set a channel topic
```
/topic #channelname This is the new topic
```
 
# Invite users

Invite users (who have registered nicks)
```
/mode #channelname +I $a:<nickofperson>
```

Give someone "ops" (admin privileges)
```
/msg ChanServ flags #channelname <nickofperson> +voAti
```

- `v` (voice): Enables use of the voice/devoice commands, allowing the user to send messages in a moderated channel.
- `o` (op): Enables use of the op/deop commands.
- `A` (access list): Enables viewing of channel access lists.
- `t` (topic): Enables use of the topic and topicappend commands.
- `i` (invite): Enables use of the invite and getkey commands.