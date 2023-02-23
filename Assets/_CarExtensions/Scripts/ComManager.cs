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

        private float _sliderValue;

        private void Awake()
        {
            // �G�t�F�N�g���N���[�����Ă����܂��B
            trailFx = Instantiate(trailFx);
        }

        private void OnCollisionEnter(Collision collision)
        {
            var fx = Instantiate(hitFx, hitFxPoint.position, Quaternion.identity);
        }

        /// <summary>
        /// ������COM�̋������w�肵�܂��B
        /// </summary>
        private void Start()
        {
            // �ŏ��ɃX���C�_�[��0.3�ɃZ�b�g���Ă����܂��B
            SetSliderValue(value: 0.1f);

            // 2�b���1�b�Ԃ�����0.8�܂ŃX���C�_�[���ړ����܂��B
            SetSliderValueSmoothly(delay: 2f, value: 1.5f, duration: 1f);

            // 6�b���0.5�b�Ԃ�����0.01�܂ŃX���C�_�[���ړ����܂��B
            SetSliderValueSmoothly(delay: 6f, value: 0.01f, duration: 0.5f);

            // �ȉ��A���b��ɉ��b�����Ăǂ̒l�܂ŃX���C�_�[���ړ����邩�A�Ƃ����悤�Ɏw�肵�Ă����܂�...
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
            var scale = Mathf.Lerp(minScale, maxScale, _sliderValue);
            transform.localScale = Vector3.one * scale;

            var torque = Mathf.Lerp(minTorque, maxTorque, 1 - _sliderValue);
            carController.SetTorque(torque);

            // �g���C���G�t�F�N�g(�������Ƃ��Ƀv���C���[�̌��ɂ��Ă���G�t�F�N�g)�̍X�V
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