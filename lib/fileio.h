#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QFile>
#include <QTextStream>

class FileIO : public QObject
{
    Q_OBJECT

public:
    explicit FileIO(QObject *parent = 0);

    Q_INVOKABLE void write(const QString &filename, const QString &inputText);
    Q_INVOKABLE QString read(const QString &filename);
    Q_INVOKABLE void save(const QString &slot, const QString &property, const QStringList &input);
    Q_INVOKABLE void save(const QString &slot, const QStringList &input);
    Q_INVOKABLE QStringList load(const QString &slot, const QString &property);
    Q_INVOKABLE QStringList load(const QString &slot);

};

#endif // FILEIO_H
