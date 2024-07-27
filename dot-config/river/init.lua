#!/usr/bin/env lua

local Autostart = require('autostart')
local KeyBinds = require('binds')
local ViewRules = require('viewrules')
local Props = require('props')
local Rivertile = require('rivertile')

-- Autostart()
os.execute(os.getenv("HOME") .. "/.config/river/start.sh")
KeyBinds()
ViewRules()
Props()
Rivertile()
