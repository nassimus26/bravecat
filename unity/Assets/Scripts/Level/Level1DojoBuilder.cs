using UnityEngine;

namespace Bravecat.Level
{
    /// <summary>
    /// Unity C# Editor Script to Procedurally Build Level 1 (The Dojo & City Suburbs)
    /// Places terrain, dojo pagoda models, cherry blossom trees, clinic, crates, and spawns Grimfang boss!
    /// </summary>
    public class Level1DojoBuilder : MonoBehaviour
    {
        [Header("3D Prefabs")]
        public GameObject dojoPrefab;
        public GameObject clinicPrefab;
        public GameObject cherryTreePrefab;
        public GameObject cratePrefab;
        public GameObject grimfangBossPrefab;

        [ContextMenu("Build Level 1 Scene")]
        public void BuildLevel1()
        {
            Debug.Log("Building Level 1: The Dojo & City Suburbs Scene...");

            // 1. Spawn Dojo
            if (dojoPrefab) Instantiate(dojoPrefab, new Vector3(-10, 0, 15), Quaternion.identity);

            // 2. Spawn Clinic
            if (clinicPrefab) Instantiate(clinicPrefab, new Vector3(15, 0, 15), Quaternion.identity);

            // 3. Spawn Cherry Blossom Trees
            if (cherryTreePrefab) {
                Instantiate(cherryTreePrefab, new Vector3(-5, 0, 10), Quaternion.identity);
                Instantiate(cherryTreePrefab, new Vector3(8, 0, 12), Quaternion.identity);
            }

            // 4. Spawn Crates
            if (cratePrefab) {
                Instantiate(cratePrefab, new Vector3(-2, 0, 5), Quaternion.identity);
                Instantiate(cratePrefab, new Vector3(2, 0, 7), Quaternion.identity);
            }

            // 5. Spawn Grimfang Boss
            if (grimfangBossPrefab) {
                Instantiate(grimfangBossPrefab, new Vector3(10, 0, 12), Quaternion.Euler(0, -90, 0));
            }

            Debug.Log("Level 1 Scene Built Successfully!");
        }
    }
}
