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
    rpm/harbour-sailtris.spec \
    rpm/harbour-sailtris.yaml \
    harbour-sailtris.desktop \
    qml/Dot.qml \
    qml/Functions.qml \
    qml/pages/FirstPage.qml \
    qml/pages/Settings.qml \
    qml/pages/About.qml \
    qml/pages/Donation.png \
    qml/cover/CoverPage.qml \
    i18n/translation_it_IT.ts \
    rpm/harbour-sailtris.changes

# to disable building translations every time, comment out the
# following CONFIG line
#CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
#TRANSLATIONS += translations/harbour-sailtris-de.ts

i18n.path = /usr/share/harbour-sailtris/i18n
i18n.files = i18n/*.qm

INSTALLS += i18n
HEADERS += \
    lib/fileio.h

