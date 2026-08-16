# Making your own card set

The mod can load extra cards at runtime: your own units, upgrades and command
cards, including factions the game never had. Open the mod's welcome dialog,
go to **Experimental Side Load**, paste the URL of your card file and press
**Load**. Then press **Create Army** on your LIST BUILDER panel - the new
factions and units are in the lists.

Two things to know before you start:

- **It is additive.** Your cards are added on top of the official ones and
  never replace them. A unit whose name and title match an official one does
  overwrite it, so pick distinct names.
- **It is not saved.** The cards live in memory for the session. Everyone who
  wants them has to load the file, and again after every reload of the mod.

## Host your images and models somewhere that will outlive you

This is the part that decides whether your set still works in two years, so it
comes first.

Every card face, every mesh and every texture is a URL that Tabletop Simulator
downloads on demand. The mod stores links, never files. If a link dies, the
card spawns blank and the model does not spawn at all - and there is nothing
the mod can do about it, because it only finds out at spawn time.

**Do not host on your personal Steam cloud.** The card set that used to ship
with this mod, `homebrew.json`, did exactly that: 92 of its 93 units and 207 of
its 210 upgrades are now unreachable, cards and models alike, because the
uploads went away with their authors' accounts. Prefer somewhere you control
and can keep: a GitHub repository served over `raw.githubusercontent.com`, an
S3 bucket, your own web host.

Tabletop Simulator accepts `.jpg`, `.png`, `.webp`, `.webm`, `.mp4`, `.m4v`,
`.mov`, `.rawt` and `.unity3d`. It reports anything else - including the HTML
error page a dead link returns - as
`Load image failed unsupported format: UNKNOWN`. That message in the chat
almost always means a broken URL rather than a broken file.

There is no prescribed folder layout. A flat directory of images next to your
JSON file works; so does one directory per faction. What matters is that every
URL in the JSON resolves, from anywhere, without a login.

## The file

One self-contained JSON file, validated by
[`mod/schema/CardSet.json`](../../mod/schema/CardSet.json). Four top-level keys
are required, even when empty, plus an optional `objects`:

```json
{
  "units": {},
  "upgrades": {},
  "commands": {},
  "battlefield": {},
  "objects": {}
}
```

Note that `contrib/cards/official.json` writes its `units` as paths to other
files (`"Rebel": "Rebel/RebelUnits.json"`). That indirection is resolved by the
build, **not** by the side loader. A file you intend to side load has to carry
its units inline.

### Units

Keyed by faction, then by rank. The faction name is free text: use `Empire` to
add to an existing one, or anything else to create a new one, which then shows
up as its own button under Create Army. Ranks are `Commander`, `Operative`,
`Corps`, `Special Forces`, `Support` and `Heavy`.

```json
"units": {
  "Scum": {
    "Commander": [
      {
        "name": "Jabba The Hutt",
        "title": "Vile Gangster",
        "image": "https://example.com/cards/jabba.png",
        "size": "large",
        "type": "Trooper",
        "points": 180,
        "speed": 1,
        "upgrades": { "Command": 2, "Counterpart": 1, "Illicit": 1 },
        "minis": [
          {
            "mesh": "https://example.com/models/jabba.obj",
            "diffuse": "https://example.com/models/jabba.png"
          }
        ],
        "commands": [
          {
            "name": "Appetite for Violence",
            "image": "https://example.com/cards/appetite.png",
            "pip": 1
          }
        ]
      }
    ]
  }
}
```

`size` picks the base and its collider: `small`, `medium`, `large`, `huge`,
`laat`, `epic`, `long` or `snail`. `upgrades` is the slot bar, by name and
count. `commands` are the unit's own command cards; generic ones go in the
top-level `commands` instead, keyed by faction.

Optional and worth knowing: `displayName` overrides the label in the builder,
`height` sets the model height in inches for the silhouette, `tokens` spawns
command tokens with the unit, and `required` lists upgrades or flaws the unit
must take.

A mini is described either by `mesh` + `diffuse` (plus an optional `collider`),
or by `bundle` for a Unity AssetBundle - see
[`mod/schema/deps/Mini.json`](../../mod/schema/deps/Mini.json).

### Upgrades and command cards

Upgrades are keyed by slot type. `name`, `image` and `points` are required:

```json
"upgrades": {
  "Illicit": [
    { "name": "Underworld Contacts", "image": "https://example.com/cards/contacts.png", "points": 5 }
  ]
}
```

Generic command cards are keyed by faction, and need `name`, `image` and `pip`:

```json
"commands": {
  "Scum": [
    { "name": "Price On Their Head", "image": "https://example.com/cards/price.png", "pip": 2 }
  ]
}
```

## Check it before you share it

If you have the repository checked out, `npm run validate` runs every contrib
file through the schemas with `ajv`. Point `ajv` at your own file to check that
one alone:

```
npx ajv -d ./my-cards.json -s ./mod/schema/CardSet.json -r "./mod/schema/deps/**.json" --strict
```

The schema catches a missing required key or a misspelled slot type. It cannot
tell you whether your URLs resolve - open a few in a browser, and load the file
in the mod before announcing it.
