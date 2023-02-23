using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine;

namespace ScaleMan
{
    /// <summary>
    /// COMの処理はプレイヤーとほとんど同じです。
    /// Startメソッドの中に、COMはどういう風に移動するかを記述していきます。
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
        /// ここでCOMの挙動を指定します。
        /// </summary>
        private void Start()
        {
            // 最初にスライダーを0.3にセットしておきます。
            SetSliderValue(value: 0.1f);

            // 2秒後に1秒間かけて0.8までスライダーを移動します。
            SetSliderValueSmoothly(delay:2f, value: 1.5f, duration: 1f);

            // 6秒後に0.5秒間かけて0.01までスライダーを移動します。
            SetSliderValueSmoothly(delay:6f, value: 0.01f, duration: 0.5f);

            // 以下、何秒後に何秒かけてどの値までスライダーを移動するか、というように指定していきます...
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

                    // ヒットエフェクトの再生
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

            // エフェクト生成
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
                // 移動スピードの更新
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

            // キャラクターサイズの更新
            var scale = Mathf.Lerp(scaleOfSmall, scaleOfBig, _sliderValue);
            comModel.transform.localScale = new Vector3(scale, scale, scale);

            // 重さ更新
            var mass = Mathf.Lerp(minMass, maxMass, _sliderValue);
            rb.mass = mass;

            // エフェクトの更新
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
