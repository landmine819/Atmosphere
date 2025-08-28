```lua
local baseFolder = "Atmosphere"

local files = {
    { name = "GuiLibrary.lua", url = "https://raw.githubusercontent.com/landmine819/Atmosphere/refs/heads/main/GuiLibrary.lua" },
    { name = "Main.lua",       url = "https://raw.githubusercontent.com/landmine819/Atmosphere/refs/heads/main/Main.lua" }
}

local subfolders = {
    "Configurations",
    "Discord Invites",
    "Key System"
}

if not isfolder or not writefile or not isfile then
    error("❌ Your executor might not support writefile/isfile/isfolder.")
end

local createdSomething = false

if not isfolder(baseFolder) then
    makefolder(baseFolder)
    print("📂 Created folder: " .. baseFolder)
    createdSomething = true
end

for _, sub in ipairs(subfolders) do
    local path = baseFolder .. "/" .. sub
    if not isfolder(path) then
        makefolder(path)
        print("📂 Created folder: " .. path)
        createdSomething = true
    end
end

for _, fileInfo in ipairs(files) do
    local fullPath = baseFolder .. "/" .. fileInfo.name
    if not isfile(fullPath) then
        local success, content = pcall(function()
            return game:HttpGet(fileInfo.url, true)
        end)

        if not success or type(content) ~= "string" or content == "" then
            warn("⚠ Failed to fetch " .. fileInfo.name .. " from " .. fileInfo.url)
        else
            writefile(fullPath, content)
            print("✅ Saved " .. fileInfo.name .. " to " .. fullPath)
            createdSomething = true
        end
    end
end

if not createdSomething then
    print("✅ All files and folders already exist!")
end

loadfile('Atmosphere/Main.lua')()
```