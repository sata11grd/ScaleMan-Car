using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ScaleMan
{
    public class GoalLine : MonoBehaviour
    {
        [SerializeField] private GameObject winMessage;
        [SerializeField] private GameObject loseMessage;

        // NEXTボタン表示用
        [SerializeField] private GameObject Goal_UI;

        private void OnTriggerEnter(Collider other)
        {
            Debug.Log("ゴール");
            
            Goal_UI.SetActive(true);

            if (other.gameObject.name == "Player")
            {
                Debug.Log("プレイヤーがゴールしました。");
                winMessage.SetActive(true);
                Destroy(this);
            }
            else if (other.gameObject.name == "COM")
            {
                loseMessage.SetActive(true);
                Destroy(this);
            }
        }
    }
}
