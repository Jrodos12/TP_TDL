--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.switchinvulnerable = false
    self.switchinvulnerableDuration = 0
    self.switchinvulnerableTimer = 0
    self.switchflashTimer = 0
    self.armor = 0
    self.silver_chest_keys = 0
    
end

function Player:give_silver_chest_keys(amount)
    self.silver_chest_keys = self.silver_chest_keys + amount
end

function Player:try_to_open_silver_chest()
    if self.silver_chest_keys == 0 then
        return false
    end
    if self.silver_chest_keys > 0 then
        self.silver_chest_keys = self.silver_chest_keys - 1
        return true
    end
end

function Player:add_armor(amount)
    if self.armor < 4 then
        self.armor = self.armor + amount
    end
end

function Player:cantPressSwitch(duration)
    self.switchinvulnerable = true
    self.switchinvulnerableDuration = duration
end

function Player:update(dt)
    Entity.update(self, dt)
    if self.switchinvulnerable then
      self.switchflashTimer = self.switchflashTimer + dt
      self.switchinvulnerableTimer = self.switchinvulnerableTimer + dt

    if self.switchinvulnerableTimer > self.switchinvulnerableDuration then
        self.switchinvulnerable = false
        self.switchinvulnerableTimer = 0
        self.switchinvulnerableDuration = 0
        self.switchflashTimer = 0
    end
  end--
end

function Player:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY - 11 > target.y + target.height) --ajuste altura
end

function Player:render()
    Entity.render(self)
     --love.graphics.setColor(255, 0, 255, 255)
     --love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
     --love.graphics.setColor(255, 255, 255, 255)
end

function Player:damage(dmg)
    if not self.invulnerable then
        if self.armor > 0 then
            local remaining_damage = dmg - self.armor
            self.armor = self.armor - dmg
            if remaining_damage > 0 then
                self.health = self.health - dmg
            end
        else
            self.health = self.health - dmg
        end
    end
end