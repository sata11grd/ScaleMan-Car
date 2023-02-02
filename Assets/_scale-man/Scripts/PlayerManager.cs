using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ScaleMan
{
    public class PlayerManager : MonoBehaviour
    {
        [Header("References")]
        [SerializeField] private SliderManager sliderManager;
        [SerializeField] private GameObject playerModel;
        [SerializeField] private Rigidbody rb;
        [SerializeField] private Animator animator;
        [SerializeField] private ParticleSystem trailFx;
        [SerializeField] private ParticleSystem hitFx;
        [SerializeField] private ParticleSystem landingFx;
        [SerializeField] private Transform hitFxPoint;

        /// <summary>
        /// プレイヤーのパラメーターを指定します。
        /// </summary>
        [Header("Player Parameters")]
        [SerializeField] private float scaleOfSmall;
        [SerializeField] private float scaleOfBig;
        [SerializeField] private float minSpeed;
        [SerializeField] private float maxSpeed;
        [SerializeField] private float minMass;
        [SerializeField] private float maxMass;

        /// <summary>
        /// ジャンプ時に加える力です。
        /// </summary>
        [SerializeField] private Vector3 jumpForce;

        /// <summary>
        /// ジャンプの時間です(ミリ秒)。
        /// </summary>
        [SerializeField] private float jumpTime;

        /// <summary>
        /// 壁にぶつかって後ろに吹っ飛ばされた時にダウンしている秒数です(ms)。
        /// </summary>
        [SerializeField] private float downTime;

        /// <summary>
        /// 赤いキューブを吹き飛ばすときに加える力です。(今は使っていません)
        /// </summary>
        [SerializeField] private Vector3 blowForce;

        /// <summary>
        /// 赤いキューブを吹き飛ばすときに加えるです。(今は使っていません)
        /// </summary>
        [SerializeField] private Vector3 blowTorque;

        private bool _isJumping;
        private bool _isDown;

        private void Awake()
        {
            // エフェクトをクローンしておきます。
            trailFx = Instantiate(trailFx);
        }

        /// <summary>
        /// エディタ上で表示されている薄い赤色の壁にキャラクターが接触した時にどういう処理をするかを定義します。
        /// </summary>
        /// <param name="collision"></param>
        private void OnCollisionStay(Collision collision)
        {
            if (collision.gameObject.name == "jump_checker")
            {
                // でかい時に接触したらジャンプ
                if (sliderManager.GetValue() >= 0.7f)
                {
                    // 障害物を乗り越えるために無理やりtransformで車を回転
                    transform.Rotate(new Vector3(-18, 0, 0));

                    // rb.AddForce(jumpForce);
                    Destroy(collision.gameObject);
                    StartCoroutine(JumpCoroutine());
                    
                    StartCoroutine(PlayLandingFxCoroutine(1f));
                }
            }
            else if (collision.gameObject.name == "down_checker")
            {
                // 小さいときに接触したら倒れる
                if (sliderManager.GetValue() <= 0.3f)
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
                if (sliderManager.GetValue() >= 0.6f)
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
            Debug.Log("ジャーーーーーーンプ！！！");
            
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

        private void Update()
        {

            // 関係なさそう
            // rb = this.GetComponent<Rigidbody>();

            // 移動処理
            // ジャンプ中または倒れているときは移動しないようにします。
            if (!_isJumping && !_isDown)
            {
                // 移動スピードの更新
                var speed = Mathf.Lerp(minSpeed, maxSpeed, 1 - sliderManager.GetValue());
                rb.velocity = new Vector3(0, rb.velocity.y, speed);
                // Debug.Log("rb.velocity == " + rb.velocity);


                if (0 <= sliderManager.GetValue() && sliderManager.GetValue() < 0.3f)
                {
                    animator.SetFloat("walk_speed", 0);
                    animator.SetFloat("run_speed", 0);
                    animator.SetFloat("sprint_speed", 1);
                }
                else if (0.3f <= sliderManager.GetValue() && sliderManager.GetValue() < 0.6f)
                {
                    animator.SetFloat("walk_speed", 1f);
                    animator.SetFloat("run_speed", 0);
                    animator.SetFloat("sprint_speed", 0);
                }
                else if (0.6f <= sliderManager.GetValue() && sliderManager.GetValue() <= 1)
                {
                    animator.SetFloat("walk_speed", 0.2f);
                    animator.SetFloat("run_speed", 0);
                    animator.SetFloat("sprint_speed", 0);
                }
                else
                {
                    // スライダーが0~1の間に収まっていなかったらエラーを出す
                    throw new NotImplementedException();
                }
            }

            // スライダーの値に応じてキャラクターサイズの更新
            var scale = Mathf.Lerp(scaleOfSmall, scaleOfBig, sliderManager.GetValue());
            playerModel.transform.localScale = new Vector3(scale, scale, scale);

            // スライダーの値に応じて重さ更新
            var mass = Mathf.Lerp(minMass, maxMass, sliderManager.GetValue());
            rb.mass = mass;

            // トレイルエフェクト(小さいときにプレイヤーの後ろについてくるエフェクト)の更新
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
