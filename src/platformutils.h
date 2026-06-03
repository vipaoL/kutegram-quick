#ifndef PLATFORMUTILS_H
#define PLATFORMUTILS_H

#include <QObject>
#include <QColor>
#if !defined(Q_OS_SYMBIAN) && !defined(Q_OS_WINPHONE)
#include <QSystemTrayIcon>
#include <QMenu>
#endif
#include <QUrl>
#include <QHash>
#include <QWidget>

#ifdef SYMBIAN3_READY
#include "QPiglerAPI.h"
#endif

class PlatformUtils : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool notificationsEnabled READ notificationsEnabled WRITE setNotificationsEnabled NOTIFY notificationsEnabledChanged)
    Q_PROPERTY(bool proxyEnabled READ proxyEnabled WRITE setProxyEnabled NOTIFY proxySettingsChanged)
    Q_PROPERTY(QString proxyType READ proxyType WRITE setProxyType NOTIFY proxySettingsChanged)
    Q_PROPERTY(QString proxyHost READ proxyHost WRITE setProxyHost NOTIFY proxySettingsChanged)
    Q_PROPERTY(int proxyPort READ proxyPort WRITE setProxyPort NOTIFY proxySettingsChanged)
    Q_PROPERTY(QString proxyUser READ proxyUser WRITE setProxyUser NOTIFY proxySettingsChanged)
    Q_PROPERTY(QString proxyPassword READ proxyPassword WRITE setProxyPassword NOTIFY proxySettingsChanged)
private:
    QWidget* window;
#if !defined(Q_OS_SYMBIAN) && !defined(Q_OS_WINPHONE)
    QSystemTrayIcon trayIcon;
    QMenu trayMenu;
#endif
    QHash<qint64, QVariantMap> unread;
#ifdef SYMBIAN3_READY
    QPiglerAPI pigler;
    qint32 piglerId;
#endif
    bool m_notificationsEnabled;
    bool m_proxyEnabled;
    QString m_proxyType;
    QString m_proxyHost;
    int m_proxyPort;
    QString m_proxyUser;
    QString m_proxyPassword;

public:
    explicit PlatformUtils(QObject *parent = 0);
    bool notificationsEnabled() const;
    void setNotificationsEnabled(bool enabled);

    bool proxyEnabled() const { return m_proxyEnabled; }
    QString proxyType() const { return m_proxyType; }
    QString proxyHost() const { return m_proxyHost; }
    int proxyPort() const { return m_proxyPort; }
    QString proxyUser() const { return m_proxyUser; }
    QString proxyPassword() const { return m_proxyPassword; }

    void setProxyEnabled(bool enabled);
    void setProxyType(const QString &type);
    void setProxyHost(const QString &host);
    void setProxyPort(int port);
    void setProxyUser(const QString &user);
    void setProxyPassword(const QString &password);

signals:
    void notificationsEnabledChanged();
    void proxySettingsChanged();

public slots:
    void showAndRaise();
    void quit();

#if !defined(Q_OS_SYMBIAN) && !defined(Q_OS_WINPHONE)
    void trayActivated(QSystemTrayIcon::ActivationReason reason);
    void messageClicked();
    void menuTriggered(QAction* action);
#endif

#ifdef SYMBIAN3_READY
    void piglerHandleTap(qint32 notificationId);
#endif

    void windowsExtendFrameIntoClientArea(int left, int top, int right, int bottom);
    bool windowsIsCompositionEnabled();
    QColor windowsRealColorizationColor();
    bool isWindows();

    void gotNewMessage(qint64 peerId, QString peerName, QString senderName, QString text, bool silent);
};

void openUrl(QUrl url);

#endif // PLATFORMUTILS_H
