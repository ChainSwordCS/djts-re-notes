# debugger trace 1 (2026-07-23 @ 08:23 PM)

notes, savestate, screenshots, TTY debug console output, etc.

for "Drake & Josh - Talent Showdown (USA) (En,Fr) (Beta).nds"



# context:
	1. booted game
	2. hit "New Game" and selected File 1
	3. wait for level 1-1 to load...
	4. close textbox
	5. move down a little, then move right to collide with that table object

Note: I didn't create the savestate on the first frame collision was triggered,
I advanced forward a couple frames to ensure the results would be -- like --
consistent i guess? 
like, at this save state, the OnCollision() function will do the exact same
thing whether you advance forward 1 frame or 2 frames (assuming you are still
holding Right on the D-Pad), just as it did in the 1-2 frames prior to creating
the save state. the only thing that should differ is the frame counter.

etc, etc.



# steps to exactly reproduce:
	1. using no$gba debugger (the april 2025 version, the latest as of 2026)... 
	2. load "Drake & Josh - Talent Showdown (USA) (En,Fr) (Beta).nds"
	3. make sure you have enabled all the cheats noted below...
	4. set a code breakpoint at address 0x02031E2C
	5. press Right on the D-Pad, hold it, and keep holding it...
	6. load "djts_beta_savestate_5.sna" while still holding Right on the D-Pad...
	7. the game should have paused by triggering the code breakpoint.
		now, click on the game window again (or press F9) to unpause for another frame
	8. profit! the game should pause as the code breakpoint gets triggered.
		(at this point the code is in the middle of processing for frame 925...)



## PLEASE NOTE!!!!

when you finish performing those steps to reproduce my results,
the game screen will probably(?) not look identical to the normal-looking
screenshot. it may instead look blacked-out, identical to the mostly-black
screenshot. this is because no$gba is buggy, and it doesn't handle savestates
(aka "snapshots") for DS(i) software correctly, so something weird happens to
the graphics. but the majority of the code logic is unaffected by this, it's
just a visual bug.

additional note: upon loading a save state, the framebuffers don't get updated immediately... that's why the instructions tell you to advance another frame, because when it first hits that code breakpoint it has not yet updated the top screen's framebuffer. and that's why i'm analyzing frame 925



# CHEATS USED:
(Action Replay DS code format)

[enable ensata debug messages on no$gba]
020BCC58 E3500001
[redirect ensata debug msg i/o -> no$gba debug msg i/o]
020BCC3C 04FFFA1C
[enable all DebugStrings.bin debug messages]
0207967C E1A00000
02079680 E1A00000
02079684 E1A00000
02079688 E1A00000
[suppress particle emitter log spam]
0206E29C E1A00000
0206E2C0 E1A00000
0206E2DC E1A00000
[suppress CurrValue/Beginning/Ending/RelevantValue/Middle log spam]
0200A828 E1A00000
0200A8C0 E1A00000
0200B204 E1A00000
0200B29C E1A00000
0200B420 E1A00000


