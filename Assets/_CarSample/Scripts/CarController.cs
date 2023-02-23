using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace BitCrewStudio.ScaleCar3D
{
    public class CarController : MonoBehaviour
    {
        [SerializeField] private GameObject wheelFrontLeft;
        [SerializeField] private GameObject wheelFrontRight;
        [SerializeField] private GameObject wheelBackLeft;
        [SerializeField] private GameObject wheelBackRight;
        [SerializeField] private float input;
        [SerializeField] RearWheelDrive rearWheelDrive;

        public void SetWheelScale(float scale)
        {
            wheelFrontLeft.transform.localScale = Vector3.one * scale;
            wheelFrontRight.transform.localScale = Vector3.one * scale;
            wheelBackLeft.transform.localScale = Vector3.one * scale;
            wheelBackRight.transform.localScale = Vector3.one * scale;
        }

        public void SetScale(float scale)
        {
            transform.localScale = Vector3.one * scale;
        }

        public void SetTorque(float torque)
        {
            rearWheelDrive.SetTorque(torque);
        }
    }
}
