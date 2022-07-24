

---@param obj tts__Object
function GetObjectAABB(obj)
  local bounds = obj.getBounds()
  bounds.size.x = math.max(bounds.size.x, obj.getScale().x)
  bounds.size.y = math.max(bounds.size.y, obj.getScale().y)
  bounds.size.z = math.max(bounds.size.z, obj.getScale().z)

  return {
    min = Vector(
        bounds.center.x - (bounds.size.x / 2),
        bounds.center.y - (bounds.size.y / 2),
        bounds.center.z - (bounds.size.z / 2)
    ),
    max = Vector(
        bounds.center.x + (bounds.size.x / 2),
        bounds.center.y + (bounds.size.y / 2),
        bounds.center.z + (bounds.size.z / 2)
    ),
  }
end

function AABBIntersect(a, b, ignoreY)
  return (a.min.x <= b.max.x and a.max.x >= b.min.x) and
      (ignoreY or (a.min.y <= b.max.y and a.max.y >= b.min.y)) and
      (a.min.z <= b.max.z and a.max.z >= b.min.z)
end

function pointInAABB(a, p, ignoreY)
  return (p.x >= a.min.x and p.x <= a.max.x) and
      (ignoreY or (p.y >= a.min.y and p.y <= a.max.y)) and
      (p.z >= a.min.z and p.z <= a.max.z)
end