using UnityEngine;

namespace Bravecat.Combat
{
    /// <summary>
    /// Unity 3D Sword Combat System for Milo
    /// Handles 3-hit combo attacks, heavy pounce attacks, hitboxes, and particle sparks.
    /// </summary>
    public class SwordCombat3D : MonoBehaviour
    {
        [Header("Hitbox & Range")]
        public Transform attackPoint;
        public float lightAttackRange = 1.5f;
        public float heavyAttackRange = 2.5f;
        public LayerMask enemyLayers;

        [Header("Particle Effects")]
        public ParticleSystem slashArcEffect;
        public ParticleSystem hitSparkEffect;

        public void PerformLightSlash()
        {
            if (slashArcEffect != null) slashArcEffect.Play();

            Collider[] hitEnemies = Physics.OverlapSphere(attackPoint.position, lightAttackRange, enemyLayers);
            foreach (Collider enemy in hitEnemies) {
                if (hitSparkEffect != null) Instantiate(hitSparkEffect, enemy.transform.position, Quaternion.identity);
                Debug.Log($"Milo Light Slashed: {enemy.name}");
            }
        }

        public void PerformHeavyPounce()
        {
            if (slashArcEffect != null) slashArcEffect.Play();

            Collider[] hitEnemies = Physics.OverlapSphere(attackPoint.position, heavyAttackRange, enemyLayers);
            foreach (Collider enemy in hitEnemies) {
                if (hitSparkEffect != null) Instantiate(hitSparkEffect, enemy.transform.position, Quaternion.identity);
                Debug.Log($"Milo Heavy Pounced: {enemy.name}");
            }
        }

        private void OnDrawGizmosSelected()
        {
            if (attackPoint == null) return;
            Gizmos.color = Color.cyan;
            Gizmos.DrawWireSphere(attackPoint.position, lightAttackRange);
        }
    }
}
