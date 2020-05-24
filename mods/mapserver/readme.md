
# mapserver mod

![](https://github.com/minetest-mapserver/mapserver_mod/workflows/luacheck/badge.svg)
![](https://github.com/minetest-mapserver/mapserver_mod/workflows/integration-test/badge.svg)

This is the complementary mod for the mapserver: https://github.com/minetest-tools/mapserver

## Documentation

See: https://github.com/minetest-tools/mapserver/blob/master/doc/mod.md

## example for active mode configuration

minetest.conf
```
secure.http_mods = mapserver
mapserver.url = http://127.0.0.1:8080
mapserver.key = myserverkey
```

# Contributors

Thanks to:
* @Panquesito7 (mod.conf/depends.txt cleanup)
* @SwissalpS (minor corrections)
* @Athemis (mineclone support)

# License

* Source code: MIT
* Textures: CC BY-SA 3.0 (unless otherwise noted)
* Sounds
  * whoosh.ogg: https://github.com/ChaosWormz/teleport-request
