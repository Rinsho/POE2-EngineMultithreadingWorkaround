# POE2-EngineMultithreadingWorkaround

Workaround to temporarily fix the load-screen freezes caused by the "engine multithreading" option.

Tested on: Win11, Powershell 5.1, Steam client of Path Of Exile 2

---

Installation:

Wherever; just keep the files together.

Use:

Start the Path of Exile 2 game client. When you get to the login screen, right-click 'poe.bat' and select "Run as administrator". As long as there   aren't any errors, you should be good to go. You can double-check everything worked by going to the Windows Start menu, search and select Task Manager, go to the "Details" tab on the bottom left, find and right-click the PathOfExile process, and select "Set affinity". All CPUs should be selected except CPU#0 and CPU#1.

> NOTE: Also if you don't trust scripts you can always manually set the affinity in Task Manager every time you launch the game.

Files:
- poe.ps1
- poe.bat

File Descriptions:
- poe.ps1
  
  This file searches for PathOfExile* processes with max affinity according to your system's logical processor count.
  This will be the main game client. It then sets the affinity to exclude logical cores #0 and #1.

- poe.bat
  
  This file is a workaround for restrictions imposed on Powershell scripts by Windows by default. Windows doesn't generally allow Powershell
  scripts to run, but if we load the script text and then invoke it directly... well it doesn't seem to care about that.

Customizing:

The idea behind the affinity value is each bit represents a logical CPU core. So the integer value of each core is 2^(core_number) with cores starting at 0. The script currently has core 0 (2^0=1) and core 1 (2^1=2) affinity disabled; the "- 1 - 2" in the script. If you wanted to disable the affinity on cores 2 (2^2=4) and 3 (2^3=8) too, for example, you'd add "- 4 - 8" to the script.
