-- ################
-- ### MONITORS ###
-- ################

local width = 1920
local height = 1080

-- Main Monitor
hl.monitor({ output = "eDP-1", mode = "2240x1400", position = "0x0", scale = 1 })
hl.workspace_rule({ workspace = "r[1-5]", monitor = "eDP-1", default = true })

