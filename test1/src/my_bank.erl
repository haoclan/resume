%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 01. 八月 2016 17:43
%%%-------------------------------------------------------------------
-module(my_bank).
-author("Administrator").
-behavior(gen_server). %里面有很多东西 callback 等框架的语法

%-behavior(supervisor).


%% API
-compile(export_all).
%-export([init/1]).
-define(SERVER,?MODULE).   %宏定义使用 另一个宏定义来代替这个宏




%外部接口                       第一个参数是名为Name的通用服务器 第2个参数是指定回调的模块
start() -> gen_server:start_link({local,?SERVER},?MODULE,[],[]).

stop() ->gen_server:call(?MODULE,stop).  %我看这里不顺眼 {stop}
new_account(Who) -> gen_server:call(?MODULE, {new,Who} ).
deposit(Who,Amount)->gen_server:call(?MODULE, {add,Who,Amount} ).
withdraw(Who,Amount)->gen_server:call(?MODULE, {remove,Who,Amount} ).


% 6种接口的实现
init([])-> {ok,ets:new(?MODULE,[])}.  %ets 内置的

handle_call({new,Who},_From,Tab)->
  Reply = case ets:lookup(Tab,Who) of
            [] ->ets:insert(Tab,{Who,0}),
              {welcome,Who};
            [_] ->{Who,you_already_ate_a_customer}
          end,
  {reply,Reply,Tab};

handle_call({add,Who,Amount},_From,Tab)->
  Reply = case ets:lookup(Tab,Who) of
            [] ->{not_a_customer};
            [{Who,Balance}] ->
              NewBalance=Balance+Amount,
              ets:insert(Tab,{Who,NewBalance}),
              {thanks,Who,your_balance_is,NewBalance}
          end,
  {reply,Reply,Tab};

handle_call({remove,Who,Amount},_From,Tab) ->
  Reply = case ets:lookup(Tab,Who) of
            [] ->{not_a_customer};
            [{Who,Balance}] when Amount =< Balance ->
              NewBalance = Balance -Amount,
              ets:insert(Tab,{Who,NewBalance}),
              {thanks,Who,your_balance_is,NewBalance};
            [{Who,Balance}] ->
              {sorry,Who,your_only_have,Balance,in_the_bank}
          end,
  {reply,Reply,Tab};

handle_call(stop,_Form,Tab)->
  {stop,normal,stopped,Tab}.

%
handle_cast(_Msg,State) -> {noreply,State}.

%貌似是并不是经过 gen_server:call 或者 gen_server:cast的原因
handle_info(_Info,State) ->{noreply,State}.
terminate(_Reason,_State)-> ok.
code_change(_OldVsn,State,_Extra) -> {ok,State}.



%  ets的查询结果类型
% [{键，值}]