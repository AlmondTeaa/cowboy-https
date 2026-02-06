## Cowboy HTTPS Set Up Step - by - Step
1. Create the application template
    ```bash
    rebar3 new app cowboy_https
    ```
2. Create the SSL/TLS Certificates (steps are indicated in SSL Setup section).
3. Put the SSL/TLS in a priv folder (erlang has way to track priv folder in its application template).
4. In your rebar.config add cowboy dependency
```erlang
{erl_opts, [debug_info]}.
{deps, [
        {cowboy, "2.10.0"}
    ]}.

{shell, [
    %% {config, "config/sys.config"},
    {apps, [cowboy_https]}
]}.
```
5. In your app.src don't forget to include cowboy
```erlang
{application, cowboy_https, [
    {description, "An OTP application"},
    {vsn, "0.1.0"},
    {registered, []},
    {mod, {cowboy_https_app, []}},
    {applications, [
        kernel,
        stdlib,
        cowboy
    ]},
    {env, []},
    {modules, []},
    {licenses, ["Apache-2.0"]},
    {links, []}
 ]}.
```
6. Lastly, in your app.erl, include this in your ***start*** function
``` erlang
start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", handler_name, []}
		]}
	]),
	PrivDir = code:priv_dir(app_name),
	{ok, _} = cowboy:start_tls(https, [
		{port, 8443},
		{certfile, PrivDir ++ "/path/to/your/cert.pem"},
		{keyfile, PrivDir ++ "/path/to/your/key.pem"}
	], #{env => #{dispatch => Dispatch}}),
	cowboy_https_sup:start%start your supervisor
    %ssl_hello_world_sup:start
```
7. Go back to SSL_Setup to know how to make a Self-signed CA a valid CA for your PC.
