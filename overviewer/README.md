# 1. Install Overviewer

`install-overviewer.sh`

# 2. Download textures (optional)

If you haven't run Minecraft on this machine, you need to grab the client jar from Mojang:

`get-minecraft-client-jar.sh`

# 3. Run Overviewer

Edit `render-config.py` with the location of your world, then:

`overviewer.py --config=render.py`

# 4. Done! Admire your map

Open up `index.html` in the output location (if you didn't edit, it's `/tmp/myworld-map`).

# 5. Add a Google Maps API key (optional)

If you're hosting this map on webserver, get an API key from Google then run:

`insert-google-key.sh <map dir> <api key>`

