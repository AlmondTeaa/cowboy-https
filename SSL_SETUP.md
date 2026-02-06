## SSL Set Up Step - by - Step
### Certifcate Authority
1. Generate a private key
    ```bash
    openssl genrsa -out CA.key
    ```
2. Generate the Root Certificate of the CA (Certificate Authority)
    ```bash
    openssl req -x509 -new -nodes -key CA.key -sha256 -days 1825 -out CACert.pem
    ```
### TLS Certificate
1. Generate the private key
    ```bash
    openssl genrsa -out myCowboy.key 2048
    ```
2. Generate your CSR (Certificate Request)
    ```bash
    openssl req -new -key myCowboy.key -out request.csr
    ```
3. (This step is optional). Create a config file, config.ext. The following step will be used to attach a domain name into your certificate,
4. It contains the following text:  
    ```
    subjectAltName = @alt_names
    [alt_names]
    DNS.1 = jracowboy.com
    ```
5. Now, we sign the csr with the configuration stated in our .ext file
    ```bash
    openssl x509 -req -in request.csr -CA CACert.pem -CAkey CA.key -CAcreateserial -out almondtea.crt -days 825 -sha256 -extfile config.ext
    ```

### Checking
- Check SSL/TLS Certificate
    ```
    openssl x509 -in certname.crt -noout -text
    ```

## Making your CA a valid Certificate Authority (Mac OS)
[Reference: Delicious Brain](https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/)
### Via the CLI
```bash
sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" myCA.pem
```
### Via the macOS Keychain App
1. Open the macOS Keychain app
2. If required, make sure you’ve selected the System Keychain (older macOS versions default to this keychain)
3. Go to File > Import Items…
4. Select your private key file (i.e. myCA.pem)
5. Search for whatever you answered as the “Common Name” name above
6. Double-click on your root certificate in the list
7. Expand the Trust section
8. Change the “When using this certificate:” select box to Always Trust
9. Close the certificate window
10. During the process it may ask you to enter your password (or scan your finger), do that