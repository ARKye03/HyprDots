#!/usr/bin/env lua

local Autostart = require('include.autostart')
local KeyBinds = require('include.binds')
local ViewRules = require('include.viewrules')
local Props = require('include.props')
local Rivertile = require('include.rivertile')

-- Autostart()
os.execute(os.getenv("HOME") .. "/.config/river/start.sh")
KeyBinds()
ViewRules()
Props()
Rivertile()
