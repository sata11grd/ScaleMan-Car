using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using ScaleMan;

namespace ScaleMan
{
    [CustomEditor(typeof(SliderManager))]
    public class SliderManagerEditor : Editor
    {
        public override void OnInspectorGUI()
        {
            base.OnInspectorGUI();

            if (GUILayout.Button("Debug"))
            {
                var sliderManager = FindObjectOfType<SliderManager>();
                Debug.Log(sliderManager.GetValue());
            }
        }
    }
}
