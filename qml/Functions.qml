import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "storage.js" as Storage

Item {
    id: functions
    property int active: 0 // 0 = empty; 1 = active; 2 = inactive; 3 = wall
    property int dots

    // New Game: ok!

    function newGame() {

        pullDownMenu.enabled = false
        root.interactive = false
        mouseArea.enabled = true
        pushUpMenu.enabled = false
        downTimer.running = true

        // Empty grids

        for ( var i = 15; i > 0; i--)
            for ( var j = 1; j < 11; j++) {
                repeater.itemAt(i*12+j).color = Theme.secondaryColor
                repeater.itemAt(i*12+j).active = 0
                repeater.itemAt(i*12+j).opacity = 0.1
            }

        for ( i = 0; i < 12; i++) {
            futureRepeater.itemAt(i).opacity = 0.1
            futureRepeater.itemAt(i).color = Theme.secondaryColor
        }

        activeBlock = -1
        futureBlock = -1

        // Reset score

        level = 1
        scoreValue = 0
        speedValue = 0

        // Calls generate()

        generate()
    }

    // Pause: ok!

    function pause() {
        pullDownMenu.enabled = !pullDownMenu.enabled
        pushUpMenu.enabled = !pushUpMenu.enabled
        root.interactive = !root.interactive
        mouseArea.enabled = !mouseArea.enabled
        downTimer.running = !downTimer.running
    }

    function setDifficulty() {

    }

    function saveGame() {
        savingPage.visible = true
        savingTimer.running = true
        pullDownMenu.enabled = false
        pushUpMenu.enabled = false
        root.interactive = false
        Storage.set("savedGame", 1)
        Storage.set("activeColor", activeColor)
        Storage.set("futureColor", futureColor)
        Storage.set("centerX", centerX)
        Storage.set("centerY", centerY)
        Storage.set("activeBlock", activeBlock)
        Storage.set("futureBlock", futureBlock)
        Storage.set("scoreValue", scoreValue)
        Storage.set("speedValue", speedValue)
        Storage.set("level", level)
        savedGame = 1
    }

    function loadGame() {
        for (var i = 15; i > 0; i--)
            for (var j = 1; j < 11; j++) {
                var index = i*12+j
                repeater.itemAt(index).active = Storage.get("Dot["+index+"].active",repeater.itemAt(index).active)
                repeater.itemAt(index).opacity = Storage.get("Dot["+index+"].opacity",repeater.itemAt(index).opacity)
                repeater.itemAt(index).color = Storage.get("Dot["+index+"].color",repeater.itemAt(index).color)
                console.log("Loading"+index)
            }
        activeColor = Storage.get("activeColor", activeColor)
        centerX = Storage.get("centerX", centerX)
        centerY = Storage.get("centerY", centerY)
        activeBlock = Storage.get("activeBlock", activeBlock)
        futureBlock = Storage.get("futureBlock", futureBlock)
        switch (futureBlock) {
        case 0 :
            future_l_normal()
            break
        case 1 :
            future_l_reverse()
            break
        case 2 :
            future_s_normal()
            break
        case 3 :
            future_s_reverse()
            break
        case 4 :
            future_t_normal()
            break
        case 5 :
            future_square()
            break
        case 6 :
            future_line()
            break
        }
        scoreValue = Storage.get("scoreValue", scoreValue)
        speedValue = Storage.get("speedValue", speedValue)
        level = Storage.get("level", level)
        pushUpMenu.enabled= true
        pause()
    }

    // Tetraminos Active: ok!

    function l_normal()  { // 0 index = [17,29,41,42]
        console.log("called l_normal()")
        var index = [17,29,41,42]
        centerX = 5
        centerY = 2
        activeColor = "red"
        for ( var i = 0; i < 4; i++) {
            repeater.itemAt(index[i]).opacity = 1
            repeater.itemAt(index[i]).color = activeColor
            repeater.itemAt(index[i]).active = 1
        }
    }
    function l_reverse() { // 1 index = [18,30,41,42]
        console.log("called l_reverse()")
        var index = [18,30,41,42]
        centerX = 6
        centerY = 2
        activeColor = "yellow"
        for ( var i = 0; i < 4; i++) {
            repeater.itemAt(index[i]).opacity = 1
            repeater.itemAt(index[i]).color = activeColor
            repeater.itemAt(index[i]).active = 1
        }
    }
    function s_normal()  { // 2 index = [17,29,30,42]
        console.log("called s_normal()")
        var index = [17,29,30,42]
        centerX = 5
        centerY = 2
        activeColor = "orange"
        for ( var i = 0; i < 4; i++) {
            repeater.itemAt(index[i]).opacity = 1
            repeater.itemAt(index[i]).color = activeColor
            repeater.itemAt(index[i]).active = 1
        }
    }
    function s_reverse() { // 3 index = [18,29,30,41]
        console.log("called s_reverse()")
        var index = [18,29,30,41]
        centerX = 6
        centerY = 2
        activeColor = "green"
        for ( var i = 0; i < 4; i++) {
            repeater.itemAt(index[i]).opacity = 1
            repeater.itemAt(index[i]).color = activeColor
            repeater.itemAt(index[i]).active = 1
        }
    }
    function t_normal()  { // 4 index = [17,29,30,41]
        console.log("called t_normal()")
        var index = [17,29,30,41]
        centerX = 5
        centerY = 2
        activeColor = "blue"
        for ( var i = 0; i < 4; i++) {
            repeater.itemAt(index[i]).opacity = 1
            repeater.itemAt(index[i]).color = activeColor
            repeater.itemAt(index[i]).active = 1
        }
    }
    function square()    { // 5 index = [17,18,29,30]
        console.log("called square()")
        var index = [17,18,29,30]
        centerX = 5.5
        centerY = 1.5
        activeColor = "magenta"
        for ( var i = 0; i < 4; i++) {
            repeater.itemAt(index[i]).opacity = 1
            repeater.itemAt(index[i]).color = activeColor
            repeater.itemAt(index[i]).active = 1
        }
    }
    function line()      { // 6 index = [16,17,18,19]
        console.log("called line()")
        var index = [16,17,18,19]
        centerX = 5
        centerY = 1
        activeColor = "cyan"
        for ( var i = 0; i < index.length; i++) {
            repeater.itemAt(index[i]).opacity = 1
            repeater.itemAt(index[i]).color = activeColor
            repeater.itemAt(index[i]).active = 1
        }
    }

    // Tetraminos Future: ok!

    function future_l_normal()  { // 0
        console.log("called future_l_normal()")
        var index = [1,5,9,10]
        futureColor = "red"
        for ( var i = 0; i < 12; i++) {
            futureRepeater.itemAt(i).opacity = 0.1
            futureRepeater.itemAt(i).color = Theme.secondaryColor
        }
        for (i = 0; i < 4; i++) {
            futureRepeater.itemAt(index[i]).opacity = 1
            futureRepeater.itemAt(index[i]).color = futureColor
        }
    }
    function future_l_reverse() { // 1
        console.log("called future_l_reverse()")
        var index = [2,6,9,10]
        futureColor = "yellow"
        for ( var i = 0; i < 12; i++) {
            futureRepeater.itemAt(i).opacity = 0.1
            futureRepeater.itemAt(i).color = Theme.secondaryColor
        }
        for (i = 0; i < 4; i++) {
            futureRepeater.itemAt(index[i]).opacity = 1
            futureRepeater.itemAt(index[i]).color = futureColor
        }
    }
    function future_s_normal()  { // 2
        console.log("called future_s_normal()")
        var index = [1,5,6,10]
        futureColor = "orange"
        for ( var i = 0; i < 12; i++) {
            futureRepeater.itemAt(i).opacity = 0.1
            futureRepeater.itemAt(i).color = Theme.secondaryColor
        }
        for (i = 0; i < 4; i++) {
            futureRepeater.itemAt(index[i]).opacity = 1
            futureRepeater.itemAt(index[i]).color = futureColor
        }
    }
    function future_s_reverse() { // 3
        console.log("called future_s_reverse()")
        var index = [2,5,6,9]
        futureColor = "green"
        for ( var i = 0; i < 12; i++) {
            futureRepeater.itemAt(i).opacity = 0.1
            futureRepeater.itemAt(i).color = Theme.secondaryColor
        }
        for (i = 0; i < 4; i++) {
            futureRepeater.itemAt(index[i]).opacity = 1
            futureRepeater.itemAt(index[i]).color = futureColor
        }
    }
    function future_t_normal()  { // 4
        console.log("called future_t_normal()")
        var index = [1,5,6,9]
        futureColor = "blue"
        for ( var i = 0; i < 12; i++) {
            futureRepeater.itemAt(i).opacity = 0.1
            futureRepeater.itemAt(i).color = Theme.secondaryColor
        }
        for (i = 0; i < 4; i++) {
            futureRepeater.itemAt(index[i]).opacity = 1
            futureRepeater.itemAt(index[i]).color = futureColor
        }
    }
    function future_square()    { // 5
        console.log("called future_square()")
        var index = [5,6,9,10]
        futureColor = "magenta"
        for ( var i = 0; i < 12; i++) {
            futureRepeater.itemAt(i).opacity = 0.1
            futureRepeater.itemAt(i).color = Theme.secondaryColor
        }
        for (i = 0; i < 4; i++) {
            futureRepeater.itemAt(index[i]).opacity = 1
            futureRepeater.itemAt(index[i]).color = futureColor
        }
    }
    function future_line()      { // 6
        console.log("called future_line()")
        var index = [4,5,6,7]
        futureColor = "cyan"
        for ( var i = 0; i < 12; i++) {
            futureRepeater.itemAt(i).opacity = 0.1
            futureRepeater.itemAt(i).color = Theme.secondaryColor
        }
        for (i = 0; i < 4; i++) {
            futureRepeater.itemAt(index[i]).opacity = 1
            futureRepeater.itemAt(index[i]).color = futureColor
        }
    }


    // Rotation: ok!

    function rotate() {
        var x = [], newX = [], originX = [], tempX = [],
            y = [], newY = [], originY = [], tempY = []

        for (var i = 15; i > 0; i--)
            for (var j = 1; j < 11; j++)
                if (repeater.itemAt(i*12+j).active === 1) {
                    x[x.length] = j
                    y[y.length] = i
                }
        // Traslation
        for (i = 0; i < x.length; i++) {
            originX[i] = (x[i] - centerX)
            originY[i] = (y[i] - centerY)
        }
        // Rotation
        for (i = 0; i < x.length; i++) {
            tempX[i] = -originY[i]
            tempY[i] =  originX[i]
        }
        // Second Traslation
        for (i = 0; i < x.length; i++) {
            newX[i] = (tempX[i] + centerX)
            newY[i] = (tempY[i] + centerY)
        }

        // Empty
        for ( i = 0; i < x.length; i++) {
            repeater.itemAt( y[i] * 12 + x[i] ).color = Theme.secondaryColor
            repeater.itemAt( y[i] * 12 + x[i] ).active = 0
            repeater.itemAt( y[i] * 12 + x[i] ).opacity = 0.1
        }

        // Check if space available
        var available = 1
        for ( i = 0; i < x.length; i++)
            if (repeater.itemAt( newY[i] * 12 + newX[i] ).active !== 0 )
                available = 0

        if (available === 1) {
            // Refill new dots
            for ( i = 0; i < x.length; i++) {
                repeater.itemAt( newY[i] * 12 + newX[i] ).color = activeColor
                repeater.itemAt( newY[i] * 12 + newX[i] ).active = 1
                repeater.itemAt( newY[i] * 12 + newX[i] ).opacity = 1
            }
        } else if (available === 0) {
            // Refill old dots
            for ( i = 0; i < x.length; i++) {
                repeater.itemAt( y[i] * 12 + x[i] ).color = activeColor
                repeater.itemAt( y[i] * 12 + x[i] ).active = 1
                repeater.itemAt( y[i] * 12 + x[i] ).opacity = 1
            }
        }
    }

    // Random choice of tetramino: ok!

    function generate() {

        if ( futureBlock === -1 ) {
            var rand = Math.floor(Math.random()*7)
            activeBlock = rand
            switch (activeBlock) {
            case 0 :
                l_normal()
                break
            case 1 :
                l_reverse()
                break
            case 2 :
                s_normal()
                break
            case 3 :
                s_reverse()
                break
            case 4 :
                t_normal()
                break
            case 5 :
                square()
                break
            case 6 :
                line()
                break
            case 7 :
                generate()
                break
            }
            var futureRand = Math.floor(Math.random()*7)
            futureBlock = futureRand
            switch (futureBlock) {
            case 0 :
                future_l_normal()
                break
            case 1 :
                future_l_reverse()
                break
            case 2 :
                future_s_normal()
                break
            case 3 :
                future_s_reverse()
                break
            case 4 :
                future_t_normal()
                break
            case 5 :
                future_square()
                break
            case 6 :
                future_line()
                break
            case 7 :
                generate()
                break
            }

        } else {
            var game = true
            activeBlock = futureBlock
            switch (activeBlock) {
            case 0 :
                if ( repeater.itemAt(17).active + repeater.itemAt(29).active + repeater.itemAt(41).active + repeater.itemAt(42).active === 0)
                    l_normal()
                else {
                    gameOver()
                    game = false
                }
                break
            case 1 :
                if ( repeater.itemAt(18).active + repeater.itemAt(30).active + repeater.itemAt(41).active + repeater.itemAt(42).active === 0)
                    l_reverse()
                else {
                    gameOver()
                    game = false
                }
                break
            case 2 :
                if ( repeater.itemAt(17).active + repeater.itemAt(29).active + repeater.itemAt(30).active + repeater.itemAt(42).active === 0)
                    s_normal()
                else {
                    gameOver()
                    game = false
                }
                break
            case 3 :
                if ( repeater.itemAt(18).active + repeater.itemAt(29).active + repeater.itemAt(30).active + repeater.itemAt(41).active === 0)
                    s_reverse()
                else {
                    gameOver()
                    game = false
                }
                break
            case 4 :
                if ( repeater.itemAt(17).active + repeater.itemAt(29).active + repeater.itemAt(30).active + repeater.itemAt(41).active === 0)
                    t_normal()
                else {
                    gameOver()
                    game = false
                }
                break
            case 5 :
                if ( repeater.itemAt(17).active + repeater.itemAt(18).active + repeater.itemAt(29).active + repeater.itemAt(30).active === 0)
                    square()
                else {
                    gameOver()
                    game = false
                }
                break
            case 6 :
                if ( repeater.itemAt(16).active + repeater.itemAt(17).active + repeater.itemAt(18).active + repeater.itemAt(19).active === 0)
                    line()
                else {
                    gameOver()
                    game = false
                }
                break
            }
            if (game) {
                futureRand = Math.floor(Math.random()*7)
                futureBlock = futureRand
                switch (futureBlock) {
                case 0 :
                    future_l_normal()
                    break
                case 1 :
                    future_l_reverse()
                    break
                case 2 :
                    future_s_normal()
                    break
                case 3 :
                    future_s_reverse()
                    break
                case 4 :
                    future_t_normal()
                    break
                case 5 :
                    future_square()
                    break
                case 6 :
                    future_line()
                    break
                case 7 :
                    generate()
                    break
                }
            }
        }
    }

    // Game over: ok!

    function gameOver() {
        pullDownMenu.enabled = true
        pushUpMenu.enabled = false
        root.interactive = true
        mouseArea.enabled = false
        downTimer.running = false
        if (scoreValue > Storage.get("highscore", highscoreValue)) {
            Storage.set("highscore", scoreValue)
            highscoreValue = scoreValue
        }
        scoreValue -= 1
        console.log("Game Over")
    }

    // Down Flow Traslation: ok!

    function flow() {
        var down = 1
        for (var i = 190; i > 12; i-- )
            if (repeater.itemAt(i).active === 1 && repeater.itemAt(i+12).active > 1)
                down = 0
        if ( down === 1 ) {
            for (i = 190; i > 12; i-- ) {
                if (repeater.itemAt(i).active === 1) {
                    repeater.itemAt(i+12).color = repeater.itemAt(i).color
                    repeater.itemAt(i+12).active = repeater.itemAt(i).active
                    repeater.itemAt(i+12).opacity = repeater.itemAt(i).opacity
                    repeater.itemAt(i).color = Theme.secondaryColor
                    repeater.itemAt(i).active = 0
                    repeater.itemAt(i).opacity = 0.1
                }
            }
            centerY += 1
        } else if (down === 0) {
            for (i = 190; i > 12; i-- )
                if (repeater.itemAt(i).active === 1)
                    repeater.itemAt(i).active = 2
            score()
            generate()
        }
    }

    // Down Traslation: ok!

    function down() {
        var down = 1
        for (var i = 190; i > 12; i-- )
            if (repeater.itemAt(i).active === 1 && repeater.itemAt(i+12).active > 1)
                down = 0
        if ( down === 1 ) {
            for (i = 190; i > 12; i-- ) {
                if (repeater.itemAt(i).active === 1) {
                    repeater.itemAt(i+12).color = repeater.itemAt(i).color
                    repeater.itemAt(i+12).active = repeater.itemAt(i).active
                    repeater.itemAt(i+12).opacity = repeater.itemAt(i).opacity
                    repeater.itemAt(i).color = Theme.secondaryColor
                    repeater.itemAt(i).active = 0
                    repeater.itemAt(i).opacity = 0.1
                }
            }
            centerY += 1
        }
    }

    // Left Traslation: ok!

    function left() {
        var left = 1
        for (var i = 1; i < 204; i++ )
            if (repeater.itemAt(i).active === 1 && repeater.itemAt(i-1).active > 1)
                left = 0

        if ( left === 1 ) {
            for (i = 1; i < 204; i++ ) {
                if (repeater.itemAt(i).active === 1) {
                    repeater.itemAt(i-1).color = repeater.itemAt(i).color
                    repeater.itemAt(i-1).active = repeater.itemAt(i).active
                    repeater.itemAt(i-1).opacity = repeater.itemAt(i).opacity
                    repeater.itemAt(i).color = Theme.secondaryColor
                    repeater.itemAt(i).active = 0
                    repeater.itemAt(i).opacity = 0.1
                }
            }
            centerX -= 1
        }
    }

    // Right traslation: ok!

    function right() {
        var right = 1
        for (var i = 202; i > 0; i-- )
            if (repeater.itemAt(i).active === 1 && repeater.itemAt(i+1).active > 1)
                right = 0

        if ( right === 1 ) {
            for (i = 202; i > 0; i-- ) {
                if (repeater.itemAt(i).active === 1) {
                    repeater.itemAt(i+1).color = repeater.itemAt(i).color
                    repeater.itemAt(i+1).active = repeater.itemAt(i).active
                    repeater.itemAt(i+1).opacity = repeater.itemAt(i).opacity
                    repeater.itemAt(i).color = Theme.secondaryColor
                    repeater.itemAt(i).active = 0
                    repeater.itemAt(i).opacity = 0.1
                }
            }
            centerX += 1
        }
    }

    // Score function:
    // Set 10 points for each full line: ok!
    // Set 100 point bonus for combos: ok!
    // Empty full lines and traslate other dots: ok!
    // Increase speed each 1000 points! ok!
    // Set 1000 point bonus for 4 lines combo: ok!

    function score() {
        var score = 0
        var lines = []
        for (var i = 15; i > 0; i--) {
            var full = 0
            for (var j = 1; j < 11; j++) {
                if (repeater.itemAt(i*12+j).active === 2) {
                    full++
                }
            }
            if (full === 10)
                lines[lines.length] = i
        }
        console.log("Full lines: " + lines)
        score += lines.length*10

        // Bonus

        if (lines.length > 1) {
            if (lines.length === 4)
                score += 1000
            else
                score += 100*lines.length
        }

        scoreValue += score
        speedValue += score

        // Increase speed

        if ( speedValue > 1000){
            speedValue = 0
            level += 1
            console.log("Timer set: " + downTimer.interval)
        }

        for (var k = 0; k < lines.length; k++) {
            for ( i = lines[0]; i > 0; i--) {
                if ( i === 1) {
                    for ( j = 1; j < 11; j++) {
                        if (repeater.itemAt(i*12+j).active !== 3){
                            repeater.itemAt(i*12+j).color = Theme.secondaryColor
                            repeater.itemAt(i*12+j).active = 0
                            repeater.itemAt(i*12+j).opacity = 0.1
                        }
                    }
                } else
                    for ( j = 1; j < 11; j++) {
                        if (repeater.itemAt(i*12+j).active !== 3){
                            repeater.itemAt(i*12+j).color = repeater.itemAt(i*12+j-12).color
                            repeater.itemAt(i*12+j).active = repeater.itemAt(i*12+j-12).active
                            repeater.itemAt(i*12+j).opacity = repeater.itemAt(i*12+j-12).opacity
                            repeater.itemAt(i*12+j-12).color = Theme.secondaryColor
                            repeater.itemAt(i*12+j-12).active = 0
                            repeater.itemAt(i*12+j-12).opacity = 0.1
                        }
                    }

            }
        }
    }

}
