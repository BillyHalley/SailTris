# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = SailTris

CONFIG += sailfishapp

SOURCES += src/SailTris.cpp

OTHER_FILES += qml/SailTris.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/DebugSettings.qml \
    qml/Dot.qml \
    qml/Functions.qml \
    rpm/SailTris.spec \
    rpm/SailTris.yaml \
    rpm/SailTris.changes \
    translations/*.ts \
    SailTris.desktop \
    qml/pages/About.qml \
    qml/pages/pics/donation.gif



# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/SailTris-it_IT.ts

HEADERS +=

