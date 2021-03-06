
--[[
Copyright 2014 The Luvit Authors. All Rights Reserved.
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS-IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

https://github.com/luvit/luvit/blob/master/tests/libs/deep-equal.lua
--]]

local function deepEqual(expected, actual, path)
  if expected == actual then
    return true
  end
  local prefix = path and (path .. ": ") or ""
  local expectedType = type(expected)
  local actualType = type(actual)
  if expectedType ~= actualType then
    return false
  end
  if expectedType ~= "table" then
    return false
  end
  local expectedLength = #expected
  local actualLength = #actual
  for key in pairs(expected) do
    if actual[key] == nil then
      return false, prefix .. "Missing table key " .. key
    end
    local newPath = path and (path .. '.' .. key) or key
    local same, message = deepEqual(expected[key], actual[key], newPath)
    if not same then
      return same, message
    end
  end
  if expectedLength ~= actualLength then
    return false, prefix .. "Expected table length " .. expectedLength .. " but found " .. actualLength
  end
  for key in pairs(actual) do
    if expected[key] == nil then
      return false, prefix .. "Unexpected table key " .. key
    end
  end
  return true
end

return deepEqual
