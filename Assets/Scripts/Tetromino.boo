import UnityEngine
import System.Collections
class Tetromino (MonoBehaviour): 

	private spawner as Spawner
		
	private horizontalSpeed as double = 1
	private verticalSpeed as double = 4
	private gravitySpeed as double = 1
	
	private gravity as bool = true
	private state as bool = true
	private isHighScore as bool = false	
	private isNotHighScore as bool = false	
	private timeStarted as double = 0.0F
	private timeToWait as double = 3.0F

	private nextRotate as double = 0.0
	private rotateRate as double = 0.5
	private nextRight as double = 0.0
	private rightRate as double = 0.5
	private nextLeft as double = 0.0
	private leftRate as double = 0.5
	private nextDown as double = 0.0
	private downRate as double = 0.5
	private nextGravity as double = 0.0
	private gravityRate as double = 0.5
	
	private topLeftBlockX as int = 4
	private topLeftBlockY as int = 21
	public type as int
	private shapeType as int = 0
	
	private playerName as string = "enter name"
	def Start ():
		spawner = GameObject.Find("spawner").GetComponent("Spawner") as Spawner		
		#GetComponent(SpriteRenderer).sortingLayerName = "UI"
		
	def CanMove(possibleTopLeftX as int, possibleTopLeftY as int, possibleShapeType as int):
		for i in range(spawner.shapeBlocksX):
			for j in range(spawner.shapeBlocksY):
				if(spawner.shape[type, possibleShapeType, i, j] == 1 and spawner.blocks[possibleTopLeftX + i, possibleTopLeftY - j] == 1):
					return false
		return true 
	
	def DownSteps() as int:	
		for i in range(verticalSpeed):
			if(CanMove(topLeftBlockX, topLeftBlockY - i - 1, shapeType)):
				pass
			else:
				return i
		return verticalSpeed
				
	def Update ():
		horizontalMovement = Input.GetAxis("Horizontal")
		verticalMovement = Input.GetAxis("Vertical")
		if(Time.time > timeStarted + timeToWait and isNotHighScore):
			Application.LoadLevel("Menu")
		if(state):
			#Debug.Log("blockx: " + topLeftBlockX)
			#Debug.Log("blocky: " + topLeftBlockY)
			#Debug.Log("type : " + type)
			pass
		if(spawner.showPause):
			return					
		if(horizontalMovement>0 and Time.time>nextRight and CanMove(topLeftBlockX+1, topLeftBlockY, shapeType) and state):
			nextRight = Time.time + rightRate
			transform.Translate(horizontalSpeed*spawner.blockSize, 0, 0, Space.World)
			topLeftBlockX = topLeftBlockX + 1		
		elif(horizontalMovement<0 and Time.time>nextLeft and CanMove(topLeftBlockX-1, topLeftBlockY, shapeType) and state):
			nextLeft = Time.time + leftRate
			transform.Translate(-horizontalSpeed*spawner.blockSize, 0, 0, Space.World)
			topLeftBlockX = topLeftBlockX - 1		
		if(verticalMovement<0 and Time.time>nextDown and state):
			downSteps = DownSteps()
			if(downSteps > 0):
				nextDown = Time.time + downRate			
				transform.Translate(0,-downSteps*spawner.blockSize,0, Space.World)
				topLeftBlockY = topLeftBlockY - downSteps
		elif(Time.time > nextGravity and gravity and state):
			if(CanMove(topLeftBlockX, topLeftBlockY-1, shapeType)):
				nextGravity = Time.time + gravityRate
				transform.Translate(0,-gravitySpeed*spawner.blockSize,0, Space.World)
				topLeftBlockY = topLeftBlockY - 1
			else:
				state = false
				for i in range(spawner.shapeBlocksX):
					for j in range(spawner.shapeBlocksY):
						if(spawner.shape[type, shapeType, i, j] == 1):
							spawner.blocks[topLeftBlockX + i, topLeftBlockY - j] = 1
							if(shapeType==0):
								for child as Transform in transform:
									#Debug.Log("child : " + child.position.x + "  " + child.position.y)							  			
									if(Mathf.Round((child.position.x - (topLeftBlockX*spawner.blockSize + 0.5))/spawner.blockSize) == i and Mathf.Round(((topLeftBlockY*spawner.blockSize + 1.5) - child.position.y)/spawner.blockSize) == j+1):	
							  			#Debug.Log("child found: " + child.localPosition.x + "  " + child.localPosition.y)
							  			#Debug.Log("child really found" + (child.position.x - transform.position.x).ToString() + " " + (child.position.y - transform.position.y).ToString())
							  			spawner.spriteOnBlock[topLeftBlockX + i, topLeftBlockY - j] = child.gameObject
							  			break
							  	#Debug.Log("end children")
							elif(shapeType==1):
								for child as Transform in transform:
									#Debug.Log("child : " + child.position.x + "  " + child.position.y)							  			
									if(Mathf.Round((child.position.x - (topLeftBlockX*spawner.blockSize + 0.5))/spawner.blockSize) == i and Mathf.Round(((topLeftBlockY*spawner.blockSize + 1.5) - child.position.y)/spawner.blockSize) == j):	
							  			#Debug.Log("child found: " + child.localPosition.x + "  " + child.localPosition.y)
							  			#Debug.Log("child really found" + (child.position.x - transform.position.x).ToString() + " " + (child.position.y - transform.position.y).ToString())
							  			spawner.spriteOnBlock[topLeftBlockX + i, topLeftBlockY - j] = child.gameObject
							  			break
							elif(shapeType==2):
								for child as Transform in transform:
									#Debug.Log("child : " + child.position.x + "  " + child.position.y)							  			
									if(Mathf.Round((child.position.x - (topLeftBlockX*spawner.blockSize + 0.5))/spawner.blockSize) == i-1 and Mathf.Round(((topLeftBlockY*spawner.blockSize + 1.5) - child.position.y)/spawner.blockSize) == j):	
							  			#Debug.Log("child found: " + child.localPosition.x + "  " + child.localPosition.y)
							  			#Debug.Log("child really found" + (child.position.x - transform.position.x).ToString() + " " + (child.position.y - transform.position.y).ToString())
							  			spawner.spriteOnBlock[topLeftBlockX + i, topLeftBlockY - j] = child.gameObject
							  			break
							elif(shapeType==3):
								for child as Transform in transform:
									#Debug.Log("child : " + child.position.x + "  " + child.position.y)							  			
									if(Mathf.Round((child.position.x - (topLeftBlockX*spawner.blockSize + 0.5))/spawner.blockSize) == i-1 and Mathf.Round(((topLeftBlockY*spawner.blockSize + 1.5) - child.position.y)/spawner.blockSize) == j+1):	
							  			#Debug.Log("child found: " + child.localPosition.x + "  " + child.localPosition.y)
							  			#Debug.Log("child really found" + (child.position.x - transform.position.x).ToString() + " " + (child.position.y - transform.position.y).ToString())
							  			spawner.spriteOnBlock[topLeftBlockX + i, topLeftBlockY - j] = child.gameObject
							  			break
							  	
				spawner.CheckRows()
				if(topLeftBlockY==21):
					Debug.Log("Game ended")
					if(spawner.score > PlayerPrefs.GetInt("highScore-4", 0)):
						isHighScore = true
					else:
						isNotHighScore = true						
						timeStarted = Time.time
				else:
					spawner.Spawn()
		if(Input.GetButton("Rotate") and Time.time>nextRotate and CanMove(topLeftBlockX, topLeftBlockY, (shapeType+1)%4) and state):
			nextRotate = Time.time + rotateRate
			transform.Rotate(0, 0, 90)
			shapeType = (shapeType+1)%4
	def OnGUI():
		if(isHighScore):
			textureFont as GUIStyle = GUIStyle()
			backTexture = Texture2D(128, 128) as Texture2D
			for i in range(128):
				for j in range(128):
					backTexture.SetPixel(i, j, Color.gray)
			backTexture.Apply()
			textureFont.normal.background = backTexture
			textureFont.fontSize = 30
			textureFont.normal.textColor = Color.red
			
			GUI.Box(Rect(100, 200, 250, 150), "")
			font as GUIStyle = GUIStyle()
			font.fontSize = 30
			font.normal.textColor = Color.red			
			
			GUI.Label(Rect(110, 220, 200, 40), "High Score!", font)
			playerName = GUI.TextField(Rect(110,300,170,40), playerName, textureFont)			
			if(GUI.Button(Rect(290, 300, 40, 40), "Go")):										
				highScores as (int) = (0, 0, 0, 0, 0)
				highScoreNames as List = ["", "", "", "", ""]					
				pos as int = -1
				for i in range(0,5):
					highScores[i] = PlayerPrefs.GetInt("highScore-" + i.ToString(), 0)
					highScoreNames[i] = PlayerPrefs.GetString("highScoreName-" + i.ToString(), "")						
					if(highScores[i] < spawner.score):
						pos = i
						break
				Debug.Log("pos : " + pos.ToString())
				for i in range(4, pos, -1):
					highScores[i] = highScores[i-1]							
					highScoreNames[i] = highScoreNames[i-1]
				highScores[pos] = spawner.score
				highScoreNames[pos] = playerName
				for i in range(0,5):
					PlayerPrefs.SetInt("highScore-" + i.ToString(), highScores[i])
					PlayerPrefs.SetString("highScoreName-" + i.ToString(), highScoreNames[i])	
				Application.LoadLevel("HighScore")				
		if(isNotHighScore):
			GUI.Box(Rect(40, 200, 250, 150), "")
			font2 as GUIStyle = GUIStyle()
			font2.fontSize = 30
			font2.normal.textColor = Color.red			
			GUI.Label(Rect(50, 220, 200, 40), "Game Over!\nPlease Wait ...", font2)