local function download(url, path)
    local request = http.get(url)
    if not request then
        print("HTTP request failed!")
        return
    end
    local content = request.readAll()
    request.close()

    local file = fs.open(path, "w")
    file.write(content)
    file.close()

    print("Downloaded as " .. path)
end

local url = ...
if not url then
    print("Usage: wget <raw-url>")
    return
end

local file = url:match("^.+/(.+)$")
download(url, file)
