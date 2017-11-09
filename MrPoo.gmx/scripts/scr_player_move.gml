///scr_player_move();

if (canMove || canJump) {
    //Get the player's input
    key_right = (keyboard_check(vk_right));
    key_left = (keyboard_check(vk_left)) * -1;
    key_jump = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_up);
    key_jump_held = keyboard_check(vk_space) || keyboard_check(vk_up);
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
    
    if (move == 0 && place_meeting(x,y+1,obj_wall)) {
        if (hsp < -acceleration) {
            hsp += 5;
        } else if (hsp > acceleration) {
            hsp -= 5;
        } else {
            hsp = 0;
        }
    } else if (move == 0 && !place_meeting(x,y+1,obj_wall)) {
        if (hsp < -acceleration) {
            hsp += 0.15;
        } else if (hsp > acceleration) {
            hsp -= 0.15;
        } else {
            hsp = 0;
        }
    }
    
    if (vsp < 0 && !key_jump_held) vsp = max(vsp, -jumpspeed / 2);
    
    if (!place_meeting(x+1,y,obj_wall) && !place_meeting(x-1,y,obj_wall)) {
        if (vsp < 31) vsp += obj_game.GRAVITY;
    } else {
        if (vsp < 31) vsp += obj_game.GRAVITY * 0.3;
    }
    
    if (place_meeting(x,y+1,obj_wall)) {
        vsp = key_jump * -jumpspeed;
    } else {
        vsp += key_down * jumpspeed * 0.6;
    }
    
    //Horizontal Collision
    if (place_meeting(x+hsp,y,obj_wall))
    {
        timeOnWall++;
        if (timeOnWall < 1) {
            vsp /= 2;
        }
        while(!place_meeting(x+sign(hsp),y,obj_wall))
        {
            x += sign(hsp);
        }
        
        hsp = 0;
    }
    x += hsp;
    
    if (wallJumped) {
        timeSinceLastWallJump++;
        canMove = false;
        if (timeSinceLastWallJump > 7) {
            timeSinceLastWallJump = 0;
            wallJumped = false;
            canMove = true;
        }
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
}
