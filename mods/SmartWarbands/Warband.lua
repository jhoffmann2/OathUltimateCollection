-- just a fun easter egg to demonstrate the capabilities of tag scripts
-- set the description of a warband to "Rainbow" and enjoy the show ;)
function onUpdate()
  if owner.getDescription() == "Rainbow" then
    owner.setColorTint(Color(
        math.random(0, 255) / 255,
        math.random(0, 255) / 255,
        math.random(0, 255) / 255
    ))
  end
end