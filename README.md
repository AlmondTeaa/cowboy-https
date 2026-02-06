# CowboyHTTPSWebserver

A minimal HTTPS web server built with [Cowboy](https://ninenines.eu/docs/en/cowboy/), a small, fast, and modern HTTP server for Erlang/OTP.

## 🧩 Notes
- This project demonstrates manual TLS setup, including creating a custom Certificate Authority (CA) and self-signed certificates.  
- Using [Certbot (Let’s Encrypt)](https://certbot.eff.org/) is also an option, but it typically requires a registered domain.  
- For local testing, the TLS handshake will be bypassed by mapping hostnames via `/etc/hosts`.

## ⚙️ Prerequisites
- **Erlang/OTP 28** or newer  
- **rebar3** (for building and running Erlang projects)
