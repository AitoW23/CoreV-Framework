----------------------- [ CoreV ] -----------------------
-- GitLab: https://git.thymonarens.nl/ThymonA/corev-framework/
-- GitHub: https://github.com/ThymonA/CoreV-Framework/
-- License: GNU General Public License v3.0
--          https://choosealicense.com/licenses/gpl-3.0/
-- Author: ThymonA
-- Name: CoreV
-- Version: 1.0.0
-- Description: Custom FiveM Framework
----------------------- [ CoreV ] -----------------------

--- Returns a webhook by action
--- @param action string Action
--- @param fallback string fallback webhook
local function getWebhooks(action, fallback)
    action = string.lower(action or 'none')

    if (Config.Webhooks ~= nil and Config.Webhooks[action] ~= nil) then
        return Config.Webhooks[action]
    end

    local actionParts = Split(action, '.')

    table.remove(actionParts, #actionParts)

    if (actionParts ~= nil and #actionParts > 0) then
        local newAction = ''

        for i = 1, #actionParts, 1 do
            if (i == 1) then
                newAction = actionParts[i]
            else
                newAction = newAction .. '.' .. actionParts[i]
            end
        end

        return getWebhooks(newAction)
    end

    if (fallback ~= nil and fallback) then
        return Config.FallbackWebhook
    end

    return nil
end

--- Reutnrs a module file
--- @param module string Module name
--- @param file string Path to module file
local function getModuleFile(module, file)
    local content = LoadResourceFile(CR(), 'modules/' .. module .. '/' .. file)

    if (content) then
        return content
    end

    return nil
end

--- Reutnrs a resource file
--- @param resource string Resource name
--- @param file string Path to module file
local function getResourceFile(resource, file)
    local content = LoadResourceFile(resource, file)

    if (content) then
        return content
    end

    return nil
end

-- FiveM maniplulation
_ENV.getWebhooks = getWebhooks
_G.getWebhooks = getWebhooks
_ENV.getModuleFile = getModuleFile
_G.getModuleFile = getModuleFile
_ENV.getResourceFile = getResourceFile
_G.getResourceFile = getResourceFile