## SSL Set Up Step - by - Step
### Certifcate Authority
1. Generate a private key
> openssl genrsa -out CA.key
2. Generate the Root Certificate of the CA (Certificate Authority)
> openssl req -x509 -new -nodes -key CA.key -sha256 -days 1825 -out CACert.pem

### TLS Certificate
1. Generate the private key
> openssl genrsa -out myCowboy.key 2048
2. Generate your CSR (Certificate Request)
> openssl req -new -key myCowboy.key -out request.csr
3. (This step is optional). Create a config file, config.ext. The following step will be used to attach a domain name into your certificate,
4. It contains the following text:
```
    subjectAltName = @alt_names
    [alt_names]
    DNS.1 = almontecowboy.com
```
5. Now, we sign the csr with the configuration stated in our .ext file
>openssl x509 -req -in request.csr -CA CACert.pem -CAkey CA.key \
-CAcreateserial -out almondtea.crt -days 825 -sha256 -extfile config.ext


### Checking
- Check SSL/TLS Certificate
> openssl x509 -in certname.crt -noout -text
