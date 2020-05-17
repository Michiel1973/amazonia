local add = hunger_ng.add_hunger_data

hunger_ng.add_hunger_data('aotearoa:cooked_bracken_root', {
    satiates = 2,
    heals = 1,
    returns = '',
    timeout = 0
})

hunger_ng.add_hunger_data('aotearoa:cooked_raupo_root', {
    satiates = 2,
    heals = 1,
    returns = '',
    timeout = 0
})

hunger_ng.add_hunger_data('aotearoa:pungapunga', {
		satiates = 3,
		heals = 1,
		returns = '',
		timeout = 0
})

hunger_ng.add_hunger_data('aotearoa:seed_cake', {
		satiates = 4,
		heals = 2,
		returns = '',
		timeout = 0
	})
	
hunger_ng.add_hunger_data('aotearoa:cooked_fiddlehead', {
	satiates = 2,
	heals = 0,
	returns = '',
	timeout = 0
})

hunger_ng.add_hunger_data('aotearoa:cooked_mamaku_pith', {
	satiates = 2,
	heals = 1,
	returns = '',
	timeout = 0
})

hunger_ng.add_hunger_data('aotearoa:cooked_cabbage_tree_root', {
	satiates = 2,
	heals = 1,
	returns = '',
	timeout = 0
})

hunger_ng.add_hunger_data('aotearoa:cooked_cabbage_tree_shoots', {
	satiates = 2,
	heals = 1,
	returns = '',
	timeout = 0
})

hunger_ng.add_hunger_data('aotearoa:cooked_nikau_shoots', {
	satiates = 2,
	heals = 1,
	returns = '',
	timeout = 0
})

hunger_ng.add_hunger_data("aotearoa:pipi", {
	satiates = 1,
	heals = 0,
	returns = '',
	timeout = 0
})

hunger_ng.add_hunger_data("aotearoa:cockle", {
	satiates = 1,
	heals = 0,
	returns = '',
	timeout = 0
})
		
hunger_ng.treelist = {
	{"pohutukawa", "Pohutukawa","\n".. minetest.colorize("#adaba0","(Metrosideros excelsa)"), 3, "flower"},
	{"kauri", "Kauri","\n".. minetest.colorize("#adaba0", "(Agathis australis)"), 2},
	{"karaka", "Karaka","\n".. minetest.colorize("#adaba0", "(Corynocarpus laevigatus)"), 3, nil,"karaka_fruit", "Karaka Fruit",{-0.2, 0, -0.2, 0.2, 0.5, 0.2},	1, -5},
	{"rimu", "Rimu","\n".. minetest.colorize("#adaba0", "(Dacrydium cupressinum)"), 3},
	{"totara", "Totara","\n".. minetest.colorize("#adaba0", "(Podocarpus totara)"), 2},
	{"miro", "Miro","\n".. minetest.colorize("#adaba0", "(Prumnopitys ferruginea)"), 2,nil, "miro_fruit", "Miro Fruit",{-0.2, 0, -0.2, 0.2, 0.5, 0.2},	1, 1},
	{"kahikatea", "Kahikatea","\n".. minetest.colorize("#adaba0", "(Dacrycarpus dacrydioides)"), 2},
  {"tawa", "Tawa","\n".. minetest.colorize("#adaba0", "(Beilschmiedia tawa)"), 3,nil, "tawa_fruit", "Tawa Fruit",{-0.2, 0, -0.2, 0.2, 0.5, 0.2},	1, 1},
  {"black_beech", "Black Beech","\n".. minetest.colorize("#adaba0", "(Fuscospora solandri)"), 2},
	{"kamahi", "Kamahi","\n".. minetest.colorize("#adaba0", "(Weinmannia racemosa)"), 2, "flower"},
	{"mountain_beech", "Mountain Beech","\n".. minetest.colorize("#adaba0", "(Fuscospora cliffortioides)"),2},
	{"pahautea", "Pahautea","\n".. minetest.colorize("#adaba0", "(Libocedrus bidwillii)"),2},
	{"kowhai", "Kowhai","\n".. minetest.colorize("#adaba0", "(Sophora microphylla)"), 3, "flower",},
	{"silver_beech", "Silver Beech","\n".. minetest.colorize("#adaba0", "(Lophozonia menziesii)"),2},
	{"black_maire", "Black Maire","\n".. minetest.colorize("#adaba0", "(Nestegis cunninghamii)"),2, "flower",},
	{"hinau", "Hinau","\n".. minetest.colorize("#adaba0", "(Elaeocarpus dentatus)"), 2,"flower", "hinau_fruit", "Hinau Fruit",{-0.2, 0, -0.2, 0.2, 0.5, 0.2},	1, 1},
}


for i in ipairs(hunger_ng.treelist) do
	local treename = hunger_ng.treelist[i][1]
	local treedesc = hunger_ng.treelist[i][2]
	local sci_name = hunger_ng.treelist[i][3]
	local decay = hunger_ng.treelist[i][4]
	local type = hunger_ng.treelist[i][5]
	local fruit = hunger_ng.treelist[i][6]
	local fruitdesc = hunger_ng.treelist[i][7]
	local selbox = hunger_ng.treelist[i][8]
	local vscale = hunger_ng.treelist[i][9]
	local foodvalue = hunger_ng.treelist[i][10]
	
local fruitname = nil
	if fruit then
	
	hunger_ng.add_hunger_data("aotearoa:"..fruit, {
			satiates = 1,
			heals = 0,
			returns = '',
			timeout = 0
		})
	end
end
