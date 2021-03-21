# Tabletop Simulator Mod for Star Wars: Legion

[![CI](https://github.com/swlegion/tts/actions/workflows/nodejs.yml/badge.svg)](https://github.com/swlegion/tts/actions/workflows/nodejs.yml)

This project is a community-contributed open source mod for
[Tabletop Simulator][1], emulating some features and game play of
[Star Wars Legion][2]. It is periodically updated to the [Steam Workshop][3].

_Star Wars: Legion and all related properties and text are owned by Fantasy Flight Games, Lucasfilm Ltd., and/or Disney._

![Screenshot of the Game](https://user-images.githubusercontent.com/168174/111917323-922c9c00-8a3c-11eb-8508-f7f0027ccebc.png)

[1]: https://store.steampowered.com/app/286160/Tabletop_Simulator/
[2]: https://www.fantasyflightgames.com/en/products/star-wars-legion/
[3]: http://go.swlegion.dev/mod

## Getting Started

If you're brand new to either Star Wars: Legion, or playing on TTS, Ben VanDonge
(also known as "Mbweha" in various online communities) has a series of tutorials
on YouTube that are great resources. We highly recommend viewing before being
more involved.

- [How to Set Up](https://www.youtube.com/watch?v=FwCmUob0OTM)
- [How to Play](https://www.youtube.com/watch?v=jEzp8qIXOAA)
- [Advanced Newer Features](https://youtu.be/OCkR6Py66m0)

## Contributing

As a community run project, artwork, scripting, table design and more is a 100%
volunteer project, and we could use your support! You will need the following
tools to make _most_ (but not all) contributions to the mod:

1. A Git or GitHub client to make copies of this repository.
2. [NodeJS](https://nodejs.org/)
3. [Tabletop Simulator][1]

You'll notice we do _not_ store the "save file" (JSON) in this repository, as
historically that made concurrent edits and collaboration much more difficult:
instead we have a series of scripts that "compile" it on demand from individual
scripts and objects.

> _WARNING_: Currently only Windows-based development is fully supported.

Once you've cloned the repository, you can build the mod:

```sh
# Install all NodeJS required dependencies.
npm install

# Creates a symbolic link to your TTS save folder, and compiles the mod.
npm start
```

For subsequent updates, you can just use compile on-demand:

```sh
# Files in "mod/**" are combined and output in "dist/" (linked to your saves).
npm run compile

# Optional, instruct TTS to reload automatically.
npm run compile -- --reload
```

If you make any edits to the save file directly, you will need to reflect
(extract) the changes into the `mod/**` folder:

```sh
# This is a rarer workflow, but still supported.
npm run extract
```

Please [file a bug][4] if any part of this process does not work as expected.

[4]: https://github.com/swlegion/tts/issues/new/choose

## Join the Community

Currently our only support channel is joining [The Legion Discord (TLD)][5] and
using the `#tts-chat` and `#tts-bugs-and-feature-requests` channels, which are
open to all players.

![Support Channels](https://user-images.githubusercontent.com/168174/111917669-8e017e00-8a3e-11eb-817e-f25a9933aff3.png)

[5]: https://discordapp.com/invite/UGP9N2v

Frequent contributors may be invited to a private Discord.
