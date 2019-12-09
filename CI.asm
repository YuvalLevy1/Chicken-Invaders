	;author: yuval levy
	ideal
	model small
	stack 100h
	dataseg
		filename db 'fss.bmp', 0 ; the bmp file name
		filehandle dw ?
		header db 54 dup (0)     ;the bmp header
		palette db 256*4 dup (0) ;the bmp's palette.
		scrline db 320 dup (0)
		errormsg db 'error', 13, 10,'$' ;the error message.
		
		
		gamemode db ? ;saving the current game mode, 1 for singleplayer, 3 to shut down the game because the user lost.
		winner db 0 ;win variable . when equals 1 the user won the game.
		
		
		hero db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,0,0,247,247,247,247,247,0,0,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,247,0,247,247,247,247,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,247,247,247,4,4,4,4,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,247,247,247,4,4,4,4,4,4,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,247,4,4,4,4,247,9,252,4,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,4,4,4,4,9,247,9,4,4,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,247,246,9,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,247,255,9,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,247,246,9,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,9,247,9,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,247,9,247,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,247,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0
		db 0,0,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,0,0
		db 0,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,0,0
		db 0,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,0
		db 0,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,0,247,247,247,247,247,247,0,0,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,247,0
		db 0,247,247,247,247,0,0,0,0,247,247,247,247,247,247,0,0,0,0,0,247,247,247,247,247,0,0,0,0,247,247,247,247,247,0,0,0,0,0,0,247,247,247,247,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ;hero charecter
		heroupdatedlocation dw 52616 ;the current location of the hero 
		herolastlocation dw 52616 ;the previous location of the hero 
		herobackgroundlocation dw 0  ;the location for the hero's backgroud
		printedhitboxforheros db 37, 45   ;the hitbox for the hero
		heroBordersBoolean db 0	 ;a boolean variable for the borders. when equals 1 the hero is trying to leave the borders. when equals 0 the hero is in the borders.
		heroHp db 3 ;the hp for the hero.
		
		
		heroLasersBooleans db 0, 0, 0, 0, 0 ;the boolean variables for the lasers.
		heroLasersLocations dw 50397, 50397, 50397, 50397, 50397 ;the location of each laser.
		Laser db 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4 ;the laser
		LaserHitBox db 6, 3 ;the laser's hitbox
		laserX dw 0,0,0,0,0	;the x value for each laser.
		
		
		chickenMap db 1,1,1,1,1,1,1,1,1 ;shows which chicken is alive and which is dead.
		LivingChickens db 9	;counting the amount of living chickens.
		chickenHitBox db 37, 56			;the hitbox for enemies
		chickensLocations dw 0, 65, 130, 195, 260, 12832, 12895, 12962, 13027 ;the location for each chicken.
		chickenHp db 3, 3, 3, 3, 3, 3, 3, 3, 3 ;arrays that hold the chickens' hp
		amountOfChickens dw 9 ;the amount of chickens on each level.
		PinkEnemy db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,249,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,249,249,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,249,249,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,248,249,249,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,247,7,247,7,7,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,248,8,0,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,246,247,248,246,248,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,248,246,246,248,247,247,247,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,251,251,249,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,251,251,251,251,3,1,1,1,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,251,251,3,3,3,1,1,1,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,248,7,249,3,3,3,3,3,3,1,1,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,248,248,0,0,0
		db 0,255,255,255,255,255,255,246,246,7,247,247,0,0,0,0,0,0,0,0,0,0,247,246,3,3,3,3,3,3,1,1,3,248,0,0,0,0,0,0,0,0,0,0,248,247,7,246,255,255,255,255,246,246,7,0
		db 0,247,8,246,255,255,255,255,255,246,246,246,246,8,7,248,248,0,0,0,0,0,248,255,246,3,3,3,1,1,1,3,248,248,0,0,0,0,0,248,248,7,246,255,255,255,255,255,255,255,246,246,7,247,247,0
		db 0,0,0,247,7,8,246,246,246,246,246,246,246,246,246,246,246,8,7,248,248,0,248,255,255,8,248,3,1,3,248,248,248,248,0,248,247,7,255,255,255,255,255,255,255,255,246,246,246,7,7,247,247,0,0,0
		db 0,0,247,246,255,246,7,7,8,8,8,246,246,246,246,246,246,246,246,8,8,7,247,246,246,246,246,7,249,248,248,248,248,7,255,255,255,255,255,255,255,255,255,246,246,8,7,7,247,247,247,7,247,0,0,0
		db 0,0,247,255,255,255,255,246,7,7,247,7,7,7,7,8,8,8,8,8,8,8,7,8,246,8,7,247,249,248,248,248,247,255,255,255,255,255,255,246,246,8,8,7,7,247,247,247,7,8,8,7,247,247,0,0
		db 0,0,0,0,247,8,246,246,255,255,246,7,7,247,247,247,247,7,7,7,7,7,7,7,7,7,7,247,249,248,248,248,246,255,246,246,8,8,7,7,247,247,247,247,247,7,8,8,7,7,247,247,0,0,0,0
		db 0,0,0,0,0,0,246,8,7,7,8,8,246,246,8,7,7,247,247,247,247,247,248,248,247,247,247,248,1,248,248,248,247,7,247,247,247,247,247,7,7,7,7,7,7,7,247,247,247,247,247,0,0,0,0,0
		db 0,0,0,0,0,0,8,255,255,246,8,7,7,247,247,247,247,247,247,247,247,247,247,253,253,253,253,248,253,253,253,253,253,247,7,7,7,7,7,247,247,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,247,247,7,8,8,246,246,8,8,7,7,7,247,247,247,253,253,253,253,253,253,253,253,253,253,253,253,247,7,7,7,7,247,7,7,7,247,247,247,247,247,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,246,246,246,8,8,7,7,7,7,7,7,253,253,253,253,253,253,253,253,253,253,253,253,253,253,248,7,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,247,247,7,7,247,247,247,247,7,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,247,247,247,247,247,247,247,247,247,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,1,0,0,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,0,1,3,3,3,1,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,1,3,3,3,1,1,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,3,249,251,249,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,3,3,3,248,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,249,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,1,3,3,3,3,1,3,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,3,251,251,251,249,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,3,3,253,253,253,253,253,253,253,253,253,253,253,253,253,253,253,248,249,3,1,3,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,0,0,0,253,253,253,253,253,253,253,253,253,253,253,253,0,0,3,251,3,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,0,0,0,0,0,253,253,253,253,253,253,253,253,253,253,0,0,0,0,3,251,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,253,253,253,0,0,0,0,0,0,0,0,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ;pink chicken

		
		eggMap db 0,1,2,3,4,5,6,7,8 ;shows which egg belongs to which chicken
		eggsStartLocations dw 11861,11926,11991,12056,12121,24693,24756,24823,24888 ;chickenLocation + 320*37+21
		eggsUpdateLocations dw 11861,11926,11991,12056,12121,24693,24756,24823,24888  ;the egg's updated location.
		eggsBooleans db 0,0,0,0,0,0,0,0,0 ;the eggs' boolean variables
		eggsCounter db 0 ;counting the amount of egg on screen.
		eggHitBox db 10, 7 ;egg's hitbox
		enemyEgg db 0,0,0,0,0,0,0
				 db 0,0,6,6,6,0,0
				 db 0,6,5,5,5,6,0
				 db 6,5,5,5,5,5,6
				 db 6,5,6,5,6,5,6
				 db 6,5,5,5,5,5,6
				 db 6,5,6,5,5,5,6
				 db 6,5,5,5,6,5,6
				 db 0,6,5,5,5,6,0
				 db 0,0,6,6,6,0,0 ;enemy egg
		
		
	codeseg

	proc openfile
	; open file
		push bp
		mov bp, sp
		push ax
		push dx
		
		mov ah, 3dh
		xor al, al
		mov dx, [bp+4]	;offset filename
		int 21h
		mov [bp+6], ax 	;[filehandle]
		
		pop dx
		pop ax
		pop bp
		ret
	endp openfile
	

	proc readheader
	; read bmp file header, 54 bytes
		
		mov ah, 3fh
		mov bx, [filehandle]
		mov cx, 54
		mov dx, offset header
		int 21h
		ret
	endp readheader
	
	proc readpalette
	; read bmp file color palette, 256 colors * 4 bytes (400h)
		push bp
		mov bp, sp
		push ax
		push cx
		push dx
		
		mov ah, 3fh
		mov cx, 400h
		mov dx, [bp+4]	;offset palette
		int 21h
		
		pop dx
		pop cx
		pop ax
		pop bp
		ret
	endp readpalette
	

	proc copypal
	; copy the colors palette to the video memory
	; the number of the first color should be sent to port 3c8h
	; the palette is sent to port 3c9h
		push bp
		mov bp, sp
		push ax
		push cx
		push dx
		push si
		
		mov si, [bp+4]	;offset palette
		mov cx, 256
		mov dx, 3c8h
		mov al, 0
		; copy starting color to port 3c8h
		out dx, al
		; copy palette itself to port 3c9h
		inc dx
		palloop:
			; note: colors in a bmp file are saved as bgr values rather than rgb.
			mov al, [si+2] ; get red value.
			shr al, 2 ; max. is 255, but video palette maximal
			; value is 63. therefore dividing by 4.
			out dx, al ; send it.
			mov al, [si+1] ; get green value.
			shr al, 2
			out dx, al ; send it.
			mov al, [si] ; get blue value.
			shr al, 2
			out dx, al ; send it.
			add si, 4 ; point to next color.
			; (there is a null chr. after every color.)
		loop palloop
		
		pop si
		pop dx
		pop cx
		pop ax
		pop bp
		ret
	endp copypal
	

	proc copybitmap
	; bmp graphics are saved upside-down.
	; read the graphic line by line (200 lines in vga format),
	; displaying the lines from bottom to top.
		push bp
		mov bp, sp
		push ax
		push cx
		push dx
		push di
		push si
		
		mov ax, 0a000h
		mov es, ax
		mov cx,200
		printbmploop:
			push cx
			; di = cx * 320, point to the correct screen line
			mov di,cx
			shl cx,6
			shl di,8
			add di,cx
			; read one line
			mov ah,3fh
			mov cx,320
			mov dx,	[bp+4]	;offset scrline
			int 21h
			; copy one line into video memory
			cld ; clear direction flag, for movsb
			mov cx,320
			mov si,	[bp+4]		;offset scrline 
			rep movsb ; copy line to the screen
			 ;rep movsb is same as the following code:
			 ;mov es:di, ds:si
			 ;inc si
			 ;inc di
			 ;dec cx
			;loop until cx=0
			pop cx
		loop printbmploop
		
		pop si
		pop di
		pop dx
		pop cx
		pop ax
		pop bp
		ret 
	endp copybitmap
	
	
	;-------------------------------;+
	proc clear 					 	;+
	;input: none					;+
	;output: none					;+
	;purpose: clearing everything 	;+
	;on the whole screen			;+
	push bp							;+		
	mov bp, sp						;+		
	push ax di 						;+
	;								;+
		mov di ,64002				;+
		mov ax, 0					;+
	lop:							;+
		sub di, 2					;+			
		mov [es:di], ax				;+
		cmp di,65534				;+
		jnz lop						;+
	;								;+	
	pop di ax bp					;+
	ret								;+
	endp clear						;+
	;-------------------------------;+
	
		
	;-------------------------------;+
	proc clearAfterHero				;+
	;input:none						;+
	;output:none					;+
	;purpose: clearing the bottom 	;+
	;part of the screen.			;+
	push bp							;+		
	mov bp,sp						;+		
	push ax di						;+
	;								;+
		mov di,64000				;+
		xor ax, ax					;+
	lop1:							;+
		sub di,2					;+
		mov [es:di],ax				;+
		cmp di, 48000				;+
		jnz lop1					;+
	;								;+	
	pop di ax bp					;+
	ret								;+
	endp clearAfterHero				;+
	;-------------------------------;+


	;-------------------------------;+
	proc clearMidScreen				;+
	;input:none						;+
	;output:none					;+
	;purpose: clearing the bottom 	;+
	;part of the screen.			;+
	push bp							;+		
	mov bp,sp						;+		
	push ax di						;+
	;								;+
		mov di,48000				;+
		xor ax, ax					;+
	lop2:							;+
		sub di,2					;+
		mov [es:di],ax				;+
		cmp di, 25242				;+
		jnz lop2					;+
	;								;+	
	pop di ax bp					;+
	ret								;+
	endp clearMidScreen				;+
	;-------------------------------;+
	
	
	;-------------------------------------;+
	proc bmpprocess						  ;+
	;input: none						  ;+
	;output: none						  ;+
	;purpose: printing the wanted bmp file;+
	push bp								  ;+
	mov bp, sp						      ;+
	push ax cx							  ;+	
	;									  ;+
		mov ax, 13h						  ;+
		int 10h						      ;+
		mov cx, offset filename		      ;+
		push [filehandle]			      ;+					
		push cx						      ;+
		call openfile				      ;+
		pop cx						      ;+
		pop [filehandle]	              ;+
		call readheader			     	  ;+
		mov cx, offset palette			  ;+
		push cx						      ;+
		call readpalette			      ;+
		call copypal		         	  ;+
		pop cx						      ;+
		mov cx, offset scrline		      ;+
		push cx						      ;+
		call copybitmap				      ;+
	;                                     ;+
	pop cx cx ax bp				          ;+
	ret							          ;+
	endp bmpprocess				          ;+
	;-------------------------------------;+
	
	
	;---------------------------------------------------------------------------------------------------------------;+
	; input: numberOfChickens, offset chickensLocations, offset chickenHp, offset pinkEnemy, offset chickenHitBox.  ;+
	; output: none																								    ;+
	;purpose: this proce prints all of the living chickens in their locations.										;+
	proc spawnLivingChickens			  																			;+
	push bp																											;+
	mov bp, sp 																										;+
	numberOfChickens equ [bp+12]																					;+
	offset_chickensLocations equ [bp+10] 																			;+
	offset_chickenHp equ [bp+8]																						;+
	offset_Enemy equ [bp+6]																							;+
	offset_ChickenHitbox equ [bp+4]																					;+
	push ax cx bx si di dx																							;+
    ;                                                                                                               ;+
		mov cx, numberOfChickens																					;+
		inc cx																										;+
		mov bx, offset_chickensLocations																			;+
		sub bx, 2																									;+
		mov di, offset_chickenHp																					;+
		sub di, 1																									;+
		xor dx, dx																									;+
		spawnChicken:	;checks if there are more chickens to spawn.												;+
		dec cx																										;+
		cmp cx, 0																									;+
		jz stopSpawning																								;+
		add bx, 2																									;+
		add di, 1																									;+
		mov dl, [di]	;checks if the chicken is dead, if the chicken is dead moves to the next one.				;+
		cmp dl, 0																									;+	
		jz spawnChicken																								;+
		cmp dl, 3																									;+
		ja resetChickenHp																							;+
		mov si, [bx]																								;+
		mov ax, offset_Enemy																						;+
		push ax																										;+
		mov ax, si						;prints the chicken.														;+
		jmp dontResetChickenHp																						;+
		resetChickenHp:																								;+
		mov [byte ptr di], 0																						;+
		jmp spawnChicken																							;+
		dontResetChickenHp:																							;+
		push ax																										;+
		mov ax, offset_ChickenHitbox    																			;+
		push ax																										;+
		call printbyhitbox																							;+	
		cmp cx, 0																									;+
		jnz spawnChicken																							;+		
		stopSpawning:																								;+
	;																												;+
	pop dx di si bx cx ax bp																						;+
	ret 10																											;+
	endP spawnLivingChickens																						;+
	;---------------------------------------------------------------------------------------------------------------;+
	
	
	;-----------------------------------------------;+
	proc delay 										;+
	;input: none									;+
	;output: none									;+
	;purpose: the procedure creates a small delay.	;+
		push bp										;+
		mov bp,sp									;+
		push ax bx cx dx							;+
		;											;+
		dlop:										;+
			xor dx,dx								;+
			inc cx									;+
			cmp cx,0100h							;+
			jz pend									;+
		inflop:										;+
			mov ax,bx								;+
			mov bx,ax								;+
			inc dx									;+
			cmp dx,0200h							;+
			jnz inflop								;+
			jmp dlop								;+
		pend:										;+
		;											;+
		pop dx cx bx ax bp							;+
		ret 										;+
	endp delay										;+
	;-----------------------------------------------;+
	
	
	;-----------------------------------------------;+
	proc EndGamedelay 								;+
	;input: none									;+
	;output: none									;+
	;purpose: the procedure creates a small delay.	;+
		push bp										;+
		mov bp,sp									;+
		push ax bx cx dx							;+
		;											;+
		dlop3:										;+
			xor dx,dx								;+
			inc cx									;+
			cmp cx,1500h							;+
			jz pend3								;+
		inflop3:									;+
			mov ax,bx								;+
			mov bx,ax								;+
			inc dx									;+
			cmp dx,0500h							;+
			jnz inflop3								;+
			jmp dlop3								;+
		pend3:										;+
		;											;+
		pop dx cx bx ax bp							;+
		ret 										;+
	endp EndGamedelay								;+
	;-----------------------------------------------;+


	;-----------------------------------------------;+
	proc SmallDelay 								;+
	;input: none									;+
	;output: none									;+
	;purpose: the procedure creates a small delay.	;+
		push bp										;+
		mov bp,sp									;+
		push ax bx cx dx							;+
		;											;+
		dlop1:										;+
			xor dx,dx								;+
			inc cx									;+
			cmp cx,0100h							;+
			jz pend1								;+
		inflop1:									;+
			mov ax,bx								;+
			mov bx,ax								;+
			inc dx									;+
			cmp dx,0150h							;+
			jnz inflop1								;+
			jmp dlop1								;+
		pend1:										;+
		;											;+
		pop dx cx bx ax bp							;+
		ret 										;+
	endp SmallDelay									;+
	;-----------------------------------------------;+

	
	;--------------------------------------------------------------------------------------------------------------------;+
	proc borders																										 ;+
	;input: offset heroLocation, offset heroBordersBoolean																 ;+
	;output: none																										 ;+
	;purpose: the procedure prevents the hero from crossing the border.													 ;+
	push bp																											   	 ;+
	mov bp, sp																											 ;+
	offset_heroLocation equ [bp+6]																						 ;+
	offset_heroBoolean equ [bp+4]																						 ;+
	push bx dx ax si di  																								 ;+
	;																													 ;+
		xor dx, dx																										 ;+
		mov si, offset_heroLocation 																					 ;+
		mov di, offset_heroBoolean ;checks if the location can be devided by the screen width with no remnant.			 ;+
		mov ax, [si]			   ;if there is no remnant the hero is crossing the border.								 ;+
		mov bx,320																										 ;+
		div bx																											 ;+
		cmp dx,0																										 ;+
		jnz InLeftBorder																								 ;+
		mov [byte ptr di], 1																							 ;+
		InLeftBorder:																									 ;+
		xor dx, dx																										 ;+
		mov ax, [si] ;checks if the location + 45 (the hero's width) can be devided by the screen width with no remnant. ;+
		add ax, 44	 ;if there is no remnant the hero is crossing the border											 ;+
		mov bx,320																										 ;+
		div bx																											 ;+
		cmp	 dx,0																										 ;+
		jnz InRightBorder																								 ;+
		mov [byte ptr di], 1																							 ;+
		InRightBorder:																									 ;+
	;																													 ;+
	pop di si ax dx bx bp																								 ;+
	ret 4																												 ;+
	endp borders																										 ;+
	;--------------------------------------------------------------------------------------------------------------------;+
	
	
	;-----------------------------------------------------------------------------------------------;+
	proc printbyhitbox																				;+
	;input: offset object hitbox, offset object, object's location.									;+
	;output: none																					;+
	;purpose: prints objects on the screen. 														;+
	push bp																							;+
	mov bp, sp																						;+
	offset_hitBox equ [bp+4]																		;+
	offset_object equ [bp+8]																		;+
	location equ [bp+6]																				;+
	push cx bx ax di dx si																			;+
	;																								;+
		mov bx,offset_hitBox																		;+
		mov cl, [bx+1]          ;object's width														;+
		mov ch, [bx]			;objet's length														;+
		mov dl, cl																					;+
		mov dh, 0				 																	;+
		mov si, 320				;calculating the amount  needed to move.							;+
		sub si, dx				;from the end of one object's line to the start of the other.		;+
		mov di, location 																			;+
		mov bx, offset_object																		;+
		printWidth:																					;+
		mov al, [bx]		;checking if the color is black.										;+
		cmp al, 0 			;if the color is black it doesn't print it.								;+
		jz skipBlack																				;+
		mov [es:di], al																				;+
		skipBlack:																					;+
		inc bx																						;+
		inc di																						;+
		dec cl				;prints the object.														;+
		cmp cl, 0																					;+
		jnz printWidth																				;+
		mov cl, dl																					;+
		dec ch																						;+
		add di, si																					;+
		cmp ch, 0																					;+
		jnz printWidth																				;+
	;																								;+	
	pop si dx di ax bx cx bp																		;+
	ret 6																							;+
	endp printbyhitbox																				;+
	;-----------------------------------------------------------------------------------------------;+
	
	
	;---------------------------------------------------------------;+
	proc UpdateLasersBooleans										;+
	;input: offset heroLasersBooleans								;+
	;output: none													;+
	;purpose: updates the first boolean variable that equals 0.		;+
	push bp															;+
	mov bp, sp														;+
	offset_heroBoolean equ [bp+8]									;+
	offset_laserX equ[bp+6]											;+
	heroLocation equ [bp+4]											;+
	push dx bx ax cx												;+
	;																;+
		mov cx, 1													;+
		xor ax, ax													;+
		mov bx, offset_heroBoolean									;+
		mov dx, offset_laserX										;+
		checkBooleans:												;+
		mov al, [bx]												;+
		cmp al, 0		;checks if the current variable equals 0	;+
		jnz dontUpdate	;if he equals 0 update to one and exit proc	;+
		push dx														;+
		mov dx, heroLocation										;+
		push dx														;+
		call calcLaserX												;+
		mov [byte ptr bx], 1 ;if not, continue to the next variable	;+
		jmp stopUpdating											;+
		dontUpdate:													;+
		inc bx														;+
		inc dx														;+
		dec cx														;+
		cmp cx, 0													;+
		jnz checkBooleans											;+
		stopUpdating:												;+
	;																;+	
	pop cx ax bx dx bp												;+
	ret 6															;+
	endp UpdateLasersBooleans										;+
	;---------------------------------------------------------------;+
	
	
	;-----------------------------------------------------------;+
	;input:none													;+
	;outPut:none												;+
	;the proc is cleaning the hero.								;+
	proc clearHero												;+
	push bp 													;+
	mov bp, sp													;+
heroLocation equ [offset herolastlocation]						;+
offset_heroHitBox equ offset printedhitboxforheros				;+
	push ax														;+
	mov ax, heroLocation										;+	
	push ax														;+
	mov ax, offset_heroHitBox									;+
	push ax														;+
	call deleteObject											;+
	pop ax bp													;+			
	ret 														;+		
	endp clearHero												;+
	;-----------------------------------------------------------;+
	
	
	;-----------------------------------------------------------;+
	proc WinnerWinnerChickenDinner								;+
	;input: offset_winner, offset_ChickenHp, 					;+
	; offset_AmountOfLivingChickens 							;+
	;output:none												;+
	;purpose: the proc counts the amount of living chickens and ;+
	;checks if the user won.                                    ;+
	push bp														;+
	mov bp, sp													;+
offset_winner equ [bp+8]										;+
offset_ChickenHp equ [bp+6]										;+
offset_AmountOfLivingChickens equ [bp+4] 						;+
	push ax bx si cx dx											;+
	;															;+
	mov si, offset_ChickenHp									;+
	mov bx, offset_winner										;+	
	xor cx, cx													;+
	xor dx, dx													;+
	;															;+
	checkHPLoop:												;+
			cmp [byte ptr si], 0 ;checks if the chicken is dead	;+
			jz dontCount										;+
			inc dl	;counting									;+
			dontCount:											;+
			inc si												;+
			inc cx												;+
			cmp cx, 9											;+
			jnz checkHPLoop										;+
			cmp dl, 0	;checking if the user won the game		;+
			jnz didntWin										;+
			mov bx, offset_winner								;+	
			mov [byte ptr bx], 1								;+
	didntWin:													;+
			mov si, offset_AmountOfLivingChickens				;+
			mov [byte ptr si], dl								;+
	pop dx cx si bx ax bp										;+
	ret	6														;+
	endp WinnerWinnerChickenDinner								;+
	;-----------------------------------------------------------;+
	
	;-----------------------------------------------------------;+
	proc UpdateLasersLocations									;+
	;input: offset heroBoolean, offset heroLocation				;+
	;output:none												;+
	;purpose: changes the Lasers Locations according to the 	;+
	;user's input.												;+
	push bp														;+
	mov bp, sp													;+
	offset_heroBoolean equ [bp+8]								;+
	offset_heroLaserLocation equ [bp+6]							;+
	newLaserLocation equ [bp+4]									;+
	push bx si ax cx dx											;+
	;															;+
		mov bx, offset_heroBoolean								;+
		mov si, offset_heroLaserLocation						;+
		mov cx, 5												;+
		mov dx, newLaserLocation								;+
		xor ax, ax												;+
		locationUpdater: ;check if the boolean equals 1,		;+
		mov al, [bx]	;if not updates the location.			;+
		cmp al, 0												;+
		jnz dontUpdateLoc										;+
		mov [si], dx											;+
		dontUpdateLoc:											;+
		inc bx													;+
		add si, 2												;+
		dec cx													;+
		cmp cx, 0												;+
		jnz locationUpdater										;+
	;															;+
	pop dx cx ax si bx bp										;+	
	ret 6														;+
	endp UpdateLasersLocations									;+
	;-----------------------------------------------------------;+	
	
	
	;-----------------------------------------------------------;+
	proc shoot													;+
	;input: offset_LasersLocations, offset_LasersBooleans,		;+
	;offset_Laser, offset_LaserHitBox, heroLocation				;+
	;output:none												;+
	;purpose:the proc moves all of the lasers one pixel up.		;+
	push bp														;+
	mov bp, sp													;+
	offset_eggCounter equ [bp+14]								;+
	offset_LasersLocations equ [bp+10]							;+
	offset_LasersBooleans equ [bp+8]							;+
	offset_Laser equ [bp+6]										;+
	offset_LaserHitBox equ [bp+12]								;+
	heroLocation equ [bp+4]										;+
	push ax bx si cx dx di										;+
	;															;+
		mov dx, 3												;+
		mov si, offset_LasersLocations							;+
		mov bx, offset_LasersBooleans							;+
		dec bx													;+
		sub si, 2												;+
		mov cx, 6												;+
	nextLaser:													;+
		dec cx													;+
		cmp cx, 0 ;checking all of the lasers					;+
		jz stopShooting											;+
		inc bx													;+	
		add si, 2												;+
		cmp [byte ptr bx], 0 ;checking if the hero 				;+
		jz  nextLaser 		 ;fired this laser					;+
			sub [word ptr si], 320	;moving the laser's location;+
			cmp [word ptr si], 320	;one pixel up.				;+
			ja LaserInBorder ;checking if the laser is in the 	;+
				mov di, [si] ;border.							;+
				add di, 320										;+
				push di											;+
				mov ax, offset_LaserHitBox						;+
				push ax											;+
				call deleteObject ;deleting the laser			;+
				mov di, [si]									;+
				add di, 2240									;+
				mov [word ptr es:di], 0							;+
				mov [byte ptr es:di+2], 0						;+
				mov di, [si]									;+
				mov [byte ptr bx], 0							;+			
				mov di, heroLocation							;+
				sub	 di, 1899 ;reseting the lasers location		;+
				mov [si], di									;+
				jmp nextLaser									;+
			LaserInBorder:										;+
				push bx											;+
				mov bx, offset_eggCounter						;+
				cmp [byte ptr bx], 0							;+
				jnz useSmallDelay ;using delay					;+
				call delay										;+
				jmp skipSmallDelay								;+
				useSmallDelay:									;+
				call SmallDelay									;+
				skipSmallDelay:									;+
				pop bx											;+
				mov ax, offset_Laser							;+
				push ax											;+
				mov di, [si] ;printing the laser				;+
				push di											;+	
				mov ax, offset_LaserHitBox						;+
				push ax											;+
				call printbyhitbox		 						;+
				mov di, [si]									;+
				add di, 2240									;+
				mov [word ptr es:di], 0							;+
				mov [byte ptr es:di+2], 0						;+
				jmp nextLaser									;+
	stopShooting:												;+
	;															;+
	pop di dx cx si bx ax bp									;+
	ret 12														;+
	endp shoot													;+
	;-----------------------------------------------------------;+
	
	
	;-------------------------------------------;+
	proc calcLaserX								;+
	;input: heroLocation, offset_laserX		;+
	;output:none								;+
	;purpose:calclating each laser's x value.	;+
	push bp										;+
	mov bp, sp									;+
heroLocation equ [bp+4]							;+
offset_laserX equ [bp+6]						;+
	push bx ax dx								;+
;												;+
	mov bx, offset_laserX						;+
	mov ax, heroLocation						;+
	mov dx, 164*320								;+
	sub ax, dx ;calculating the hero's x value	;+
	add ax, 21 ;								;+
	;laserX = heroLocation - heroY +21			;+ 
	mov [bx], ax								;+
;												;+
	pop dx ax bx bp								;+
	ret 4										;+
	endp calcLaserX								;+
	;-------------------------------------------;+
	
	
	;-------------------------------------------------------------------;+
	proc damageChickens													;+
	;input: heroLocation, offset_laserX, offset_laserLocations			;+
	;offset_lasersBooleans, offset_chickensLocations,offset_ChickenHp	;+
	;output:none														;+
	;purpose:damaging chickens											;+
	 push bp															;+
	 mov bp, sp 														;+
 offset_laserX equ [bp+14]												;+
 offset_laserLocations equ [bp+12]										;+
 offset_lasersBooleans equ [bp+10]										;+	
 offset_chickensLocations equ [bp+8]									;+
 heroLocation equ [bp+6]												;+
 offset_chickenHp equ [bp+4]											;+
	 push ax bx cx si di dx												;+
	;																	;+
		mov si, offset_laserLocations									;+
		mov di, offset_laserX											;+
		sub si, 2														;+
		sub di, 2														;+
		xor dx, dx														;+
		dec dx															;+
		jmp nextDamageLaser												;+
	resetBX:															;+
		pop bx	;reseting bx 											;+
	nextDamageLaser:													;+
		xor cx, cx														;+
		add si, 2														;+
		add di, 2														;+
		inc dx	;checking if the proc checked all of the lasers			;+
		cmp dx, 5														;+
		jnz skipStop													;+	
		jmp stopDamage													;+
	skipStop:															;+
		push bx															;+
		mov bx, offset_lasersBooleans									;+
		add bx, dx		;checking if the user fired the laser			;+
		cmp [byte ptr bx], 0											;+
		jz resetBX														;+
		pop bx															;+
		mov bx, [si]	;checking if the laser is in the upper part		;+
		cmp bx, 30000	;of the screen.									;+
		ja nextDamageLaser												;+
		sub bx, 320														;+
		;																;+
		cmp [byte ptr es:bx], 253										;+
		jnz nextDamageLaser ;checking if the laser hit the chicken.		;+
		;																;+
		push si 														;+
		mov si, offset_chickensLocations								;+
		sub si, 2														;+
		dec cx															;+
	chickenLoop:														;+
		 inc cx															;+
		 cmp bx, 12830 ;checking if the laser hit one of the lower 		;+
		 ja lowerChickenPreparation	;chickens.							;+
		 add si, 2														;+
		 mov ax, [si]	;checking if which chicken the laser hit 		;+
		 add ax, 56														;+
		 cmp [word ptr di], ax											;+
		 ja chickenLoop													;+
	damageChicken:														;+
		 pop si															;+
		 push bx														;+
		 mov bx, offset_chickenHp										;+
		 add bx, cx														;+
		 dec [byte ptr bx]	;damaging the chicken 						;+
		 mov bx, offset_lasersBooleans									;+
		 add bx, dx														;+
		 mov [byte ptr bx], 0 ;turning the laser's boolean off			;+
		 mov di, heroLocation											;+
		 sub di, 1899 ;reseting the location of the laser.				;+
		 mov [si], di													;+
		 pop bx															;+
		 call clear														;+
		 jmp nextDamageLaser											;+
	lowerChickenPreparation:											;+
		add si, 10														;+
		mov cx, 4														;+
	lowerChickenLoop:													;+
		 inc cx															;+
		 add si, 2	 ;moving to the next chicken						;+
		 mov ax, [si]													;+
		 add ax, 56														;+
	calculateLowerX:	 												;+
		 sub ax, 320													;+
		 cmp ax, 320 ;calculation the chicken's x 						;+
		 ja calculateLowerX												;+
		 stopadding:													;+
		 cmp [word ptr di], ax											;+
		 ja lowerChickenLoop ;checking which chicken the laser hit.		;+
		 jmp damageChicken												;+
		;																;+
	 stopDamage:														;+
	 pop dx di si cx bx ax bp											;+
	 ret 12 															;+
	endp damageChickens													;+
	;-------------------------------------------------------------------;+
	
	
	;-----------------------------------------------------------------------------------;+
	proc layRandomEgg																	;+
	push bp																				;+
	mov bp, sp																			;+
offset_eggCounter equ offset eggsCounter												;+
offset_chickenHp equ offset chickenHp													;+
offset_eggBooleans equ offset eggsBooleans 												;+
offset_amountOfLivingChickens equ offset LivingChickens									;+
offset_eggMap equ offset eggMap															;+
offset_chickenMap equ offset chickenMap													;+
	push si di bx cx dx ax																;+
	mov ax, offset_chickenMap															;+
	push ax																				;+
	mov ax, offset_eggMap 																;+
	push ax																				;+
	mov ax, offset_chickenHp															;+
	push ax																				;+
    call updateEggMap	;updating egg map												;+
	mov si, offset_eggCounter															;+
	cmp [byte ptr si], 1																;+
	jnb dontLayEgg																		;+
	; generate a rand no using the system time											;+
	randStart:																			;+
		mov ah, 00h  ; interrupts to get system time        							;+
		int 1ah      ; CX:DX now hold number of clock ticks since midnight      		;+
	;																					;+					
		mov ax, dx																		;+
		mov bx, dx																		;+
		mov dx, [bx]																	;+
		xor ax, dx																		;+
		;																				;+
		xor  dx, dx																		;+
		mov  cx, 9    																	;+
		div  cx       ; here dx contains the remainder of the division - from 0 to 8	;+
		;																				;+
		mov si, offset_chickenHp														;+
		add si, dx																		;+
		cmp [byte ptr si], 0															;+
		jz chickenIsDead ;checking if the chicken is dead								;+
		;																				;+
		cmp [byte ptr si], 3															;+
		ja chickenISDead																;+
		;																				;+
		jmp chickenCanLay																;+
		;																				;+
	chickenIsDead:																		;+
		push si																			;+
		mov si, offset_eggMap															;+
		add si, dx	 ;using egg map to lay random egg if the chicken died.				;+	
		mov dl, [si]																	;+
		mov dh, 0 																		;+
		pop si																			;+
			;																			;+
		chickenCanLay:																	;+
			mov si, offset_eggBooleans													;+
			add si, dx	;checking if the chicken already has an egg on the screen.		;+
			cmp [byte ptr si], 1														;+
			jz randStart																;+
			;																			;+
			mov si, offset_eggBooleans													;+
			add si, dx																	;+
			mov [byte ptr si], 1	 ;laying the egg and adding one to the egg counter. ;+
			mov si, offset_eggCounter													;+
			inc [byte ptr si]															;+
			;																			;+
	dontLayEgg:																			;+
	pop ax dx cx bx di si bp															;+
	ret 12																				;+
	endp layRandomEgg																	;+
	;-----------------------------------------------------------------------------------;+


	;---------------------------------------------------------------;+
	proc updateLivingChickensMap									;+
	;input:offset_ChickenHp, offset_chickenMap						;+
	;output:none													;+
	;purpose:updating chicken map									;+
	push bp															;+
	mov bp, sp														;+
offset_chickensHp equ [bp+6]										;+
offset_chickenMap equ [bp+4]										;+
	push si di dx													;+
	;																;+
	mov di, offset_chickenHp										;+
	mov si, offset_chickenMap										;+
	dec si															;+
	dec di															;+
	xor dx, dx														;+
	chickenMapLoop:													;+
		inc si														;+	
		inc di														;+
		cmp [byte ptr di], 0										;+
		jnz dontUpdateMap	;checking if the chicken died			;+
		mov [byte ptr si], 0;if died move to chicken map 0.			;+
	dontUpdateMap:													;+
		inc dx 														;+
		cmp dx, 9 ;loop that checks all of the chickens.			;+
		jnz chickenMapLoop											;+
		;															;+
	pop dx di si bp													;+
	ret 4															;+
	endp updateLivingChickensMap									;+
	;---------------------------------------------------------------;+
	
	
	;-----------------------------------------------------------------------;+
	proc updateEggMap														;+
	;input:offset_ChickenHp, offset_eggMap, offset_chickenMap.				;+
	;output:none															;+
	;purpose:updating egg map 												;+
	push bp																	;+
	mov bp, sp																;+
offset_chickenMap equ [bp+8]												;+
offset_eggMap equ [bp+6]													;+
offset_chickensHp equ [bp+4]												;+
	push si di ax cx														;+
	;																		;+	
	mov ax, offset_chickenHp												;+
	push ax																	;+
	mov ax, offset_chickenMap												;+
	push ax																	;+
	call updateLivingChickensMap ;updating chicken map						;+
	xor ax, ax																;+				
	mov si, offset_eggMap													;+
	mov di, offset_chickenMap												;+
	dec ax																	;+
	dec di																	;+
	eggMapLoop:																;+
		inc di																;+
		inc al																;+	
		cmp al, 8															;+
		jna skipResetingAx ;checking if the proc checked all of the chickens;+
		xor ax, ax															;+
		dec ax 																;+
		mov di, offset_chickenMap ;reseting the variables					;+
		dec di																;+
		jmp eggMapLoop														;+
		skipResetingAx:														;+
		cmp [byte ptr di], 1	;checking if the chicken is dead			;+
		jnz dontUpdateEggMap												;+
		mov [si], al														;+
		inc si ;if not enter the num of the living chicken to the map		;+
		mov cx, si															;+
		sub cx, offset_eggMap												;+
		cmp cx, 8															;+
		ja stopUpdatingEggMap ;checks if all of the chickens were checked   ;+
		dontUpdateEggMap:													;+
		jmp eggMapLoop														;+
		;																	;+
	stopUpdatingEggMap:														;+
	pop cx ax di si bp 														;+
	ret 6																	;+
	endp updateEggMap 														;+
	;-----------------------------------------------------------------------;+
	
	;-------------------------------------------------------------------;+
	proc moveEgg														;+
	;input: offset_eggsStartLoc, offset_eggsUpdateLoc, offset_egg		;+
	;offset_eggsBooleans, offset_EggHitBox, offset_EggCounter			;+
	;output:none														;+
	;purpose: printing the egg											;+
	push bp																;+
	mov bp, sp															;+	
offset_eggsStartLoc equ [bp+14] 										;+
offset_eggsUpdateLoc equ [bp+12]										;+
offset_eggsBooleans equ [bp+10]											;+
offset_egg equ [bp+8]													;+
offset_EggHitBox equ [bp+6]												;+
offset_EggCounter equ [bp+4]											;+
	;																	;+
	push bx si di ax cx dx												;+
		;																;+
		mov bx, offset_eggsBooleans										;+
		mov si, offset_eggsUpdateLoc									;+
		dec bx															;+
		sub si, 2														;+
		xor cx, cx														;+
		sub cx, 2														;+				
	eggLoop:															;+
		add cx,2	;counting the eggs.									;+
		cmp cx, 18														;+
		jz stopMovingEgg												;+	
		inc bx															;+
		add si, 2														;+	
		cmp [byte ptr bx], 1 ;checking if the chicken laid the egg.		;+	
		jnz eggLoop														;+
		mov dx, [si]													;+
		;																;+
		add dx, 320 * 10 + 320 ;checking if the egg left the screen.	;+
		cmp dx, 64000													;+
		jb eggInBorder													;+
		;																;+
		notInBorder:													;+
			mov [byte ptr bx], 0 ;reseting egg's boolean.				;+
			mov dx, [si] 												;+
			push dx														;+
			mov dx, offset_EggHitBox									;+
			push dx														;+
			call deleteObject	;deleting the egg.						;+
			push si														;+
			mov si, offset_eggCounter ;egg's counter - 1				;+
			dec [byte ptr si] 											;+
			pop si														;+
			push bx														;+
			mov bx, offset_eggsStartLoc									;+
			add bx, cx	;reseting egg's location.						;+
			mov dx, [bx]												;+
			mov [si], dx												;+
			pop bx														;+
			jmp eggLoop													;+
			;															;+
	eggInBorder:														;+
				cmp dx, 11000 ;checking if the egg left the screen.		;+	
				jb notInBorder											;+
				mov ax, [si]											;+
				push ax													;+
				mov ax, offset_EggHitBox								;+
				push ax													;+
				call deleteObject ;deleting the last egg.				;+
				add [word ptr si], 320									;+
				mov ax, offset_egg										;+
				push ax													;+
				mov ax,[si]												;+
				push ax													;+
				mov ax, offset_EggHitBox								;+
				push ax													;+
				call printbyhitbox	;printing the egg					;+
				call Delay												;+
				jmp eggLoop ;moving to the next egg. 					;+
	;																	;+
	stopMovingEgg:														;+
	pop dx cx ax di si bx bp											;+
	ret 12																;+
	endp moveEgg														;+
	;-------------------------------------------------------------------;+
	
	
	;-----------------------------------------------------------------------;+
	proc eggDamage															;+
	;input:offset_eggsStartLoc, offset_eggsUpdateLoc, offset_eggsBooleans	;+
	;offset_EggCounter, offset_EggHitBox, offset_HeroHp.					;+
	push bp																	;+
	mov bp, sp																;+
offset_eggsStartLoc equ [bp+14] 											;+
offset_eggsUpdateLoc equ [bp+12]											;+
offset_eggsBooleans equ [bp+10]												;+
offset_EggCounter equ [bp+8]												;+
offset_EggHitBox equ [bp+6]													;+
offset_HeroHp equ [bp+4]													;+
	push si bx di ax dx cx													;+
	;																		;+
	mov si, offset_eggBooleans												;+
	mov bx, offset_eggsUpdateLoc											;+
	xor cx, cx																;+
	dec si																	;+
	sub bx, 2																;+
	sub cx, 2																;+
		nextEgg:															;+
		inc si																;+
		add bx, 2 ;checking the eggs.										;+
		add cx, 2															;+
		;																	;+
		cmp cx, 18															;+
		jz stopEggDamage 													;+
		;																	;+
		cmp [byte ptr si], 1												;+
		jnz nextEgg		;checking if the egg was fired.						;+
		;																	;+
		mov di, [bx]														;+
		add di, 320 * 10 ;moving to the damage point.						;+
		add di, 2															;+
		;																	;+
	    cmp di, 45000														;+
		jna nextEgg		;checking if the egg could have						;+
		;				;hit the hero										;+
		cmp [byte ptr es:di +320], 247 ;checking if the egg 				;+
		jnz nextEggPixel			   ;hit the hero.						;+
		jmp damageHero														;+
		;																	;+
		nextEggPixel:														;+
		cmp [byte ptr es:di + 321], 247										;+
		jnz thirdEggPixel	;checking if the egg hit the hero.				;+
		jmp damageHero														;+
		;																	;+
		thirdEggPixel:														;+
		cmp [byte ptr es:di + 322], 247										;+
		jnz nextEgg	;checking if the egg hit the hero.						;+
		;																	;+
			damageHero:														;+
			push si															;+
			mov si, offset_HeroHp											;+
			dec [byte ptr si]	;damaging the hero.							;+
			pop si															;+
			mov [byte ptr si], 0											;+
			mov di, [bx]													;+
			push di															;+
			mov di, offset_EggHitBox ;deleting the egg.						;+
			push di															;+
			call deleteObject												;+
			mov di, offset_eggsStartLoc										;+
			add di, cx														;+
			mov dx, [di] ;reseting the egg's location.						;+
			mov [bx], dx													;+
			mov di, offset_EggCounter										;+
			dec [byte ptr di]	;subbing one from the counter.				;+
			jmp nextEgg														;+
			;																;+
	stopEggDamage:															;+
	pop cx dx ax di bx si bp												;+
	ret 12																	;+
	endp eggDamage															;+
	;-----------------------------------------------------------------------;+
		
		
	;---------------------------------------------------------------------------------------;+
	proc inputfromuser																		;+
	;input: offset heroLocation, offset heroLastLocation, 									;+
	;offset gamemode, offset herolastlocation.												;+
	;output: none																			;+	
	;purpose: receiving input from the user and changes										;+
	;the location of the hero according to that.											;+
	push bp																					;+
	mov bp, sp																				;+
	offset_heroupdatedLocation equ [bp+10]													;+	
	offset_heroBoolean equ [bp+8]															;+
	offset_gameMode equ [bp+6]																;+
	offset_heroLastLocation equ [bp+4]														;+
	offset_heroLaserLocation equ [bp+12]													;+
	offset_heroLaserBoolean equ [bp+14]														;+
	offset_laserX equ [bp+16]																;+
	input equ [bp+18]																		;+
	push cx ax bx si di dx																	;+
	;																						;+	
		call smallDelay																		;+
		call clearAfterHero	;cleaning the bottom part of the screen		      				;+
		mov di, offset_heroupdatedLocation													;+
		mov bx, [di]																		;+
		mov si, bx																			;+
		mov di, offset_heroBoolean															;+
		mov [byte ptr di],0																	;+
		mov di, offset_gameMode																;+
		mov ax, input																		;+
	;																						;+	
		cmp al, 'a'		;checks if the input is a											;+
		jnz skipa		;and changes the location according to that.						;+
		sub bx, 2																			;+
	skipa:																					;+
		cmp al, 'd'		;checks if the input is d											;+
		jnz skipd		;and changes the location according to that.						;+
		add bx, 2																			;+
	skipd:																					;+
		cmp al, 27		;checks if the input is escape.										;+
		jnz skipEsc		;and changes the game mode according to that.						;+
		mov [byte ptr di], 3																;+		
	skipEsc:																				;+
		cmp al, 'A'		;checks if the input is capital A									;+
		jnz skipCapA	;does the same thing as a											;+
		sub bx, 2																			;+
	skipCapA:																				;+
		cmp al,'D'		;checks if the input is capital D									;+
		jnz skipCapD	;does the same thing as a											;+
		add bx, 2																			;+
	skipCapD:																				;+
		cmp al, 32																			;+
		jnz skipSpace																		;+
		mov dx, offset_heroLaserBoolean	;checks if the input is space						;+
		push dx							;if space update the first laser boolean			;+
		mov dx, offset_laserX																;+
		push dx																				;+
		push bx																				;+
		mov bx, heroupdatedLocation															;+
		mov dx, [bx]																		;+
		pop dx																				;+
		push dx																				;+
		call UpdateLasersBooleans															;+
	skipSpace:																				;+
		mov di, offset_heroupdatedLocation													;+
		mov [di], bx																		;+
		mov di, offset_heroLastLocation														;+
		mov [di], si						;checking if the user crossed the border.		;+	
		mov cx, offset heroupdatedlocation													;+
		push cx																				;+
		mov cx, offset heroBordersBoolean													;+
		push cx																				;+
		call borders																		;+
		mov di, offset_heroBoolean															;+
		cmp [byte ptr di], 0				;if the user crossed the border the location	;+
		jz InTheBorders						;doesn't change.								;+
		mov di, offset_heroupdatedLocation													;+
		mov [di], si																		;+
		InTheBorders:																		;+
		mov dx, offset heroLasersBooleans													;+
		push dx																				;+
		mov dx, offset heroLasersLocations		;updates the Lasers Locations				;+
		push dx																				;+
		mov di, offset_heroupdatedLocation													;+
		mov dx, [di]																		;+
		add dx, 21																			;+
		sub dx, 2240																		;+
		push dx																				;+
		call UpdateLasersLocations															;+
	;																						;+
	pop dx di si bx ax cx bp																;+
	ret 16																					;+
	endp inputfromuser																		;+
	;---------------------------------------------------------------------------------------;+
	

	;-----------------------------------------------------------------------------------------------;+
	proc deleteObject																				;+
	;input: offset_hitBox, location,																;+
	;output:none																					;+
	;purpose:deleting objects                 														;+
	push bp																							;+
	mov bp, sp																						;+
	offset_hitBox equ [bp+4]																		;+
	location equ [bp+6]																				;+
	push cx bx ax di dx si																			;+
	;																								;+
		mov bx,offset_hitBox																		;+
		mov cl, [bx+1]          ;object's width														;+
		mov ch, [bx]			;objet's length														;+
		mov dl, cl																					;+
		mov dh, 0				 																	;+
		mov si, 320				;calculating the amount  needed to move.							;+
		sub si, dx				;from the end of one object's line to the start of the other.		;+
		mov di, location 																			;+
		mov al, 0 																					;+
		deleteWidth:																				;+
		mov [es:di], al																				;+
		inc di																						;+
		dec cl				;deletes the object.													;+
		cmp cl, 0																					;+
		jnz deleteWidth																				;+
		mov cl, dl																					;+
		dec ch																						;+
		add di, si																					;+
		cmp ch, 0																					;+
		jnz deleteWidth																				;+
	;																								;+	
	pop si dx di ax bx cx bp																		;+
	ret 4																							;+
	endp deleteObject																				;+
	;-----------------------------------------------------------------------------------------------;+
	
	
	;==================================================================================================================================
	start:
	mov ax, @data
	mov ds, ax
	mov ax, 0A000h
	mov es, ax
	; graphic mode
	mov ax, 13h
	int 10h
		
	;==========================
	;starting the main menue ;+
	call bmpprocess			 ;+
	;==========================
		mov ah, 0
		int 16h
	;----------------------------------
	call clear 
	;----------------------------------
	;prints all of the objects before the game starts.
	mov ax, offset hero
	push ax
	mov bx, offset heroupdatedlocation
	mov ax,[bx]
	push ax								;spawning the hero before the start of the game
	mov ax, offset printedhitboxforheros
	push ax
	call printbyhitbox
	;-----------------------------------
	mov ax,[amountOfChickens]
	push ax
	mov ax, offset chickensLocations
	push ax
	mov ax, offset chickenHp
	push ax								;printing the living chickens.
	mov ax, offset PinkEnemy
	push ax
	mov ax, offset chickenHitBox
	push ax	 
	call spawnLivingChickens         
	;-----------------------------------
	game:
	mov ah, 1																			
	int 16h																			    
	jz skipInput
	mov ah, 0																			
	int 16h
	mov ah,0
	push ax
	mov ax, offset laserX
	push ax
	mov ax, offset heroLasersBooleans
	push ax
	mov ax, offset heroLasersLocations
	push ax
	mov ax, offset heroupdatedlocation
	push ax
	mov ax, offset heroBordersBoolean
	push ax								;receiving input from the user.
	mov ax, offset gamemode
	push ax
	mov ax, offset herolastlocation
	push ax
	call inputfromuser
	skipInput:
	mov bx, offset gamemode
	cmp [byte ptr bx], 3 	;checking if the player quit
	jnz didntLose
	jmp loseExit
	mov bx, offset heroHp
	cmp [byte ptr bx], 0	;checking if the player lost
	ja didntLose
	jmp loseExit
	didntLose:
	mov ax, offset winner
	push ax
	mov ax, offset ChickenHp	;calculating the amount of living chickens
	push ax
	mov ax, offset LivingChickens 
	push ax
	call WinnerWinnerChickenDinner
	mov bx, offset winner
	cmp [byte ptr bx], 1	;checking if the player won
	jnz didntWinGame
	jmp winExit
	didntWinGame:
	;---------------------------------- 
	mov ax, offset eggsCounter
	push ax
	mov ax, offset chickenHp	
	push ax
	mov ax, offset eggsBooleans
	push ax						;turning a random egg boolean
	mov ax, offset LivingChickens
	push ax
	mov ax, offset eggMap
	push ax
	mov ax, offset chickenMap 
	push ax
	call layRandomEgg
	;----------------------------------
	mov ax, offset eggsStartLocations 	
	push ax
	mov ax, offset eggsUpdateLocations
	push ax
	mov ax, offset eggsBooleans
	push ax
	mov ax, offset enemyEgg ;printing the egg
	push ax
	mov ax, offset eggHitBox
	push ax
	mov ax, offset eggsCounter
	push ax
	call moveEgg
	;----------------------------------
	mov ax, offset eggsStartLocations 					
	push ax
	mov ax, offset eggsUpdateLocations						
	push ax
	mov ax, offset eggsBooleans							
	push ax
	mov ax, offset eggsCounter							
	push ax
	mov ax, offset eggHitBox ;checking the egg's damage
	push ax						
	mov ax, offset heroHp
	push ax
	call eggDamage
	mov bx, offset heroHp
	cmp [byte ptr bx], 0
	jna loseExit
	;----------------------------------
	mov ax, offset hero
	push ax
	mov bx, offset heroupdatedlocation
	mov ax,[bx]
	push ax
	mov ax, offset printedhitboxforheros
	push ax								;spawning the hero
	call printbyhitbox
	;----------------------------------
	mov ax, offset eggsCounter					
	push ax
	mov ax, offset LaserHitBox
	push ax
	mov ax, offset heroLasersLocations
	push ax
	mov ax, offset heroLasersBooleans
	push ax								;printing the laser
	mov ax, offset Laser
	push ax
	mov bx, offset heroupdatedlocation
	mov ax, [bx]
	push ax
	call shoot
	;----------------------------------
	mov ax, offset laserX	
	push ax
	mov ax, offset heroLasersLocations
	push ax
	mov ax, offset heroLasersBooleans
	push ax
	mov ax, offset chickensLocations	;checking if the hero needs to lose hp
	push ax
	mov ax, [offset heroupdatedLocation]
	push ax
	mov ax, offset chickenHp
	push ax
	call damageChickens
	;----------------------------------
	mov ax, [amountOfChickens]
	push ax
	mov ax, offset chickensLocations
	push ax
	mov ax, offset chickenHp
	push ax
	mov ax, offset PinkEnemy			;spawning the living chickens.
	push ax
	mov ax, offset chickenHitBox
	push ax	 
	call spawnLivingChickens
	jmp game
	;=======================================
	loseExit:
	call clear 
	mov [filename], 'G'
	mov [filename+1],'O'
	mov [filename+2], '1' ;printing the game over screen
	call delay
	call bmpprocess
	call EndGamedelay
	jmp leaveGame
	
	winExit:
	call clear 
	mov [filename], 'G'
	mov [filename+1],'G'
	mov [filename+2], '1' ;printing the victory screen
	call delay
	call bmpprocess
	call EndGamedelay
	leaveGame:	
	mov ah, 0
	int 16h
	call clear
	mov ax,3
	int 10h
	mov ax, 4c00h
	int 21h
	end start
