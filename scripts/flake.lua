#!/usr/bin/env lua


-- Get the directory of the current script
local script_dir = debug.getinfo(1).source:match("@?(.*/)")
package.path = script_dir .. "?.lua;" .. package.path

local lib = require('lib')

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local function parse_args(args)
  local native_build_inputs = {}
  local build_inputs = {}
  local current_flag = nil

  for _, arg in ipairs(args) do
    if arg == "-n" then
      current_flag = "native"
    elseif arg == "-b" then
      current_flag = "build"
    else
      if current_flag == "native" then
        table.insert(native_build_inputs, arg)
      elseif current_flag == "build" then
        table.insert(build_inputs, arg)
      else
        table.insert(native_build_inputs, arg)
      end
    end
  end

  return native_build_inputs, build_inputs
end

local native_build_inputs, build_inputs = parse_args(arg)

if file_exists("flake.nix") then
  os.exit(0)
else
  local flake_nix_content = [[
{
  description = "my project description";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          nix-utils = with pkgs; [
            nixd
            nixpkgs-fmt
          ];
          shell = pkgs.mkShell {
            nativeBuildInputs = with pkgs.buildPackages; [ ]] ..
      table.concat(native_build_inputs, " ") .. [[ ] ++ nix-utils;
            buildInputs = with pkgs; [ ]] .. table.concat(build_inputs, " ") .. [[ ];
          };
        in
        {
          devShells.default = shell;
        }
      );
}
]]

  local file = io.open("flake.nix", "w")
  if file then
    file:write(flake_nix_content)
    file:close()
  end
  lib.Notify("flake.nix created", "low", 2000)
end
