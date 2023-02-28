using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;
using UnityEngine;
using UnityEngine.UI;
using BitCrewStudio.ScaleCar3D;

public class GameManager : MonoBehaviour
{

    // UIの表示に関する宣言
    [SerializeField] private GameObject MainCanvas;

    [SerializeField] private GameObject Start_UI;

    [SerializeField] private GameObject Goal_UI;
    [SerializeField] private GameObject Goal_Line;

    [SerializeField] private GameObject Retry_UI;

    [SerializeField] private PlayerManager playerManager;
    [SerializeField] private ComManager comManager;

    [SerializeField] private WisdomSDKManager wisdomSDKmanager_Script;



    public static int currentLevel_now = 1;

    void Awake()
    {
        // wisdomSDKの初期化
        wisdomSDKmanager_Script.wisdomSDK_init();
    }



    void Start()
    {
        playerManager.enabled = false;
        comManager.enabled = false;
    }


    public void PushStart()
    {
        Start_UI.SetActive(false);
        playerManager.enabled = true;
        comManager.enabled = true;

        wisdomSDKmanager_Script.Level_Start(currentLevel_now);
        Debug.Log("Start_currentLevel == "+ currentLevel_now);
    }

    public void PushNext()
    {
        // NEXTボタンを押したときに現ステージ数に1を加算。
        AddCurrentLevel();
        
        SceneManager.LoadScene("Main");
    }


    // レベルが進むごとに現時点のステージデータを更新
    public static void AddCurrentLevel()
    {
        currentLevel_now++;
    }

    public static void PushRetry()
    {
        SceneManager.LoadScene("Main");
    }
}
