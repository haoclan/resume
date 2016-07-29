%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 七月 2016 12:14
%%%-------------------------------------------------------------------
-author("Administrator").

-record(todo,{status = reminder, who = joe, text}). %%没有定义的东西，默认就是原子undefined

