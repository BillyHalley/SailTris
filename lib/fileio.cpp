#include "../lib/fileio.h"
#include <QDir>
#include <QStringList>
#include <QStandardPaths>

//Constructor
FileIO::FileIO(QObject *parent) :
    QObject(parent)
{}



//Your custom function
void FileIO::write(const QString &filename, const QString &inputText) {
    QDir dir("/home/nemo/.local/share/harbour-sailtris");
    if (!dir.exists())
        dir.mkpath(".");
    QDir::setCurrent("/home/nemo/.local/share/harbour-sailtris");
    QFile file( filename );
    QTextStream(stdout) << "Write Path: " << QDir::currentPath() << endl;
    if ( file.open(QIODevice::ReadWrite) ) {
        QTextStream stream( &file );
        stream << inputText << endl;
    }
    return;
}

QString FileIO::read(const QString &filename) {
    QDir dir("/home/nemo/.local/share/harbour-sailtris");
    if (!dir.exists())
        dir.mkpath(".");
    QDir::setCurrent("/home/nemo/.local/share/harbour-sailtris");
    QString outputText;
    QFile file( filename );
    QTextStream(stdout) << "Read Path: " << QDir::currentPath() << endl;
    if ( file.exists()) {
        if ( file.open(QIODevice::ReadWrite) ) {
            QTextStream stream( &file );
            stream >> outputText;
        }
    }
    else {
        outputText = '0';
    }
    QTextStream(stdout) << filename << ": " << outputText << endl;
    return outputText;
}

void FileIO::save(const QString &slot, const QString &property, const QStringList &input) {
    QDir dir("/home/nemo/.local/share/harbour-sailtris/Slot"+slot);
    if (!dir.exists())
        dir.mkpath(".");
    QDir::setCurrent("/home/nemo/.local/share/harbour-sailtris/Slot"+slot);
    QTextStream(stdout) << "Save Path: " << QDir::currentPath() << endl;
    QFile file( property );
    if ( file.open(QIODevice::ReadWrite) ) {
        QTextStream stream( &file );
        for (int i = 0; i < input.length(); i++) {
            stream << input.at(i) << endl;
        }
    }
    return;
}

QStringList FileIO::load(const QString &slot, const QString &property) {
    QDir dir("/home/nemo/.local/share/harbour-sailtris/Slot"+slot);
    if (!dir.exists())
        dir.mkpath(".");
    QDir::setCurrent("/home/nemo/.local/share/harbour-sailtris/Slot"+slot);
    QTextStream(stdout) << "Load Path: " << QDir::currentPath() << endl;
    QFile file( property );
    QStringList loading;
    if ( file.open(QIODevice::ReadWrite) ) {
        QTextStream stream( &file );
        for ( int i = 0; i < 204; i++) {
            loading << stream.readLine();
        }
    }
    file.close();
    return loading;
}

void FileIO::save(const QString &slot, const QStringList &input) {
    QDir dir("/home/nemo/.local/share/harbour-sailtris/Slot"+slot);
    if (!dir.exists())
        dir.mkpath(".");
    QDir::setCurrent("/home/nemo/.local/share/harbour-sailtris/Slot"+slot);
    QTextStream(stdout) << "Save Path: " << QDir::currentPath() << endl;
    QFile file( "values" );
    if ( file.open(QIODevice::ReadWrite) ) {
        QTextStream stream( &file );
        for (int i = 0; i < input.length(); i++) {
            stream << input.at(i) << endl;
        }
    }
    return;
}

QStringList FileIO::load(const QString &slot) {
    QDir dir("/home/nemo/.local/share/harbour-sailtris/Slot"+slot);
    if (!dir.exists())
        dir.mkpath(".");
    QDir::setCurrent("/home/nemo/.local/share/harbour-sailtris/Slot"+slot);
    QTextStream(stdout) << "Load Path: " << QDir::currentPath() << endl;
    QFile file( "values" );
    QStringList loading;
    if ( file.open(QIODevice::ReadWrite) ) {
        QTextStream stream( &file );
        for ( int i = 0; i < 9; i++) {
            loading << stream.readLine();
        }
    }
    file.close();
    return loading;
}
