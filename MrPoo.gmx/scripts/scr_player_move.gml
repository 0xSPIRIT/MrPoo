///scr_player_move();

//Get the player's input
key_right = (keyboard_check(vk_right) || keyboard_check(ord("D")));
key_left = (keyboard_check(vk_left) || keyboard_check(ord("A"))) * -1;
key_jump = (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space));
key_jump_held = (keyboard_check(ord("W")) || keyboard_check(vk_up) || keyboard_check(vk_space));
key_down = (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down));

//React to inputs
move = key_left + key_right;
hsp += move * acceleration;

if (vsp > 40) vsp = 40;

if (hsp > movespeed) {
    hsp = movespeed;
}
if (hsp < -movespeed) {
    hsp = -movespeed;
}

if (move == 0) {
    if (hsp < -acceleration) {
        hsp += frction;
    } else if (hsp > acceleration) {
        hsp -= frction;
    } else {
        hsp = 0;
    }
}

if (vsp < 0 && !key_jump_held) vsp = max(vsp, -jumpspeed / 2);

if (vsp < 31) vsp += obj_game.GRAVITY;

if (place_meeting(x,y+1,obj_wall)) {
    vsp = key_jump * -jumpspeed;
} else {
    vsp += key_down * jumpspeed * 0.6;
}

//Horizontal Collision
if (place_meeting(x+hsp,y,obj_wall))
{
    while(!place_meeting(x+sign(hsp),y,obj_wall))
    {
        x += sign(hsp);
    }
    
    hsp = 0;
}
x += hsp;

if ((key_jump) && (place_meeting(x+2,y,obj_wall))) {
    vsp = -jumpspeed;
    hsp -= 20;
}
if ((key_jump) && (place_meeting(x-2,y,obj_wall))) {
    vsp = -jumpspeed;
    hsp += 20;
}
//Vertical Collision

if (place_meeting(x,y+vsp,obj_wall))
{
    while(!place_meeting(x,y+sign(vsp),obj_wall))
    {
        y += sign(vsp);
    }
    vsp = 0;
}

y += vsp;
