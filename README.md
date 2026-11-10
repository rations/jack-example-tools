# JACK example tools

> This repository is the source of the `jack_tools` package for RenkuOS. Built
> packages are on its [Releases](https://github.com/rations/jack-example-tools/releases) page, and
> [renku-audio](https://github.com/rations/renku-audio) lists the whole audio stack.

This repository holds the official JACK example clients and tools, which have
been tracked in the
[example-clients](https://github.com/jackaudio/example-clients) and
[tools](https://github.com/jackaudio/tools) repositories in the past.

## Dependencies

The project requires the following dependencies:

* [alsa-lib](https://www.alsa-project.org/wiki/Main_Page) (required when
  building `alsa_in` and `alsa_out` or ZALSA internal clients)
* [jack1](https://github.com/jackaudio/jack1) >= 0.126.0,
  [jack2](https://github.com/jackaudio/jack2) >= 1.9.20, or
  [pipewire-jack](https://gitlab.freedesktop.org/pipewire/pipewire) >= 0.3.44
  (other versions may work but are not supported)
* [opus](https://www.opus-codec.org/) (optional buildtime/ runtime dependency
  for `jack_netsource`)
* [readline](https://tiswww.case.edu/php/chet/readline/rltop.html) (optional
  buildtime/ runtime dependency for `jack_transport`)
* [libsamplerate](https://libsndfile.github.io/libsamplerate/) (required when
  building `alsa_in` and `alsa_out` or `jack_netsource`)
* [libsndfile](https://libsndfile.github.io/libsndfile/) (required when
  building `jack_rec`)
* [libzita-alsa-pcmi](https://kokkinizita.linuxaudio.org/linuxaudio/) (required
  when building ZALSA internal clients)
* [libzita-resampler](https://kokkinizita.linuxaudio.org/linuxaudio/) (required
  when building ZALSA internal clients)

For all available options please refer to
[meson_options.txt](meson_options.txt) or run `meson configure` in the project
directory.

## Building

jack-example-tools uses the [meson build system](https://mesonbuild.com).

To configure the project, meson's [universal
options](https://mesonbuild.com/Builtin-options.html#universal-options) (e.g.
**--prefix**) can be used to prepare a build directory:

```bash
meson --prefix=/usr build
```

To build the applications and libraries [ninja](https://ninja-build.org/) is
required:

```bash
ninja -C build
```

## Installing

Meson is able to install the project components to the system directories (when
run as root), while honoring the **DESTDIR** environment variable:

```bash
DESTDIR="/some/other/location" meson install -C build
```

## Install / packaging (RenkuOS)

This fork builds these tools natively on RenkuOS (x86_64) as part of the Kasen audio
stack. They are JACK clients, so they need the `jack` package (jack-port-renku) at
runtime.

- **From source:** `./build-from-source.sh` (`pkgman install`s meson/ninja + the optional
  `libsndfile`/`libsamplerate`/`readline` deps, then builds and installs into
  `/boot/system/non-packaged`). Build the `jack` package first.
- **Prebuilt package:** `packaging/make-hpkg.sh` → `jack_tools-4-2-x86_64.hpkg`, then
  `pkgman install ./jack_tools-*.hpkg` (`pkgman` pulls `libsndfile`/`libsamplerate`/
  `readline` from the RenkuOS repositories). Provides `jack_lsp`, `jack_connect`, `jack_transport`,
  `jack_midi_dump`, and the rest.

See [renku-audio](https://github.com/rations/renku-audio) for how the pieces fit together.

## Releases

[Releases of
jack-example-tools](https://github.com/jackaudio/jack-example-tools/tags) are
created by its current maintainer [Filipe Coelho](https://github.com/falktx)
(`62B11043D2F6EB6672D93103CDBAA37ABC74FBA0`).

To verify a tag, first import the relevant PGP key:

```
gpg --auto-key-locate wkd,keyserver --search-keys falktx@falktx.com
```

Afterwards a tag can be verified from a clone of this repository:

```
git verify-tag <tag>
```

## License

All files (unless noted otherwise) are licensed under the terms of the
**GPL-2.0-or-later** (see [LICENSE](LICENSE)).

The code in [tools/zalsa](tools/zalsa) is provided via [Fons Adriansen's
zita-ajbridge](https://kokkinizita.linuxaudio.org/linuxaudio/zita-ajbridge-doc/quickguide.html)
and licensed under the terms of the **GPL-3.0-or-later** (see
[tools/zalsa/LICENSE](tools/zalsa/LICENSE)).
