using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class rotate : MonoBehaviour
{
    public float speed;
    public float range;


    // Update is called once per frame
    void Update()
    {
        float pp =  Mathf.Cos(Time.time * speed * Mathf.PI) * range;

        transform.localRotation = Quaternion.Euler(6, pp, 0);
    }
}
