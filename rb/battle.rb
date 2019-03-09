class Battle
  def self.battle_run(player, stage,encount_value:rand(100))
    enemy = EnemyEncount.encount(stage,encount_value)
    BattleResult.battle_result(player, enemy,Fight.fighting(player, enemy))
 end
end

class EnemyEncount
  def self.encount(stage,encount_value)
    enemy = EncountList::Encount_list[stage.to_sym].find { |i| i[:encount_rate].include?(encount_value)}
    enemy[:enemy_instance]
  end
end

class Fight
  def self.fighting(player, enemy)
    fight_scene = 'player'
    loop do
      case fight_scene
      when 'player'
        # 表示テキストをなくしてボタンとかメニューにする処理
        # 入力待ち
        player_act_select = true
        if player_act_select
          Skill.use_skill(player, enemy, 'atk')
          return 'win' if enemy.hp <= 0

          player_act_select = false
          fight_scene = 'enemy'
        end
      when 'enemy'
        Skill.use_skill(enemy, player, 'atk')
        return  'lose' if player.hp <= 0

        fight_scene = 'player'
      end
    end
  end
end

class BattleResult
  def self.battle_result(player, enemy,flg)
    case flg
    when 'win'
      player.exp += enemy.exp
    when 'lose'
      player.hp = player.max_hp
    when 'escape'
    end
    enemy.hp = enemy.ini_hp
    BattleText.battle_result_text(flg)
  end
end
