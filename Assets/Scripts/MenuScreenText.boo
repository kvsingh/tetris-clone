 
import UnityEngine

class MenuScreenText (MonoBehaviour): 

	public menuTextType as int;
	
	def Start ():
		pass
				
	def OnMouseEnter() as void:
		renderer.material.color = Color.green
		
	def OnMouseExit() as void:
		renderer.material.color = Color.white
		
	def OnMouseUp() as void:
		if(menuTextType==1):			
			Application.LoadLevel("Gameplay")
		elif(menuTextType==2):
			Application.LoadLevel("Help")	
		elif(menuTextType==3):
			Application.LoadLevel("HighScore")	
		elif(menuTextType==4):
			Application.Quit()
		
	def Update ():
		if(Input.GetKey(KeyCode.Escape)):
			Application.Quit()