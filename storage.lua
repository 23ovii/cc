-- storage.lua
-- Calculates total, used, and free storage on computer + connected drives

local total = 0
local free = 0

print("=== Storage Summary ===")

-- List all items in root directory
for _, name in ipairs(fs.list("/")) do
    local path = "/" .. name

    -- Check if this is a drive root
    if fs.isDriveRoot(path) then
        local cap = fs.getCapacity(path)
        local fr = fs.getFreeSpace(path)

        -- Skip if capacity is nil (ROM or invalid mount)
        if cap and fr then
            local used = cap - fr
            print(string.format("[%s]  Used: %d KB  Free: %d KB  Total: %d KB",
                name, used/1024, fr/1024, cap/1024))

            total = total + cap
            free = free + fr
        end
    end
end

-- Print totals
print("\n=== TOTAL STORAGE ===")
print(string.format("Used: %d KB", (total - free)/1024))
print(string.format("Free: %d KB", free/1024))
print(string.format("Total: %d KB", total/1024))
