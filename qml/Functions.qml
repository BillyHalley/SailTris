import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: functions
    property int active: 0 // 0 = empty; 1 = active; 2 = inactive; 3 = wall
    property int dots

    // New Game:
    // Empty grid, reset score, calls random(): ok

    function newGame() {

        pullDownMenu.enabled = false
        root.interactive = false
        mouseArea.enabled = true
        pauseMenuItem.visible = true

        // Empty grid

        for (var i = 15; i > 0; i--)
            for (var j = 1; j < 11; j++) {
                repeater.itemAt(i*12+j).color = Theme.secondaryColor
                repeater.itemAt(i*12+j).active = 0
                repeater.itemAt(i*12+j).opacity = 0.1
            }

        // Reset score

        page.scoreValue = 0
        page.speedValue = 0
        page.speed = 0
        page.interval = 1000

        // Calls random()
        var rand = Math.floor(Math.random()*7)
        console.log("Casuale: " + rand)
        random(rand)
    }

    // Pause: ok!

    function pause() {
        pullDownMenu.enabled = true
        root.interactive = true
        mouseArea.enabled = false
        pauseMenuItem.visible = false
    }

    // Tetraminos: ok!

    function l_normal()  { // 0
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
    function l_reverse() { // 1
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
    function s_normal()  { // 2
        console.log("called s_normal()")
        var index = [17,18,28,29]
        centerX = 5
        centerY = 2
        activeColor = "orange"
        for ( var i = 0; i < 4; i++) {
            repeater.itemAt(index[i]).opacity = 1
            repeater.itemAt(index[i]).color = activeColor
            repeater.itemAt(index[i]).active = 1
        }
    }
    function s_reverse() { // 3
        console.log("called s_reverse()")
        var index = [17,18,30,31]
        centerX = 6
        centerY = 2
        activeColor = "green"
        for ( var i = 0; i < 4; i++) {
            repeater.itemAt(index[i]).opacity = 1
            repeater.itemAt(index[i]).color = activeColor
            repeater.itemAt(index[i]).active = 1
        }
    }
    function t_normal()  { // 4
        console.log("called t_normal()")
        var index = [16,17,18,29]
        centerX = 5
        centerY = 1
        activeColor = "blue"
        for ( var i = 0; i < 4; i++) {
            repeater.itemAt(index[i]).opacity = 1
            repeater.itemAt(index[i]).color = activeColor
            repeater.itemAt(index[i]).active = 1
        }
    }
    function square()    { // 5
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
    function line()      { // 6
        console.log("called line()")
        var index = [18,30,42,54]
        centerX = 6
        centerY = 3
        activeColor = "cyan"
        for ( var i = 0; i < index.length; i++) {
            repeater.itemAt(index[i]).opacity = 1
            repeater.itemAt(index[i]).color = activeColor
            repeater.itemAt(index[i]).active = 1
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

    // Random choice of tetramino: a bit confusing, have to add future block choice

    function random(rand) {
        page.activeBlock = rand
        if ( rand === 0 && repeater.itemAt(17).active === 0 && repeater.itemAt(29).active === 0
                        && repeater.itemAt(41).active === 0 && repeater.itemAt(42).active === 0) {
            l_normal()
        } else if ( rand === 1 && repeater.itemAt(18).active === 0 && repeater.itemAt(30).active === 0
                               && repeater.itemAt(41).active === 0 && repeater.itemAt(42).active === 0) {
            l_reverse()
        } else if ( rand === 2 && repeater.itemAt(17).active === 0 && repeater.itemAt(18).active === 0
                               && repeater.itemAt(28).active === 0 && repeater.itemAt(29).active === 0) {
            s_normal()
        } else if ( rand === 3 && repeater.itemAt(17).active === 0 && repeater.itemAt(29).active === 0
                               && repeater.itemAt(30).active === 0 && repeater.itemAt(31).active === 0) {
            s_reverse()
        } else if ( rand === 4 && repeater.itemAt(16).active === 0 && repeater.itemAt(17).active === 0
                               && repeater.itemAt(18).active === 0 && repeater.itemAt(29).active === 0) {
            t_normal()
        } else if ( rand === 5 && repeater.itemAt(17).active === 0 && repeater.itemAt(18).active === 0
                               && repeater.itemAt(29).active === 0 && repeater.itemAt(30).active === 0) {
            square()
        } else if ( rand === 6 && repeater.itemAt(18).active === 0 && repeater.itemAt(30).active === 0
                               && repeater.itemAt(42).active === 0 && repeater.itemAt(54).active === 0 ) {
            line()
        } else if ( rand === 7){
            random(Math.floor(Math.random()*7))
        } else {
            console.log("Game Over")
            pullDownMenu.enabled = true
            root.interactive = true
            mouseArea.enabled = false
            pauseMenuItem.visible = false
        }
    }

    // Down traslation: ok!

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
        } else if (down === 0) {
            for (i = 190; i > 12; i-- )
                if (repeater.itemAt(i).active === 1)
                    repeater.itemAt(i).active = 2
            score()
            var rand = Math.floor(Math.random()*7)
            random(rand)
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
    // Increase speed each 1000 points! maybe consider increasing faster
    // Set 1000 point bonus for 4 lines combo

    function score() {
        var score = 0
        var lines = []
        for (var i = 15; i > 0; i--) {
            score = 0
            for (var j = 1; j < 11; j++) {
                if (repeater.itemAt(i*12+j).active === 2) {
                    score++
                }
            }
            if (score === 10)
                lines[lines.length] = i
        }
        console.log("Empty lines: " + lines)
        score += lines.length*10

        // Bonus

        if (lines.length > 1) {
            if (lines.length === 4)
                score += 1000
            else
                score += 100*lines.length
        }

        page.scoreValue += score
        page.speedValue += score

        // Increase speed

        if (page.speedValue >= 1000 && (page.speed + 100 + page.scoreValue/100) < 1000){
            page.speedValue = 0
            page.speed += 100 + page.scoreValue/100
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
