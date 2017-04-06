Simple and scriptable tools for Minecraft server admins. [Read my blog post for the full story](http://www.aaronbell.com/how-to-create-overviewer-maps-from-minecraft-realms/).

# Download your world from Realms

```
$ source login.sh EMAIL PASSWORD
$ realms-download.sh
```

This downloads the latest backup of your currently active world to `world.tar.gz`.
No local install of Minecraft is needed. You're now free to run [Overviewer](https://overviewer.org/) or whatever you want.

## You'll need

You need `httpie` and `jq`, so `sudo apt-get install httpie jq` if needed.

## Validate your current access token

When you login, your access token is displayed and stored in the environment variable `access_token`. The token means you don't have to keep logging in (and risk rate-limiting), but eventually it expires.
You can validate your access token at any time with
```
$ validate.sh $access_token
```

# Understanding logins

We run the login script with `source` to set three environment variables for the other tools to pick up:
- `access_token`, e.g. `14fc1a392727462fa35e0d82e138aef1`
- `name`, e.g. `notch`
- `id`, e.g. `069a79f444e94726a5befca90e38aaf5`

If you're interested in player UUIDs check out https://mcuuid.net.

## Rate limiting

If you made too many authentication requests recently, a valid login will be **rejected** as invalid - the error looks like an incorrect password. If in doubt, wait 15 minutes.

Notice, as long as `validate.sh $access_token` shows your token is valid, you don't need to authenticate again.

# Download an older backup

Pass the backup number 1-4, e.g. `realms-download.sh 2` downloads the second backup in the list. Default is 1.

# Limitations

- Only the currently active world is available.
- Only the four most recent backups are available for download.

# Why did I make this?

As an admin I want small, simple tools that are easy to understand and adapt for my purposes.

There are amazing tools out there like [yggdrasil](https://github.com/zekesonxx/node-yggdrasil), but they carry a ton of baggage (i.e. 67 npm packages).

The point of REST APIs is to be simple and accessible without advanced tools. For these scripts you just need [httpie](https://httpie.org/) and [jq](https://stedolan.github.io/jq/), which deserve a place in your toolbox.

# Understanding Realms

The backups listed in the game client are the only backups that exist. The 'download latest' button just selects the one at the top - #1, as indexed by the API - downloads it and extracts into your `$HOME/.minecraft/saves` with the correct world name.

You can see the same backup list in raw JSON with `GET ${realms_server}/worlds/${world_id}/backups`.

## Service availability

I've seen the Realms API throw 503s - with the response `Retry again later` - on retrieving the download link for a world. Keep retrying until it works.

## Timestamps

Each backup has a timestamp. When you download a world, check the timestamp on `level.dat` - this should match what's shown in the game client.

If you 'download latest' from the game,, what ends up in your `saves` directory is not identical to what you get direct from the API. I believe the game client processes the world files somehow, since many of their timestamps are set to now.
