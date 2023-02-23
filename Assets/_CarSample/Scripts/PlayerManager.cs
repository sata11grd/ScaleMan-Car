using ScaleMan;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using static UnityEngine.ParticleSystem;

namespace BitCrewStudio.ScaleCar3D
{
    public class PlayerManager : MonoBehaviour
    {
        [SerializeField] private SliderManager sliderManager;
        [SerializeField] private float minScale;
        [SerializeField] private float maxScale;
        [SerializeField] private float minTorque;
        [SerializeField] private float maxTorque;
        [SerializeField] private CarController carController;
        [SerializeField] private ParticleSystem trailFx;
        [SerializeField] private ParticleSystem hitFx;
        [SerializeField] private Transform hitFxPoint;

        private void Awake()
        {
            // エフェクトをクローンしておきます。
            trailFx = Instantiate(trailFx);
        }

        private void OnCollisionEnter(Collision collision)
        {
            var fx = Instantiate(hitFx, hitFxPoint.position, Quaternion.identity);
        }

        private void Update()
        {
            var scale = Mathf.Lerp(minScale, maxScale, sliderManager.GetValue());
            transform.localScale = Vector3.one * scale;

            var torque = Mathf.Lerp(minTorque, maxTorque, 1 - sliderManager.GetValue());
            carController.SetTorque(torque);

            // トレイルエフェクト(小さいときにプレイヤーの後ろについてくるエフェクト)の更新
            if (sliderManager.GetValue() <= 0.1f)
            {
                if (!trailFx.isPlaying)
                {
                    trailFx.Play();
                }

                trailFx.transform.position = transform.position + Vector3.back / 2 + Vector3.down * 0.5f;
            }
            else
            {
                if (trailFx.isPlaying)
                {
                    trailFx.Stop();
                }
            }
        }
    }
}
