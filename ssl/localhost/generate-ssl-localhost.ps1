<#
    .SYNOPSIS
    Creates self signed certificates for localhost using openssl.
    Can be used for TLS/HTTPS connection with docker daemon.

    .DESCRIPTION
    This script creates a self signed CA and corresponding x509 client and server certificates to use for
    localhost. The server certificate is configured with DNS and IP alt names to support
    DNS.1 = localhost
    IP.1 = 127.0.0.1
    IP.2 = ::1
    IP.3 = 0:0:0:0:0:0:0:1

    .PARAMETER outputPath
    Specify the path to the directory that this script should use to store the generated openssl files,
    certificates and keys into.

    .PARAMETER caValidityDays
    The number of days the CA certificate should be valid.

    .PARAMETER clientValidityDays
    The number of days the client certificate should be valid.

    .PARAMETER
    The number of days the server certificate should be valid.
#>
param(
    [Alias("out")]
    [Parameter(Mandatory = $true)]
    [string]$outputPath,

    [Alias("cav")]
    [Int32]$caValidityDays = 3650,

    [Alias("clv")]
    [Int32]$clientValidityDays = 3650,

    [Alias("srv")]
    [Int32]$serverValidityDays = 3650
)

# obtain the path to the configuration files for openssl
$configPath = $PSScriptRoot

# generate a new key for the CA
openssl genrsa -out $outputPath\ca-key.pem 4096
# use the CA key to create self signed root certificate
openssl req -x509 -new -nodes -key $outputPath\ca-key.pem -days $caValidityDays -out $outputPath\ca.pem -subj "/CN=ca-localhost"

# generate a new key for the client
openssl genrsa -out $outputPath\client-key.pem 4096
# generate a certificate signing request for the client using the clients key
openssl req -new -key $outputPath\client-key.pem -out $outputPath\client-cert.csr -subj "/CN=client-localhost" -config $configPath\openssl-client.cnf
# use the CA to create the certificate for the client based on the certificate signing request
openssl x509 -req -in $outputPath\client-cert.csr -CA $outputPath\ca.pem -CAkey $outputPath\ca-key.pem -CAcreateserial -out $outputPath\client-cert.pem -days 3650 -extensions v3_req -extfile $configPath\openssl-client.cnf

# generate a new key for the server
openssl genrsa -out $outputPath\server-key.pem 4096
# generate a certificate signing request for the server using the servers key
openssl req -new -key $outputPath\server-key.pem -out $outputPath\server-cert.csr -subj "/CN=server-localhost" -config $configPath\openssl-server.cnf
# use the CA to create the certificate for the server based on the certificate signing request
openssl x509 -req -in $outputPath\server-cert.csr -CA $outputPath\ca.pem -CAkey $outputPath\ca-key.pem -CAcreateserial -out $outputPath\server-cert.pem -days 3650 -extensions v3_req -extfile $configPath\openssl-server.cnf

# generate a certificate signing request for the registry using the servers key
openssl req -new -key $outputPath\server-key.pem -out $outputPath\registry-cert.csr -subj "/CN=server-localhost" -config $configPath\openssl-registry.cnf
# use the CA to create the certificate for the registry based on the certificate signing request
openssl x509 -req -in $outputPath\registry-cert.csr -CA $outputPath\ca.pem -CAkey $outputPath\ca-key.pem -CAcreateserial -out $outputPath\registry-cert.pem -days 3650 -extensions v3_req -extfile $configPath\openssl-registry.cnf

Write-Host "Created self signed CA certificate, server certificate and client certificate for localhost in $outputPath directory."