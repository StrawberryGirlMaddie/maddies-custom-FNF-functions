forcedBars = false
showBars = false
bars = 1
maxBars = 1
function setMaxBars(value, show)
    if value < 2 then
        showBars = false
    else
        showBars = true
    end
    if show then
        showBars = true
    end
    maxBars = value
    if not forcedBars then
        if bars > maxBars then
            bars = maxBars
        end
    end
end
function setBars(value, force)
    if force then
        forcedBars = true
    end
    if force == false then
        forcedBars = false
    end
    if value == '+' then
        bars = bars + 1
    end
    if value == '-' then
        bars = bars - 1
    end
    if not (value == '+' or value == '-') then
        bars = value
    end
    if not force and not forcedBars then
        forcedBars = false
        if bars > maxBars then
            bars = maxBars
        end
    end
    if bars <= maxBars then
        forcedBars = false
    end
    if bars < 1  then
        setProperty('health', 0)
    end
end
function checkForBars(operation, value)
    if bars == 1 then
        return false
    else
        if operation == '=' then
            if bars == value then
                return true
            end
        end
        if operation == '~=' then
            if bars ~= value then
                return true
            end
        end
        if operation == '>' then
            if bars > value then
                return true
            end
        end
        if operation == '<' then
            if bars < value then
                return true
            end
        end
        if operation == '<=' then
            if bars <= value then
                return true
            end
        end
        if operation == '>=' then
            if bars >= value then
                return true
            end
        end
    end
end

function onUpdatePost()
    if maxBars > 1 then
        if bars > 1 then
            setProperty('iconP1.animation.curAnim.curFrame', 0)
        else
            setProperty('iconP1.animation.curAnim.curFrame', 1)
        end
        if bars ~= maxBars then
            setProperty('iconP2.animation.curAnim.curFrame', 0)
        else
            setProperty('iconP2.animation.curAnim.curFrame', 1)
        end
    end
end
function onGameOver()
    if bars > 1 then
        setBars('-')
        setProperty('health', 2)
        return Function_Stop
    else
        return Funtion_Continue
    end
end

function goodNoteHit()
    if bars < maxBars then
        if getProperty('health') >= 2 then
            setBars('+')
            setProperty('health', 0.01)
        end
    end
end

barText = ''
hpText = ''
function onUpdate()
    if showBars or bars > 1 or maxBars > 1 then
        barText = ' / hp bars: '..bars..'/'..maxBars
    end

    hpText = math.floor((((getProperty('health')/2) * 100) / maxBars) + ((100/maxBars) * (bars - 1)))
    setTextString('scoreTxt','Score: '..score..' / Misses: '..misses..' / Rating: '..string.format("%.2f", (rating * 100))..'%'..' / HP:'..hpText..barText)  
end