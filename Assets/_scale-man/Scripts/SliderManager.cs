using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ScaleMan
{
    /// <summary>
    /// スライダーのUIです。
    /// </summary>
    public class SliderManager : MonoBehaviour
    {
        [SerializeField] private EventTrigger handle;
        [SerializeField] private Transform startPosition;
        [SerializeField] private Transform endPosition;

        /// <summary>
        /// ハンドルが掴まれているかどうか
        /// </summary>
        private bool _handleIsHold;

        private void Awake()
        {
            // スライダーのハンドルの上でマウスポインタが押された時にOnPointerDownメソッドが呼ばれるようにします。
            var onPointerDown = new EventTrigger.Entry();
            onPointerDown.eventID = EventTriggerType.PointerDown;
            onPointerDown.callback.AddListener(data => OnPointerDown());
            handle.triggers.Add(onPointerDown);

            // スライダーのハンドルの上でマウスポインタがリリースされた時にOnPointerUpメソッドが呼ばれるようにします。
            var onPointerUp = new EventTrigger.Entry();
            onPointerUp.eventID = EventTriggerType.PointerUp;
            onPointerUp.callback.AddListener(data => OnPointerUp());
            handle.triggers.Add(onPointerUp);
        }

        private void Update()
        {
            // スライダーのハンドル位置を更新します。
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
        /// スライダーの値を返します。
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
