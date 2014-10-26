import UnityEngine

class HelpScreen (MonoBehaviour): 

	def Start ():
		pass
	
	def Update ():
		verticalMovement = Input.GetAxis("Vertical")
		if(verticalMovement > 0):
			Application.LoadLevel("Menu")
		