#include maps\mp\zombies\_zm_utility;
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm_powerups;
#include maps\mp\zombies\_zm_audio;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_magicbox;
#include maps\_utility;
#include maps\_effects;
#include maps\mp\zombies\_zm_laststand;
#include maps\mp\_visionset_mgr;
#include maps\mp\zombies\_zm_score;
#include maps\mp\zombies\_zm_zonemgr;
#include maps\mp\zombies\_zm_perks;
#include maps\mp\animscripts\zm_utility;
#include maps\mp\animscripts\zm_shared;

main()
{
	replacefunc(maps\mp\zombies\_zm_magicbox::treasure_chest_weapon_spawn, ::treasure_chest_weapon_spawn);
	
	replacefunc(maps\mp\zombies\_zm_score::add_to_player_score, ::add_to_player_score);

	replacefunc(maps\mp\zombies\_zm_powerups::double_points_powerup, ::double_points_powerup);
	replacefunc(maps\mp\zombies\_zm_powerups::insta_kill_powerup, ::insta_kill_powerup);
	replacefunc(maps\mp\zombies\_zm_powerups::point_doubler_on_hud, ::point_doubler_on_hud);
	replacefunc(maps\mp\zombies\_zm_powerups::insta_kill_on_hud, ::insta_kill_on_hud);
	
	precachemodel("p6_zm_tm_crate_01_short");
	precachemodel("zombie_teddybear");
}

init()
{
	if(level.script == "zm_transit")
	{
		level thread spawnGumballMachine((-7060.83, 4147.14, -63.7768), 90); //Bus Depot
		level thread spawnGumballMachine((-5424.36, -7775.02, -63.2332), 0); //Diner
		level thread spawnGumballMachine((7764.63, -6324.16, 117.125), 30); //Farm
		level thread spawnGumballmachine((10957.6, 8058.04, -561.764), -180); //Power Station
		level thread spawnGumballMachine((1115.55, -1114.27, 120.125), 130); //Town
	}
	else if(level.script == "zm_prison")
	{
		level thread spawnGumballMachine((351.142, 10194.9, 1336.13), 0);
		level thread spawnGumballMachine((-1056.36, 8527.64, 1336.13), 40);
		level thread spawnGumballMachine((-1056.36, 8527.64, 1336.13), 0);
		level thread spawnGumballmachine((3235.64, 9286.04, 1704.13), 0);
		level thread spawnGumballmachine((758.62, 6538.42, 212.13), 140);
	}
	else if(level.script == "zm_nuked")
	{
		level thread spawnGumballmachine((-499.377, 291.778, -61.1773), -18);
		level thread spawnGumballMachine((-1578.5, 124.496, -63.209), 160);
		level thread spawnGumballMachine((1731.97, 765.43, -63.6793), -160);
	}
	else if(level.script == "zm_tomb")
	{
		level thread spawnGumballMachine((2972.35, 5254.26, -376.51), 180);
		level thread spawnGumballMachine((-564.998, 3725.61, -295.875), -50);
		level thread spawnGumballMachine((-2673.69, 360.359, 48.125), -100);
		level thread spawnGumballMachine((684.989, -3958.89, 301.647), 42);
		level thread spawnGumballMachine((-262.565, 133.323, -750.968), -27.7957);
	}
	else if(level.script == "zm_buried")
	{
		level thread spawnGumballMachine((-463.641, -540.399, -11.875), 180);
		level thread spawnGumballMachine((1642.36, 97.387, -1.11589), 135);
		level thread spawnGumballMachine((6749.98, 881.081, 108.125), -170);
	}
	else if(level.script == "zm_highrise")
	{
		level thread spawnGumballMachine((1740.47, 1768.67, 3217.61), -176.285);
		level thread spawnGumballMachine((1642.83, 1476.36, 3052.33), -74.9744);
		level thread spawnGumballMachine((2137.17, -181.075, 1296.13), 55.5891);
		level thread spawnGumballMachine((2332.43, -596.083, 2880.13), 14.8187);
	}

	register_gobblegum( "reign_drops", "Reign Drops", "gum_reign_drops", ::spawn_all_powerups, "activate", "Spawn every powerup in the map.", "blue", 0, ::default_check_use);
	register_gobblegum( "whos_keeping_score", "Whos Keeping Score", "gum_whos_keeping_score", ::spawn_double_points, "activate", "Spawn a Double Points powerup.", "blue", 0, ::default_check_use);
	register_gobblegum( "nuclear_winter", "Nuclear Winter", "gum_nuclear_winter", ::spawn_nuke, "activate", "Spawn a Nuke powerup.", "blue", 0, ::default_check_use);
	register_gobblegum( "licensed_contractor", "Licensed Contractor", "gum_licensed_contractor", ::spawn_carpenter, "activate", "Spawn a Carpenter powerup.", "blue", 0, ::default_check_use);
	register_gobblegum( "feeling_lucky", "Im Feeling Lucky", "gum_feeling_lucky", ::spawn_random_powerup, "activate", "Spawn a Random Powerup", "blue", 0, ::default_check_use);
	register_gobblegum( "round_robin", "Round Robin", "gum_round_robin", ::round_robin_use, "activate", "End the current round. All players will be given 2500 points.", "blue", 0, ::default_check_use);
	register_gobblegum( "phoenix_up", "Phoenix Up", "gum_phoenix_up", ::phoenix_up_use, "activate", "Revive all downed players.", "blue", 0, ::check_downed_players);
	register_gobblegum( "undead_man_walking", "Undead Man Walking", "gum_undead_man_walking", ::undead_man_walking_use, "timed", "All Zombies will walk instead of running and sprinting.", "green", 5, ::default_check_use);
	register_gobblegum( "power_vacuum", "Power Vacuum", "gum_power_vacuum", ::power_vacuum_use, "timed", "Powerups have no limit per round.", "cyan", 5, ::default_check_use);
	register_gobblegum( "cache_back", "Cache Back", "gum_cache_back", ::spawn_max_ammo, "activate", "Spawn a Max Ammo powerup.", "blue", 0, ::default_check_use);
	register_gobblegum( "kill_joy", "Kill Joy", "gum_kill_joy", ::spawn_insta_kill, "activate", "Spawn an Insta Kill powerup.", "blue", 0, ::default_check_use);
	register_gobblegum( "on_the_house", "On the House", "gum_on_the_house", ::on_the_house_use, "activate", "Obtain a random perk.", "yellow", 0, ::default_check_use);
	register_gobblegum( "soda_fountain", "Soda Fountain", "gum_soda_fountain", ::soda_fountain_use, "activate", "Obtain a random perk when buying a perk.", "yellow", 0, ::default_check_use);
	register_gobblegum( "idle_eyes", "Idle Eyes", "gum_idle_eyes", ::idle_eyes_use, "activate", "All players will be hidden from zombies for 30 seconds.", "cyan", 0, ::default_check_use);
	register_gobblegum( "stock_option", "Stock Option", "gum_stock_option", ::stock_option_use, "timed", "Shoot from the reserve instead of the Magazine.", "green", 3, ::default_check_use);
	register_gobblegum( "free_fire", "Free Fire", "gum_free_fire", ::free_fire_use, "timed", "Have unlimited ammo.", "blue", 5, ::default_check_use);
	register_gobblegum( "profit_sharing", "Profit Sharing", "gum_profit_sharing", ::profit_sharing_use, "timed", "Players near you will gain your points.", "cyan", 5, ::default_check_use);
	if(level.script != "zm_transit")
	{
		register_gobblegum( "immolation_liquidation", "Immolation Liquidation", "gum_immolation_liquidation", ::spawn_fire_sale, "actovate", "Spawns a Fire Sale powerup.", "blue", 0, ::default_check_use);
	}
	register_gobblegum( "crate_power", "Crate Power", "gum_crate_power", ::crate_power_use, "activate", "Upgrades weapon taken from Mystery Box", "yellow", 0, ::default_check_use);
	register_gobblegum( "wall_power", "Wall Power", "gum_wall_power", ::wall_power_use, "activate", "Upgrades weapon taken from a Wall Buy", "yellow", 0, ::default_check_use);
	register_gobblegum( "anywhere_but_here", "Anywhere But Here", "gum_anywhere_but_here", ::anywhere_but_here_use, "activate", "Teleport to a random area", "blue", 0, ::default_check_use);
	register_gobblegum( "wonderbar", "Wonderbar", "gum_wonderbar", ::wonderbar_use, "activate", "Next Mystery Box roll is a Wonder Weapon", "red", 0, ::default_check_use);
	register_gobblegum( "nowhere_but_there", "Nowhere But There", "gum_nowhere_but_there", ::nowhere_but_there_use, "activate", "Teleport to a downed player, instantly reviving them.", "blue", 0, ::check_downed_players);
	register_gobblegum( "perkaholic", "Perkaholic", "gum_perkaholic", ::perkaholic_use, "activate", "Give all the maps perks.", "red", 0, ::default_check_use);
	register_gobblegum( "near_death_experience", "Near Death Experience", "gum_near_death_experience", ::near_death_experience_use, "timed", "Revive players by standing near them.", "cyan", 3, ::default_check_use);
	register_gobblegum( "temporal_gift", "Temporal Gift", "gum_temporal_gift", ::temporal_gift_use, "timed", "Powerups will be longer.", "cyan", 3, ::default_check_use);

/////////////////// These dont work. Plan to fix them.
//	register_gobblegum( "respin_cycle", "Respin Cycle", "gum_respin_cycle", ::respin_cycle_use, "activate", "Respins the Mystery Box", "", 0, ::player_is_using_box);

	level thread reset_gobble_machine_uses();
	
	level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
		player.gobblegum_active = 0;
		player.gobblemachine_uses = 3;
		player thread use_gobblegum();
		player thread gobblegum_hud();
		player thread awaiting_gobble_use();
	}
}

get_color(color)
{
	switch(color)
	{
		case "black":
			return "^0";
		case "red":
			return "^1";
		case "green":
			return "^2";
		case "yellow":
			return "^3";
		case "blue":
			return "^4";
		case "cyan":
			return "^5";
		case "pink":
			return "^6";
		case "white":
			return "^7";
		default:
			return "^7";
	}
}

get_wonderbar_weapons()
{
	array = array("raygun_zm","raygun_mark2_zm","cymbal_monkey_zm");
	if(level.script == "zm_buried")
	{
		array[array.size] = "slowgun_zm";
	}
	else if(level.script == "zm_prison")
	{
		array[array.size] = "blundergat_zm";
	}
	return array;
}

gobblegum_hud()
{
	self.gobbleHUDText = newClientHudElem(self);
	self.gobbleHUDText.alignx = "center";
    self.gobbleHUDText.aligny = "bottom";
    self.gobbleHUDText.horzalign = "right";
    self.gobbleHUDText.vertalign = "bottom";
    self.gobbleHUDText.fontscale = 1.5;
	self.gobbleHUDText.x = -150;
    self.gobbleHUDText.y = 20;
	
	self.gobbleHUDImage = newClientHudElem(self);
	self.gobbleHUDImage.alignx = "center";
    self.gobbleHUDImage.aligny = "bottom";
    self.gobbleHUDImage.horzalign = "right";
    self.gobbleHUDImage.vertalign = "bottom";
    self.gobbleHUDImage.fontscale = 1.5;
	self.gobbleHUDImage.x = self.gobbleHUDText.x;
    self.gobbleHUDImage.y = self.gobbleHUDText.y - 16;
	self.gobbleHUDImage setShader ("", 32, 32);
	
	while(1)
	{
		if(isDefined(self.gobblegum))
		{
			self.gobbleHUDImage setshader( level.gobblegums[self.gobblegum].shader, 32, 32 );
		}
		wait 0.05;
	}
}

gobblegum_get_hud(gobblegum)
{
	animation_speed = 0.35;
	
	if(isDefined(self.gobbleGetHUD))
	{
		self.gobbleGetHUD destroy();
		self.gobbleGetHUDDesc destroy();
		self.gobbleGetHUDShader destroy();
		self.gobbleGetHUDActivate destroy();
		self notify ("reset_gobble_hud");
	}
	self endon ("reset_gobble_hud");
	self.gobbleGetHUD = newClientHudElem(self);
	self.gobbleGetHUD.alignx = "center";
	self.gobbleGetHUD.aligny = "top";
	self.gobbleGetHUD.horzalign = "user_center";
	self.gobbleGetHUD.vertalign = "top";
	self.gobbleGetHUD.fontscale = 5;
	self.gobbleGetHUD.x = 0;
	self.gobbleGetHUD.y = 80;
	self.gobbleGetHUD.alpha = 0;
		
	self.gobbleGetHUDDesc = newClientHudElem(self);
	self.gobbleGetHUDDesc.alignx = "center";
	self.gobbleGetHUDDesc.aligny = "top";
	self.gobbleGetHUDDesc.horzalign = "user_center";
	self.gobbleGetHUDDesc.vertalign = "top";
	self.gobbleGetHUDDesc.fontscale = 5;
	self.gobbleGetHUDDesc.x = 0;
	self.gobbleGetHUDDesc.y = self.gobbleGetHUD.y + 30;
	self.gobbleGetHUDDesc.alpha = 0;
	
	self.gobbleGetHUDActivate = newClientHudElem(self);
	self.gobbleGetHUDActivate.alignx = "center";
	self.gobbleGetHUDActivate.aligny = "top";
	self.gobbleGetHUDActivate.horzalign = "user_center";
	self.gobbleGetHUDActivate.vertalign = "top";
	self.gobbleGetHUDActivate.fontscale = 5;
	self.gobbleGetHUDActivate.x = 0;
	self.gobbleGetHUDActivate.y = self.gobbleGetHUDDesc.y + 20;
	self.gobbleGetHUDActivate.alpha = 0;
		
	self.gobbleGetHUDShader = newClientHudElem(self);
	self.gobbleGetHUDShader.alignx = "center";
	self.gobbleGetHUDShader.aligny = "top";
	self.gobbleGetHUDShader.horzalign = "user_center";
	self.gobbleGetHUDShader.vertalign = "top";
	self.gobbleGetHUDShader.fontscale = 1.5;
	self.gobbleGetHUDShader.x = 0;
	self.gobbleGetHUDShader.y = self.gobbleGetHUD.y - 60;
	self.gobbleGetHUDShader.alpha = 0;
		
	self.gobbleGetHUD setText (level.gobblegums[gobblegum].name);
	self.gobbleGetHUDDesc setText (level.gobblegums[gobblegum].description);
	self.gobbleGetHUDActivate setText (get_activation_text(gobblegum));
	self.gobbleGetHUDShader setShader (level.gobblegums[gobblegum].shader, 64, 64);
	
	
	self.gobbleGetHUD changefontscaleovertime( animation_speed );
    self.gobbleGetHUD fadeovertime( animation_speed );
    self.gobbleGetHUD.alpha = 1;
    self.gobbleGetHUD.fontscale = 3;
	self.gobbleGetHUDDesc changefontscaleovertime( animation_speed );
    self.gobbleGetHUDDesc fadeovertime( animation_speed );
    self.gobbleGetHUDDesc.alpha = 1;
    self.gobbleGetHUDDesc.fontscale = 1.5;
	self.gobbleGetHUDActivate changefontscaleovertime( animation_speed );
    self.gobbleGetHUDActivate fadeovertime( animation_speed );
    self.gobbleGetHUDActivate.alpha = 1;
    self.gobbleGetHUDActivate.fontscale = 1;
	self.gobbleGetHUDShader changefontscaleovertime( animation_speed );
    self.gobbleGetHUDShader fadeovertime( animation_speed );
    self.gobbleGetHUDShader.alpha = 1;
    self.gobbleGetHUDShader.fontscale = 1.5;
    wait animation_speed + 3;
    self.gobbleGetHUD changefontscaleovertime( animation_speed );
    self.gobbleGetHUD fadeovertime( animation_speed );
	self.gobbleGetHUD.fontscale = 5;
	self.gobbleGetHUD.alpha = 0;
	self.gobbleGetHUDDesc changefontscaleovertime( animation_speed );
    self.gobbleGetHUDDesc fadeovertime( animation_speed );
    self.gobbleGetHUDDesc.alpha = 0;
    self.gobbleGetHUDDesc.fontscale = 5;
	self.gobbleGetHUDActivate changefontscaleovertime( animation_speed );
    self.gobbleGetHUDActivate fadeovertime( animation_speed );
    self.gobbleGetHUDActivate.alpha = 0;
    self.gobbleGetHUDActivate.fontscale = 5;
	self.gobbleGetHUDShader changefontscaleovertime( animation_speed );
    self.gobbleGetHUDShader fadeovertime( animation_speed );
    self.gobbleGetHUDShader.alpha = 0;
    self.gobbleGetHUDShader.fontscale = 5;
	
	wait animation_speed + 1;
		
	self.gobbleGetHUD destroy();
	self.gobbleGetHUDDesc destroy();
	self.gobbleGetHUDShader destroy();
	self.gobbleGetHUDActivate destroy();
}

get_activation_text(gobblegum)
{
	if(level.gobblegums[gobblegum].type == "activate")
	{
		return "Can be activated instantly!";
	}
	else if(level.gobblegums[gobblegum].type == "timed")
	{
		return "Lasts " + level.gobblegums[gobblegum].duration + " minutes!";
	}
	else if(level.gobblegums[gobblegum].type == "round_based")
	{
		return "Lasts " + level.gobblegums[gobblegum].duration + " rounds!";
	}
	else
	{
		return "Invalid Activation Type!";
	}
}

register_gobblegum( gobble_name, gobblestring, shader, use_function, type, description, color, duration, check_use)
{
	if(!isDefined(level.gobblegums))
	{
		level.gobblegums = [];
	}
	if(!isDefined(level.gobblegums[gobble_name]))
	{
		level.gobblegums[gobble_name] = spawnstruct();
	}
	
	if (!isDefined(level.gobblegums[gobble_name].duration))
	{
		level.gobblegums[gobble_name].duration = duration;
	}
	
	precacheshader(shader);
	
	level.gobblegums[gobble_name].id = gobble_name;
	level.gobblegums[gobble_name].name = gobblestring;
	level.gobblegums[gobble_name].shader = shader;
	level.gobblegums[gobble_name].use_func = use_function;
	level.gobblegums[gobble_name].type = type;
	level.gobblegums[gobble_name].description = description;
	level.gobblegums[gobble_name].check_use = check_use;
	level.gobblegums[gobble_name].active = 0;
	level.gobblegums[gobble_name].color = color;
}

use_gobblegum()
{
	for(;;)
	{
		if(self actionslotthreebuttonpressed() && isDefined(self.gobblegum))
		{
			if( self [[level.gobblegums[self.gobblegum].check_use]]() )
			{
				self playsound ("gobblegum_use");
				wait 1;
				self.gobblegum_active = 1;
				if(level.gobblegums[self.gobblegum].type == "activate")
				{
					self [[ level.gobblegums[self.gobblegum].use_func ]]();
				}
				else if(level.gobblegums[self.gobblegum].type == "timed")
				{
					self timed_gobblegum();
				}
				self.gobblegum_active = 0;
				self.gobblegum = undefined;
				self.gobbleHUDText setText ("");
				self.gobbleHUDImage setShader ("", 32, 32);
			}
			else
			{
				self cancel_gobble_gum_action();
			}
		}
		
		wait 0.05;
	}
}

default_check_use()
{
	return true;
}

timed_gobblegum()
{
	self endon ("gobblegum_switched");
	self thread timed_function();
	self.gobbleHUDText setText ("");
	self.gobbleHUDText setTimer (level.gobblegums[self.gobblegum].duration * 60);
	wait level.gobblegums[self.gobblegum].duration * 60;
	self.gobbleHUDText setText ("");
	self playsound ("gobblegum_expire");
	self notify ("gobblegum_finished");
}

timed_function()
{
	self endon( "gobblegum_switched" );
	self endon ("gobblegum_finished");
	while( 1 )
	{
		self [[ level.gobblegums[self.gobblegum].use_func ]]();
		wait 0.01;
	}
}

round_gobblegum()
{
	self endon ("gobblegum_switched");
	max_round = level.round_number + level.gobblegums[self.gobblegum].duration;
	self thread timed_function();
	while(level.round_number < max_round)
	{
		self.gobbleHUDText setText ("Rounds Left: " + (max_round - level.round_number));
		level waittill ("between_round_over");
	}
	self playsound ("gobblegum_expire");
	self.gobbleHUDText setText ("");
	self notify ("gobblegum_finished");
}

teddybear_spin(duration)
{
	time = 2;

	self rotateTo(self.angle + (0,90,0), time);
	self waittill ("rotatedone");
}

spawnGumballMachine(location, angle)
{
	gumballTrigger = spawn( "trigger_radius", location, 1, 50, 50 );
	gumballTrigger setHintString("Press ^3&&1 ^7to roll a Gobblegum");
	gumballTrigger setcursorhint( "HINT_NOICON" );
	gumballModel = spawn( "script_model", location);
	gumballModel setmodel ("p6_zm_tm_crate_01_short");
	gumballModel rotateTo((0,angle+90,0),.1);
	
	gumballCollision = spawn( "script_model", location);
	gumballCollision setModel("collision_clip_32x32x128");
	gumballCollision rotateTo((0,angle+90,0),.1);
	
	gumballTeddyBear = spawn("script_model", location + (0,0,40));
	gumballTeddyBear setModel ("zombie_teddybear");
	gumballTeddyBear rotateTo((0,angle,0),.1);
	
	gumballTeddyBear thread gobblegum_machine_ambience();
	
	gumballModel.user = undefined;
	gumballModel.chosen_gum = undefined;
	
	for(;;)
	{
		gumballTrigger waittill( "trigger", i );
		
		
		if(i.gobblemachine_uses > 0)
		{
			if(gumballModel.beingUsed == 0)
			{
				gumballTrigger setHintString("Press ^3&&1 ^7to roll a Gobblegum");
			}
		
			if ( i usebuttonpressed() )
			{
				if(!isDefined(gumballModel.user))
				{
					gumballModel.beingUsed = 1;
					gumballModel.user = i;
					gumballTrigger setHintString("");
					gumballModel thread flash_when_gums_ready(gumballTeddyBear.origin);
				
					gumballModel playsound("gobblegum_machine_spin");
					wait 2;
					gumballModel playsound("gobblegum_machine_spin_done");
					wait 0.5;
					gumballModel thread machine_tick(gumballTeddyBear.origin);
					key = getarraykeys( level.gobblegums );
					if(key.size == 1)
					{
						num = randomintrange(0,key.size);
					}
					else
					{
						num = randomintrange(0,key.size-1);
					}
					gumballModel.chosen_gum = key[num];
					gumballTrigger setHintString("Press ^3&&1 ^7for " + get_color(level.gobblegums[gumballModel.chosen_gum].color) + level.gobblegums[gumballModel.chosen_gum].name);
					gumballModel thread gobble_timeout(6, gumballTrigger);
				}
				else
				{
					i notify ("gobblegum_switched");
					i.gobblegum_active = 0;
					wait 0.1;
					i.gobblegum = gumballModel.chosen_gum;
					i thread gobblegum_get_hud(gumballModel.chosen_gum);
					gumballModel notify ("gobble_pickedup");
					gumballModel stopsounds();
					gumballModel.user = undefined;
					gumballModel.chosen_gum = undefined;
					i.gobbleHUDText setText ("[{+actionslot 3}]");
					gumballModel playsound("gobblegum_machine_timeout");
					wait 3;
					i.gobblemachine_uses -= 1;
					gumballModel.beingUsed = 0;
					gumballTrigger setHintString("Press ^3&&1 ^7to roll a Gobblegum");
				}
			}
		}
		else
		{
			gumballTrigger setHintString("You cannot use the machine at this time!");
		}
		wait 0.01;
	}
}

flash_when_gums_ready(location)
{
	temp_ent = spawn( "script_model", location );
	temp_ent setModel("tag_origin");
	playfxontag( level._effect[ "powerup_on" ], temp_ent, "tag_origin" );
	self waittill_any ("gobble_pickedup", "gobble_timeout");
	temp_ent delete();
}

gobblegum_machine_ambience()
{
	for(;;)
	{
		wait(randomintrange(1,120));
		self playsound ("gobblegum_machine_idle1");
		wait 40;
	}
}

reset_gobble_machine_uses()
{
	for(;;)
	{
		level waittill ("between_round_over");
		foreach (player in level.players)
		{
			if(player.gobblemachine_uses < 3)
			{
				player.gobblemachine_uses += 1;
			}
		}
	}
}

machine_tick(location)
{
	self endon ("gobble_pickedup");
	self endon ("gobble_timeout");
	for(;;)
	{
		self playsound( "gobblegum_machine_tick" );
		playfx( level._effect["powerup_grabbed"], location );
		wait 1;
	}
}

gobble_timeout(time, trigger)
{
	self endon ("gobble_pickedup");
	wait time;
	self notify ("gobble_timeout");
	self stopsounds();
	self.user.gobblemachine_uses -= 1;
	self.user = undefined;
	self.chosen_gum = undefined;
	self playsound("gobblegum_machine_timeout");
	self.beingUsed = 0;
	trigger setHintString("Press ^3&&1 ^7to roll a Gobblegum");
}

get_front_location(distance)
{
	if(!isDefined(distance))
	{
		distance = 100;
	}
	
	trace = bullettrace( self.origin, self.origin + vectorscale( ( anglestoforward( self.angles ) ), distance ), 1, self );
    return trace["position"];
}

cancel_gobble_gum_action()
{
	for( i = 0; i < 2; i++ )
	{
		colornum = 0;
		while (colornum < 1)
		{
			self.gobbleHUDImage.color = ( 1, colornum, colornum );
			colornum += 0.2;
			wait 0.01;
		}
		self.gobbleHUDImage.color = ( 1, 1, 1);
	}
	self.gobbleHUDImage.color = ( 1, 1, 1 );
}

awaiting_gobble_use()
{
	for(;;)
	{
		while(self.gobblegum_active == 1)
		{
			
			colornum = 1;
			while (colornum > 0)
			{
				self.gobbleHUDImage.alpha = colornum;
				colornum -= 0.1;
				wait 0.04;
			}
			
			colornum = 0;
			while (colornum < 1)
			{
				self.gobbleHUDImage.alpha = colornum;
				colornum += 0.1;
				wait 0.01;
			}
			self.gobbleHUDImage.alpha = 1;
		}
		self.gobbleHUDImage.alpha = 1;
		wait 0.01;
	}
}

/////////////////////////
// All Gobblegums
/////////////////////////

test_use()
{
	self iprintln("uses test");
}

spawn_all_powerups()
{
	loc = self get_front_location(300);
	
	powerup_keys = getarraykeys( level.zombie_include_powerups );
	foreach (key in powerup_keys)
	{
		if(level.zombie_include_powerups[key].zombie_grabbable == 1)
		{
			x = loc[0] + randomintrange(-150,150);
			y = loc[1] + randomintrange(-150,150);
			z = loc[2];
		
			level maps\mp\zombies\_zm_powerups::specific_powerup_drop(level.zombie_include_powerups[key].powerup_name, (x,y,z));
		}
	}
}

spawn_insta_kill()
{
	level maps\mp\zombies\_zm_powerups::specific_powerup_drop("insta_kill", self get_front_location());
}

spawn_max_ammo()
{
	level maps\mp\zombies\_zm_powerups::specific_powerup_drop("full_ammo", self get_front_location());
}

spawn_double_points()
{
	level maps\mp\zombies\_zm_powerups::specific_powerup_drop("double_points", self get_front_location());
}

spawn_fire_sale()
{
	level maps\mp\zombies\_zm_powerups::specific_powerup_drop("fire_sale", self get_front_location());
}

spawn_carpenter()
{
	level maps\mp\zombies\_zm_powerups::specific_powerup_drop("carpenter", self get_front_location());
}

spawn_nuke()
{
	level maps\mp\zombies\_zm_powerups::specific_powerup_drop("nuke", self get_front_location());
}

spawn_random_powerup()
{
	random_powerups = array(::spawn_insta_kill, ::spawn_max_ammo, ::spawn_double_points, ::spawn_carpenter, ::spawn_nuke);

	random = array_randomize(random_powerups);
	
	[[ random[randomintrange(0,random.size)] ]]();
}

round_robin_use()
{
	level.zombie_total = 0;
	zombies = getAiArray(level.zombie_team);
	foreach (zombie in zombies)
	{
		zombie dodamage(zombie.health, zombie.origin);
	}
	foreach (player in level.players)
	{
		player.score += 2500;
	}
}

stock_option_use()
{
	if (self getweaponammoclip(self getcurrentweapon() ) < weaponclipsize( self getcurrentweapon() ))
	{
		if( self getammocount( self getcurrentweapon() ) > self getweaponammoclip( self getcurrentweapon() ) )
		{
			self setweaponammostock( self getcurrentweapon(), self getweaponammostock( self getcurrentweapon() ) - 1 );
			self setweaponammoclip( self getcurrentweapon(), self getweaponammoclip( self getcurrentweapon() ) + 1 );
		}
	}
}

free_fire_use()
{
	self setweaponammoclip( self getcurrentweapon(), self getammocount( self getcurrentweapon() ) );
}

perkaholic_use()
{
	machines = getentarray( "zombie_vending", "targetname" );
	perks = [];
	i = 0;
	while ( i < machines.size )
	{
		if ( machines[ i ].script_noteworthy == "specialty_weapupgrade" )
		{
			i++;
			continue;
		}
		perks[ perks.size ] = machines[ i ].script_noteworthy;
		i++;
	}
	foreach ( perk in perks )
	{
		if ( isDefined( self.perk_purchased ) && self.perk_purchased == perk )
		{
		}
		else
		{
			if ( self hasperk( perk ) || self maps\mp\zombies\_zm_perks::has_perk_paused( perk ) )
			{
			}
			else
			{
				self maps\mp\zombies\_zm_perks::give_perk( perk, 0 );
				wait 0.25;
			}
		}
	}
	if ( level.script == "zm_tomb" )
	{
		self maps\mp\zombies\_zm_perks::give_perk( "specialty_rof", 0 );
		wait 0.25;
		self maps\mp\zombies\_zm_perks::give_perk( "specialty_deadshot", 0 );
		wait 0.25;
		self maps\mp\zombies\_zm_perks::give_perk( "specialty_flakjacket", 0 );
		wait 0.25;
		self maps\mp\zombies\_zm_perks::give_perk( "specialty_grenadepulldeath", 0 );
	}
	self._retain_perks = 1;
}

crate_power_use()
{
	self endon ("gobble_pickedup");
	self endon ("gobblegum_switched");
	self waittill ( "user_grabbed_weapon" );
	upgrade_name = maps\mp\zombies\_zm_weapons::get_upgrade_weapon( self getcurrentweapon(), will_upgrade_weapon_as_attachment( self getcurrentweapon() ) );
	self takeweapon (self getcurrentweapon());
	self giveweapon (upgrade_name);
}

wall_power_use()
{
	self endon ("gobble_pickedup");
	self endon ("gobblegum_switched");
	for(;;)
	{
		level waittill ( "weapon_bought", player, weapon);
		if(player == self)
		{
			wait 0.2;
			upgrade_name = maps\mp\zombies\_zm_weapons::get_upgrade_weapon( weapon, will_upgrade_weapon_as_attachment( weapon ) );
			self takeweapon (weapon);
			self giveweapon (upgrade_name);
			self switchtoweapon (upgrade_name);
			break;
		}
	}
}

wonderbar_use()
{
	self endon ("gobble_pickedup");
	self endon ("gobblegum_switched");
	self waittill ("user_grabbed_weapon");
}

near_death_experience_use()
{
	foreach (player in level.players)
	{
		if(player player_is_in_laststand() && player != self)
		{
			if(distance(player.origin, self.origin) < 20)
			{
				player maps\mp\zombies\_zm_laststand::auto_revive( self );
				player thread return_retained_perks();
			}
		}
	}
}

profit_sharing_use()
{
	self endon ("gobble_pickedup");
	self endon ("gobblegum_switched");
	self waittill ("points_gained", points);
	foreach (player in level.players)
	{
		if(distance(self, player) < 100 && self != player)
		{
			player.score += points;
		}
	}
}

on_the_house_use()
{
	powerup_keys = getarraykeys( level.zombie_include_powerups );
	use_powerup_instead = undefined;
	foreach(powerup in powerup_keys)
	{
		use_powerup_instead = false;
	}
	
	if(use_powerup_instead)
	{
		level maps\mp\zombies\_zm_powerups::specific_powerup_drop("free_perk", self get_front_location());
	}
	else
	{
		self maps\mp\zombies\_zm_perks::give_random_perk();
	}
}

soda_fountain_use()
{
	self waittill( "perk_bought" );
	self maps\mp\zombies\_zm_perks::give_random_perk();
}

nowhere_but_there_use()
{
	foreach (player in level.players)
	{
		if(self != player && player maps\mp\zombies\_zm_laststand::player_is_in_laststand() )
		{
			downed_player = player;
		}
		self setorigin( player.origin );
		player maps\mp\zombies\_zm_laststand::auto_revive( self );
	}
}

phoenix_up_use()
{
	foreach (player in level.players)
	{
		if(self != player && player maps\mp\zombies\_zm_laststand::player_is_in_laststand() )
		{
			player maps\mp\zombies\_zm_laststand::auto_revive( self );
		}
	}
}

respin_cycle_use()
{
	foreach (box in level.chests)
	{
		if(box.chest_user == self)
		{
			box notify( "box_hacked_respin" );
		}
	}
}

temporal_gift_use()
{

}

idle_eyes_use()
{
    temp_ent = spawn( "script_origin", ( 0, 0, 0 ) );
    temp_ent playloopsound( "zmb_double_point_loop" );
	foreach(player in level.players)
	{
		player thread hide_player(self);
	}
	self.gobbleHUDText setText ("");
	self.gobbleHUDText setTimer (30);
	wait 30;
	self.gobbleHUDText setText ("");
	temp_ent delete();
}

hide_player(gum_user)
{
//	maps\mp\_visionset_mgr::vsmgr_activate( "visionset", "zm_powerup_zombie_blood_visionset", self );
	self.ignoreme = 1;
	wait 30;
//    maps\mp\_visionset_mgr::vsmgr_deactivate( "visionset", "zm_powerup_zombie_blood_visionset", self );
	self.ignoreme = 0;
}

anywhere_but_here_use()
{

	spawn_points = maps\mp\gametypes_zm\_zm_gametype::get_player_spawns_for_gametype();

    for ( j = 0; j < spawn_points.size; j++ )
    {
        if ( spawn_points[j].locked == 0 )
		{
			points[points.size] = spawn_points[j].origin;
		}
	}
	
	
	zombies = getAiArray(level.zombie_team);
	foreach (zombie in zombies)
	{
		if(distance(zombie.origin, self.origin) < 100)
		{
			zombie dodamage(zombie.health, zombie.origin);
		}
	}
	
	random_loc = array_randomize(points);

	self setOrigin (random_loc[randomintrange(0,random_loc.size-1)]);
}

undead_man_walking_use()
{
	zombies = getAiArray(level.zombie_team);
	foreach (zombie in zombies)
	{
		zombie maps\mp\zombies\_zm_utility::set_zombie_run_cycle("walk");
		zombie.zombie_move_speed = "walk";
	}
}

power_vacuum_use()
{
	level.powerup_drop_count = 0;
}

//////////////////////////////
// Check Functions
/////////////////////////////

check_downed_players()
{
	downed_players = 0;
	foreach (player in level.players)
	{
		if(player maps\mp\zombies\_zm_laststand::player_is_in_laststand() )
		{
			downed_players += 1;
		}
	}
	
	if(downed_players > 0)
	{
		return true;
	}
	else
	{
		return false;
	}
}


player_is_using_box()
{
	foreach (chest in level.chests)
	{
		zbarrier = getent( chest.script_noteworthy + "_zbarrier", "script_noteworthy" );
		if(zbarrier.chest_user == self)
		{
			return true;
		}
	}
	return false;
}

//////////////////////////////
// Replaced Functions
////////////////////////////

treasure_chest_weapon_spawn( chest, player, respin )
{
    if ( isdefined( level.using_locked_magicbox ) && level.using_locked_magicbox )
    {
        self.owner endon( "box_locked" );
        self thread maps\mp\zombies\_zm_magicbox_lock::clean_up_locked_box();
    }

    self endon( "box_hacked_respin" );
    self thread clean_up_hacked_box();
    assert( isdefined( player ) );
    self.weapon_string = undefined;
    modelname = undefined;
    rand = undefined;
    number_cycles = 40;

    if ( isdefined( chest.zbarrier ) )
    {
        if ( isdefined( level.custom_magic_box_do_weapon_rise ) )
            chest.zbarrier thread [[ level.custom_magic_box_do_weapon_rise ]]();
        else
            chest.zbarrier thread magic_box_do_weapon_rise();
    }

    for ( i = 0; i < number_cycles; i++ )
    {
        if ( i < 20 )
        {
            wait 0.05;
            continue;
        }

        if ( i < 30 )
        {
            wait 0.1;
            continue;
        }

        if ( i < 35 )
        {
            wait 0.2;
            continue;
        }

        if ( i < 38 )
            wait 0.3;
    }

    if ( isdefined( level.custom_magic_box_weapon_wait ) )
        [[ level.custom_magic_box_weapon_wait ]]();

    if ( isdefined( player.pers_upgrades_awarded["box_weapon"] ) && player.pers_upgrades_awarded["box_weapon"] )
        rand = maps\mp\zombies\_zm_pers_upgrades_functions::pers_treasure_chest_choosespecialweapon( player );
	else if(isDefined(level.gobblegums[player.gobblegum]) && level.gobblegums[player.gobblegum].id == "wonderbar")
		rand = get_wonderbar_weapons()[randomintrange(0,get_wonderbar_weapons().size)];
    else
        rand = treasure_chest_chooseweightedrandomweapon( player );

    self.weapon_string = rand;
    wait 0.1;

    if ( isdefined( level.custom_magicbox_float_height ) )
        v_float = anglestoup( self.angles ) * level.custom_magicbox_float_height;
    else
        v_float = anglestoup( self.angles ) * 40;

    self.model_dw = undefined;
    self.weapon_model = spawn_weapon_model( rand, undefined, self.origin + v_float, self.angles + vectorscale( ( 0, 1, 0 ), 180.0 ) );

    if ( weapon_is_dual_wield( rand ) )
        self.weapon_model_dw = spawn_weapon_model( rand, get_left_hand_weapon_model_name( rand ), self.weapon_model.origin - vectorscale( ( 1, 1, 1 ), 3.0 ), self.weapon_model.angles );

    if ( getdvar( #"magic_chest_movable" ) == "1" && !( isdefined( chest._box_opened_by_fire_sale ) && chest._box_opened_by_fire_sale ) && !( isdefined( level.zombie_vars["zombie_powerup_fire_sale_on"] ) && level.zombie_vars["zombie_powerup_fire_sale_on"] && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() ) )
    {
        random = randomint( 100 );

        if ( !isdefined( level.chest_min_move_usage ) )
            level.chest_min_move_usage = 4;

        if ( level.chest_accessed < level.chest_min_move_usage )
            chance_of_joker = -1;
        else
        {
            chance_of_joker = level.chest_accessed + 20;

            if ( level.chest_moves == 0 && level.chest_accessed >= 8 )
                chance_of_joker = 100;

            if ( level.chest_accessed >= 4 && level.chest_accessed < 8 )
            {
                if ( random < 15 )
                    chance_of_joker = 100;
                else
                    chance_of_joker = -1;
            }

            if ( level.chest_moves > 0 )
            {
                if ( level.chest_accessed >= 8 && level.chest_accessed < 13 )
                {
                    if ( random < 30 )
                        chance_of_joker = 100;
                    else
                        chance_of_joker = -1;
                }

                if ( level.chest_accessed >= 13 )
                {
                    if ( random < 50 )
                        chance_of_joker = 100;
                    else
                        chance_of_joker = -1;
                }
            }
        }

        if ( isdefined( chest.no_fly_away ) )
            chance_of_joker = -1;

        if ( isdefined( level._zombiemode_chest_joker_chance_override_func ) )
            chance_of_joker = [[ level._zombiemode_chest_joker_chance_override_func ]]( chance_of_joker );

        if ( chance_of_joker > random )
        {
            self.weapon_string = undefined;
            self.weapon_model setmodel( level.chest_joker_model );
            self.weapon_model.angles = self.angles + vectorscale( ( 0, 1, 0 ), 90.0 );

            if ( isdefined( self.weapon_model_dw ) )
            {
                self.weapon_model_dw delete();
                self.weapon_model_dw = undefined;
            }

            self.chest_moving = 1;
            flag_set( "moving_chest_now" );
            level.chest_accessed = 0;
            level.chest_moves++;
        }
    }

    self notify( "randomization_done" );

    if ( flag( "moving_chest_now" ) && !( level.zombie_vars["zombie_powerup_fire_sale_on"] && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() ) )
    {
        if ( isdefined( level.chest_joker_custom_movement ) )
            self [[ level.chest_joker_custom_movement ]]();
        else
        {
            wait 0.5;
            level notify( "weapon_fly_away_start" );
            wait 2;

            if ( isdefined( self.weapon_model ) )
            {
                v_fly_away = self.origin + anglestoup( self.angles ) * 500;
                self.weapon_model moveto( v_fly_away, 4, 3 );
            }

            if ( isdefined( self.weapon_model_dw ) )
            {
                v_fly_away = self.origin + anglestoup( self.angles ) * 500;
                self.weapon_model_dw moveto( v_fly_away, 4, 3 );
            }

            self.weapon_model waittill( "movedone" );
            self.weapon_model delete();

            if ( isdefined( self.weapon_model_dw ) )
            {
                self.weapon_model_dw delete();
                self.weapon_model_dw = undefined;
            }

            self notify( "box_moving" );
            level notify( "weapon_fly_away_end" );
        }
    }
    else
    {
        acquire_weapon_toggle( rand, player );

        if ( rand == "tesla_gun_zm" || rand == "ray_gun_zm" )
        {
            if ( rand == "ray_gun_zm" )
                level.pulls_since_last_ray_gun = 0;

            if ( rand == "tesla_gun_zm" )
            {
                level.pulls_since_last_tesla_gun = 0;
                level.player_seen_tesla_gun = 1;
            }
        }

        if ( !isdefined( respin ) )
        {
            if ( isdefined( chest.box_hacks["respin"] ) )
                self [[ chest.box_hacks["respin"] ]]( chest, player );
        }
        else if ( isdefined( chest.box_hacks["respin_respin"] ) )
            self [[ chest.box_hacks["respin_respin"] ]]( chest, player );

        if ( isdefined( level.custom_magic_box_timer_til_despawn ) )
            self.weapon_model thread [[ level.custom_magic_box_timer_til_despawn ]]( self );
        else
            self.weapon_model thread timer_til_despawn( v_float );

        if ( isdefined( self.weapon_model_dw ) )
        {
            if ( isdefined( level.custom_magic_box_timer_til_despawn ) )
                self.weapon_model_dw thread [[ level.custom_magic_box_timer_til_despawn ]]( self );
            else
                self.weapon_model_dw thread timer_til_despawn( v_float );
        }

        self waittill( "weapon_grabbed" );

        if ( !chest.timedout )
        {
            if ( isdefined( self.weapon_model ) )
                self.weapon_model delete();

            if ( isdefined( self.weapon_model_dw ) )
                self.weapon_model_dw delete();
        }
    }

    self.weapon_string = undefined;
    self notify( "box_spin_done" );
}

double_points_powerup( drop_item, player )
{
    level notify( "powerup points scaled_" + player.team );
    level endon( "powerup points scaled_" + player.team );
    team = player.team;
    level thread point_doubler_on_hud( drop_item, team, player );

    if ( isdefined( level.pers_upgrade_double_points ) && level.pers_upgrade_double_points )
        player thread maps\mp\zombies\_zm_pers_upgrades_functions::pers_upgrade_double_points_pickup_start();

    if ( isdefined( level.current_game_module ) && level.current_game_module == 2 )
    {
        if ( isdefined( player._race_team ) )
        {
            if ( player._race_team == 1 )
                level._race_team_double_points = 1;
            else
                level._race_team_double_points = 2;
        }
    }

    level.zombie_vars[team]["zombie_point_scalar"] = 2;
    players = get_players();

    for ( player_index = 0; player_index < players.size; player_index++ )
    {
        if ( team == players[player_index].team )
            players[player_index] setclientfield( "score_cf_double_points_active", 1 );
    }

	if(player.gobblegum.id == "temporal_gift" && player.gobblegum_active == 1)
	{
		wait 60;
	}
	else
	{
		wait 30;
	}
    level.zombie_vars[team]["zombie_point_scalar"] = 1;
    level._race_team_double_points = undefined;
    players = get_players();

    for ( player_index = 0; player_index < players.size; player_index++ )
    {
        if ( team == players[player_index].team )
            players[player_index] setclientfield( "score_cf_double_points_active", 0 );
    }
}

point_doubler_on_hud( drop_item, player_team, player )
{
    self endon( "disconnect" );

    if(player.gobblegum.id == "temporal_gift" && player.gobblegum_active == 1)
	{
		level.zombie_vars[player_team]["zombie_powerup_point_doubler_time"] = 60;
	}
	else
	{
		level.zombie_vars[player_team]["zombie_powerup_point_doubler_time"] = 30;
	}

    if ( level.zombie_vars[player_team]["zombie_powerup_point_doubler_on"] )
    {
        return;
    }

    level.zombie_vars[player_team]["zombie_powerup_point_doubler_on"] = 1;
    level thread time_remaining_on_point_doubler_powerup( player_team );
}

insta_kill_powerup( drop_item, player )
{
    level notify( "powerup instakill_" + player.team );
    level endon( "powerup instakill_" + player.team );

    if ( isdefined( level.insta_kill_powerup_override ) )
    {
        level thread [[ level.insta_kill_powerup_override ]]( drop_item, player );
        return;
    }

    if ( is_classic() )
        player thread maps\mp\zombies\_zm_pers_upgrades_functions::pers_upgrade_insta_kill_upgrade_check();

    team = player.team;
    level thread insta_kill_on_hud( drop_item, team, player );
    level.zombie_vars[team]["zombie_insta_kill"] = 1;
	if(player.gobblegum.id == "temporal_gift" && player.gobblegum_active == 1)
	{
		wait 60;
	}
	else
	{
		wait 30;
	}
    level.zombie_vars[team]["zombie_insta_kill"] = 0;
    players = get_players( team );

    for ( i = 0; i < players.size; i++ )
    {
        if ( isdefined( players[i] ) )
            players[i] notify( "insta_kill_over" );
    }
}

insta_kill_on_hud( drop_item, player_team, player )
{
    if(player.gobblegum.id == "temporal_gift" && player.gobblegum_active == 1)
	{
		level.zombie_vars[player_team]["zombie_powerup_insta_kill_time"] = 60;
	}
	else
	{
		level.zombie_vars[player_team]["zombie_powerup_insta_kill_time"] = 30;
	}
	
	if ( level.zombie_vars[player_team]["zombie_powerup_insta_kill_on"] )
    {
        return;
    }

    level.zombie_vars[player_team]["zombie_powerup_insta_kill_on"] = 1;
    level thread time_remaning_on_insta_kill_powerup( player_team );
}

add_to_player_score( points, add_to_total )
{
    if ( !isdefined( add_to_total ) )
        add_to_total = 1;

    if ( !isdefined( points ) || level.intermission )
        return;
	
    self.score = self.score + points;
    self.pers["score"] = self.score;

	self notify ("points_gained", points);

    if ( add_to_total )
        self.score_total = self.score_total + points;

    self incrementplayerstat( "score", points );
}