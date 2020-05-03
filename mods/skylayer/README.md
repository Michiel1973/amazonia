# Skylayer
Minetest utility mod to help manage sky transitions. 
Mod includes the smooth transition between users given base sky colors (for plain sky type).
Tracks multiple sky definitions and display the latest one. Each player has own list of sky layers.

## Data Structures
Skylayer mod related data structures explained.

`ColorSpec` - a table of color value (0..255) in format `{r, g, b}`, e.g.:

```
{r=68, g=34, b=153}
```

`GradientSpec` - an array of `ColorSpec` that defines gradient points, e.g.:

```
 {{r=68, g=34, b=153}, {r=68, g=68, b=221}}
```

`GradientSky` - a table with parameter names matching original minetest lua api `sky_color` table parameters.
Main difference is that values are `GradientSpec` type:

```
gradient_sky = {
    day_sky = GradientSpec,
    day_horizon = GradientSpec,
    dawn_sky = GradientSpec,
    dawn_horizon = GradientSpec,
    night_sky = GradientSpec,
    night_horizon = GradientSpec,
    indoors = GradientSpec,
    fog_sun_tint = GradientSpec,
    fog_moon_tint = GradientSpec,
}
```

`SkyData` - a table with properties used for directly for `set_sky` with additional `skylayer` mod
properties for gradient support.

```
sky_data = {
    -- same properties as set_sky api:
    base_color = ..,
    type = ..,
    textures = ..,
    clouds = ..,
    sky_color = ..,

    -- skylayer-specific properties, if set some of above properties will be overiden: 

    -- overrides base_color property with gradient support.
    gradient_colors = GradientSpec

    -- overrides sky_color properties with gradient support.
    gradient_sky = {
        day_sky = GradientSpec,
        day_horizon = GradientSpec,
        dawn_sky = GradientSpec,
        dawn_horizon = GradientSpec,
        night_sky = GradientSpec,
        night_horizon = GradientSpec,
        indoors = GradientSpec,
        fog_sun_tint = GradientSpec,
        fog_moon_tint = GradientSpec,
    }
}
```

`SunData` a table which matches minetest `set_sun` parameters, no `skylayer` specifics.

`MoonData` a table which matches minetest `set_moon` parameters, no `skylayer` specifics.

`StarsData` a table with properties used for directly for `set_stars` with additional `skylayer` mod properties for gradient support.

```
stars_data = {
    -- same set of properties as set_stars api:
    visible = ..,
    count = ..,
    star_color = ..,
    scale = ..,

    -- skylayer-specific properties, if set some of above properties will be overiden: 
    gradient_star_colors = GradientSpec
}
```

`CloundsData` a table with properties used for directly for `set_clouds` with additional `skylayer` mod properties for gradient support.

```
clouds_data = {
    -- same set of properties as set_clouds api:
    density = ..,
    color = ..,
    ambient = ..,
    height = ..,
    height = ..,
    thickness = ..,
    speed = ..,

    -- skylayer-specific properties, if set some of above properties will be overiden: 
    gradient_colors = GradientSpec
    gradient_ambient_colors = GradientSpec
}
```

## Usage samples
The Skylayer mod designed to be configured by other mods. See demo.lua for examples and pre-builds commands for quick tests.
Demo by default is disabled and can be enabled by uncommenting file include inside init.lua.

### Plain color without clouds
```
    local sl = {}
    sl.name = "plain_without_clouds_sky"
    sl.sky_data = {
        base_color = { r = 0, g = 0, b = 0 },
        clouds = false
    }
    skylayer.add_layer(player_name, sl)
```

### Gradient plain color with clouds

```
    local sl = {}
    sl.name = "gradient_plain_with_clouds_sky"
    sl.sky_data = {
        gradient_colors = {
            { r = 68, g = 34, b = 153 },
            { r = 59, g = 12, b = 189 },
            { r = 51, g = 17, b = 187 },
            { r = 68, g = 68, b = 221 },
            { r = 17, g = 170, b = 187 },
            { r = 18, g = 189, b = 185 },
            { r = 34, g = 204, b = 170 },
            { r = 105, g = 208, b = 37 },
            { r = 170, g = 204, b = 34 },
            { r = 208, g = 195, b = 16 },
            { r = 204, g = 187, b = 51 },
            { r = 254, g = 174, b = 45 },
            { r = 255, g = 153, b = 51 },
            { r = 255, g = 102, b = 68 },
            { r = 255, g = 68, b = 34 },
            { r = 255, g = 51, b = 17 },
            { r = 248, g = 12, b = 18 },
            { r = 255, g = 51, b = 17 },
            { r = 255, g = 68, b = 34 },
            { r = 255, g = 102, b = 68 },
            { r = 255, g = 153, b = 51 },
            { r = 254, g = 174, b = 45 },
            { r = 204, g = 187, b = 51 },
            { r = 208, g = 195, b = 16 },
            { r = 170, g = 204, b = 34 },
            { r = 105, g = 208, b = 37 },
            { r = 34, g = 204, b = 170 },
            { r = 18, g = 189, b = 185 },
            { r = 17, g = 170, b = 187 },
            { r = 68, g = 68, b = 221 },
            { r = 51, g = 17, b = 187 },
            { r = 59, g = 12, b = 189 }
        }
    }
    sl.clouds_data = {
        gradient_colors = {
            { r = 34, g = 204, b = 170 },
            { r = 105, g = 208, b = 37 },
            { r = 170, g = 204, b = 34 },
            { r = 208, g = 195, b = 16 },
            { r = 204, g = 187, b = 51 },
            { r = 254, g = 174, b = 45 },
            { r = 255, g = 68, b = 34 },
            { r = 255, g = 102, b = 68 },
            { r = 255, g = 153, b = 51 },
            { r = 254, g = 174, b = 45 },
            { r = 59, g = 12, b = 189 }
        },
        speed = { x = 110, z = -400 }
    }
    sl.sun_data = {
        visible = false
    }
    sl.moon_data = {
        visible = false
    }
    skylayer.add_layer(player_name, sl)

```

### Gradient plain sky colors
```
    local sl = {}
    sl.name = "gradient_plain_sky_colors_with_defaults_sky"
    sl.sky_data = {
        gradient_sky = {
            day_sky = {
                { r = 100, g = 0, b = 6},
                { r = 6, g = 100, b = 0},
                { r = 0, g = 6, b = 100}
            },
            day_horizon = {
                { r = 100, g = 56, b = 0},
                { r = 42, g = 100, b = 0},
                { r = 92, g = 100, b = 0}
            },
            night_sky = {
                { r = 0, g = 255, b = 87},
                { r = 250, g = 187, b = 100},
                { r = 255, g = 82, b = 0}
            },
            night_horizon = {
                { r = 87, g = 100, b = 0},
                { r = 0, g = 87, b = 100},
                { r = 100, g = 0, b = 87}
            },
        }
    }
    skylayer.add_layer(player_name, sl)

```

## Media
Textures used for demo is all created by me with public domain (CC0):
- skylayer_demo_cold_moon.png
- skylayer_demo_hot_sun.png
- skylayer_demo_stars_sky.png
