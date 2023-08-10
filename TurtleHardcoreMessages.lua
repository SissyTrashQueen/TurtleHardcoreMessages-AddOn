local function nameToLink(playerName) return '\124cffffffff\124Hplayer:'..playerName..'\124h['..playerName..']\124h\124r' end

local Original_ChatFrame_OnEvent = ChatFrame_OnEvent
function ChatFrame_OnEvent(event)
  if event=='CHAT_MSG_SYSTEM' and arg1 then
    local name, level, init
    --Anyname has reached level 10 in Hardcore mode! Their ascendance towards immortality continues, however, so do the dangers they will face.
    --Anyname has reached level 20 in Hardcore mode! Their ascendance towards immortality continues, however, so do the dangers they will face.
    --Anyname has reached level 30 in Hardcore mode! Their ascendance towards immortality continues, however, so do the dangers they will face.
    --Anyname has reached level 40 in Hardcore mode! Their ascendance towards immortality continues, however, so do the dangers they will face.
    --Anyname has reached level 50 in Hardcore mode! Their ascendance towards immortality continues, however, so do the dangers they will face.
    --Anyname has transcended death and reached level 60 on Hardcore mode without dying once! Anyname shall henceforth be known as the Immortal!
    --Anyname has laughed in the face of death in the Hardcore challenge. Anyname has begun the Inferno Challenge!
    if strfind(arg1, 'Hardcore mode') or strfind(arg1, 'Hardcore challenge') then
      if strfind(arg1, 'ascendance towards') then
        name = nameToLink(strsub(arg1, 1, strlen(arg1) - 130)) --name acquired
        --
        _, init = strfind(arg1, 'reached level ')
        level = strsub(arg1, init + 1, strfind(arg1, ' in Hardcore') - 1)  --level acquired
        arg1 = 'HC News: '..name..' has reached level '..level..'!'

      elseif strfind(arg1, 'transcended death') then
        name = nameToLink(strsub(arg1, 1, strfind(arg1, ' has transcended') - 1)) --name acquired
        arg1 = 'HC News: '..name..' has transcended death by reaching level 60!'

      else --Inferno challenge
        name = nameToLink(strsub(arg1, 1, strfind(arg1, ' has laughed') - 1)) --name acquired
        arg1 = 'HC News: '..name..' has begun the Infernal Challenge by reaching level 60!'
      end
      
    elseif strfind(arg1, 'A tragedy has occurred.') then
      --A tragedy has occurred. Hardcore character Any has fallen to NPCName (level 40) at level 1. May this sacrifice not be forgotten.
      --A tragedy has occurred. Hardcore character Any has fallen in PvP to Enemyname at level 20. May this sacrifice not be forgotten.
      --A tragedy has occurred. Hardcore character Any died of natural causes at level 7. May this sacrifice not be forgotten.

      --A tragedy has occurred. Inferno character has fallen to NPCName (level 63) at level 60. They laughed in the face of death, but have learnt that death always has the last laugh.
      --A tragedy has occurred. Inferno character has fallen in PvP to Enemyname at level 60. They laughed in the face of death, but have learnt that death always has the last laugh.
      --A tragedy has occurred. Inferno character died of natural causes at level 60. They laughed in the face of death, but have learnt that death always has the last laugh.
      _, init = strfind(arg1, 'at level ')
      level = strsub(arg1, init + 1, strfind(arg1, '%. May') - 1) --level acquired
      
      if strfind(arg1, 'fallen') then
        if strfind(arg1, 'Hardcore character') then
          _, init = strfind(arg1, 'Hardcore character ')
          name = nameToLink(strsub(arg1, init + 1, strfind(arg1, ' has fallen') - 1))
        else
          name = 'Infernal Player'
        end
        _, init = strfind(arg1, ' to ')
        if not strfind(arg1, 'in PvP') then
          otherName = '"'..strsub(arg1, init + 1, strfind(arg1, ' %(level') - 1)..'"' --otherName acquired
          _, init = strfind(arg1, '%(level ')
          otherLevel = strsub(arg1, init + 1, strfind(arg1, '%) at') - 1) --otherLevel acquired
          arg1 = 'HC News: '..name..' has fallen to '..otherName..' (level '..otherLevel..') at level '..level..'.'

        else --PvP
          otherName = nameToLink(strsub(arg1, init + 1, strfind(arg1, ' at ') - 1)) --otherName acquired
          arg1 = 'HC News: '..name..' has fallen to '..otherName..' at level '..level..'.'
        end

      else --natural causes
        if strfind(arg1, 'Hardcore character') then
          _, init = strfind(arg1, 'Hardcore character ')
          name = nameToLink(strsub(arg1, init + 1, strfind(arg1, ' died of') - 1))
        else
          name = 'Infernal Player'
        end
        arg1 = 'HC News: '..name..' died of natural causes at level '..level..'.'
      end
    end
  end
  
  Original_ChatFrame_OnEvent(event)
end