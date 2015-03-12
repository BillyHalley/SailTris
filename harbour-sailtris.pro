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
TARGET = harbour-sailtris

CONFIG += sailfishapp

SOURCES += src/harbour-sailtris.cpp \
    lib/fileio.cpp

OTHER_FILES += qml/harbour-sailtris.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-sailtris.spec \
    rpm/harbour-sailtris.yaml \
    translations/*.ts \
    harbour-sailtris.desktop \
    qml/pages/Settings.qml \
    qml/pages/About.qml \
    qml/Functions.qml \
    qml/Dot.qml \
    rpm/harbour-sailtris.changes

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-sailtris-es.ts \
    translations/harbour-sailtris-fi.ts \
    translations/harbour-sailtris-fr.ts \
    translations/harbour-sailtris-it_IT.ts \
    translations/harbour-sailtris-nl_NL.ts \
    translations/harbour-sailtris-ru.ts


HEADERS += \
    lib/fileio.h

