using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class warFogSimulation : MonoBehaviour {

    public CustomRenderTexture texture;
	void Start () {
        texture.Initialize();
	}
	
	
	void Update () {
        UpdateZone();
	}

    void UpdateZone()
    {
        if(Input.GetMouseButtonDown(0))
        {
            if(Camera.main != null)
            {
                RaycastHit hit;
                if(Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition), out hit))
                {
                    CustomRenderTextureUpdateZone clearZone = new CustomRenderTextureUpdateZone();
                    clearZone.needSwap = false;
                    clearZone.passIndex = 0;
                    clearZone.rotation = 0;
                    clearZone.updateZoneCenter = new Vector2(hit.textureCoord.x, 1 - hit.textureCoord.y);
                    clearZone.updateZoneSize = Vector2.one * 0.2f;
                    texture.SetUpdateZones(new CustomRenderTextureUpdateZone[] { clearZone });
                    texture.Update();
                    print("new zone");
                }
            }
        }
    }
}
