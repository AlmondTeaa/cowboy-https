%%%-------------------------------------------------------------------
%% @doc cowboy_https public API
%% @end
%%%-------------------------------------------------------------------

-module(cowboy_https_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    cowboy_https_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
