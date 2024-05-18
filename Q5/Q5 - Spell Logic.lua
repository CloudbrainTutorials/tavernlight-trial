-- Instantiates the spell effects in the world
function spellCallback(cid, postion, round)
    if Creature(cid) then
        -- Make sure each quadrant only runs three times and delay each round by 1 second
        if round < 3 then
            doAreaCombat(cid, COMBAT_ICEDAMAGE, postion, 0, -100, -100, CONST_ME_ICETORNADO)
            round = round + 1
            addEvent(spellCallback, 1000, cid, postion, round)
        end
    end
end

-- Initial Callback functions for each tornado section
function onTargetTileQ1(creature, position)
    spellCallback(creature:getId(), position, 0)
end
function onTargetTileQ2(creature, position)
    spellCallback(creature:getId(), position, 0)
end
function onTargetTileQ3(creature, position)
    spellCallback(creature:getId(), position, 0)
end
function onTargetTileQ4(creature, position)
    spellCallback(creature:getId(), position, 0)
end

-- Tornado section one parameters
local tornadoQuad1 = Combat()
tornadoQuad1:setArea(createCombatArea(AREA_WINDQ1))
tornadoQuad1:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTileQ1")

-- Tornado section two parameters
local tornadoQuad2 = Combat()
tornadoQuad2:setArea(createCombatArea(AREA_WINDQ2))
tornadoQuad2:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTileQ2")

-- Tornado section three parameters
local tornadoQuad3 = Combat()
tornadoQuad3:setArea(createCombatArea(AREA_WINDQ3))
tornadoQuad3:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTileQ3")

-- Tornado section four parameters
local tornadoQuad4 = Combat()
tornadoQuad4:setArea(createCombatArea(AREA_WINDQ4))
tornadoQuad4:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTileQ4")

-- Runs the four seperate spell quadrants in staggered succession
function onCastSpell(creature, variant)
    tornadoQuad1:execute(creature, variant)
    addEvent(function(creature, variant)
        tornadoQuad2:execute(creature, variant)
    end, 300, creature, variant)
    addEvent(function(creature, variant)
        tornadoQuad3:execute(creature, variant)
    end, 600, creature, variant)
    addEvent(function(creature, variant)
        tornadoQuad4:execute(creature, variant)
    end, 900, creature, variant)
end