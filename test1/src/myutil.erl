%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 七月 2016 14:17
%%%-------------------------------------------------------------------
-module(myutil).
-author("Administrator").

-export([qsort/1,perms/1,reversebit/1]).


%%%% 统计一个 字符串（[]） 返回一个映射组
%%count_characts(Str)->
%%  count_characts(Str,#{}).  %统一为第2个参数只是映射组了。9
%%%判断下 键 有没有的问题   牛B直接在参数这里完成了。。
%%count_characts([H|T],#{H := Value} = X)->   %这一步最厉害
%%  count_characts(T, X#{H := Value+1});
%%count_characts([H|T],X)->              %配合这一步
%%  count_characts(T,X#{H => 1});
%%count_characts([],X)->
%%  X.


%整数的for  1,10，fun 要是我就再来一个需要保存list的参数了。。。
%结果书上没有这么做

for(End,End,F) ->
  [F(End)];
for(Start,End,F) ->  %也就是这里传入的东西是待定的。可以直接传入函数变量
  [F(Start)|for(Start+1,End,F)].



%对于 list的快排
qsort([]) -> [];
qsort([Pivot|T])->
  qsort([X||X <- T,X < Pivot ])++[Pivot]++qsort([X|| X <- T,X >= Pivot ]).



%递归实现全排列
perms([]) ->
  [[]];                                           %这里错了。因为[X|T] T永远是一个[]因此 T <- TT ，TT需要时一个[[]]
perms(List) ->
  [[X|T] || X <- List,T <- perms(List--[X]) ].  %错在List-X 写法


%翻转位 先用list翻转，然后再导成 <<>>
%变成list 自能手动边
reversebit(Bits)->
  List = [ X || <<X:1>> <= Bits ],
  List2 = lists:reverse(List),
% 方法
  << <<XX:1>> ||  XX <- List2 >>. %% 从list变为binary 且数字符合要求我直接

%  list_to_binary(List2). %%这个是不对的！！！

%% API
