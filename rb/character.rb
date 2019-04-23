# 基礎的なステータスと通常攻撃
# 名前、体力、攻撃力、属性、防御したかどうか、生きているか、初期体力、最大体力、初期攻撃力、経験値がいじれる
# いじれるとやばい系はいじれないように
class Character
  attr_accessor :name, :jp_name, :hp, :strength, :element, :defence_flg, :alive_flg, :max_hp, :exp
  attr_reader :ini_hp, :ini_strength
  def initialize(name:, jp_name:, hp:, strength:, element: 'nomal', exp: 0)
    @name = name
    @jp_name = jp_name
    @hp = hp
    @strength = strength
    @element =  element
    @exp = exp
    @ini_hp = hp
    @max_hp = hp
    @ini_strength = strength
    @defence_flg = false
    @alive_flg = true
  end
end

class Player < Character
  attr_accessor :level
  def initialize(name: 'player', jp_name:, hp:, strength:, element: 'nomal', exp: 0)
    @level = 1
    super(name: name, jp_name: jp_name, hp: hp, strength: strength, element: element, exp: exp)
  end
end

class Enemy < Character
  def initialize(name:, jp_name:, hp:, strength:, element: 'nomal', exp: 0, use_skills: [{ skill_name: 'atk', use_rate: 0..100 }])
    @use_skills = use_skills
    super(name: name, jp_name: jp_name, hp: hp, strength: strength, element: element, exp: exp)
    EnemyList.enemy_add(self)
  end

  def enemy_act(other, use: rand(100))
    if select = @use_skills.find { |i| i[:use_rate].include?(use) }
      Skill.use_skill(self, other, select[:skill_name])
    else
      Skill.use_skill(self, other, 'atk')
    end
  end
end

class EnemyList
  @@enemy_list = {}

  def self.enemy_add(enemy)
    @@enemy_list[enemy.name.to_sym] = enemy
  end

  def self.enemy_list
    @@enemy_list
  end
end
