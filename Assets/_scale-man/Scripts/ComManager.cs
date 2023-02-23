using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine;

namespace ScaleMan
{
    /// <summary>
    /// COM�̏����̓v���C���[�ƂقƂ�Ǔ����ł��B
    /// Start���\�b�h�̒��ɁACOM�͂ǂ��������Ɉړ����邩���L�q���Ă����܂��B
    /// </summary>
    public class ComManager : MonoBehaviour
    {
        [SerializeField] private GameObject comModel;
        [SerializeField] private float scaleOfSmall;
        [SerializeField] private float scaleOfBig;

        [Space]

        [SerializeField] private Rigidbody rb;
        [SerializeField] private float minSpeed;
        [SerializeField] private float maxSpeed;
        [SerializeField] private float minMass;
        [SerializeField] private float maxMass;
        [SerializeField] private Vector3 jumpForce;
        [SerializeField] private float jumpTime;
        [SerializeField] private float downTime;

        [Space]

        [SerializeField] private Vector3 blowForce;
        [SerializeField] private Vector3 blowTorque;

        [Space]

        [SerializeField] private Animator animator;

        [Space]

        [SerializeField] private ParticleSystem trailFx;
        [SerializeField] private ParticleSystem hitFx;
        [SerializeField] private ParticleSystem landingFx;
        [SerializeField] private Transform hitFxPoint;

        private bool _isJumping;
        private bool _isDown;
        private float _sliderValue;

        private void Awake()
        {
            trailFx = Instantiate(trailFx);
        }

        /// <summary>
        /// ������COM�̋������w�肵�܂��B
        /// </summary>
        private void Start()
        {
            // �ŏ��ɃX���C�_�[��0.3�ɃZ�b�g���Ă����܂��B
            SetSliderValue(value: 0.1f);

            // 2�b���1�b�Ԃ�����0.8�܂ŃX���C�_�[���ړ����܂��B
            SetSliderValueSmoothly(delay:2f, value: 1.5f, duration: 1f);

            // 6�b���0.5�b�Ԃ�����0.01�܂ŃX���C�_�[���ړ����܂��B
            SetSliderValueSmoothly(delay:6f, value: 0.01f, duration: 0.5f);

            // �ȉ��A���b��ɉ��b�����Ăǂ̒l�܂ŃX���C�_�[���ړ����邩�A�Ƃ����悤�Ɏw�肵�Ă����܂�...
        }

        public void InvokeAfterDelay(float delay, Action action)
        {
            StartCoroutine(InvokeAfterDelayCoroutine(delay, action));
        }

        private IEnumerator InvokeAfterDelayCoroutine(float delay, Action action)
        {
            yield return new WaitForSeconds(delay);

            action?.Invoke();
        }

        private void OnCollisionStay(Collision collision)
        {
            if (collision.gameObject.name == "jump_checker")
            {
                if (_sliderValue >= 0.7f)
                {
                    StartCoroutine(JumpCoroutine());
                    Destroy(collision.gameObject);

                    StartCoroutine(PlayLandingFxCoroutine(1f));
                }
            }
            else if (collision.gameObject.name == "down_checker")
            {
                if (_sliderValue <= 0.3f)
                {
                    StartCoroutine(DownCoroutine());
                    Destroy(collision.gameObject);

                    // �q�b�g�G�t�F�N�g�̍Đ�
                    var fx = Instantiate(hitFx.gameObject);
                    fx.transform.position = hitFxPoint.position;
                    fx.SetActive(true);
                }
            }

            /*
            else if (collision.gameObject.name == "Broke Cube")
            {
                if (_sliderValue >= 0.6f)
                {
                    collision.rigidbody.mass = 1;
                    collision.rigidbody.AddForce(blowForce);
                    collision.rigidbody.AddTorque(blowTorque);
                }
            }
            */
        }

        private IEnumerator PlayLandingFxCoroutine(float delay)
        {
            yield return new WaitForSeconds(delay);

            // �G�t�F�N�g����
            var fx = Instantiate(landingFx.gameObject);
            fx.transform.position = transform.position;
            fx.SetActive(true);
        }

        private IEnumerator JumpCoroutine()
        {
            _isJumping = true;
            animator.SetFloat("walk_speed", 0);
            animator.SetFloat("run_speed", 0);
            animator.SetFloat("sprint_speed", 0);
            animator.SetBool("jump", true);
            rb.AddForce(jumpForce);
            GetComponent<Collider>().enabled = false;

            yield return new WaitForSeconds(jumpTime);

            GetComponent<Collider>().enabled = true;
            _isJumping = false;
            animator.SetBool("jump", false);
        }

        private IEnumerator DownCoroutine()
        {
            animator.SetBool("down", true);
            animator.SetFloat("walk_speed", 0);
            animator.SetFloat("run_speed", 0);
            animator.SetFloat("sprint_speed", 0);
            _isDown = true;
            yield return new WaitForSeconds(jumpTime);
            animator.SetBool("down", false);
            _isDown = false;
        }

        private void Jump(float delay)
        {
            InvokeAfterDelay(delay, () => StartCoroutine(JumpCoroutine()));
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
            if (!_isJumping && !_isDown)
            {
                // �ړ��X�s�[�h�̍X�V
                var speed = Mathf.Lerp(minSpeed, maxSpeed, 1 - _sliderValue);
                rb.velocity = new Vector3(0, rb.velocity.y, speed);

                if (0 <= _sliderValue && _sliderValue < 0.3f)
                {
                    animator.SetFloat("walk_speed", 0);
                    animator.SetFloat("run_speed", 0);
                    animator.SetFloat("sprint_speed", 1);
                }
                else if (0.3f <= _sliderValue && _sliderValue < 0.6f)
                {
                    animator.SetFloat("walk_speed", 1f);
                    animator.SetFloat("run_speed", 0);
                    animator.SetFloat("sprint_speed", 0);
                }
                else if (0.6f <= _sliderValue && _sliderValue <= 1)
                {
                    animator.SetFloat("walk_speed", 0.2f);
                    animator.SetFloat("run_speed", 0);
                    animator.SetFloat("sprint_speed", 0);
                }
                else
                {
                    //throw new NotImplementedException();
                }
            }

            // �L�����N�^�[�T�C�Y�̍X�V
            var scale = Mathf.Lerp(scaleOfSmall, scaleOfBig, _sliderValue);
            comModel.transform.localScale = new Vector3(scale, scale, scale);

            // �d���X�V
            var mass = Mathf.Lerp(minMass, maxMass, _sliderValue);
            rb.mass = mass;

            // �G�t�F�N�g�̍X�V
            if (animator.GetFloat("sprint_speed") > 0.1f)
            {
                if (!trailFx.isPlaying)
                {
                    trailFx.Play();
                }

                trailFx.transform.position = transform.position + (Vector3.up * 0.1f);
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
