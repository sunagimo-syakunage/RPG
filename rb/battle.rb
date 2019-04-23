class Battle
  @@battlescene = 'encount'

  def self.run(player, stage, encount_value: rand(100), auto: false, test_mode: false)
    loop do
      flg = battle(player, stage, encount_value: rand(100), auto: auto, test_mode: test_mode)
      return flg if flg
    end
  end

  def self.battle(player, stage, encount_value: rand(100), auto: false, test_mode: false)
    case @@battlescene
    when 'encount'
      @@enemy = EnemyEncount.encount(stage, encount_value)
      BattleText.encount_text(@@enemy)
      # @@battlescene = 'fight'
      @@battlescene = 'encount_click'
    when 'encount_click'
      @@battlescene = 'fight' if auto || Input.mousePush?(M_LBUTTON)
    when 'fight'
      @@flg = Fight.fighting(player, @@enemy, auto: auto)
      @@battlescene = 'result' if @@flg
    when 'result'
      BattleText.battle_result_text(@@flg)
      @@battlescene = 'result_click'
    when 'result_click'
      @@battlescene = 'encount' if auto || Input.mousePush?(M_LBUTTON)
      return BattleResult.battle_result(player, @@enemy, @@flg)
    end
    BattleView.run(@@enemy) unless test_mode
    false
 end
end

class EnemyEncount
  def self.encount(stage, encount_value)
    enemy = EncountList::ENCOUNT_LIST[stage.to_sym].find { |i| i[:encount_rate].include?(encount_value) }
    enemy[:enemy_instance]
  end
end

# module Turn
#   def self.enemy_turn(player, enemy)
#             Skill.use_skill(enemy, player, 'atk')
#   end
#
#   def self.player_turn(player, enemy)
#
#
#     end
#   end
# end

class Fight
  @@fight_scene = 'player'
  @@player_act_select = false

  def self.run(player, enemy, auto: false)
    loop do
      flg = fighting(player, enemy, auto: auto)
      return flg if flg
    end
  end

  def self.fighting(player, enemy, auto: false)
    case @@fight_scene
    when 'player'
      return 'lose' if player.hp <= 0

      # 表示テキストをなくしてボタンとかメニューにする処理
      # 入力待ち
      @@player_act_select = 'atk'
      @@fight_scene = 'player_selected' if @@player_act_select
    when 'player_selected'
      player_skill = Skill.use_skill(player, enemy, @@player_act_select)
      BattleText.damege_skill_text(player, enemy, player_skill)
      @@fight_scene = 'player_selected_click'
    when 'player_selected_click'
      @@fight_scene = 'enemy' if auto || Input.mousePush?(M_LBUTTON)
    when 'enemy'
      @@player_act_select = false
      return 'win' if enemy.hp <= 0

      enemy_skill = enemy.enemy_act(player)
      BattleText.damege_skill_text(enemy, player, enemy_skill)
      @@fight_scene = 'enemy_click'
    when 'enemy_click'
      @@fight_scene = 'player' if auto || Input.mousePush?(M_LBUTTON)
  end
    false
end
end

class BattleResult
  def self.battle_result(player, enemy, flg)
    case flg
    when 'win'
      player.exp += enemy.exp
    when 'lose'
      player.hp = player.max_hp
    when 'escape'
    end
    enemy.hp = enemy.ini_hp
    flg
  end
end
