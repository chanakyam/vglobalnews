-module(vglobalnews_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
        {'_',[
                {"/", home_page_handler, []},
                {"/video", video_page_handler, []},
                {"/more_videos", more_videos_handler, []},
                {"/terms", tnc_page_handler, []},
                {"/privacy", privacy_page_handler, []},

                %%
                %% Release Routes
                %%
                {"/css/[...]", cowboy_static, {priv_dir, vglobalnews, "static/css"}},
                {"/images/[...]", cowboy_static, {priv_dir, vglobalnews, "static/images"}},
                {"/js/[...]", cowboy_static, {priv_dir, vglobalnews, "static/js"}},
                {"/fonts/[...]", cowboy_static, {priv_dir, vglobalnews, "static/fonts"}}
                % %%
                %% Dev Routes
                %%
                % {"/css/[...]", cowboy_static, {dir, "priv/static/css"}},
                % {"/images/[...]", cowboy_static, {dir, "priv/static/images"}},
                % {"/js/[...]", cowboy_static, {dir,"priv/static/js"}},
                % {"/fonts/[...]", cowboy_static, {dir, "priv/static/fonts"}}
        ]}      
    ]), 
   

    {ok, _} = cowboy:start_http(http,100, [{port, 11001}],[{env, [{dispatch, Dispatch}]}
              ]),
    vglobalnews_sup:start_link().

stop(_State) ->
    ok.
