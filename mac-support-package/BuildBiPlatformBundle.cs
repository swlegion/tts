using System;
using System.IO;
using UnityEditor;
using UnityEngine;

// Builds the selected prefab(s) as AssetBundles for BOTH Windows and macOS, so
// the two can be merged into a single file that renders on either platform.
//
// Put this in any Editor/ folder of the Unity project, then either:
//   - select prefabs in the Project window and use  Assets > Build Bundle (Windows + macOS)
//   - or run it in batch mode:
//       Unity -batchmode -quit -projectPath . \
//             -executeMethod BuildBiPlatformBundle.Run -logFile build.log
//     (batch mode builds every asset that already has an AssetBundle name)
//
// Output: BiPlatformBundles/win/<name> and BiPlatformBundles/mac/<name>.
// Then merge each pair:
//     python3 merge_subshader_bundles.py BiPlatformBundles/win/<name> \
//                                        BiPlatformBundles/mac/<name> <name>
// and upload the merged file. Windows players get the exact same rendering as
// before, Mac players stop seeing magenta and raw team-colour masks.
public static class BuildBiPlatformBundle
{
    const string OutRoot = "BiPlatformBundles";

    [MenuItem("Assets/Build Bundle (Windows + macOS)")]
    static void BuildSelection()
    {
        var builds = new System.Collections.Generic.List<AssetBundleBuild>();

        foreach (var obj in Selection.objects)
        {
            string path = AssetDatabase.GetAssetPath(obj);
            if (string.IsNullOrEmpty(path)) continue;

            // Reuse the bundle name already set on the asset when there is one,
            // so the output matches what the mod expects.
            var importer = AssetImporter.GetAtPath(path);
            string name = importer != null && !string.IsNullOrEmpty(importer.assetBundleName)
                ? importer.assetBundleName
                : Path.GetFileNameWithoutExtension(path).ToLowerInvariant();

            builds.Add(new AssetBundleBuild { assetBundleName = name, assetNames = new[] { path } });
        }

        if (builds.Count == 0)
        {
            Debug.LogError("Select at least one prefab in the Project window.");
            return;
        }

        BuildBoth(builds.ToArray());
    }

    [MenuItem("Assets/Build Bundle (Windows + macOS)", true)]
    static bool BuildSelectionValidate()
    {
        return Selection.objects != null && Selection.objects.Length > 0;
    }

    public static void Run()
    {
        // Batch mode: build everything that already carries an AssetBundle name.
        BuildBoth(null);
    }

    static void BuildBoth(AssetBundleBuild[] builds)
    {
        BuildOne(builds, BuildTarget.StandaloneWindows64, Path.Combine(OutRoot, "win"));
        BuildOne(builds, BuildTarget.StandaloneOSX, Path.Combine(OutRoot, "mac"));
        Debug.Log("BIPLATFORM: done. Now merge each pair with merge_subshader_bundles.py");
    }

    static void BuildOne(AssetBundleBuild[] builds, BuildTarget target, string outputPath)
    {
        Directory.CreateDirectory(outputPath);
        var started = DateTime.Now;

        AssetBundleManifest manifest = builds == null
            ? BuildPipeline.BuildAssetBundles(outputPath, BuildAssetBundleOptions.None, target)
            : BuildPipeline.BuildAssetBundles(outputPath, builds, BuildAssetBundleOptions.None, target);

        if (manifest == null)
        {
            Debug.LogError("BIPLATFORM: build failed for " + target);
            return;
        }

        Debug.Log(string.Format("BIPLATFORM: {0} -> {1} ({2} bundles, {3:F1} min)",
            target, outputPath, manifest.GetAllAssetBundles().Length,
            (DateTime.Now - started).TotalMinutes));
    }
}
