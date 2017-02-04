# usage

```
source login.sh EMAIL PASSWORD
realms-download.sh
```

# logging in

Why run with `source`? This will set three environment variables for the other tools to pick up:
- `access_token`, e.g. `14fc1a392727462fa35e0d82e138aef1`
- `name`, e.g. `notch`
- `id`, e.g. `1b2708c3d5d1456b9b1dec95cf38ebdd`

## rate limiting

A valid login will be rejected if you have made too many authentication requests recently! If in doubt, wait 15 minutes.
As long as `validate.sh $access_token` shows your token is valid, you don't need to authenticate again.

# validating your login

You can validate your access token at any time with:
`validate.sh $access_token`

# downloading

You can download the latest backup with `realms-download.sh`. This requires the environment variables set by `login.sh`.

## limitations

Currently selects the first world only. Next step is support all 4.

# why

There are amazing tools like [yggdrasil](https://github.com/zekesonxx/node-yggdrasil) out there.
the point of REST APIs is that they're simple and don't need complex tools. I don't want to install and download the whole nodejs ecosystem.
You will need two tools: httpie and jq. Both are indispensable for dealing with JSON APIs.

# understanding backups

The backups listed in the game are the only backups. The 'download latest' button just selects the one at the top.
The content returned from ${realms_server}/worlds/${world_id}/backups is exactly this.
The backup has a timestamp. This timestamp is shown when you play the backup in Singleplayer.
If you download latest from the game, and download latest from the API, the archive you receive is not exactly the same.
For some reason the archive downloaded through the game will have backup contents touched to set all timestamps to now. However when played in Singleplayer the true timestamp is shown.

It's not clear how you can access an earlier backup through the API.
