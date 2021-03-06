-module(mtree_server_sup).

-behaviour(supervisor).

%% API
-export([start_link/0, add_child/3]).

%% Supervisor callbacks
-export([init/1]).

-define(CHILD(I, Type), {I, {I, start_link, []}, temporary, 5000, Type, [I]}).

%%%===================================================================
%%% API functions
%%%===================================================================

add_child(Tree, Mod, Pid) ->
    supervisor:start_child(?MODULE, [Tree, Mod, Pid]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

init([]) ->
    {ok, { {simple_one_for_one, 5, 10}, [?CHILD(mtree_server, worker)]} }.

%%%===================================================================
%%% Internal functions
%%%===================================================================
