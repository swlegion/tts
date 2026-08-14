using System;
using System.IO;
using UnityEditor;
using UnityEngine;

// Greffon Metal au format de serialisation Unity 2019, 12 aout 2026.
//
// But : produire un bundle qui ne contient RIEN d'autre que les shaders du mod,
// compiles pour Metal. merge_subshader_platforms.py empile ensuite leur
// SubShader derriere celui du bundle PUBLIE, qui ne connait que d3d11/glcore.
// Le bundle publie garde donc ses maillages, ses textures et ses materiaux bit
// pour bit : c'est la voie zero-derive, et la seule ouverte pour les 8
// orphelins dont on n'a pas les sources.
//
// Un shader n'entre dans un bundle que s'il est reference : on cree donc un
// materiau par shader, porte par un quad, et c'est tout.
//
// Usage :
//   -executeMethod BuildMetalGraft.Run [-out <dossier>]
public static class BuildMetalGraft
{
    const string BundleName = "metal_graft";
    const string StageDir = "Assets/_Graft";

    public static void Run()
    {
        string outputPath = Arg("-out", "AssetBundles-graft");

        if (!Directory.Exists(StageDir))
            AssetDatabase.CreateFolder("Assets", "_Graft");

        string[] shaderGuids = AssetDatabase.FindAssets("t:Shader", new[] { "Assets/Shaders" });
        if (shaderGuids.Length == 0)
        {
            Debug.LogError("GRAFT: aucun shader dans Assets/Shaders");
            EditorApplication.Exit(1);
            return;
        }

        foreach (string guid in shaderGuids)
        {
            string shaderPath = AssetDatabase.GUIDToAssetPath(guid);
            Shader shader = AssetDatabase.LoadAssetAtPath<Shader>(shaderPath);
            if (shader == null)
            {
                Debug.LogError("GRAFT: illisible " + shaderPath);
                EditorApplication.Exit(2);
                return;
            }
            if (shader.name.StartsWith("Hidden/InternalErrorShader"))
            {
                Debug.LogError("GRAFT: " + shaderPath + " ne compile pas (InternalErrorShader)");
                EditorApplication.Exit(3);
                return;
            }

            string matPath = StageDir + "/" + Path.GetFileNameWithoutExtension(shaderPath) + ".mat";
            var mat = new Material(shader);
            AssetDatabase.CreateAsset(mat, matPath);

            var importer = AssetImporter.GetAtPath(matPath);
            importer.assetBundleName = BundleName;

            Debug.Log("GRAFT: " + shader.name + " <- " + shaderPath);
        }

        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh();

        Directory.CreateDirectory(outputPath);
        var manifest = BuildPipeline.BuildAssetBundles(
            outputPath, BuildAssetBundleOptions.None, BuildTarget.StandaloneOSX);

        if (manifest == null)
        {
            Debug.LogError("GRAFT: build echoue");
            EditorApplication.Exit(4);
            return;
        }

        string produced = Path.Combine(outputPath, BundleName);
        if (!File.Exists(produced))
        {
            Debug.LogError("GRAFT: " + produced + " absent apres build");
            EditorApplication.Exit(5);
            return;
        }

        Debug.Log(string.Format("GRAFT: termine, {0} shaders, {1} octets -> {2}",
            shaderGuids.Length, new FileInfo(produced).Length, produced));
    }

    static string Arg(string name, string fallback)
    {
        var args = Environment.GetCommandLineArgs();
        int i = Array.IndexOf(args, name);
        return (i >= 0 && i + 1 < args.Length) ? args[i + 1] : fallback;
    }
}
