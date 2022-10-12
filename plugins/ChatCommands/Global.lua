
local commands = {}

function onLoad(saveString)
  if saveString and saveString ~= "" then
    commands = JSON.decode(saveString)
  end
  
  Method.AddCommand({
    identifier = '!help',
    eventName = 'OnCommand_Help',
    description = 'Print this message.'
  })
end

function onSave()
  return JSON.encode(commands)
end

function Callback.OnCommand_Help(chatPlayer)
  local headerColor = "[61fff4]"
  local commandColor = "[c4ffed]"
  local paramColor = "[f79081]"
  local popColor = "[-]"
  
  function printCommand(commandInfo)
    
    local prettyCommandName = commandColor..commandInfo.identifier
    for _, parameter in ipairs(commandInfo.parameters) do
      prettyCommandName = prettyCommandName..' '..'<'..paramColor..parameter..popColor..'>'
    end
    prettyCommandName = prettyCommandName..popColor
    
    printToColor(string.format("%s    %s", prettyCommandName, commandInfo.description), chatPlayer.color)
  end
  
  printToColor("", chatPlayer.color)
  printToColor(headerColor.."Chat commands for all players:"..popColor, chatPlayer.color)
  for identifier, commandInfo in pairs(commands) do
    if not commandInfo.hostOnly then
      printCommand(commandInfo)
    end
  end

  printToColor("", chatPlayer.color)
  printToColor(headerColor.."Chat commands only usable by the host:"..popColor, chatPlayer.color)
  for identifier, commandInfo in pairs(commands) do
    if commandInfo.hostOnly then
      printCommand(commandInfo)
    end
  end
  
  printToColor("", chatPlayer.color)
  printToColor("", chatPlayer.color)
end

function Method.AddCommand(command)
  if command.hostOnly == nil then
    command.hostOnly = false
  end
  if command.parameters == nil then
    command.parameters = {}
  end
  
  commands[command.identifier] = command
end


function tokenize(s)
  local tokens = {}
  for v in s:gmatch("([^%s]+)%s*") do
    table.insert(tokens, v)
  end
  return tokens
end

function onChat(message, chatPlayer)
  Wait.frames(
    function()
      if message:sub(1,1) ~= '!' then
        return
      end

      local tokens = tokenize(message)
      local command = commands[tokens[1]]
      if command then
        if command.hostOnly and not chatPlayer.host then
          printToColor("Only the host can use that command", chatPlayer.color)
        end
        tokens[1] = chatPlayer
        InvokeEvent(command.eventName, table.unpack(tokens))
      else
        printToColor("Error, unknown command.", chatPlayer.color)
      end
    end,
    1)
end