using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// Script by TetraArts
/// </summary>

public class DissolveScript : MonoBehaviour
{
    #region Variables
    
    private MeshRenderer[] mesh;
    private SkinnedMeshRenderer[] skinMesh;

    [Tooltip("Particles to launch when dissolving")]
    [SerializeField]
    private ParticleSystem particles;

    private Material[] matGrp;
    private float time;

    [Tooltip("Starting height")]
    [SerializeField]
    private float startDissolveValue;

    [Tooltip("Ending height")]
    [SerializeField]
    private float endDissolveValue;

    [Tooltip("Delay for playing entire animation")]
    [SerializeField]
    private float delay;

    private bool action;

    

    
    //[SerializeField]
    //private bool debug;

    #endregion

    // Start is called before the first frame update
    void Start()
    {
        
        mesh = GetComponentsInChildren<MeshRenderer>();
        
        skinMesh = GetComponentsInChildren<SkinnedMeshRenderer>();
        
        particles = GetComponentInChildren<ParticleSystem>();
       

    }

    // Update is called once per frame
    void Update()
    {
        time += Time.deltaTime;
        /*if (debug)
        {
            if (Input.GetKeyDown(KeyCode.F1))
            {
                LaunchDissolve();
                //Debug.Log("Dissolve");
            }
        }*/

        if (action && mesh != null)
        {
            foreach(MeshRenderer skined in mesh)
            {
                matGrp = skined.materials;
                foreach (Material mat in matGrp)
                {
                    mat.SetFloat("_Dissolve", Mathf.Lerp(startDissolveValue, endDissolveValue, time / delay));
                }
            }
            
            if (time >= delay)
                action = false;
        }

        if (action && skinMesh != null)
        {
            foreach (SkinnedMeshRenderer skined in skinMesh)
            {
                matGrp = skined.materials;
                foreach (Material mat in matGrp)
                {
                    mat.SetFloat("_Dissolve", Mathf.Lerp(startDissolveValue, endDissolveValue, time / delay));
                }
            }

            if (time >= delay)
                action = false;
        }
    }

    /// <summary>
    /// Use to launch dissolve animation
    /// </summary>
    public void LaunchDissolve()
    {
        action = true;
        time = 0;
        if (action == true && particles != null)
        {
            particles.Play();
        }
    }

    

}
