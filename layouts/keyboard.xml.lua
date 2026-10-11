local click_pos = {0, 0}
local pressed = false
local initialized = false

local function update_keyboard()
    local mouse_pos = input.get_mouse_pos()
    local mouse_pressed = input.is_pressed("mouse:left")
    local keyboard = document.root

    if not pressed and mouse_pressed then
        if (mouse_pos[1] >= keyboard.pos[1]) and (mouse_pos[1] <= (keyboard.pos[1] + keyboard.size[1])) and (mouse_pos[2] >= keyboard.pos[2]) and (mouse_pos[2] <= (keyboard.pos[2] + keyboard.size[2])) then
            click_pos[1] = mouse_pos[1] - keyboard.pos[1]
            click_pos[2] = mouse_pos[2] - keyboard.pos[2]
            pressed = true
        end

        return
    elseif not mouse_pressed then
        pressed = false
        return
    end

    keyboard.pos = {mouse_pos[1] - click_pos[1], mouse_pos[2] - click_pos[2]}
end

function press_key(key)
    events.emit("dave_keyboard:keyboard.key_pressed", key)
end

function switch_key(key, button_id)
    local button = document[button_id]
    local temp = button.color

    button.color = button.hoverColor
    button.hoverColor = temp

    press_key(key)
end

function send()
    local clipboard = document.clipboard

    events.emit("dave_keyboard:keyboard.send_text", clipboard.text)
    clipboard.text = ""
end

function on_open()
    local keyboard = document.root
    local viewport = gui.get_viewport()

    if not initialized then
        initialized = true
        keyboard:setInterval(100, update_keyboard)
    end

    input.add_callback("key:escape", function()
        hud.close("dave_keyboard:keyboard")
    end, document.root)

    keyboard.pos = {viewport[1] / 2 - keyboard.size[1] / 2, viewport[2] / 2 - keyboard.size[2] / 2}
end

function on_close()
    document.clipboard.text = ""
    pressed = false
    events.emit("dave_keyboard:keyboard.close")
end
