using System.Collections;
using System.Collections.Generic;
using UnityEngine;


namespace Unity.GPUAnimation
{
    public class RenderSystemSetup : MonoBehaviour
    {
        static RenderSystemSetup _instance;

        public Scrubber animationScrubber;
        public Scrubber propertyScrubber;
        public bool renderingEnabled = true;

        public string propertyName = "_Value";

        void Awake()
        {
            if (!_instance)
            {
                _instance = this;
            } else
            {
                Destroy(this);
                return;
            }

            ScrubAnimUpdaterSystem.scrub = animationScrubber;
            ScrubMaterialPropertySystem.scrubber = propertyScrubber;
            GpuCharacterRenderSystem.SetProperty(propertyName);
        }

        // Start is called before the first frame update
        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {
            GpuCharacterRenderSystem.RenderingEnabled = renderingEnabled;
        }
    }
}
