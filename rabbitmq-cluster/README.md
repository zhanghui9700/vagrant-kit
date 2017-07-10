### rabbitmq cluster

`apt-get install -y rabbitmq-server`

#### 1. cookie & hosts

    /var/lib/rabbitmq/.erlang.cookie

#### 2. cluster

    # master
    rabbitmqctl add_user nova nova && rabbitmqctl set_user_tags nova administrator

    # master
    rabbitmqctl stop_app
    rabbitmqctl reset
    rabbitmqctl start_app

    # slave
    rabbitmqctl stop_app
    rabbitmqctl reset
    rabbitmqctl join_cluster --ram rabbit@master
    rabbitmqctl start_app

#### 3. policy

     # master
     rabbitmqctl set_policy ha-nova "^nova" \ '{"ha-mode":"all", "ha-sync-mode":"automatic"}'
     rabbitmqctl list_policies

     # all nodes
     rabbitmqctl list_queues name consumers messages

