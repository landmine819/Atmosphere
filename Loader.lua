local baseFolder = "Kamiblue"

local files = {
    { name = "Library/GuiLibrary.lua", url = "https://raw.githubusercontent.com/landmine819/Atmosphere/refs/heads/main/GuiLibrary.lua" },
    { name = "Main.lua",               url = "https://raw.githubusercontent.com/landmine819/Atmosphere/refs/heads/main/Main.lua" }
}

local subfolders = {
    "Configurations",
    "Discord Invites",
    "Key System",
    "Library"
}

if not isfolder or not writefile or not isfile then
    error("Your executor does not support writefile.")
end

local createdSomething = false

if not isfolder(baseFolder) then
    makefolder(baseFolder)
    print("Succesfully created folder: " .. baseFolder)
    createdSomething = true
end

for _, sub in ipairs(subfolders) do
    local path = baseFolder .. "/" .. sub
    if not isfolder(path) then
        makefolder(path)
        print("Succesfully created subfolder: " .. path)
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
            warn("Failed to fetch " .. fileInfo.name .. " from " .. fileInfo.url)
        else
            local parent = fullPath:match("(.+)/[^/]+$")
            if parent and not isfolder(parent) then
                makefolder(parent)
            end

            writefile(fullPath, content)
            print("Saved " .. fileInfo.name .. " to " .. fullPath)
            createdSomething = true
        end
    end
end

if not createdSomething then
    print("All files and folders already exist!")
end

task.wait()
loadfile(baseFolder .. "/Main.lua")()
