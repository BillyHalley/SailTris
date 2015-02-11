/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: page
    property int timerValue
    property bool gridEnabled
    property int gridOpacity
    Column {
        id: column

        width: page.width
        spacing: Theme.paddingLarge

        DialogHeader {
            title: qsTr("Debug Settings")
        }
        // Time Slider
        Slider {
            id: timerSlider
            width: parent.width
            minimumValue: 100
            maximumValue: 2000
            value: 1000
            stepSize: 100
            valueText: value/1000 + qsTr(" Seconds")
            label: qsTr("Timer Interval")
        }


        // Grid Value Debug

        TextSwitch {
            id: gridSwitch
            text: qsTr("Enables Debug Mode")
            description: qsTr("Shows grid numbers, speed values and MouseArea in green.")
            onCheckedChanged: gridEnabled = !gridEnabled

        }
    }
    onDone: {
        if (result === DialogResult.Accepted) {
            timerValue = timerSlider.value
            if (gridEnabled === true) {
                gridOpacity = 1
                console.log("opacity set")
            }
            else
                gridOpacity = 0
        }
    }
}





