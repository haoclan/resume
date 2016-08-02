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
-compile(export_all).

start2()->
    ?MODULE.

start() ->
  spawn(fun loop/0).




loop() ->
  receive
    after 5000->
    io:format("hello ~n")
  end.



  %lists:foldl(fun myadd/2,0,[1,2,3,4,5]).

myadd(X,Tempsum) ->
  X + Tempsum.

%% API

