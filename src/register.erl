-module(register).

%cowboy_rest standard callbacks
-export([init/2]). 
-export([allowed_methods/2]).
-export([content_types_provided/2]). %Goes in here when method is GET
-export([content_types_accepted/2]). %when method is PUT, PATCH, etc.

%custom callbacks
-export([paste_html/2]). %when requesting HTML file using GET
-export([create_account/2]). %when sending x-www-form-urlencoded data using POST

init(Req, State)->
  {cowboy_rest, Req, State}.

allowed_methods(Req, State) ->
  {[<<"GET">>,<<"POST">>], Req, State}.

content_types_provided(Req, State) ->
  {[
    {{<<"text">>, <<"html">>, []}, paste_html},
    {{<<"text">>, <<"plain">>, []}, past_text}
  ], Req, State}.
  
content_types_accepted(Req, State)->
  {[
    {{<<"application">>, <<"x-www-form-urlencoded">>, []}, create_account}],
    Req, State  
  }.


%custom callbacks
create_account(Req, State) ->
  {ok,Body, Req1} = cowboy_req:read_urlencoded_body(Req),
  Meth = cowboy_req:method(Req),
  io:format("~p",[Meth]),
  io:format("method called containing the data~n~p~n", [Body]),
  {{true, <<$/, <<>>/binary>>}, Req1, State}.

paste_html(Req, State) ->
  Private_directory = code:priv_dir(cowboy_https),
  {ok, Binary} = file:read_file(Private_directory ++ "/register.html"),
  Meth = cowboy_req:method(Req),
  io:format("~p",[Meth]),
  io:format(" method for the register html file had been called~n"),
  {Binary, Req, State}.