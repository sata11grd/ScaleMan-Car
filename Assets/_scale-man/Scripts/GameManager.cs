using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;
using UnityEngine;
using UnityEngine.UI;

public class GameManager : MonoBehaviour
{

    // UIの表示に関する宣言
    [SerializeField] private GameObject MainCanvas;

    [SerializeField] private GameObject Start_UI;

    [SerializeField] private GameObject Goal_UI;


    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }


    public void PushStart()
    {
        Start_UI.SetActive(false);
    }

    public void PushNext()
    {
        SceneManager.LoadScene("Main");
    }
}
