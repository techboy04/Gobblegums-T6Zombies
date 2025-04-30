# Gobblegums for Black Ops 2
Have you ever wanted to utilize Gobblegums in Black Ops 2? Well now you can!
Players will have limited uses for the Machine. The uses increase every round similar to Afterlives with a max of 3.

You can also add your own! See the bottom for how to add it.

Current Gobblegums Officially added:
- Reign Drops
- Whos Keeping Score
- Nuclear Winter
- Licensed Contractor
- Im Feeling Lucky
- Round Robin
- Phoenix Up
- Undead Man Walking
- Power Vacuum
- Cache Back
- Kill Joy
- On the House
- Idle Eyes
- Stock Option
- Free Fire
- Immolcation Liquidation
- Crate Power
- Wall Power
- Anywhere But Here
- Wonderbar
- Nowhere But There
- Perkaholic
- Temporal Gift
- Mind Blown
- Crawl Space
- Ephemeral Enhancement
These Gobblegums are added but their functionalities is limited due to my lack of knowledge in certain areas:
- Near Death Experience - Players will be revived instantly instead of a delay, the Revive mechanic kept breaking on me and I decided to just give up on it for the time being.
- Profit Sharing - Instead of vice versa, only teammates get the points you earn.
### Huge Shoutout to [Parkajack](https://forum.plutonium.pw/user/parkajack) for helping out adding these gobbles!
- Burned Out
- Tone Death

## Custom Options
This mod has some custom dvars!
- gobble_debug 0/1 - Toggle the debug text used in development.
- gobble_max_uses # - Amount of uses per round. By Default this is set to 3.

## Debugging Commands
- .givegobble - Gives the player a gobblegum. Perfect for debugging added gobbles. Requires sv_cheats to be turned on!

## Add your own!
I took heavy inspiration from Gerards Cold War mod with how you can add your own Field Upgrade.
In your script, add a register_gobblegum and add the use function for it.

register_gobblegum(gobble_name, gobblestring, shader, use_function, type, description, color, duration, check_use)

- gobble_name - This is the ID of your gum, for example, for Wall Power, "wall_power" is used.
- gobblestring - The name of the Gobblegum that will appear on the HUDs. For Examplem, "Wall Power".
- shader - The icon for the gobblegum. If youre using custom youll need to make sure the image and material is added to the mods source and them being defined in the .zone. You can look at the mods source on how the official Gobbles are added for reference. For Examplem, "gum_wall_power".
- use_function - Use ::function_name, this will be the function that will execute when the Gobble is used if the TYPE is set to "activate", if set to "timed" or "round_based", the function will be looped instead. For Example, "::wall_power_use".
- type - The Type of gum this is. There is three supported gums. "activate" which is manually activated (is also used for gobbles that are set to auto activate, but the player will have to manually activate regardless), "timed" and "round_based" are on a timer instead, they also activate when the player manually activates it first. For Example, for Wall Power, we will need to wait till the player buys a wall weapon, so we will use "activate" type while the gums function will have a waittill.
- description - Description of the gobblegum, this will show when the player grabs it from the machine. For Example, for Wall Power we will put "Wall Buys automatically become ugpraded".
- color - The color you want the text to be in the Gobblegum Machine. For Example, "yellow" which will show "Press F to grab Wall Power" where the Wall Power will be colored.
- duration - Set the Duration of the gobble, if using Activate type just set this to 0. If using Timed type, how long in minutes the gum will last, and for Round Based type, how long the gum will last in rounds. For Example, since we are using Wall Power, it doesnt need to be timed, so we will simply put 0.
- check_use - Function that checks if the gum can be activated. Perfect for certain requirements like Phoenix Up requiring a player to be down so you can simply check if a player is down and if so, return true. For no requirement you can use the ::default_check_use function. Otherwise your function will need to return both True and False in some way.
- doesnt_appear_in_machine - If set to true, it will not appear in the Gobblegum Machine, perfect for obtaining exclusive gobblegums. For example, since we want Crate Power to be in the machine, we will need to set it to False.

TIP 1:
For any Gum that uses a Waittill, make sure to use two endons to be sure the gums functionality doesnt continue after you switch the gobblegum.

- self endon ("gobblegum_switched"); //This ends when the player switches gobbles.
- self endon ("gobble_pickedup"); //In the case the top doesnt execute, this will end if the player picks up the gobble. This can also be used if you wanted to make certain gobblegums drops.

The Timed and Round Based functions have these by default.

TIP 2:
If youre making your gobblegum outside of the included script, make sure you use #include scripts\zm\gobblegum; or where ever you placed the gobblegum.gsc script if you moved it.
