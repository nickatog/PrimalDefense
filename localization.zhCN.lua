﻿if (GetLocale() ~= "zhCN") then
  return
end

PDLocals = setmetatable({
--enemies
  ["Sheep: 100 health, 1 gold each."] = "羊：100血，每个1金。",
  ["Cats: 150 health, 2 gold each."] = "猫：150血，每个2金",
  ["Snakes: 200 health, 2 gold each."] = "蛇：200血，每个2金",
  ["Bats: 125 health, 3 gold each.  Immune to cannon towers!"] = "蝙蝠：125血，每个3金。免疫加农塔！",
  ["Boars: 300 health, 3 gold each."] = "野猪：300血，每个3金。",
  ["Panthers: 300 health, 4 gold each.  Increased speed!"] = "黑豹：300血，每个4金。速度提升！",
  ["Bears: 400 health, 4 gold each.  Boss next level!"] = "熊：400血，每个4金。下一关Boss！",
  ["BOSS - Angry Cow: 4500 health, 50 gold."] = "Boss - 愤怒的奶牛：4500血，50金。",
  ["Gnomes: 350 health, 6 gold each.  Increased group size!"] = "侏儒：350血，每个6金。数量增多！",
  ["Dwarves: 650 health, 7 gold each."] = "矮人：650血，每个7金。",
  ["Humans: 650 health, 8 gold each.  Increased speed!"] = "人类：650血，每个8金。",
  ["Night Elves: 850 health, 9 gold each.  Boss next level!"] = "暗夜精灵：850血，每个9金。下一关Boss！",
  ["BOSS - Knight: 9500 health, 100 gold."] = "Boss - 骑士：9500血，100金。",
  ["Gyrocopters: 950 health, 11 gold each.  Immune to cannon towers!"] = "直升飞机：950血，每个11金。免疫加农塔！",
  ["Bloodlusted Orcs: 1450 health, 12 gold each."] = "嗜血兽人：1450血，每个12金。",
  ["Imps: 1450 health, 13 gold each.  Immune to fire towers!"] = "小鬼：1450血，每个13金。免疫火塔！",
  ["Leeches: 1950 health, 14 gold each.  Boss next level!"] = "吸血鬼：1950血，每个14金。下一关Boss！",
  ["BOSS - Avatar: 22500 health, 150 gold."] = "Boss - 天神下凡：22500血，150金。",
  ["Blood Elves: 1800 health, 16 gold each.  Increased group size!"] = "血精灵：1800血，每个16金。数量增多！",
  ["Trolls: 3250 health, 17 gold each."] = "巨魔：3250血，每个17金。",
  ["Forsaken: 3250 health, 18 gold each.  Increased speed!"] = "被遗忘者：3250血，每个18金。速度提升！",
  ["Tauren: 4250 health, 19 gold each.  Boss next level!"] = "牛头人：4250血，每个19金。下一关Boss！",
  ["BOSS - Spectral Tiger: 47500 health, 200 gold."] = "Boss - 幽灵虎：47500血，200金。",
  ["Demons: 4750 health, 23 gold each.  Immune to shadow towers!"] = "恶魔：4750血，每个23金。免疫暗影塔！",
  ["Ghouls: 6550 health, 26 gold each."] = "食尸鬼：6550，每个26金。",
  ["Frozen Corpses: 6550 health, 29 gold each.  Immune to ice towers!"] = "冰尸：6550血，每个29金。免疫冰塔！",
  ["Soultakers: 8350 health, 32 gold each.  Boss next level!"] = "夺魂者：8350血，每个32金。下一关Boss！",
  ["Illidan: 92500 health, 350 gold."] = "伊利丹：92500血，350金。",
  ["Lava Spawns: 9250 health, 39 gold each.  Immune to fire towers!"] = "火元素：9250血，每个39金。免疫火塔！",
  ["Abyssal Fiends: 10850 health, 43 gold each.  Immune to shadow towers!"] = "深渊恶魔：10850血，每个43金。免疫暗影塔！",
  ["Water Elementals: 12450 health, 47 gold each.  Immune to ice towers!"] = "水元素：12450血，每个47金。免疫冰塔！",
  ["Nether Drakes: 15750 health, 51 gold each.  Boss next level!"] = "虚空龙：15750血，每个51金。下一关Boss！",
  ["Kil'Jaedan: 172500 health, 550 gold."] = "基尔加丹：172500血，550金。",
  ["Red Dragons: 17250 health, 62 gold.  Immune to fire towers!"] = "红龙：17250血，62金。免疫火塔！",
  ["Black Dragons: 20250 health, 70 gold.  Immune to shadow towers!"] = "黑龙：20250血，70金。免疫暗影塔！",
  ["Blue Dragons: 23250 health, 77 gold.  Immune to ice towers!"] = "蓝龙：23250血，77金。免疫冰塔！",
  ["Bronze Dragons: 29250 health, 85 gold."] = "青铜龙：29250血，85金。",
  ["Green Dragons: 32250 health, 92 gold.  Boss next level!"] = "绿龙：32250血，92金。下一关Boss！",
  ["C\'Thun: 350000 health, 1000 gold.  Boss next level!"] = "克苏恩：350000血，1000金。下一关Boss！",
  ["Yogg Saron: 500000 health, 1500 gold.  One more level!"] = "尤格萨隆：500000血，1500金。还有最后一关！",
  ["Hula Girls: 50000 health, 1000 gold each.  Good luck!"] = "草裙舞女孩：50000血，每个1000金。祝好运！",
  
--TooltipData
  ["Cannon Tower~A basic physical damage tower.  Cannot hit flying enemies.  Upgradeable for higher damage."] = "加农塔~基础物理伤害炮塔。不能攻击飞行敌人。升级可获得更高伤害。",
  ["%1$d gold\nMore damage.  Boom."] = "%1$d金\n更高伤害。轰隆。",
  ["%1$d gold\nEven more damage."] = "%1$d金\n再多伤害。",
  ["Arrow Tower~A simple tower which can attack both land and air units.  Upgradeable for higher damage."] = "箭塔~能同时攻击地面和空中单位的简单炮塔。",
  ["%1$d gold\nMore Damage.  Pew pew."] = "%1$d金\n更高伤害。Biu biu。",
  ["%1$d gold\nEven more damage."] = "%1$d金\n再多伤害。",
  ["Fire Tower~A tower with the ability to char the flesh of enemies.  Early levels deal splash damage.  Upgradeable to AoE damage."] = "火塔~燃烧敌人肉体的炮塔。开始造成溅射伤害。可升级为AoE伤害。",
  ["%1$d gold\nFires an explosive shell which explodes on impact for more splash damage."] = "%1$d金\n发射可爆炸弹丸，在爆炸时造成更多溅射伤害。",
  ["%1$d gold\nEngulfs the surrounding area, dealing damage to all enemies nearby."] = "%1$d金\n吞噬周围的区域，对附近所有敌人造成伤害。",
  ["Ice Tower~A frozen tower that chills the spirit of attackers.  Early levels slow their targets, while later levels slow all enemies in the area."] = "冰塔~冰冻敌人灵魂的冰霜之塔。开始可以减速目标，后期可以减速区域内所有敌人。",
  ["%1$d gold\nFires an enchanted missile that slows the speed of attackers and deals more damage."] = "%1$d金\n发射增强的导弹，减速并造成更多的伤害。",
  ["%1$d gold\nChills the ground, slowing the speed of all enemies nearby but deals no damage."] = "%1$d金\n冰冻大地，让周围所有敌人减速但是不造成伤害。",
  ["Shadow Tower~A tower of darkness that consumes the soul of infidels.  Inflicts a high amount of damage over time, but multiple shadow effects do not stack.  Higher levels deal more damage."] = "暗影塔~吞噬异教徒灵魂的黑暗之塔。造成大量的DOT伤害，但是效果不叠加。更高等级造成更多伤害。",
  ["%1$d gold\nFires a plagued bolt that inflicts more damage over time."] = "%1$d金\n发射瘟疫之矢造成更多DOT伤害。",
  ["%1$d gold\nFires a plagued bolt that deals significantly more damage over time."] = "%1$d金\n发射瘟疫之矢造成极多DOT伤害。",
  ["%1$d gold\nChaotic energy infuses this tower, enabling it to deal significant single-target damage that pierces all immunities."] = "溷乱的能量充斥着这座炮塔，使它能造成极大的单目标伤害，并穿越一切免疫效果。",
  ["Sell (|cffffffffX|r)~Sell this tower for a 75% refund of the current level\'s cost."] = "出售 (|cffffffffX|r)~出售该塔以获得当前级别所花费的75%金币。",
  ["Upgrade (|cffffffffU|r)"] = "升级 (|cffffffffU|r)",
  ["The Fury of Skoll~A fiery rage burns within the Amiran builders, allowing the creation of fire towers."] = "Skoll之怒~Amiran建造者们内心的强烈怒火，允许建造火塔。",
  ["The Song of Lorelei~By harnessing the enchanted melody of the river maiden, the Amiran builders are able to craft ice towers."] = "Lorelei之歌~利用河流少女的魔法旋律，Amiran建造者们可以制作冰塔。",
  ["The Blight of the Abyss~Forces from the great unknown compel the Amiran builders, granting the ability to forge shadow towers."] = "炼狱之疫~凭借Amiran建造者们强大而未知的力量，获得铸造暗影塔的能力。",
  
--Towers
  ["None"] = "无",
  ["Splash damage"] = "溅射伤害",
  ["AoE damage"] = "AoE伤害",
  ["Single slow"] = "单体减速",
  ["AoE slow"] = "AoE减速",
  ["DoT damage"] = "DoT伤害",
  ["Heavy DoT damage"] = "大量DoT伤害",
  ["Chaos Damage"] = "溷乱伤害",
  
--PrimalDefense_StartLevel
  ["You've saved the Amirans from destruction!  All too easy..."] = "你已经拯救了Amirans！一切都太简单了...",

--reset game
  ["Level"] = "等级 ",
  ["Lives"] = "生命",
  ["Gold"] = "金币",
  ["Essence"] = "精华",
  ["Fury of Skoll"] = "Skoll之怒",
  ["Song of Lorelei"] = "Lorelei之歌",
  ["Blight of the Abyss"] = "炼狱之疫",
  ["Welcome to Primal Defense!"] = "欢迎来到Primal Defense!",
  
--PrimalDefense_UpdateBlessingsTexts
  ["You are fully blessed."] = "你已经被完全祝福。",
  
--PrimalDefense_UpdateCostTexts
  ["Requires Blessing"] = "需要祝福",
  ["Cannon"] = "加农塔",
  ["Arrow"] = "箭塔",
  ["Fire"] = "火塔",
  ["Ice"] = "冰塔",
  ["Shadow"] = "暗影塔",
  
--PrimalDefense_MapTileOnClick
  ["Range"] = "射程",
  ["Damage"] = "伤害",
  ["Speed"] = "速度",
  ["Ability"] = "技能",
}, {__index = PDLocals})