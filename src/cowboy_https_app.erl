-module(cowboy_https_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/", toppage_h, []}
        ]}
    ]),
    PrivDir = code:priv_dir(cowboy_https),
    % erlang:display(PrivDir),
    % CertFile = file:read_file(PrivDir ++ "/SSL_Certs/almondtea.crt"),
    % erlang:display(CertFile),
    {ok, _} = cowboy:start_tls(https, [
        {port, 8443},
        {certfile, PrivDir ++ "/SSL_Certs/almondtea.crt"},
        {keyfile,  PrivDir ++ "/SSL_Certs/myCowboy.key"}
    ], #{env => #{dispatch => Dispatch}}),
    cowboy_https_sup:start_link().

stop(_State) ->
    ok = cowboy:stop_listener(https).
