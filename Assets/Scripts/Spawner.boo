import UnityEngine

class Spawner (MonoBehaviour): 

	public blockSize as double = 0.8
	
	public numBlocksX as int = 10
	public numBlocksY as int = 20
	public shapeBlocksX as int = 4
	public shapeBlocksY as int = 4
	public numTetrominoes as int = 7
	public numShapes as int = 4	
	
	public blocks = matrix(int, numBlocksX+2, numBlocksY+2)	
	public shape = matrix(int, numTetrominoes, numShapes, shapeBlocksX, shapeBlocksY)		
	public spriteOnBlock = matrix(GameObject, numBlocksX+2, numBlocksY+2)

	public score as int = 0
	public rowFullPoints as int = 100
	public nextType as int = 0
	public nextTetrominoe as SpriteRenderer

	public showPause as bool = false
	def Start ():
		Time.timeScale = 1.0
		for x in range(numBlocksX+2):
			blocks[x, 0] = 1
			blocks[x, numBlocksY+1] = 1
		for y in range(numBlocksY+2):
			blocks[0, y] = 1
			blocks[numBlocksX+1, y] = 1	
		
		shape[0, 0, 0, 1] = 1
		shape[0, 0, 1, 1] = 1
		shape[0, 0, 2, 1] = 1
		shape[0, 0, 3, 1] = 1
		
		shape[0, 1, 1, 0] = 1
		shape[0, 1, 1, 1] = 1
		shape[0, 1, 1, 2] = 1
		shape[0, 1, 1, 3] = 1
		
		shape[0, 2, 0, 2] = 1
		shape[0, 2, 1, 2] = 1
		shape[0, 2, 2, 2] = 1
		shape[0, 2, 3, 2] = 1
		
		shape[0, 3, 2, 0] = 1
		shape[0, 3, 2, 1] = 1
		shape[0, 3, 2, 2] = 1
		shape[0, 3, 2, 3] = 1
		
		
		
		shape[1, 0, 1, 1] = 1
		shape[1, 0, 1, 2] = 1
		shape[1, 0, 2, 2] = 1
		shape[1, 0, 3, 2] = 1
		
		shape[1, 1, 2, 0] = 1
		shape[1, 1, 2, 1] = 1
		shape[1, 1, 2, 2] = 1
		shape[1, 1, 1, 2] = 1
		
		shape[1, 2, 0, 1] = 1
		shape[1, 2, 1, 1] = 1
		shape[1, 2, 2, 1] = 1
		shape[1, 2, 2, 2] = 1
		
		shape[1, 3, 1, 1] = 1
		shape[1, 3, 1, 2] = 1
		shape[1, 3, 1, 3] = 1
		shape[1, 3, 2, 1] = 1
		
		
		
		shape[2, 0, 0, 2] = 1
		shape[2, 0, 1, 2] = 1
		shape[2, 0, 2, 2] = 1
		shape[2, 0, 2, 1] = 1
		
		shape[2, 1, 2, 1] = 1
		shape[2, 1, 2, 2] = 1
		shape[2, 1, 2, 3] = 1
		shape[2, 1, 1, 1] = 1
		
		shape[2, 2, 1, 1] = 1
		shape[2, 2, 2, 1] = 1
		shape[2, 2, 3, 1] = 1
		shape[2, 2, 1, 2] = 1
		
		shape[2, 3, 1, 0] = 1
		shape[2, 3, 1, 1] = 1
		shape[2, 3, 1, 2] = 1
		shape[2, 3, 2, 2] = 1
		
		
		
		shape[3, 0, 1, 1] = 1
		shape[3, 0, 2, 2] = 1
		shape[3, 0, 1, 2] = 1
		shape[3, 0, 2, 1] = 1
		
		shape[3, 1, 1, 1] = 1
		shape[3, 1, 2, 2] = 1
		shape[3, 1, 1, 2] = 1
		shape[3, 1, 2, 1] = 1
		
		shape[3, 2, 1, 1] = 1
		shape[3, 2, 2, 2] = 1
		shape[3, 2, 1, 2] = 1
		shape[3, 2, 2, 1] = 1
		
		shape[3, 3, 1, 1] = 1
		shape[3, 3, 2, 2] = 1
		shape[3, 3, 1, 2] = 1
		shape[3, 3, 2, 1] = 1
		
		
		
		shape[4, 0, 1, 2] = 1
		shape[4, 0, 2, 2] = 1
		shape[4, 0, 2, 1] = 1
		shape[4, 0, 3, 1] = 1
		
		shape[4, 1, 1, 0] = 1
		shape[4, 1, 1, 1] = 1
		shape[4, 1, 2, 1] = 1
		shape[4, 1, 2, 2] = 1
		
		shape[4, 2, 1, 1] = 1
		shape[4, 2, 2, 1] = 1
		shape[4, 2, 1, 2] = 1
		shape[4, 2, 0, 2] = 1
		
		shape[4, 3, 1, 1] = 1
		shape[4, 3, 1, 2] = 1
		shape[4, 3, 2, 2] = 1
		shape[4, 3, 2, 3] = 1
		
		
		
		shape[5, 0, 1, 2] = 1
		shape[5, 0, 2, 2] = 1
		shape[5, 0, 3, 2] = 1
		shape[5, 0, 2, 1] = 1
		
		shape[5, 1, 2, 0] = 1
		shape[5, 1, 2, 1] = 1
		shape[5, 1, 2, 2] = 1
		shape[5, 1, 1, 1] = 1
		
		shape[5, 2, 0, 1] = 1
		shape[5, 2, 1, 1] = 1
		shape[5, 2, 2, 1] = 1
		shape[5, 2, 1, 2] = 1
		
		shape[5, 3, 1, 1] = 1
		shape[5, 3, 1, 2] = 1
		shape[5, 3, 1, 3] = 1
		shape[5, 3, 2, 2] = 1
		
		
		
		shape[6, 0, 1, 1] = 1
		shape[6, 0, 2, 1] = 1
		shape[6, 0, 2, 2] = 1
		shape[6, 0, 3, 2] = 1
		
		shape[6, 1, 2, 0] = 1
		shape[6, 1, 2, 1] = 1
		shape[6, 1, 1, 1] = 1
		shape[6, 1, 1, 2] = 1
		
		shape[6, 2, 0, 1] = 1
		shape[6, 2, 1, 1] = 1
		shape[6, 2, 1, 2] = 1
		shape[6, 2, 2, 2] = 1
		
		shape[6, 3, 2, 1] = 1
		shape[6, 3, 2, 2] = 1
		shape[6, 3, 1, 2] = 1
		shape[6, 3, 1, 3] = 1		
		
		type = Random.RandomRange(0, numTetrominoes)
		#type = Random.RandomRange(0, 7)
		tetrominoe = Instantiate(Resources.Load("tetrominoe_" + type)) as GameObject
		tetrominoeScript = tetrominoe.GetComponent("Tetromino") as Tetromino
		tetrominoeScript.type = type
				
		nextType = Random.RandomRange(0, numTetrominoes)
		nextTetrominoe = GameObject.Find("nextTetrominoe").GetComponent("SpriteRenderer")	
		nextTetrominoe.sprite = Resources.Load("sprites/tetrominoe_sprite_" + nextType.ToString(), Sprite)
		
	public def Spawn ():
		#type = Random.RandomRange(0, numTetrominoes)
		#type = Random.RandomRange(0, )
		type = nextType
		temptetrominoe = Instantiate(Resources.Load("tetrominoe_" + type)) as GameObject
		tetrominoeScript = temptetrominoe.GetComponent("Tetromino") as Tetromino
		tetrominoeScript.type = type
		
		nextType = Random.RandomRange(0, numTetrominoes)
		nextTetrominoe.sprite = Resources.Load("sprites/tetrominoe_sprite_" + nextType.ToString(), Sprite)
		
	public def IsRowFull(rowIndex as int):
		for i in range(1, numBlocksX+1):
			if(blocks[i, rowIndex]==0):
				return false
		return true
	
	public def BlocksFall(rowIndex as int):
		for i in range(1, numBlocksX+1):
			blocks[i, rowIndex] = blocks[i, rowIndex + 1]
			Destroy(spriteOnBlock[i, rowIndex])
		for j in range(rowIndex+1, numBlocksY):
			for i in range(1, numBlocksX+1):
				if(blocks[i, j]==1):
					thisBlock = spriteOnBlock[i, j]					
					thisBlock.transform.Translate(0, -blockSize, 0, Space.World)
					spriteOnBlock[i, j-1] = thisBlock
					spriteOnBlock[i, j] = null						
				blocks[i, j] = blocks[i, j+1]
				
	public def CheckRows():
		#Start checking rows from the bottom
		j = 1
		while(j<numBlocksY):			
			#rowIndex = numBlocksY - j
			rowIndex = j
			if(IsRowFull(rowIndex)):
				score = score + rowFullPoints					
				BlocksFall(rowIndex)
			else:
				j = j + 1
		scoreWidgetMesh = GameObject.Find("gameplayScreenScoreText").transform.GetComponent("TextMesh") as TextMesh
		scoreWidgetMesh.text = score.ToString()
				
	def Update ():
		for j in range(1, numBlocksY+1):
			a = ""
			for i in range(1, numBlocksX+1):
				a = a + blocks[i, numBlocksY + 1 - j] + ", "
			#Debug.Log(a)
		Debug.Log("score: " + score)
		if(Input.GetKeyDown(KeyCode.P) or Input.GetKeyDown(KeyCode.Escape)):
			if(showPause):
				showPause = false
				Time.timeScale = 1.0
			else:
				showPause = true
				Time.timeScale = 0.0
		if(Input.GetKeyDown(KeyCode.Q)):
			Application.LoadLevel("Menu")
	
	def OnGUI():
		if(showPause):
			font as GUIStyle = GUIStyle()
			textureFont as GUIStyle = GUIStyle()
			font.fontSize = 15
			font.normal.textColor = Color.red
			backTexture = Texture2D(128, 128) as Texture2D
			for i in range(128):
				for j in range(128):
					backTexture.SetPixel(i, j, Color.black)
			backTexture.Apply()
			textureFont.normal.background = backTexture
			
			GUI.Box(Rect(100, 150, 260, 250), "", textureFont)			
			GUI.Label(Rect(110,180,150,350), "Game Paused. Press P to \nunpause and Q to quit to menu", font)
			
			GUI.Label(Rect(110,230,150,350), "Move Left \t \t \t \t Left Arrow Key", font)
			GUI.Label(Rect(110,250,150,350), "Move Right \t \t \t \t Right Arrow Key", font)
			GUI.Label(Rect(110,270,150,350), "Accelerate Down \t Down Arrow Key", font)
			GUI.Label(Rect(110,290,150,350), "Rotate	\t \t \t \t	Enter", font)