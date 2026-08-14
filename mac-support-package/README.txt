Making the mod's AssetBundles work on Mac
=========================================

Short version: build each bundle twice and merge the two files. One extra step
for whoever builds the bundles, and every mini from then on renders correctly on
both platforms. Nothing changes for Windows players.


WHAT IS BROKEN AND WHY

Shader variants inside an AssetBundle are compiled per graphics API, decided by
the build target. The mod's bundles were built for Windows, so they carry d3d11
and glcore variants (we scanned them: 60 of 62 shaders are exactly that pair).
That was correct at the time, and it is why the mod used to work on Mac: TTS ran
OpenGL there.

Since TTS v14 the Mac player runs Metal and has no usable OpenGL path left.
-force-glcore reaches the process and is silently ignored. So the custom shaders
never find a variant they can load. TTS substitutes the Standard shader where it
can, which is why minis show their raw team-colour mask, and renders magenta
where it cannot, which is why the projectors look worst.

Nothing is wrong with the shader code. It was simply never compiled for Metal.


THE FIX, IN THREE PARTS

1. Two shader-source changes, worth doing once and for all
----------------------------------------------------------

In ColorReplacer.shader (and the other BucketheadBits shaders), the team colour
swap is computed in fixed precision:

    fixed ramp     = 1.0 - distance(c.rgb, _SwapColor.rgb);
    fixed swapMask = saturate((ramp - _SwapCutoff) * _SwapContrast);

On DirectX, fixed and half are treated as 32-bit floats. On Metal, half is a real
16-bit float. The mask is a near-binary threshold amplified by _SwapContrast (5.0
by default), so in 16 bits the pixels sitting near the threshold flip at random:
speckled bases, cape linings left green, magenta fringes along the swapped areas.

Changing fixed and half to float in these shaders is a no-op on Windows (they
were already 32-bit there) and fixes Metal for good. That is the cleanest place
to fix it: once, in the source.

The second change matters most for whatever you build next, because it hits any
mini with a glow effect. The BucketheadBits glow shaders multiply their effect by
the vertex colour:

    o.v.x = min(1.0f, viewSat * v.color.a);
    float4 lerpColor = _FarColor * pow(...) * i.col.r * _Contrast;

No mesh in the mod carries a Color channel. When the channel is missing, DirectX
and OpenGL hand the shader white (1,1,1,1) and the effect lights up; Metal hands
it black (0,0,0,0). The passes are Blend One One, so multiplied by zero they add
exactly nothing. The mesh renders, the glow does not, and nothing is logged.

This one is nasty precisely because it is invisible: it does not go magenta, it
does not error, the model just looks flat on Mac. It had switched off 12 bundles
worth of lightsabers, IG-88's eyes and the Droideka's shield without anyone
noticing. Replacing v.color with white in these shaders restores exactly what
Windows already receives, and is a no-op there. We checked every mesh in the
published bundles first: exactly one carries a Color channel, and it uses no
custom shader.

2. Build each bundle twice, then merge
--------------------------------------

Unity cannot produce a single bundle covering both platforms: ask for Metal in a
Windows build and it silently drops it. But a Shader object can declare several
SubShaders, and Unity falls through to the next one when the first has no variant
for the current graphics API.

So: build the prefab for StandaloneWindows64, build it again for StandaloneOSX,
and stack the macOS SubShader behind the Windows one in the same file.

    # 1. build both (Editor menu: Assets > Build Bundle (Windows + macOS))
    #    -> BiPlatformBundles/win/<name> and BiPlatformBundles/mac/<name>

    # 2. merge
    pip install UnityPy
    python3 merge_subshader_bundles.py BiPlatformBundles/win/<name> \
                                       BiPlatformBundles/mac/<name> <name>

    # 3. upload <name> as usual

The Windows SubShader stays first and the merge does not touch it, so Windows
players get exactly what they get today. The extra SubShader is inert for them.

3. When the sources are gone, graft instead of rebuilding
---------------------------------------------------------

Some of the older units have no usable sources any more, and one had a rebuild
that no longer matched the object you publish. You do not need the sources: a
Metal SubShader can be grafted straight into the published bundle.

The one thing that matters is building the graft in the same Unity version the
bundle was made with. These were made with 2019.1.9f1, not the 2019.4 we first
assumed, and a graft from the wrong version loads without complaint and renders
wrong. Nine bundles took this route, with no model rebuilt and nothing else about
them touched.


FILES HERE

  BuildBiPlatformBundle.cs    drop into any Editor/ folder. Adds
                              Assets > Build Bundle (Windows + macOS), and works
                              in batch mode via
                              -executeMethod BuildBiPlatformBundle.Run
  merge_subshader_bundles.py  the merge step. Requires UnityPy.


ONE TRAP, IF YOU GO DIGGING

Merging the variants inside a single pass does not work. The parameter binding
tables (m_NameIndices, m_CommonParameters, m_ConstantBufferBindings) are stored
once per pass and shared by every platform in it, and Metal lays them out
differently from DirectX (VGlobals/FGlobals instead of $Globals, offsets reset to
zero). The result loads, logs nothing, and renders wrong, which costs a lot of
time to diagnose. A SubShader carries its own tables. It is also why d3d11 and
glcore coexist happily in the current bundles: those two share the layout.


STATUS ON OUR SIDE

Tested in game on both platforms with the same merged file: an A-A5 Speeder Truck
renders correctly on Mac and on Windows.

Of the 266 bundles the mod references, 114 use no custom shader and were never
broken. The other 152 are all repaired: 143 rebuilt from sources and merged, 9
grafted. Nothing is left broken on Mac. They are running here, and they are
downloadable from the release linked in PR #600 if you want to try them before
deciding anything.

Happy to help wire this into your build, or to hand over the repaired bundles.
