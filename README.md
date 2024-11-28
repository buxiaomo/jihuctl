# jihuctl

This project will used ansible to deployment gitlab-jh ha.

Read the documentation to see how the project is used


## how to use

### Install dependent software

```
make runtime
```

### download package to local

```
make download
```

### copy package to roles directory

```
make prepare
```

### configuring software architecture

```
make hosts
```

* `apt-get install -y expect`


### 常用命令
```
# 查看 consul 状态
/opt/gitlab/embedded/bin/consul members

# 查看 redis 状态
/opt/gitlab/embedded/bin/redis-cli -h 127.0.0.1 -a 'gIBSEHgRjQ6wr6MM' info replication

# 查看 sentinel 状态
/opt/gitlab/embedded/bin/redis-cli -h 127.0.0.1 -p 26379 sentinel masters

# 查看 postgresql 状态
gitlab-ctl patroni members

# 查看 pgbouncer 状态
```