Enemy.new(name: 'fire_spirit', jp_name: 'ファイアスピリット', hp: 10, strength: 1, exp: 10, use_skills: [{ skill_name: 'fire_breath', use_rate: 0...50 }])
Enemy.new(name: 'ice_spirit', jp_name: 'アイススピリット', hp: 10, strength: 1, exp: 10, use_skills: [{ skill_name: 'fire_breath', use_rate: 0...50 }])
Enemy.new(name: 'bear', jp_name: '熊', hp: 10, strength: 1, exp: 10)

module EncountList
  @@enemys = EnemyList.enemy_list
  FOREST_ENCOUNT_LIST = [
    { enemy_instance: @@enemys[:fire_spirit], encount_rate: 0...45 },
    { enemy_instance: @@enemys[:ice_spirit], encount_rate: 45...90 },
    { enemy_instance: @@enemys[:bear], encount_rate: 90..100 }
  ].freeze
  ENCOUNT_LIST = {
    forest: FOREST_ENCOUNT_LIST
  }.freeze
end

module BattleData
  SKILL_LIST = [
    { skill_type: 'damege', name: 'atk', jp_name: '攻撃', ratio: 1.0, element: 'nomal' },
    { skill_type: 'damege', name: 'fire_breath', jp_name: 'ファイアブレス', ratio: 1.2, element: 'fire' },
    { skill_type: 'damege', name: 'blizzard', jp_name: 'ブリザード', ratio: 1.2, element: 'ice' }
  ].freeze

  # 弱点表
  # forest はまだ作ってないけどこんな感じに入れればできる
  ELEMENT_LIST = [{ use: 'fire', weak: %w[ice forest], resist: ['fire'] },
                  { use: 'ice', weak: ['fire'], resist: ['ice'] }].freeze
end

module CharacterImages
  PLAYER_IMAGE = Image.load('./media/character/hero.png')
  ENEMY_IMAGES = [{ name: 'fire_spirit', image: Image.load('./media/character/spi_fire.png') },
                  { name: 'ice_spirit', image: Image.load('./media/character/spi_ice.png') },
                  { name: 'bear', image: Image.load('./media/character/boss_bear.png') }].freeze
end
