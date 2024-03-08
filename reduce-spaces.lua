-- reduce-spaces.lua

function cleanText(text)
    -- Replace multiple spaces with a single space
    return text:gsub("%s%s+", " ")
end

function Str(elem)
    -- Clean up text in Str elements
    elem.text = cleanText(elem.text)
    return elem
end
