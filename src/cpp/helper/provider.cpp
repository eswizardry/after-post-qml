#include "provider.h"
#include "utils.h"
#include <QString>


std::unique_ptr<ConnectorSocket>        Provider::m_instanceConnectorSocket = nullptr;
std::unique_ptr<ConnectorSerialPort>    Provider::m_instanceConnectorSerialPort = nullptr;
std::unique_ptr<NetworkManager>         Provider::m_instanceNetworkManger = nullptr;
std::unique_ptr<BiorecJson>             Provider::m_instanceBiorecJson = nullptr;

static QString JSON_FILE_NAME = QStringLiteral("bioreactor.json");

ConnectorSocket &Provider::GetSocketAsSingleton()
{
    if (m_instanceConnectorSocket == nullptr) {
        m_instanceConnectorSocket =  std::make_unique<ConnectorSocket> (nullptr);
    }
    return *m_instanceConnectorSocket;
}
