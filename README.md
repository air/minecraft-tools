# Usage

## Download your world from Realms

```
source login.sh EMAIL PASSWORD
realms-download.sh
```

This downloads the latest backup of your world to `world.tar.gz`. No local install of Minecraft is needed. You're now free to run [Overviewer](https://overviewer.org/) or whatever you want.

## Validate your current access token

You can validate your access token at any time with
```
validate.sh $access_token
```

# Logging in

Why run with `source`? This will set three environment variables for the other tools to pick up:
- `access_token`, e.g. `14fc1a392727462fa35e0d82e138aef1`
- `name`, e.g. `notch`
- `id`, e.g. `1b2708c3d5d1456b9b1dec95cf38ebdd`

## Rate limiting

A valid login will be **rejected** if you made too many authentication requests recently. If in doubt, wait 15 minutes.

Notice, as long as `validate.sh $access_token` shows your token is valid, you don't need to authenticate again.

# Limitations

Currently selects the first world only. Next step is support all 4.

# Why?

As an admin I want small, simple tools that are easy to understand and adapt for my purposes.

There are amazing tools out there like [yggdrasil](https://github.com/zekesonxx/node-yggdrasil), but they carry a ton of baggage (i.e. 67 npm packages).

The point of REST APIs is to be simple and accessible without advanced tools. For these scripts you'll need just
You will need two tools: [httpie](https://httpie.org/) and [jq](https://stedolan.github.io/jq/). Both are indispensable for dealing with JSON.

# Understanding Realms

The backups listed in the game client are the only backups that exist. The 'download latest' button just selects the one at the top.
You can see this list in raw JSON with a `GET ${realms_server}/worlds/${world_id}/backups`.

Each backup has a timestamp. This timestamp is shown when you play the backup in Singleplayer.

If you 'download latest' from the game, and download latest from the API (e.g. using `realms-download.sh`), the archive you receive is not exactly the same.

For some reason the archive downloaded through the game client will have backup contents *touched* to set all timestamps to now. However when played in Singleplayer, the true timestamp is shown.

It's not clear how you can access an earlier backup (not the latest) through the API.
