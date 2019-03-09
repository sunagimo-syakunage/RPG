class Texts
  def self.output(str)
    puts str
  end
end

class BattleText <Texts

  def self.battle_result_text(flg)
    str=[]
    case flg
    when 'win'
      str << "戦闘に勝利した"
    when 'lose'
      str << "戦闘に敗北した"
    when 'escape'
    end
    output(str.join)
    str.join
  end

  def self.damege_skill_text(attacker, defender, select_skill, damege)
    str = []
    str << "#{attacker.jp_name}の#{select_skill[:jp_name]}\n"
    # は防御した
    str << "#{defender.jp_name}は#{damege}ダメージを受けた"
    output(str.join)
    str.join
  end
end
