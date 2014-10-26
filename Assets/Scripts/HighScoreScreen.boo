import UnityEngine

class HighScoreScreen (MonoBehaviour): 

	done = false
	def Start ():
		for i in range(5):
			#gameObjectThis = GameObject.Find("scoreScreenText" + (i+1).ToString()) as GameObject
			#textMesh = gameObjectThis.transform.GetComponent("TextMesh") as TextMesh
			textMesh = GameObject.Find("scoreScreenText" + (i+1).ToString()).transform.GetComponent("TextMesh") as TextMesh
			textMesh.text = PlayerPrefs.GetString("highScoreName-" + i.ToString(), "------")
			textMesh2 = GameObject.Find("scoreScreenScore" + (i+1).ToString()).transform.GetComponent("TextMesh") as TextMesh
			textMesh2.text = PlayerPrefs.GetInt("highScore-" + i.ToString(), 0).ToString()			
			if(textMesh2.text == "0"):
				textMesh2.text = ""
	def Update ():
		verticalMovement = Input.GetAxis("Vertical")
		if(verticalMovement > 0):
			Application.LoadLevel("Menu")
			