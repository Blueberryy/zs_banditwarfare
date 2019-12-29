
-- Change this if you plan to alter the cost of items or you severely change how Worth works.
-- Having separate cart files allows people to have separate loadouts for different servers.
GM.CartFile = "zsbanditcarts.txt"

ITEMCAT_GUNS = 1
ITEMCAT_AMMO = 2
ITEMCAT_MELEE = 3
ITEMCAT_TOOLS = 4
ITEMCAT_OTHER = 5
ITEMCAT_TRAITS = 6
ITEMCAT_RETURNS = 7


GM.ItemCategories = {
	[ITEMCAT_GUNS] = "총기",
	[ITEMCAT_AMMO] = "탄약",
	[ITEMCAT_MELEE] = "근접 무기",
	[ITEMCAT_TOOLS] = "도구",
	[ITEMCAT_OTHER] = "기타",
	[ITEMCAT_TRAITS] = "특성",
	[ITEMCAT_RETURNS] = "환불",	
}

--[[
Humans select what weapons (or other things) they want to start with and can even save favorites. Each object has a number of 'Worth' points.
Signature is a unique signature to give in case the item is renamed or reordered. Don't use a number or a string number!
A human can only use 100 points (default) when they join. Redeeming or joining late starts you out with a random loadout from above.
SWEP is a swep given when the player spawns with that perk chosen.
Callback is a function called. Model is a display model. If model isn't defined then the SWEP model will try to be used.
swep, callback, and model can all be nil or empty
]]
GM.Items = {}
function GM:AddItem(tier, signature, name, desc, category, worth, swep, callback, model )
	local tab = { Tier = tier, Signature = signature, Name = name, Description = desc, Category = category, Worth = worth or 0, SWEP = swep, Callback = callback, Model = model}
	self.Items[#self.Items + 1] = tab

	return tab
end

function GM:AddPointShopItem(tier, signature, name, desc, category, points, worth, callback, model)
	return self:AddItem(tier, "ps_"..signature, name, desc, category, points, worth, callback, model)
end

-- Weapons are registered after the gamemode.
timer.Simple(0, function()
	for _, tab in pairs(GAMEMODE.Items) do
		if not tab.Description and tab.SWEP then
			local sweptab = weapons.GetStored(tab.SWEP)
			if sweptab then
				tab.Description = sweptab.Description
			end
		end
	end
end)

-- How much ammo is considered one 'clip' of ammo? For use with setting up weapon defaults. Works directly with zs_survivalclips
GM.AmmoCache = {}
GM.AmmoCache["ar2"] = 30 -- Assault rifles.
GM.AmmoCache["alyxgun"] = 24 -- Not used.
GM.AmmoCache["pistol"] = 12 -- Pistols.
GM.AmmoCache["smg1"] = 30 -- SMG's and some rifles.
GM.AmmoCache["357"] = 6 -- Rifles, especially of the sniper variety.
GM.AmmoCache["xbowbolt"] = 2 -- Crossbows
GM.AmmoCache["buckshot"] = 8 -- Shotguns
GM.AmmoCache["ar2altfire"] = 1 -- Smokes.
GM.AmmoCache["slam"] = 1 -- Force Field Emitters.
GM.AmmoCache["rpg_round"] = 1 -- Fbangs
GM.AmmoCache["smg1_grenade"] = 1 -- .
GM.AmmoCache["sniperround"] = 1 -- Barricade Kit
GM.AmmoCache["sniperpenetratedround"] = 1 -- Remote Det pack.
GM.AmmoCache["grenade"] = 1 -- Grenades.
GM.AmmoCache["thumper"] = 1 -- Gun turret.
GM.AmmoCache["gravity"] = 1 -- EMP Charge.
GM.AmmoCache["battery"] = 30 -- Used with the Medical Kit.
GM.AmmoCache["gaussenergy"] = 1 -- Nails used with the Carpenter's Hammer.
GM.AmmoCache["combinecannon"] = 1 -- .
GM.AmmoCache["airboatgun"] = 1 -- Arsenal crates.
GM.AmmoCache["striderminigun"] = 1 -- Message beacons.
GM.AmmoCache["helicoptergun"] = 1 --Resupply boxes.
GM.AmmoCache["spotlamp"] = 1
GM.AmmoCache["manhack"] = 1
GM.AmmoCache["pulse"] = 30

-- These ammo types are available at ammunition boxes.
-- The amount is the ammo to give them.
-- If the player isn't holding a weapon that uses one of these then they will get smg1 ammo.
GM.AmmoResupply = {}
GM.AmmoResupply["ar2"] = 20
GM.AmmoResupply["alyxgun"] = GM.AmmoCache["alyxgun"]
GM.AmmoResupply["pistol"] = GM.AmmoCache["pistol"]
GM.AmmoResupply["smg1"] = 20
GM.AmmoResupply["357"] = GM.AmmoCache["357"]
GM.AmmoResupply["xbowbolt"] = GM.AmmoCache["xbowbolt"]
GM.AmmoResupply["buckshot"] = GM.AmmoCache["buckshot"]
GM.AmmoResupply["battery"] = 30
GM.AmmoResupply["pulse"] = GM.AmmoCache["pulse"]
GM.AmmoResupply["gravity"] = 1 -- EMP Charge.
GM.AmmoResupply["gaussenergy"] = 1 -- Nails used with the Carpenter's Hammer.
GM.AmmoResupply["sniperround"] = 1
GM.AmmoResupply["grenlauncher"] = 1

------------
-- Points --
------------
GM:AddPointShopItem(0,"btlax", "'배틀액스' 권총", nil, ITEMCAT_GUNS, 10, "weapon_zs_battleaxe")
GM:AddPointShopItem(0,"pshtr", "'피슈터' 권총", nil, ITEMCAT_GUNS, 10, "weapon_zs_peashooter")
GM:AddPointShopItem(0,"owens", "'오웬스' 권총", nil, ITEMCAT_GUNS, 15, "weapon_zs_owens")
GM:AddPointShopItem(0,"blstr", "'블래스터' 산탄총", nil, ITEMCAT_GUNS, 15, "weapon_zs_blaster")
GM:AddPointShopItem(0,"tossr", "'토저' SMG", nil, ITEMCAT_GUNS, 10, "weapon_zs_tosser")
GM:AddPointShopItem(0,"stbbr", "'스터버' 소총", nil, ITEMCAT_GUNS, 15, "weapon_zs_stubber")
GM:AddPointShopItem(0,"crklr", "'크래클러' 돌격 소총", nil, ITEMCAT_GUNS, 10, "weapon_zs_crackler")
GM:AddPointShopItem(0,"z9000", "'Z9000' 펄스 권총", nil, ITEMCAT_GUNS, 15, "weapon_zs_z9000")
GM:AddPointShopItem(0,"deagle", "'좀비 드릴' 데저트 이글", nil, ITEMCAT_GUNS, 25, "weapon_zs_deagle")

GM:AddPointShopItem(1,"doublebarrel", "'카우' 더블배럴", nil, ITEMCAT_GUNS, 55, "weapon_zs_doublebarrel")
GM:AddPointShopItem(1,"glock3", "'크로스파이어' 글록-3", nil, ITEMCAT_GUNS, 60, "weapon_zs_glock3")
GM:AddPointShopItem(1,"magnum", "'리코세' 매그넘", nil, ITEMCAT_GUNS, 65, "weapon_zs_magnum")
GM:AddPointShopItem(1,"eraser", "'이레이저' 전략 권총", nil, ITEMCAT_GUNS, 60, "weapon_zs_eraser")
GM:AddPointShopItem(1,"shredder", "'슈레더' SMG", nil, ITEMCAT_GUNS, 60, "weapon_zs_smg")
GM:AddPointShopItem(1,"hunter", "'헌터' 소총", nil, ITEMCAT_GUNS, 65, "weapon_zs_hunter")
GM:AddPointShopItem(1,"neutrino", "'뉴트리노' 펄스 LMG", nil, ITEMCAT_GUNS, 65, "weapon_zs_neutrino")
GM:AddPointShopItem(1,"akbar", "'아크바' 돌격소총", nil, ITEMCAT_GUNS, 75, "weapon_zs_akbar")

GM:AddPointShopItem(2,"waraxe", "'워액스' 권총", nil, ITEMCAT_GUNS, 85, "weapon_zs_waraxe")
GM:AddPointShopItem(2,"ender", "'엔더' 자동 샷건", nil, ITEMCAT_GUNS, 100, "weapon_zs_ender")
GM:AddPointShopItem(2,"annabelle", "'애나멜' 소총", nil, ITEMCAT_GUNS, 100, "weapon_zs_annabelle")
GM:AddPointShopItem(2,"uzi", "'스프레이어' Uzi 9mm", nil, ITEMCAT_GUNS, 115, "weapon_zs_uzi")
GM:AddPointShopItem(2,"stalker", "'스토커' M4", nil, ITEMCAT_GUNS, 120, "weapon_zs_m4")
GM:AddPointShopItem(2,"immortal", "'불멸' 권총", nil, ITEMCAT_GUNS, 130, "weapon_zs_immortal")
GM:AddPointShopItem(2,"ioncannon", "이온캐논", nil, ITEMCAT_GUNS, 130, "weapon_zs_ioncannon")

GM:AddPointShopItem(3,"terminator", "'터미네이터' 권총", nil, ITEMCAT_GUNS, 155, "weapon_zs_terminator")
GM:AddPointShopItem(3,"bulletstorm", "'총알비' SMG", nil, ITEMCAT_GUNS, 155, "weapon_zs_bulletstorm")
GM:AddPointShopItem(3,"silencer", "'사일런서' SMG", nil, ITEMCAT_GUNS, 170, "weapon_zs_silencer")
GM:AddPointShopItem(3,"inquisition", "'인퀴지션' 소형 석궁", nil, ITEMCAT_GUNS, 155, "weapon_zs_inquisition")
GM:AddPointShopItem(3,"practition", "'프랙티션' 돌격소총", nil, ITEMCAT_GUNS, 135, "weapon_zs_practition")
GM:AddPointShopItem(3,"inferno", "'인페르노' AUG", nil, ITEMCAT_GUNS, 155, "weapon_zs_inferno")
GM:AddPointShopItem(3,"sweeper", "'스위퍼' 샷건", nil, ITEMCAT_GUNS, 155, "weapon_zs_sweepershotgun")
GM:AddPointShopItem(3,"pulserifle", "'아도니스' 펄스 소총", nil, ITEMCAT_GUNS, 145, "weapon_zs_pulserifle")
GM:AddPointShopItem(3,"zeus", "'제우스' 자동소총", nil, ITEMCAT_GUNS, 155, "weapon_zs_zeus")

GM:AddPointShopItem(4,"crossbow", "'임펠러' 석궁", nil, ITEMCAT_GUNS, 215, "weapon_zs_crossbow")
GM:AddPointShopItem(4,"reaper", "'리퍼' UMP", nil, ITEMCAT_GUNS, 225, "weapon_zs_reaper")
GM:AddPointShopItem(4,"blitz", "'블리츠' 돌격소총", nil, ITEMCAT_GUNS, 225, "weapon_zs_blitz")
GM:AddPointShopItem(4,"sg550", "'헬베티카' DMR", nil, ITEMCAT_GUNS, 225, "weapon_zs_sg550")
GM:AddPointShopItem(4,"positron", "'포지트론' 입자포", nil, ITEMCAT_GUNS, 230, "weapon_zs_positron")
GM:AddPointShopItem(4,"boomstick", "붐스틱", nil, ITEMCAT_GUNS, 235, "weapon_zs_boomstick")
GM:AddPointShopItem(4,"tommy", "'토미' SMG", nil, ITEMCAT_GUNS, 256, "weapon_zs_tommy")
GM:AddPointShopItem(4,"slugrifle", "'티니' 슬러그 소총", nil, ITEMCAT_GUNS, 300, "weapon_zs_slugrifle")

GM:AddPointShopItem(nil,"pistolammo", "권총 탄약", nil, ITEMCAT_AMMO, 3, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["pistol"] or 12, "pistol", true) end, "models/Items/BoxSRounds.mdl")
GM:AddPointShopItem(nil,"shotgunammo", "샷건 탄약", nil, ITEMCAT_AMMO, 6, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["buckshot"] or 8, "buckshot", true) end, "models/Items/BoxBuckshot.mdl")
GM:AddPointShopItem(nil,"smgammo", "SMG 탄약", nil, ITEMCAT_AMMO, 5, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["smg1"] or 30, "smg1", true) end, "models/Items/BoxMRounds.mdl")
GM:AddPointShopItem(nil,"assaultrifleammo", "돌격소총 탄약", nil, ITEMCAT_AMMO, 6, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["ar2"] or 30, "ar2", true) end, "models/Items/357ammobox.mdl")
GM:AddPointShopItem(nil,"rifleammo", "소총 탄약", nil, ITEMCAT_AMMO, 8, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["357"] or 10, "357", true) end, "models/Items/BoxSniperRounds.mdl")
GM:AddPointShopItem(nil,"crossbowammo", "크로스보우 화살 묶음", nil, ITEMCAT_AMMO, 4, nil, function(pl) pl:GiveAmmo(5, "XBowBolt", true) end, "models/Items/CrossbowRounds.mdl")
GM:AddPointShopItem(nil,"pulseammo", "펄스건 탄약", nil, ITEMCAT_AMMO, 5, nil, function(pl) pl:GiveAmmo(GAMEMODE.AmmoCache["pulse"] or 40, "pulse", true) end, "models/Items/combine_rifle_ammo01.mdl")
GM:AddPointShopItem(nil,"medicammo", "메디컬 에너지", nil, ITEMCAT_AMMO, 4, nil, function(pl) pl:GiveAmmo(50, "Battery", true) end, "models/healthvial.mdl")
GM:AddPointShopItem(nil,"empround", "EMP 배터리", "EMP건의 추가 탄환이다.", ITEMCAT_AMMO, 15, nil, function(pl) pl:GiveAmmo(5, "gravity", true) end, "models/items/Battery.mdl").NoClassicMode = true
GM:AddPointShopItem(nil,"nails", "못 2개", nil, ITEMCAT_AMMO, 5, nil, function(pl) pl:GiveAmmo(2, "GaussEnergy", true) end, "models/crossbow_bolt.mdl").NoClassicMode = true

GM:AddPointShopItem(nil,"axe", "도끼", nil, ITEMCAT_MELEE, 25, "weapon_zs_axe")
GM:AddPointShopItem(nil,"crowbar", "빠루", nil, ITEMCAT_MELEE, 27, "weapon_zs_crowbar")
GM:AddPointShopItem(nil,"stunbaton", "전기충격기", nil, ITEMCAT_MELEE, 23, "weapon_zs_stunbaton")
GM:AddPointShopItem(nil,"knife", "칼", nil, ITEMCAT_MELEE, 5, "weapon_zs_swissarmyknife")
GM:AddPointShopItem(nil,"shovel", "삽", nil, ITEMCAT_MELEE, 45, "weapon_zs_shovel")
GM:AddPointShopItem(nil,"sledgehammer", "오함마", nil, ITEMCAT_MELEE, 70, "weapon_zs_sledgehammer")
GM:AddPointShopItem(nil,"energysword", "에너지 소드", nil, ITEMCAT_MELEE, 140, "weapon_zs_energysword")
GM:AddPointShopItem(nil,"zpplnk", "판자", nil, ITEMCAT_MELEE, 10, "weapon_zs_plank")
GM:AddPointShopItem(nil,"zpfryp", "후라이팬", nil, ITEMCAT_MELEE, 17, "weapon_zs_fryingpan")
GM:AddPointShopItem(nil,"zpcpot", "냄비", nil, ITEMCAT_MELEE, 22, "weapon_zs_pot")
GM:AddPointShopItem(nil,"butcher", "정육점 칼", nil, ITEMCAT_MELEE, 25, "weapon_zs_butcherknife")
GM:AddPointShopItem(nil,"pipe", "납 파이프", nil, ITEMCAT_MELEE, 40, "weapon_zs_pipe")
GM:AddPointShopItem(nil,"hook", "갈고리", nil, ITEMCAT_MELEE, 20, "weapon_zs_hook")

GM:AddPointShopItem(nil,"tracker", "송신기 추적장치", nil, ITEMCAT_TOOLS, 5, "weapon_zs_objectiveradar").NoClassicMode = true
GM:AddPointShopItem(nil,"enemytracker", "생체 탐지기", nil, ITEMCAT_TOOLS, 10, "weapon_zs_enemyradar")
GM:AddPointShopItem(nil,"empgun", "EMP 건", nil, ITEMCAT_TOOLS, 45, "weapon_zs_empgun").NoClassicMode = true
GM:AddPointShopItem(nil,"backdoor", "통신 백도어 장치", nil, ITEMCAT_TOOLS, 35, "weapon_zs_backdoor").NoClassicMode = true
GM:AddPointShopItem(nil,"medgun", "메디컬 건", nil, ITEMCAT_TOOLS, 45, "weapon_zs_medicgun")
GM:AddPointShopItem(nil,"medkit", "메디킷", nil, ITEMCAT_TOOLS, 50, "weapon_zs_medicalkit")
GM:AddPointShopItem(nil,"ammokit", "탄약킷", nil, ITEMCAT_TOOLS, 12, "weapon_zs_ammokit")
local item = GM:AddPointShopItem(nil,"infturret", "자동 터렛", nil, ITEMCAT_TOOLS, 60, nil, function(pl)
	pl:GiveEmptyWeapon("weapon_zs_gunturret")
	pl:GiveAmmo(1, "thumper")
	pl:GiveAmmo(250, "smg1")
end)
item.Countables = {"weapon_zs_gunturret", "prop_gunturret"}
item.NoClassicMode = true
GM:AddPointShopItem(nil,"manhack", "맨핵", nil, ITEMCAT_TOOLS, 45, "weapon_zs_manhack").NoClassicMode = true
GM:AddPointShopItem(nil,"drone", "드론", nil, ITEMCAT_TOOLS, 50, "weapon_zs_drone").NoClassicMode = true
GM:AddPointShopItem(nil,"wrench", "메카닉의 렌치", nil, ITEMCAT_TOOLS, 25, "weapon_zs_wrench").NoClassicMode = true
GM:AddPointShopItem(nil,"ffemitter", "방어막 생성기", nil, ITEMCAT_TOOLS, 60, "weapon_zs_ffemitter").Countables = "prop_ffemitter"

GM:AddPointShopItem(nil,"crphmr", "목수의 망치", nil, ITEMCAT_TOOLS, 30, "weapon_zs_hammer").NoClassicMode = true
GM:AddPointShopItem(nil,"nailgun", "리벳건", nil, ITEMCAT_TOOLS, 65, "weapon_zs_nailgun").NoClassicMode = true
GM:AddPointShopItem(nil,"barricadekit", "'이지스' 바리케이드 킷", nil, ITEMCAT_TOOLS, 125, "weapon_zs_barricadekit").NoClassicMode = true
GM:AddPointShopItem(nil,"boardpack", "판자 5장", nil, ITEMCAT_TOOLS, 25, "weapon_zs_boardpack").NoClassicMode = true

GM:AddPointShopItem(nil,"extrahp", "추가 방탄복", nil, ITEMCAT_OTHER, 20, "weapon_zs_extrahealth")
GM:AddPointShopItem(nil,"extraspd", "아드레날린", nil, ITEMCAT_OTHER, 17, "weapon_zs_extraspeed")
GM:AddPointShopItem(nil,"grenade", "수류탄", nil, ITEMCAT_OTHER, 20, "weapon_zs_grenade")
GM:AddPointShopItem(nil,"flashbang", "섬광탄", nil, ITEMCAT_OTHER, 15, "weapon_zs_flashbang")
GM:AddPointShopItem(nil,"smoke", "연막탄", nil, ITEMCAT_OTHER, 10, "weapon_zs_smokegrenade")
GM:AddPointShopItem(nil,"detpck", "C4", nil, ITEMCAT_OTHER, 40, "weapon_zs_detpack")
GM:AddPointShopItem(nil,"grenadelauncher", "유탄발사기", nil, ITEMCAT_OTHER, 125, "weapon_zs_grenadelauncher")
GM:AddPointShopItem(nil,"glgrenade", "유탄", nil, ITEMCAT_OTHER, 40, nil, function(pl) pl:GiveAmmo(1, "grenlauncher", true) end, "models/items/ar2_grenade.mdl")

-- These are the honorable mentions that come at the end of the round.

local function genericcallback(pl, magnitude) return pl:Name(), magnitude end
GM.HonorableMentions = {}
GM.HonorableMentions[HM_MOSTENEMYKILLED] = {Name = "살인마", String = "%s - %d명의 적을 죽였다.", Callback = genericcallback}
GM.HonorableMentions[HM_MOSTDAMAGETOENEMY] = {Name = "전쟁광", String = "%s - 전체 %d 대미지를 적에게 주었다.", Callback = genericcallback}
GM.HonorableMentions[HM_PACIFIST] = {Name = "비폭력주의자", String = "%s - 한 명의 적도 죽이지 않았다.", Callback = genericcallback}
GM.HonorableMentions[HM_MOSTHELPFUL] = {Name = "조력자", String = "%s - 동료가 %d명의 적을 죽일 수 있도록 도왔다.", Callback = genericcallback}
GM.HonorableMentions[HM_BLACKCOW] = {Name = "흑우", String = "%s - 물건을 사는 데 %d포인트를 사용했다.", Callback = genericcallback, Color = COLOR_CYAN}
--GM.HonorableMentions[HM_OUTLANDER] = {Name = "도망자", String = "%s - 좀비 스폰 지점에서 %d피트나 떨어진 장소에서 살해당했다.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_GOODDOCTOR] = {Name = "의사양반", String = "%s - 팀의 체력을 %d만큼 책임졌다.", Callback = genericcallback}
GM.HonorableMentions[HM_HANDYMAN] = {Name = "공돌이", String = "%s - %d만큼 바리케이드를 수리했다.", Callback = genericcallback}
--GM.HonorableMentions[HM_SCARECROW] = {Name = "죄 없는 까마귀", String = "%s - 까마귀 %d마리를 무참히 살해했다.", Callback = genericcallback, Color = COLOR_WHITE}
--GM.HonorableMentions[HM_MOSTBRAINSEATEN] = {Name = "인간 학살자", String = "BJ %s님의 인간 뇌 먹방! 오늘은 %d명의 뇌를 먹어치워보겠습니다!", Callback = genericcallback, Color = COLOR_LIMEGREEN}
--GM.HonorableMentions[HM_MOSTDAMAGETOHUMANS] = {Name = "너 나한테 시비 걸었냐?", String = "플레이어 %s님이 시비를 거는 인간들에게 %d 데미지로 응징했다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
--GM.HonorableMentions[HM_LASTBITE] = {Name = "심판자", String = "플레이어 %s님이 최후의 인간을 먹어치웠다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_USEFULTOOPPOSITE] = {Name = "자살특공대", String = "%s는 적에게 %d번 죽었다.", Callback = genericcallback}
--GM.HonorableMentions[HM_STUPID] = {Name = "똥멍청이", String = "플레이어 %s님은 좀비 스폰 지점에서 겨우 %d피트 떨어진 곳에서 살해당했다.", Callback = genericcallback, Color = COLOR_RED}
--GM.HonorableMentions[HM_SALESMAN] = {Name = "세일즈맨", String = "%s는 장사를 통해 %d포인트를 벌었다.", Callback = genericcallback}
--GM.HonorableMentions[HM_WAREHOUSE] = {Name = "창고장", String = "%s는 자신의 보급 상자로 %d번 동료를 도왔다.", Callback = genericcallback}
--GM.HonorableMentions[HM_SPAWNPOINT] = {Name = "살아있는 스폰지점", String = "플레이어 %s님이 %d마리의 좀비를 부활시켰다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
--GM.HonorableMentions[HM_CROWFIGHTER] = {Name = "King of Crows", String = "플레이어 %s님이 %d마리의 까마귀를 전멸시켰다.", Callback = genericcallback, Color = COLOR_WHITE}
--GM.HonorableMentions[HM_CROWBARRICADEDAMAGE] = {Name = "쥐꼬리만한 골칫거리", String = "플레이어 %s님이 까마귀로 바리케이드에 총합 %d 데미지를 가했다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_BARRICADEDESTROYER] = {Name = "철거단원", String = "%s - %d의 대미지를 주었다.", Callback = genericcallback}
--GM.HonorableMentions[HM_NESTDESTROYER] = {Name = "네스트 디스트로이어", String = "%s - %d개의 둥지를 흔적도 없이 날려버렸다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
--GM.HonorableMentions[HM_NESTMASTER] = {Name = "네스트 마스터", String = "%s - %d마리의 좀비를 자신의 둥지에서 부활시켰다.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_COMMSUNIT] = {Name = "통신사 직원", String = "%s - %d개의 송신기를 탈환했다.", Callback = genericcallback}


-- Zombine: has no head.
-- Skeleton: doesn't have flesh therefore making the hitboxes seem wonky
GM.RestrictedModels = {
	"models/player/zombine.mdl",
	"models/player/zombie_soldier.mdl",
	"models/player/skeleton.mdl"
	
	--[["models/player/zombie_classic.mdl",
	"models/player/zombie_fast.mdl",
	"models/player/corpse1.mdl",
	"models/player/charple.mdl",
	]]
}
GM.MapWhitelist = {
	--"cs_assault",
	"cs_compound",
	"cs_galleria",
	"cs_havana",
	"cs_italy",
	"cs_kismayo",
	"cs_militia",
	"cs_office",
	"de_aztec",
	"de_cbble",
	"de_chateau",
	"de_dust",
	"de_dust2",
	"de_inferno",
	"de_nuke",
	"de_piranesi",
	"de_nightfever",
	"de_port",
	"de_prodigy",
	"de_school",
	"de_tides",
	"de_train",
	--"zm_4ngry_quarantine",
	"zm_ryan_valley02",
	--"zm_stab_aroundtown_v3c",
	"zm_tx_highschoolbeta7_d_vh",
	"zs_ambush_v4",
	"zs_ancient_castle_opt",
	"zs_clav_oblivion",
	--"zs_coasthouse",
	"zs_countryside_b1",
	"zs_deadmount_reborn_v1",
	"zs_dryfield_v2",
	"zs_hazard_v2",
	--"zs_insurance",
	"zs_laboratory",
	"zs_lockup_v2",
	"zs_outpost_gold_v2",
	--"zs_placid",
	--"zs_plague",
	--"zs_port_v4",
	"zs_raunchyhouse_v2",
	"zs_ravine",
	"zs_scrapmetal_v2_fixed",
	"zs_slugde_fixed",
	"zs_trainstation",
	"zs_urbandecay2",
	--"zsb_ravenholm_pre_b1"
}

-- If a person has no player model then use one of these (auto-generated).
GM.RandomPlayerModels = {}
for name, mdl in pairs(player_manager.AllValidModels()) do
	if not table.HasValue(GM.RestrictedModels, string.lower(mdl)) then
		table.insert(GM.RandomPlayerModels, name)
	end
end

-- Utility function to setup a weapon's DefaultClip.
function GM:SetupDefaultClip(tab)
	tab.DefaultClip = math.max(math.ceil(tab.ClipSize * self.SurvivalClips * (tab.ClipMultiplier or 1)),30)
end

GM.MaxSigils = CreateConVar("zsb_maxsigils", "3", FCVAR_ARCHIVE + FCVAR_NOTIFY, "How many sigils to spawn. 0 for none."):GetInt()
cvars.AddChangeCallback("zsb_maxsigils", function(cvar, oldvalue, newvalue)
	GAMEMODE.MaxSigils = math.Clamp(tonumber(newvalue) or 0, 0, 10)
end)

GM.NumberOfWaves = CreateConVar("zsb_numberofwaves", "9", FCVAR_REPLICATED + FCVAR_ARCHIVE + FCVAR_NOTIFY, "Number of waves in a game."):GetInt()
cvars.AddChangeCallback("zsb_numberofwaves", function(cvar, oldvalue, newvalue)
	GAMEMODE.NumberOfWaves = tonumber(newvalue) or 1
end)

GM.RoundLimit = CreateConVar("zsb_roundlimit", "3", FCVAR_ARCHIVE + FCVAR_NOTIFY, "How many times the game can be played on the same map. -1 means infinite or only use time limit. 0 means once."):GetInt()
cvars.AddChangeCallback("zsb_roundlimit", function(cvar, oldvalue, newvalue)
	GAMEMODE.RoundLimit = tonumber(newvalue) or 3
end)

-- Static values that don't need convars...

-- Initial length for wave 1.
GM.WaveOneLength = 420

-- For Classic Mode
GM.WaveOneLengthClassic = 120

-- Add this many seconds for each additional wave.
GM.TimeLostPerWave = 15

-- For Classic Mode
GM.TimeAddedPerWaveClassic = 10

-- New players are put on the zombie team if the current wave is this or higher. Do not put it lower than 1 or you'll break the game.
GM.NoNewHumansWave = 2

-- Humans can not commit suicide if the current wave is this or lower.
GM.NoSuicideWave = 0

-- How long 'wave 0' should last in seconds. This is the time you should give for new players to join and get ready.
GM.WaveZeroLength = 60

-- Time humans have between waves to do stuff without NEW zombies spawning. Any dead zombies will be in spectator (crow) view and any living ones will still be living.
GM.WaveIntermissionLength = 35

-- For Classic Mode
GM.WaveIntermissionLengthClassic = 25

-- Time in seconds between end round and next map.
GM.EndGameTime = 25

-- How many clips of ammo guns from the Worth menu start with. Some guns such as shotguns and sniper rifles have multipliers on this.
GM.SurvivalClips = 2

-- Put your unoriginal, 5MB Rob Zombie and Metallica music here.
GM.SuddenDeathSound = Sound("zombiesurvival/lasthuman.ogg")

-- Sound played when humans all die.
GM.AllLoseSound = Sound("zombiesurvival/music_lose.ogg")

-- Sound played when humans survive.
GM.HumanWinSound = Sound("zombiesurvival/music_qethics1.ogg")
GM.BanditWinSound = Sound("zombiesurvival/music_rules.ogg")
-- Sound played to a person when they die as a human.
GM.DeathSound = Sound("music/stingers/HL1_stinger_song28.mp3")
