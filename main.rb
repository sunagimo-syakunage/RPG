# require 'dxopal'
# include DXOpal
# require_remote './rb/skill.rb'
# require_remote './rb/character.rb'
# require_remote './rb/battle.rb'
# require_remote './rb/texts.rb'
# require_remote './rb/ui.rb'
# require_remote './rb/scene.rb'
require 'dxruby'
require_relative './rb/skill.rb'
require_relative './rb/character.rb'
require_relative './rb/battle.rb'
require_relative './rb/texts.rb'
require_relative './rb/ui.rb'
require_relative './rb/scene.rb'
require_relative './rb/data.rb'
WindowSetting.window_size_preset
@testkun = Player.new(name: 'player', jp_name: 'テスト君1号', hp: 20, strength: 6, element: 'nomal')
@testenemy = Enemy.new(name: 'red', jp_name: 'テストエネミー', hp: 20, strength: 11, exp: 10)
Window.loop do
  TextField.run
  CharacterView.player_view
  Battle.battle(@testkun, 'forest')
end
