using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace ScaleMan
{
    public class GoalLine : MonoBehaviour
    {
        [SerializeField] private GameObject winMessage;
        [SerializeField] private GameObject loseMessage;

        private void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.name == "Player")
            {
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
