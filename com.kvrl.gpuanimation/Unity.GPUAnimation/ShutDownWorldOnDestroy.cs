using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Unity.Burst;
using Unity.Entities;
using Unity.Jobs;

public class ShutDownWorldOnDestroy : MonoBehaviour
{
    private void OnDestroy() {
        var em = World.Active.EntityManager;
        em.DestroyEntity(em.UniversalQuery);
    }
}
