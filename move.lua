--[[
    Script made by zitus
	discord.gg/zitus
    Cracked and deobfuscated by Natix
    discord.gg/xQA6AnMxfk

    Message for zitus:
    	Nice try with your "obfuscation" attempt, but really... you should have known better.
		Really liked those "api" requests ;)
		P. S. Obfuscating your code multiple times doesn't make it more secure...
]]

lock_license = true -- true = license lock, false = growid lock

-- DISCORD SETTING
YourDiscordid = "384301331273220106"
webhookdc = "https://discord.com/api"

-- MOVE SETTING
move_interval = 265 -- default SAFE
move_range = 6 -- default SAFE
delay_drop = 4000 -- set lower for faster drop
delay_joinworld = 10000 -- set lower for faster drop if ercon do your own risk

-- STORAGE WORLD
main_world = [[
    world|door
    world|door
]]

-- WORLD DESTINATION
world_drop = [[
    world|door
]]

item_id = { 242, 198 } -- multiple item to move

max_value_drop = 100000 -- set each world drop max 10.000, if dont want limit max just set to 9999999
move_direction = 1 -- 1 = drop right, -1 = drop left

-- ============================================

ownerzitus = "NATIX"

allEmpty = false
nuked = false

local script = "move"

getBot():setInterval(Action.move, move_interval / 1000)
getBot().move_range = move_range

-- Error handling
index_storage = 1
chomp = 0
ownerzitus = "NATIX"
getBot():setInterval(Action.collect, 50 / 1000)
getBot().object_collect_delay = 50

new_main_world = {}
new_world_drop = {}

for line in main_world:gmatch("[^\r\n]+") do
	local tmp = line:gsub("%s", "")
	table.insert(new_main_world, tmp)
end
for line in world_drop:gmatch("[^\r\n]+") do
	local tmp = line:gsub("%s", "")
	table.insert(new_world_drop, tmp)
end

list_main_world = {}
list_main_door = {}

list_drop_world = {}
list_drop_door = {}

for i, worlds in pairs(new_main_world) do
	local world = ""
	local door = ""

	local delimiter_bot = string.find(worlds, "[|:]")
	if delimiter_bot then
		world = string.sub(worlds, 1, delimiter_bot - 1)
		door = string.sub(worlds, delimiter_bot + 1)
		table.insert(list_main_world, world:upper())
		table.insert(list_main_door, door:upper())
	end
end

for i, worlds in pairs(new_world_drop) do
	local world = ""
	local door = ""

	local delimiter_bot = string.find(worlds, "[|:]")
	if delimiter_bot then
		world = string.sub(worlds, 1, delimiter_bot - 1)
		door = string.sub(worlds, delimiter_bot + 1)
		table.insert(list_drop_world, world:upper())
		table.insert(list_drop_door, door:upper())
	end
end

posx_save = 0
posy_save = 0
--=====================================================
isDropped = false
alreadyCollect = false

j = 1
k = 1

addEvent(Event.variantlist, function(variant, netid)
	if variant:get(0):getString() == "OnConsoleMessage" then
		if variant:get(1):getString():lower():find("inaccessible") then
			nuked = true
			print("nuked")
		end
	end
end)

-- check Owner script (Patched by Natix)
function verify(lock)
	return "SUCCESS"
end

function isMatch()
	local isOwner = false
	local count = 0
	if not lock_license then
		getBot():say("Wait lemme check")
		sleep(2000)
		-- check Owner script
		while isOwner == false do
			for _, player in pairs(getPlayers()) do
				if verify(player.name) == "SUCCESS" then
					isOwner = true
					ownerzitus = player.name
					getBot():say("Okok i got u")
					powershell("Owner Script is alive")
					sleep(4000)
					break
				end
			end
			if count > 5 then
				return false
			end
			count = count + 1
			sleep(1000)
		end
		return true
	else
		local username_license = getUsername()
		if verify(username_license) ~= "SUCCESS" then
			powershell("License Lucifer not match : " .. username_license)
			print("License Lucifer not match : " .. username_license)
		else
			isOwner = true
		end
	end
	return isOwner
end

function getBP()
	local bp_active = 0
	for _, item in pairs(getBot():getInventory().items) do
		bp_active = bp_active + 1
	end
	return bp_active
end

dcbotnamedc = "MULTI TO MULTI MOVE v1.11 Nuron"
thumbnaildc =
	"https://media.discordapp.net/attachments/1024958860290707457/1100018957819330641/movev.png?width=48&height=48"
colorEmbed = "4672231"
username_bot = "Auto Move Logs"
-- ==================== WEBHOOK ====================================
function powershell(text)
	webhook = Webhook.new(webhookdc)
	webhook.username = username_bot
	webhook.content = text
	webhook.avatar_url = thumbnaildc
	webhook:send()
end

function pshell(text)
	wh = Webhook.new(webhookdc)
	wh.embed1.use = true
	wh.username = username_bot
	wh.embed1.title = dcbotnamedc
	wh.embed1.color = colorEmbed
	wh.embed1.footer.text = os.date("!%a %b %d, %Y at %I:%M %p", os.time() + 7 * 60 * 60)
	wh.embed1:addField("<:megaphone:1164892284408582206> INFORMATION", text, true)
	wh:send()
end

function getBotStatus()
	local status = getBot().status
	if status == BotStatus.online then
		return "online"
	elseif status == BotStatus.offline then
		return "offline"
	elseif status == BotStatus.wrong_password then
		return "wrong_password"
	elseif status == BotStatus.account_banned then
		return "account_banned"
	elseif status == BotStatus.location_banned then
		return "location_banned"
	elseif status == BotStatus.version_update then
		return "version_update"
	elseif status == BotStatus.advanced_account_protection then
		return "AAP"
	elseif status == BotStatus.server_overload then
		return "login fail"
	elseif status == BotStatus.too_many_login then
		return "login fail"
	elseif status == BotStatus.maintenance then
		return "maintenance"
	elseif status == BotStatus.server_busy then
		return "login fail"
	elseif status == BotStatus.guest_limit then
		return "guest_limit"
	elseif status == BotStatus.http_block then
		return "http_block"
	elseif status == BotStatus.bad_name_length then
		return "bad_name_length"
	elseif status == BotStatus.invalid_account then
		return "invalid_account"
	elseif status == BotStatus.error_connecting then
		return "error_connecting"
	elseif status == BotStatus.logon_fail then
		return "login fail"
	elseif status == BotStatus.changing_subserver then
		return "changing sub_server"
	elseif status == BotStatus.captcha_requested then
		return "captcha"
	else
		return "unknown_status"
	end
end

getposx = function()
	player = getBot():getWorld():getLocal()
	if player then
		return math.floor(player.posx / 32)
	end
	return 0
end

getposy = function()
	player = getBot():getWorld():getLocal()
	if player then
		return math.floor(player.posy / 32)
	end
	return 0
end

function recon_pos(x, y, worldnya, id_doornya)
	while getBotStatus() ~= "online" do
		while getBot().google_status == 1 do
			sleep(30000)
		end
		if getBot().google_status ~= 1 and getBotStatus() ~= "online" then
			getBot():connect()
			sleep(30000)
		end
	end

	if getTile(getposx(), getposy()).fg == 6 then
		getBot():warp(worldnya .. "|" .. id_doornya)
		sleep(delay_joinworld)
		getBot():findPath(x, y)
		sleep(100)
	end
end

function scanFloat(id)
	count = 0
	for _, obj in pairs(getObjects()) do
		if obj.id == id then
			count = count + obj.count
		end
	end
	return count
end

function cekWD(worldnya, idworldnya)
	while getTile(getposx(), getposy()).fg == 6 do
		sleep(1000)
		chomp = chomp + 1
		getBot():say("`2CHOMPED " .. chomp .. "x -_-")
		getBot():warp(worldnya .. "|" .. idworldnya)
		sleep(delay_joinworld)
	end
end

function joinworld(worldnya, idworldnya)
	while not nuked and getBot():getWorld().name:lower() ~= worldnya:lower() do
		getBot():warp(worldnya:upper() .. "|" .. idworldnya:upper())
		listenEvents(10)
		while getBotStatus() ~= "online" or getBot():getPing() == 0 do
			while getBot().google_status == 1 do
				sleep(30000)
			end
			if getBot().google_status ~= 1 and getBotStatus() ~= "online" then
				getBot():connect()
				sleep(10000)
			end
		end
	end

	if not nuked then
		if getBot():getWorld().name ~= worldnya:upper() or getTile(getposx(), getposy()).fg == 6 then
			getBot():warp(worldnya .. "|" .. idworldnya)
			sleep(5000)
		end
		return true
	else
		nuked = false
		return false
	end
end

function recon(worldnya, iddoornya)
	if getBotStatus() ~= "online" or getBot():getPing() == 0 then
		powershell("BOT DISCONNECTED")
	end
	while getBotStatus() ~= "online" or getBot():getPing() == 0 do
		while getBot().google_status == 1 do
			sleep(30000)
		end
		if getBot().google_status ~= 1 and getBotStatus() ~= "online" then
			getBot():connect()
			sleep(30000)
		end
		if getBotStatus() == "online" and getBot():getWorld().name ~= worldnya then
			joinworld(worldnya, iddoornya)
		end
	end
end

function isEmpty()
	local count = 0
	-- cek bp kalo semua kosong baru take ke world storage
	for _, itemID in pairs(item_id) do
		if getBot():getInventory():findItem(itemID) == 0 then
			count = count + 1
		end
	end
	if count == #item_id then
		return true
	end
	return false
end

-- kalo floating ada yang 0 tapi ada yg lbh dr 0 maka belum next world
-- kalo semua 0 dari item_id maka next world
function take()
	local count = 0
	local alreadyCollect = false

	-- cek bp kalo semua kosong baru take ke world storage
	while true do
		if isEmpty() then
			-- print("bp emptyyy")
			if joinworld(list_main_world[index_storage], list_main_door[index_storage]) then
				cekWD(list_main_world[index_storage], list_main_door[index_storage])
				-- cek storage mana yang masih ada isi nya
				for _, obj in pairs(getObjects()) do
					for _, itemID in pairs(item_id) do
						if itemID == obj.id then
							count = count + 1
						end
					end
				end

				-- masih ada item floating
				if count > 0 then
					-- print("Item exist")
					for _, itemID in pairs(item_id) do
						for _, obj in pairs(getObjects()) do
							if obj.id == itemID then
								x = math.floor(obj.x / 32)
								y = math.floor(obj.y / 32)
								cekWD(list_main_world[index_storage], list_main_door[index_storage])
								recon_pos(x, y, list_main_world[index_storage], list_main_door[index_storage])
								sleep(200)

								if getBot():findPath(x, y) == false then
									print("Can't teleport something blocked path")
								else
									getBot():findPath(x, y)
								end
								sleep(200)
								getBot():collect(4)
								sleep(200)
							end

							-- kalo semisal mau take floating item dari ht
							if scanFloat(itemID) > 0 then
								if getBot():getInventory():findItem(itemID) == 200 then
									alreadyCollect = true
									break
								end
							-- floating dah abis
							else
								if getBot():getInventory():findItem(itemID) > 0 then
									alreadyCollect = true
									break
								end
							end
						end
						if alreadyCollect == true then
							break
						end
					end
				else
					index_storage = index_storage + 1
					if index_storage > #list_main_world then
						index_storage = 1
						powershell("ALL STORAGE IS EMPTY")
						allEmpty = true
						break
					end
				end
			else
				index_storage = index_storage + 1
				if index_storage > #list_main_world then
					index_storage = 1
					powershell("ALL STORAGE IS EMPTY")
					allEmpty = true
					break
				end
			end
		else -- di bp masi ada item
			-- print("sudah gk 0")
			break
		end
	end
end

function countTile(target_x, target_y)
	count = 0
	for _, obj in pairs(getObjects()) do
		local x = math.floor(obj.x / 32)
		local y = math.floor(obj.y / 32)
		if x == target_x and y == target_y then
			count = count + 1
		end
	end
	return count
end

function isMax(target_x, target_y)
	if countTile(target_x, target_y) >= 15 then
		return true
	end
	return false
end

function main()
	powershell("BOT START MOVE BLOCK")
	for _, world in pairs(list_drop_world) do
		local isWorldFull = false
		while isWorldFull == false and allEmpty == false do
			-- take item dari storage + cek item di bp
			take()
			-- Scan isi world apakah sudah maximum dari yang sudah ditentukan
			if joinworld(world, list_drop_door[_]) then
				cekWD(world, list_drop_door[_])
				local ori_x = getposx()
				for _, itemID in pairs(item_id) do
					if scanFloat(itemID) >= max_value_drop then
						isWorldFull = true
						-- getBot():say("/msg "..ownerzitus.." World "..world.." is already more than "..max_value_drop)
						powershell("WORLD DROP : " .. world .. " REACH MAX AMMOUNT")
						break
					end
				end

				if isWorldFull == false then
					if posx_save ~= 0 or posy_save ~= 0 then
						if posx_save == 98 or posx_save == 1 then
							posy_save = posy_save - 1
							posx_save = ori_x
						end

						if getposx() ~= posx_save or getposy() ~= posy_save then
							cekWD(world, list_drop_door[_])
							getBot():findPath(posx_save, posy_save)
							sleep(40)
							while getposx() ~= posx_save or getposy() ~= posy_save do
								cekWD(world, list_drop_door[_])
								recon(world, list_drop_door[_])
								getBot():findPath(posx_save, posy_save)
								recon(world, list_drop_door[_])
								sleep(40)
							end
							recon(world, list_drop_door[_])
						end
					end

					for _, itemID in pairs(item_id) do
						if getBot():getInventory():findItem(itemID) > 0 then
							x = getposx()
							y = getposy()
							cekWD(world, list_drop_door[_])
							count = getBot():getInventory():findItem(itemID)
							getBot():drop(itemID, getBot():getInventory():findItem(itemID))
							sleep(delay_drop)
							recon_pos(x, y, world, list_drop_door[_])
							while
								getBot():getInventory():findItem(itemID) == count
								and getBot():getInventory():findItem(itemID) ~= 0
								and isWorldFull == false
							do
								cekWD(world, list_drop_door[_])
								recon(world, list_drop_door[_])
								getBot():moveTo(move_direction, 0)
								getBot():drop(itemID, getBot():getInventory():findItem(itemID))
								sleep(delay_drop)
								recon_pos(x, y, world, list_drop_door[_])
								posx_save = getposx()
								posy_save = getposy()
							end
						end
					end
				else
					posx_save = 0
					posy_save = 0
				end
			end
		end
	end

	getBot():warp("EXIT")
	getBot():disconnect()
end

if isMatch() then
	getBot():say("AUTO MOVE ON !")
	main()
end
