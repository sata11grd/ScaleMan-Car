using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ScaleMan
{
    /// <summary>
    /// �A�^�b�`�����I�u�W�F�N�g�̓G�f�B�^�ł̂ݕ\�������悤�ɂȂ�܂��B
    /// �G�f�B�^�ŕ\������Ă���Ԃ������ǂɃA�^�b�`���Ă��܂��B
    /// </summary>
    public class HideOnAwake : MonoBehaviour
    {
        private void Awake()
        {
            GetComponent<MeshRenderer>().enabled = false;
        }
    }
}
