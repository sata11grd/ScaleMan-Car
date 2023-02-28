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


        [SerializeField] private WisdomSDKManager wisdomSDKmanager_Script;

        private void OnTriggerEnter(Collider other)
        {
            Debug.Log("ゴール");
            
            Goal_UI.SetActive(true);

            // wisdomSDKのログ送信
            // --------------------
            Debug.Log("Complete_currentLevel == "+ GameManager.currentLevel_now);
            wisdomSDKmanager_Script.Level_Complete(GameManager.currentLevel_now);
            // --------------------


            if (other.CompareTag("Player"))
            {
                Debug.Log("プレイヤーがゴールしました。");
                winMessage.SetActive(true);
                Destroy(this);
            }
            else if (other.CompareTag("Com"))
            {
                loseMessage.SetActive(true);
                Destroy(this);
            }
        }
    }
}
