%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. 七月 2016 12:13
%%%-------------------------------------------------------------------
-module(afile_server).
-author("Administrator").
%% API
-export([start/1,loop/1]). %%这样调用也会出问题？？

start(Dir)->spawn(afile_server,loop,[Dir]).

loop(Dir)->
  receive
    {Client,list_dir}->
      Client!{self(),file:list_dir(Dir) };
    {Client,{get_file,File}}->
      Full=filename:join(Dir,File),
      Client!{self(),file:read_file(Full)}
  end,


  loop(Dir).







