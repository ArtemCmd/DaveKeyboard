# DaveKeyboard
On-Screen keyboard for [VoxelCore](https://github.com/MihailRis/voxelcore).
# Usage
```lua
-- Show keyboard:
hud.open_permanent("dave_keyboard:keyboard")
-- Hide keyboard:
hud.close("dave_keyboard:keyboard")

events.on("dave_keyboard:keyboard.key_pressed", function(key)
    print("Key: " .. key .. "pressed!")
end)

events.on("dave_keyboard:keyboard.send_text", function(text)
    print("Text: " .. text .. "has been sent!")
end)
```
