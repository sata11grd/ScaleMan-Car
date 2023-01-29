using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ScaleMan
{
    /// <summary>
    /// �X���C�_�[��UI�ł��B
    /// </summary>
    public class SliderManager : MonoBehaviour
    {
        [SerializeField] private EventTrigger handle;
        [SerializeField] private Transform startPosition;
        [SerializeField] private Transform endPosition;

        /// <summary>
        /// �n���h�����͂܂�Ă��邩�ǂ���
        /// </summary>
        private bool _handleIsHold;

        private void Awake()
        {
            // �X���C�_�[�̃n���h���̏�Ń}�E�X�|�C���^�������ꂽ����OnPointerDown���\�b�h���Ă΂��悤�ɂ��܂��B
            var onPointerDown = new EventTrigger.Entry();
            onPointerDown.eventID = EventTriggerType.PointerDown;
            onPointerDown.callback.AddListener(data => OnPointerDown());
            handle.triggers.Add(onPointerDown);

            // �X���C�_�[�̃n���h���̏�Ń}�E�X�|�C���^�������[�X���ꂽ����OnPointerUp���\�b�h���Ă΂��悤�ɂ��܂��B
            var onPointerUp = new EventTrigger.Entry();
            onPointerUp.eventID = EventTriggerType.PointerUp;
            onPointerUp.callback.AddListener(data => OnPointerUp());
            handle.triggers.Add(onPointerUp);
        }

        private void Update()
        {
            // �X���C�_�[�̃n���h���ʒu���X�V���܂��B
            if (_handleIsHold)
            {
                var position = handle.transform.position;

                position.x = Input.mousePosition.x;

                if (position.x < startPosition.position.x)
                {
                    position.x = startPosition.position.x;
                }

                if (position.x > endPosition.position.x)
                {
                    position.x = endPosition.position.x;
                }

                handle.transform.position = position;
            }
        }

        /// <summary>
        /// �X���C�_�[�̒l��Ԃ��܂��B
        /// </summary>
        /// <returns></returns>
        public float GetValue()
        {
            var length = endPosition.position.x - startPosition.position.x;
            var progress = handle.transform.position.x;

            if (progress > 0)
            {
                progress += -startPosition.position.x;
            }
            else
            {
                progress *= -1;
            }

            return progress / length;
        }

        private void OnPointerDown()
        {
            _handleIsHold = true;
        }

        private void OnPointerUp()
        {
            _handleIsHold = false;
        }
    }
}
