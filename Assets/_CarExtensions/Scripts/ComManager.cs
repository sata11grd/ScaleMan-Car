using ScaleMan;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using static UnityEngine.ParticleSystem;

namespace BitCrewStudio.ScaleCar3D
{
    public class ComManager : MonoBehaviour
    {
        [SerializeField] private float minScale;
        [SerializeField] private float maxScale;
        [SerializeField] private float minTorque;
        [SerializeField] private float maxTorque;
        [SerializeField] private CarController carController;
        [SerializeField] private ParticleSystem trailFx;
        [SerializeField] private ParticleSystem hitFx;
        [SerializeField] private Transform hitFxPoint;

        [SerializeField] private GameObject Start_UI;

        private float _sliderValue;

        private void Awake()
        {
            // エフェクトをクローンしておきます。
            trailFx = Instantiate(trailFx);
        }

        private void OnCollisionEnter(Collision collision)
        {
            var fx = Instantiate(hitFx, hitFxPoint.position, Quaternion.identity);
        }

        /// <summary>
        /// ここでCOMの挙動を指定します。
        /// </summary>
        private void Start()
        {
            // 最初にスライダーを0.1にセットしておきます。
            SetSliderValue(value: 0.1f);

            // 2秒後に1秒間かけて1.0までスライダーを移動します。
            SetSliderValueSmoothly(delay: 2f, value: 1.0f, duration: 1f);

            // 6秒後に0.5秒間かけて0.01までスライダーを移動します。
            SetSliderValueSmoothly(delay: 6f, value: 0.01f, duration: 0.5f);
 
            // 8秒後に0.5秒間かけて1.0までスライダーを移動します。
            SetSliderValueSmoothly(delay: 12.5f, value: 1.0f, duration: 0.5f);

            // 15秒後に0.5秒間かけて0.2までスライダーを移動します。
            SetSliderValueSmoothly(delay: 16f, value: 0.01f, duration: 0.5f);

            // 20秒後に0.5秒間かけて1.0までスライダーを移動します。
            SetSliderValueSmoothly(delay: 20f, value: 1f, duration: 1f);

            // 23秒後に0.5秒間かけて0.05までスライダーを移動します。
            SetSliderValueSmoothly(delay: 23f, value: 0.05f, duration: 0.5f);

            // 25秒後に0.5秒間かけて0.05までスライダーを移動します。
            SetSliderValueSmoothly(delay: 25f, value: 1f, duration: 1f);



            // 以下、何秒後に何秒かけてどの値までスライダーを移動するか、というように指定していきます...
        }

        private void SetSliderValue(float value)
        {
            _sliderValue = value;
        }

        private void SetSliderValueSmoothly(float value, float duration, float delay)
        {
            StartCoroutine(SetSliderValueSmoothlyCoroutine(value, duration, delay));
        }

        private IEnumerator SetSliderValueSmoothlyCoroutine(float value, float duration, float delay)
        {
            yield return new WaitForSeconds(delay);

            var buffer = duration;
            var startValue = _sliderValue;
            var endValue = value;

            while (duration > 0)
            {
                duration -= Time.deltaTime;
                _sliderValue = Mathf.Lerp(startValue, endValue, 1 - duration / buffer);

                yield return null;
            }
        }

        private void Update()
        {
            // Startボタンが表示されている限り、ボールは動かさない。
            if(Start_UI.activeSelf == true)
            {
                return;
            }


            var scale = Mathf.Lerp(minScale, maxScale, _sliderValue);
            transform.localScale = Vector3.one * scale;

            var torque = Mathf.Lerp(minTorque, maxTorque, 1 - _sliderValue);
            carController.SetTorque(torque);

            // トレイルエフェクト(小さいときにプレイヤーの後ろについてくるエフェクト)の更新
            if (_sliderValue <= 0.1f)
            {
                if (!trailFx.isPlaying)
                {
                    trailFx.Play();
                }

                trailFx.transform.position = transform.position + Vector3.back + Vector3.down * 0.5f;
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
