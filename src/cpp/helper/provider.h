#pragma once
#include <memory>

class ConnectorSocket;
class ConnectorSerialPort;
class NetworkManager;
class BiorecJson;

/**
 * @brief The Provider class
 */
class Provider final
{
public:
    ~Provider();
    static ConnectorSocket &GetSocketAsSingleton();

private:
    static std::unique_ptr<ConnectorSocket>     m_instanceConnectorSocket;
    static std::unique_ptr<ConnectorSerialPort> m_instanceConnectorSerialPort;
    static std::unique_ptr<NetworkManager>      m_instanceNetworkManger;
    static std::unique_ptr<BiorecJson>          m_instanceBiorecJson;

    explicit Provider(const Provider &rhs) = delete;
    Provider &operator= (const Provider &rhs) = delete;
};

