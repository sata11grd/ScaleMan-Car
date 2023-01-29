using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace ScaleMan
{
    public class GoalMeterManager : MonoBehaviour
    {
        [SerializeField] private Image gage;
        [SerializeField] private Image fill;
        [SerializeField] private Transform player;
        [SerializeField] private Transform startPoint;
        [SerializeField] private Transform endPoint;

        /// <summary>
        /// Set the value between 0 and 1.
        /// </summary>
        /// <param name="value"></param>
        public void SetValue(float value)
        {
            var width = Mathf.Lerp(0, gage.rectTransform.sizeDelta.x, value);
            fill.rectTransform.sizeDelta = new Vector2(width, 0);
        }

        private void FixedUpdate()
        {
            var value = player.position.z / (endPoint.position.z - startPoint.position.z);
            SetValue(value);
        }
    }
}
