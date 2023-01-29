using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using ScaleMan;

namespace ScaleMan
{
    [CustomEditor(typeof(GoalMeterManager))]
    public class GoalMeterManagerEditor : Editor
    {
        [SerializeField] private float value;

        public override void OnInspectorGUI()
        {
            base.OnInspectorGUI();

            if (GUILayout.Button("Debug"))
            {
                var goalMeterManager = FindObjectOfType<GoalMeterManager>();
            }
        }
    }
}
