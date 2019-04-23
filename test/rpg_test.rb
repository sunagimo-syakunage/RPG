require 'minitest/autorun'
require 'dxruby'
require_relative '../rb/skill.rb'
require_relative '../rb/character.rb'
require_relative '../rb/battle.rb'
require_relative '../rb/texts.rb'
require_relative '../rb/ui.rb'
require_relative '../rb/data.rb'

class CharacterTest < Minitest::Test
  def setup
    @testkun = Character.new(name: 'test', jp_name: 'テスト君1号', hp: 10_000, strength: 1, element: 'nomal')
    @iceman = Character.new(name: 'iceman', jp_name: 'テストアイスマン', hp: 10_000, strength: 1, element: 'ice')
    @enemy = Enemy.new(name: 'enemy', jp_name: 'テストエネミー', hp: 10, strength: 100, use_skills: [{ skill_name: 'fire_breath', use_rate: 0...40 },
                                                                                                     { skill_name: 'blizzard', use_rate: 40...80 }])
  end

  def test_to_enemy
    assert_equal @enemy.strength, 100
    assert_equal @enemy.enemy_act(@testkun, use: 100), damege: 100, select_skill: { skill_type: 'damege', name: 'atk', jp_name: '攻撃', ratio: 1.0, element: 'nomal' }
    assert_equal @testkun.hp, @testkun.ini_hp - 100
    assert_equal Damege.calc(@enemy, @testkun), 100
    assert_equal @enemy.enemy_act(@testkun, use: 20), damege: 120, select_skill: { skill_type: 'damege', name: 'fire_breath', jp_name: 'ファイアブレス', ratio: 1.2, element: 'fire' }
    assert_equal @enemy.enemy_act(@testkun, use: 40), damege: 120, select_skill: { skill_type: 'damege', name: 'blizzard', jp_name: 'ブリザード', ratio: 1.2, element: 'ice' }
    assert_equal @enemy.enemy_act(@iceman, use: 20), damege: 156, select_skill: { skill_type: 'damege', name: 'fire_breath', jp_name: 'ファイアブレス', ratio: 1.2, element: 'fire' }
    assert_equal @enemy.enemy_act(@iceman, use: 40), damege: 96, select_skill: { skill_type: 'damege', name: 'blizzard', jp_name: 'ブリザード', ratio: 1.2, element: 'ice' }
  end
end

class BattleTest < Minitest::Test
  def setup
    @testkun = Player.new(name: 'test', jp_name: 'テスト君1号', hp: 10, strength: 1, element: 'nomal')
    @testkun2 = Player.new(name: 'test2', jp_name: 'テスト君2号', hp: 5, strength: 0, element: 'nomal')
    @enemy = Enemy.new(name: 'enemy', jp_name: 'テストエネミー', hp: 10, strength: 1, exp: 10, use_skills: [{ skill_name: 'fire_breath', use_rate: 0...40 },
                                                                                                            { skill_name: 'blizzard', use_rate: 40...80 }])
  end

  def test_to_battle
    assert_equal Fight.run(@testkun2, @enemy, auto: true), 'lose'
    assert_equal Fight.run(@testkun, @enemy, auto: true), 'win'
    @testkun.hp = @testkun.ini_hp
    @testkun2.hp = @testkun2.ini_hp
    @enemy.hp = @enemy.ini_hp
    assert_equal Battle.run(@testkun2, 'forest', encount_value: 20, auto: true, test_mode: true), 'lose'
    assert_equal Battle.run(@testkun, 'forest', encount_value: 20, auto: true, test_mode: true), 'win'
    assert_equal Battle.run(@testkun2, 'forest', encount_value: 20, auto: true, test_mode: true), 'lose'
    assert_equal Battle.run(@testkun, 'forest', encount_value: 20, auto: true, test_mode: true), 'lose'
    assert_equal @testkun.exp, 10
    assert_equal EnemyList.enemy_list[:fire_spirit].name, 'fire_spirit'
    assert_equal EnemyEncount.encount('forest', 20).name, 'fire_spirit'
  end
end
