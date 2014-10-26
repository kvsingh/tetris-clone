import UnityEngine

class PauseScreen (MonoBehaviour): 

	def Start ():
		pass
	
	def Update ():
		verticalMovement = Input.GetAxis("Vertical")
		if(verticalMovement > 0):
			Application.LoadLevel("GamePlay-Saved")
		
