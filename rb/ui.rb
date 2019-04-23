class UI < Sprite
end
# カーソルはスプライトじゃなくて範囲でしたほうがいいのでは

class WindowSetting
  def self.window_size_preset(mode: 'svga')
    case mode
    when 'svga'
      window_size(width: 800, height: 600)
      TextField.setting
    when 'max'
      window_max_size = Window.get_screen_modes.max
      window_size(width: window_max_size[0], height: window_max_size[1])
      TextField.setting
    when 'full'
      window_size(width: window_max_size[0], height: window_max_size[1], full_screen_mode: true)
      TextField.setting
    end
  end

  def self.window_size(width:, height:, full_screen_mode: false, bgcolor: [180, 180, 180])
    Window.width = width
    Window.height = height
    Window.full_screen = full_screen_mode
    Window.bgcolor = bgcolor
  end
end

class TextField
  def self.setting
    @@font_size = Window.width / 25
    @@text_field_width = Window.width
    @@text_field_height = @@font_size * 5
    @@text_field_x = 0
    @@text_field_y = Window.height - @@text_field_height
    @@text_field_background = Image.new(@@text_field_width, @@text_field_height, [50, 50, 50]).box(@@font_size / 2, @@font_size / 2, @@text_field_width - @@font_size / 2, @@text_field_height - @@font_size / 2, [255, 255, 255])
    @@text_x = @@text_field_x + @@font_size
    @@text_y = @@text_field_y + @@font_size
    @@font = Font.new(@@font_size)
    @@str = ''
  end

  def self.run
    Window.draw_font(@@text_x, @@text_y, @@str, @@font, z: 1)
    Window.draw(@@text_field_x, @@text_field_y, @@text_field_background)
  end

  def self.text_change(str)
    @@str = str
  end
end

class CharacterView
  def self.player_view
    player_img = CharacterImages::PLAYER_IMAGE
    Window.draw(Window.width / 7, Window.height * 5 / 7 - player_img.height, player_img, 50)
  end

  def self.enemy_view(enemy)
    if enemy_img = CharacterImages::ENEMY_IMAGES.find { |e| e[:name] == enemy.name }[:image]
      Window.draw(Window.width * 5 / 7 - enemy_img.width / 5, Window.height * 5 / 7 - enemy_img.height, enemy_img, 50)
    end
  end
end

class BattleView
  def self.run(enemy)
    CharacterView.enemy_view(enemy) if enemy.alive_flg
  end
end
