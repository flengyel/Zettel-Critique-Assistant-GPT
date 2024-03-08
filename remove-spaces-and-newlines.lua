-- remove-spaces-and-newlines.lua
function cleanText(text)
    -- Replace multiple Windows-style newlines with a single Windows-style newline
    text = text:gsub("\r\n(\r\n)+", "\r\n")
    -- Replace multiple spaces with a single space
    text = text:gsub("%s%s+", " ")
    return text
end

function Str(elem)
    -- Clean up text in Str elements
    elem.text = cleanText(elem.text)
    return elem
end

function Para(elem)
    -- Clean up text in all Str elements within a Para element
    elem.content = pandoc.List.map(elem.content, function(item)
        if item.t == "Str" then
            item.text = cleanText(item.text)
        end
        return item
    end)
    return elem
end
