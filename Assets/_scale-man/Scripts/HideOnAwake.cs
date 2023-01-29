using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ScaleMan
{
    /// <summary>
    /// アタッチしたオブジェクトはエディタでのみ表示されるようになります。
    /// エディタで表示されている赤い薄い壁にアタッチしています。
    /// </summary>
    public class HideOnAwake : MonoBehaviour
    {
        private void Awake()
        {
            GetComponent<MeshRenderer>().enabled = false;
        }
    }
}
