using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SupersonicWisdomSDK;

public class WisdomSDKManager : MonoBehaviour
{
    public void wisdomSDK_init()
    {
        // Subscribe
        SupersonicWisdom.Api.AddOnReadyListener(OnSupersonicWisdomReady);
        // Then initialize
        SupersonicWisdom.Api.Initialize();
    }

    void OnSupersonicWisdomReady()
    {
        // Start your game from this point
    }

    public void Level_Start(int currentLevel)
    {
        SupersonicWisdom.Api.NotifyLevelStarted(currentLevel, null);
    }

    public void Level_Complete(int currentLevel)
    {
        SupersonicWisdom.Api.NotifyLevelCompleted(currentLevel, null);
    }

    public void Level_Fail(int currentLevel)
    {
        SupersonicWisdom.Api.NotifyLevelFailed(currentLevel, null);
    }




    
}
