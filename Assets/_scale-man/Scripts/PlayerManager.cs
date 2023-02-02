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
        /// �v���C���[�̃p�����[�^�[���w�肵�܂��B
        /// </summary>
        [Header("Player Parameters")]
        [SerializeField] private float scaleOfSmall;
        [SerializeField] private float scaleOfBig;
        [SerializeField] private float minSpeed;
        [SerializeField] private float maxSpeed;
        [SerializeField] private float minMass;
        [SerializeField] private float maxMass;

        /// <summary>
        /// �W�����v���ɉ�����͂ł��B
        /// </summary>
        [SerializeField] private Vector3 jumpForce;

        /// <summary>
        /// �W�����v�̎��Ԃł�(�~���b)�B
        /// </summary>
        [SerializeField] private float jumpTime;

        /// <summary>
        /// �ǂɂԂ����Č��ɐ�����΂��ꂽ���Ƀ_�E�����Ă���b���ł�(ms)�B
        /// </summary>
        [SerializeField] private float downTime;

        /// <summary>
        /// �Ԃ��L���[�u�𐁂���΂��Ƃ��ɉ�����͂ł��B(���͎g���Ă��܂���)
        /// </summary>
        [SerializeField] private Vector3 blowForce;

        /// <summary>
        /// �Ԃ��L���[�u�𐁂���΂��Ƃ��ɉ�����ł��B(���͎g���Ă��܂���)
        /// </summary>
        [SerializeField] private Vector3 blowTorque;

        private bool _isJumping;
        private bool _isDown;

        private void Awake()
        {
            // �G�t�F�N�g���N���[�����Ă����܂��B
            trailFx = Instantiate(trailFx);
        }

        /// <summary>
        /// �G�f�B�^��ŕ\������Ă��锖���ԐF�̕ǂɃL�����N�^�[���ڐG�������ɂǂ��������������邩���`���܂��B
        /// </summary>
        /// <param name="collision"></param>
        private void OnCollisionStay(Collision collision)
        {
            if (collision.gameObject.name == "jump_checker")
            {
                // �ł������ɐڐG������W�����v
                if (sliderManager.GetValue() >= 0.7f)
                {
                    // ��Q�������z���邽�߂ɖ������transform�ŎԂ���]
                    transform.Rotate(new Vector3(-18, 0, 0));

                    // rb.AddForce(jumpForce);
                    Destroy(collision.gameObject);
                    StartCoroutine(JumpCoroutine());
                    
                    StartCoroutine(PlayLandingFxCoroutine(1f));
                }
            }
            else if (collision.gameObject.name == "down_checker")
            {
                // �������Ƃ��ɐڐG������|���
                if (sliderManager.GetValue() <= 0.3f)
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
            Debug.Log("�W���[�[�[�[�[�[���v�I�I�I");
            
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

            // �֌W�Ȃ�����
            // rb = this.GetComponent<Rigidbody>();

            // �ړ�����
            // �W�����v���܂��͓|��Ă���Ƃ��͈ړ����Ȃ��悤�ɂ��܂��B
            if (!_isJumping && !_isDown)
            {
                // �ړ��X�s�[�h�̍X�V
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
                    // �X���C�_�[��0~1�̊ԂɎ��܂��Ă��Ȃ�������G���[���o��
                    throw new NotImplementedException();
                }
            }

            // �X���C�_�[�̒l�ɉ����ăL�����N�^�[�T�C�Y�̍X�V
            var scale = Mathf.Lerp(scaleOfSmall, scaleOfBig, sliderManager.GetValue());
            playerModel.transform.localScale = new Vector3(scale, scale, scale);

            // �X���C�_�[�̒l�ɉ����ďd���X�V
            var mass = Mathf.Lerp(minMass, maxMass, sliderManager.GetValue());
            rb.mass = mass;

            // �g���C���G�t�F�N�g(�������Ƃ��Ƀv���C���[�̌��ɂ��Ă���G�t�F�N�g)�̍X�V
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
