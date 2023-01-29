using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace ScaleMan
{
    public class Debugger : MonoBehaviour
    {
        [SerializeField] private float value1;
        [SerializeField] private GoalMeterManager goalMeterManager;
        [SerializeField] private PlayerManager playerManager;
        [SerializeField] private string playerAnimation;

        private void Update()
        {
            if (Input.GetKeyDown(KeyCode.Space))
            {
                goalMeterManager.SetValue(value1);
            }
        }
    }
}
