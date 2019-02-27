require 'dxopal'
include DXOpal
Window.load_resources do



  class Character
    attr_accessor :name, :hp, :strength, :element, :defence_flg, :alive_flg, :ini_hp, :max_hp, :ini_strength, :exp
    def initialize(name:,hp:,strength:,element:'nomal',exp:0);
      @name = name
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

    def test
      p @name
      p @hp
      p @strength
      p @element
    end

    def atk(other)
      damege = @strength
      other.hp -= damege
      puts "#{other.name}の残りhpは#{other.hp}\n"
    end
  end

  class Enemy < Character
    def initialize(name:,hp:,strength:,element:'nomal',exp:0,skill1:['atk',100],skill2:['atk',100],skill3:['atk',100])
      @skill1 = skill1
      @skill2 = skill2
      @skill3 = skill3
      super(name:name,hp:hp,strength:strength,element:element,exp:exp)
    end

    def my_skill
      p @skill1
      p @skill2
      p @skill3
    end

    def enemy_act(other)
      case rand(100)
      when 0..@skill1[1]
        puts(@skill1[0])
      when @skill1[1]..@skill2[1]
        puts(@skill2[0])
      when @skill2[1]..@skill3[1]
        puts(@skill3[0])
      end
    end
  end

  testkun = Character.new(name: 'test',hp:25,strength:7,element:'fire')
  testkun2 = Character.new(name: 'test2',hp:15,strength:5,element:'fire')
  enemy = Enemy.new(name: 'enemy',hp:99,strength:9,skill1: ['foo',40], skill2: ['bar',80])
  enemy.test
  enemy.my_skill
  10.times do
    enemy.enemy_act(testkun)
  end
  # testkun.test
  # testkun2.test
  # testkun.atk(testkun2)
  # testkun2.atk(testkun)
  Window.bgcolor = C_BLACK

  Window.loop do
    Window.draw_font(0, 0, "Hello!", Font.default, color: C_WHITE)
  end
end
