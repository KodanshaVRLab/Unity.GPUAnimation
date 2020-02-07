using System.Collections;
using System.Collections.Generic;
using Unity.Entities;
using Unity.Mathematics;
using UnityEngine;

namespace Unity.GPUAnimation
{

    public class Scrubber : MonoBehaviour
    {
        //[Range(0, 1)]
        public float time = 0f;
        public bool auto = false;

        List<Entity> entities = new List<Entity>();

        public void Link(Entity e)
        {
            entities.Add(e);
        }

        public float GetDebugTime()
        {
            Debug.Log("Queried...");
            return time;
        }

        private void Awake()
        {
            //if (auto)
            //{
            //    World.Active.CreateSystem<ScrubAnimAutoSystem>();
            //}
            //else
            //{
            //    ScrubAnimUpdaterSystem.scrub = this;
            //    ScrubMaterialPropertySystem.scrubber = this;

            //    World.Active.CreateSystem<ScrubAnimUpdaterSystem>();
            //    World.Active.CreateSystem<ScrubMaterialPropertySystem>();
            //}
        }

        private void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {
            //if (entities.Count > 0)
            //{
            //    foreach (Entity e in entities)
            //    {
            //        var data = World.Active.EntityManager.GetComponentData<ScrubAnim>(e);
            //        data.Time = time;
            //        World.Active.EntityManager.SetComponentData<ScrubAnim>(e, data);
            //    }
            //}
        }
    }
}
