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

    [SerializeField] private PlayerManager playerManager;
    [SerializeField] private ComManager comManager;


    // Start is called before the first frame update
    void Start()
    {
        playerManager.enabled = false;
        comManager.enabled = false;
    }

    // Update is called once per frame
    void Update()
    {
        
    }


    public void PushStart()
    {
        Start_UI.SetActive(false);
        playerManager.enabled = true;
        comManager.enabled = true;
    }

    public void PushNext()
    {
        SceneManager.LoadScene("Main");
    }
}
