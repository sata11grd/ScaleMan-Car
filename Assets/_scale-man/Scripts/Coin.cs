using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ScaleMan
{
    public class Coin : MonoBehaviour
    {
        [SerializeField] private float rotationSpeed;
        [SerializeField] private ParticleSystem vfx;
        [SerializeField] private Transform center;

        private void OnTriggerEnter(Collider other)
        {
            Destroy(gameObject);

            // エフェクト生成
            var fx = Instantiate(vfx.gameObject);
            fx.transform.position = center.position;
            fx.SetActive(true);
        }

        private void FixedUpdate()
        {
            transform.Rotate(Vector3.right * rotationSpeed);
        }
    }
}
