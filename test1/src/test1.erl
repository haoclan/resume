%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 七月 2016 17:32
%%%-------------------------------------------------------------------
-module(test1).
-author("Administrator").
-export([start/0]).

myadd(X,Tempsum) ->
  X + Tempsum.


start() ->
  lists:foldl(fun myadd/2,0,[1,2,3,4,5]).


%% API

