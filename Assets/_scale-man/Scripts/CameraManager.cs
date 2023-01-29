using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ScaleMan
{
    public class CameraManager : MonoBehaviour
    {
        [SerializeField] private Transform player;

        private Vector3 _offset;

        private void Awake()
        {
            _offset = transform.position - player.position;
        }

        void Update()
        {
            transform.position = player.position + _offset;
        }
    }
}
