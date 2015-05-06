-module(video_page_handler).
-author("sushmap@ybrantinc.com").

-export([init/3]).

-export([content_types_provided/2]).
-export([welcome/2]).
-export([terminate/3]).

%% Init
init(_Transport, _Req, []) ->
	{upgrade, protocol, cowboy_rest}.

%% Callbacks
content_types_provided(Req, State) ->
	{[		
		{<<"text/html">>, welcome}	
	], Req, State}.

terminate(_Reason, _Req, _State) ->
	ok.

%% API
welcome(Req, State) ->
	{CategoryBinary, _} = cowboy_req:qs_val(<<"id">>, Req),
	Category = binary_to_list(CategoryBinary),
	
	% Url_all_news = sglobally_util:video_data(Category),
	Url_all_news = string:concat("http://api.contentapi.ws/v?id=",Category ),
	%io:format("url: ~p~n",[Url_all_news]), 
	{ok, "200", _, ResponseAllNews} = ibrowse:send_req(Url_all_news,[],get,[],[]),
	ResAllNews = string:sub_string(ResponseAllNews, 1, string:len(ResponseAllNews) -1 ),
	Params = jsx:decode(list_to_binary(ResAllNews)),	

	Url = "http://api.contentapi.ws/videos?channel=world_news&limit=1&skip=4&format=long",
	% io:format("movies url: ~p~n",[Url]),
	{ok, "200", _, Response_mlb} = ibrowse:send_req(Url,[],get,[],[]),
	ResponseParams_mlb = jsx:decode(list_to_binary(Response_mlb)),	
	[VideoParams] = proplists:get_value(<<"articles">>, ResponseParams_mlb),

	Popular_Videos_Url = "http://api.contentapi.ws/videos?channel=world_news&limit=6&skip=17&format=short",
	{ok, "200", _, Response_Popular_Videos} = ibrowse:send_req(Popular_Videos_Url,[],get,[],[]),
	ResponseParams_Popular_Videos = jsx:decode(list_to_binary(Response_Popular_Videos)),	
	PopularVideos = proplists:get_value(<<"articles">>, ResponseParams_Popular_Videos),

	More_Videos_Url = "http://api.contentapi.ws/videos?channel=world_news&limit=12&skip=53&format=short",
	{ok, "200", _, Response_More_Videos} = ibrowse:send_req(More_Videos_Url,[],get,[],[]),
	ResponseParams_More_Videos = jsx:decode(list_to_binary(Response_More_Videos)),	
	MoreVideos = proplists:get_value(<<"articles">>, ResponseParams_More_Videos),


	{ok, Body} = video_page_dtl:render([{<<"videoParam">>,VideoParams},{<<"allnews">>,Params},{<<"popularvideos">>,PopularVideos},{<<"morevideos">>,MoreVideos}]),
	% io:format("url: ~p~n", [allnews]), 
    {Body, Req, State}.
	


