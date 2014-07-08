Switch config files based on the most profitable coins at the moment. This script checks to see which types of coins are most profitable, then kills your mining tool, and overwrites your config. A cronjob or other script should start the miner back up, with the new config.




To Setup:

First, make sure you have all mining tools setup and working: cgminer, sgminer, and vertminer.

Then, create different config files for all the different types of altcoin algorithms. 

- cgminer.tcl
- nscrypt.tcl
- x11.tcl
- x13.tcl

I use this script, and just change all the settings accordingly: https://bitcointalk.org/index.php

Finally, setup a *root* cronjob to run this script. I have it run every 20 minutes.

That's it. Just make sure you have the settings correct for all your configs. I also have a cronjob for running the default script cgmon.tcl.




I'm an unemployed developer, feel free to donate if this helps!

Bitcoins: 1BQUwpRBsDU5yjwd1yHgWVGPgsbfCvQviL
