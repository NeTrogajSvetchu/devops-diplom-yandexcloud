Машинки создаються удачно 
[master.tf](terraform/kub/master.tf)
[worker.tf](terraform/kub/worker.tf)

в kubespray передается инвентори 

[ansible.tf](terraform/kub/ansible.tf)
[hosts.tftpl](terraform/kub/hosts.tftpl)

при применение плейбука 
```
ansible-playbook -i inventory/mycluster/hosts.yaml -u ubuntu --become --become-user=root --private-key=~/.ssh/id_ed25519 -e 'ansible_ssh_common_args="-o StrictHostKeyChecking=no"' cluster.yml --flush-cache
```
 вылезает ошибка 

```
TASK [etcd : Configure | Ensure etcd is running] **************************************************************************************************************************************************************
changed: [master]
Monday 03 February 2025  16:54:26 +0300 (0:00:00.726)       0:07:18.928 ******* 
Monday 03 February 2025  16:54:26 +0300 (0:00:00.026)       0:07:18.955 ******* 
FAILED - RETRYING: Configure | Wait for etcd cluster to be healthy (4 retries left).
FAILED - RETRYING: Configure | Wait for etcd cluster to be healthy (3 retries left).
FAILED - RETRYING: Configure | Wait for etcd cluster to be healthy (2 retries left).
FAILED - RETRYING: Configure | Wait for etcd cluster to be healthy (1 retries left).

TASK [etcd : Configure | Wait for etcd cluster to be healthy] *************************************************************************************************************************************************
fatal: [master]: FAILED! => {"attempts": 4, "changed": false, "cmd": "set -o pipefail && /usr/local/bin/etcdctl endpoint --cluster status && /usr/local/bin/etcdctl endpoint --cluster health 2>&1 | grep -v 'Error: unhealthy cluster' >/dev/null", "delta": "0:00:05.020352", "end": "2025-02-03 13:55:16.814091", "msg": "non-zero return code", "rc": 1, "start": "2025-02-03 13:55:11.793739", "stderr": "{\"level\":\"warn\",\"ts\":\"2025-02-03T13:55:16.812Z\",\"caller\":\"clientv3/retry_interceptor.go:62\",\"msg\":\"retrying of unary invoker failed\",\"target\":\"endpoint://client-a9608fd5-ca0d-4743-9196-01875cc3f828/10.0.1.15:2379\",\"attempt\":0,\"error\":\"rpc error: code = DeadlineExceeded desc = latest balancer error: all SubConns are in TransientFailure, latest connection error: connection error: desc = \\\"transport: Error while dialing dial tcp 10.0.1.15:2379: connect: connection refused\\\"\"}\nError: failed to fetch endpoints from etcd cluster member list: context deadline exceeded", "stderr_lines": ["{\"level\":\"warn\",\"ts\":\"2025-02-03T13:55:16.812Z\",\"caller\":\"clientv3/retry_interceptor.go:62\",\"msg\":\"retrying of unary invoker failed\",\"target\":\"endpoint://client-a9608fd5-ca0d-4743-9196-01875cc3f828/10.0.1.15:2379\",\"attempt\":0,\"error\":\"rpc error: code = DeadlineExceeded desc = latest balancer error: all SubConns are in TransientFailure, latest connection error: connection error: desc = \\\"transport: Error while dialing dial tcp 10.0.1.15:2379: connect: connection refused\\\"\"}", "Error: failed to fetch endpoints from etcd cluster member list: context deadline exceeded"], "stdout": "", "stdout_lines": []}

NO MORE HOSTS LEFT ********************************************************************************************************************************************************************************************
```

рестартиться контейнер etcd1 с данными логами

```
2025-02-03 13:56:54.190321 I | pkg/flags: recognized and used environment variable ETCD_ADVERTISE_CLIENT_URLS=https://89.169.135.18:2379
2025-02-03 13:56:54.190399 I | pkg/flags: recognized and used environment variable ETCD_AUTO_COMPACTION_RETENTION=8
2025-02-03 13:56:54.190410 I | pkg/flags: recognized and used environment variable ETCD_CERT_FILE=/etc/ssl/etcd/ssl/member-master.pem
2025-02-03 13:56:54.190418 I | pkg/flags: recognized and used environment variable ETCD_CLIENT_CERT_AUTH=true
2025-02-03 13:56:54.190428 I | pkg/flags: recognized and used environment variable ETCD_DATA_DIR=/var/lib/etcd
2025-02-03 13:56:54.190438 I | pkg/flags: recognized and used environment variable ETCD_ELECTION_TIMEOUT=5000
2025-02-03 13:56:54.190445 I | pkg/flags: recognized and used environment variable ETCD_ENABLE_V2=true
2025-02-03 13:56:54.190467 I | pkg/flags: recognized and used environment variable ETCD_HEARTBEAT_INTERVAL=250
2025-02-03 13:56:54.190546 I | pkg/flags: recognized and used environment variable ETCD_INITIAL_ADVERTISE_PEER_URLS=https://89.169.135.18:2380
2025-02-03 13:56:54.190555 I | pkg/flags: recognized and used environment variable ETCD_INITIAL_CLUSTER=etcd1=https://10.0.1.15:2380
2025-02-03 13:56:54.190561 I | pkg/flags: recognized and used environment variable ETCD_INITIAL_CLUSTER_STATE=new
2025-02-03 13:56:54.190566 I | pkg/flags: recognized and used environment variable ETCD_INITIAL_CLUSTER_TOKEN=k8s_etcd
2025-02-03 13:56:54.190573 I | pkg/flags: recognized and used environment variable ETCD_KEY_FILE=/etc/ssl/etcd/ssl/member-master-key.pem
2025-02-03 13:56:54.190588 I | pkg/flags: recognized and used environment variable ETCD_LISTEN_CLIENT_URLS=https://10.0.1.15:2379,https://127.0.0.1:2379
2025-02-03 13:56:54.190597 I | pkg/flags: recognized and used environment variable ETCD_LISTEN_PEER_URLS=https://10.0.1.15:2380
2025-02-03 13:56:54.190617 I | pkg/flags: recognized and used environment variable ETCD_METRICS=basic
2025-02-03 13:56:54.190623 I | pkg/flags: recognized and used environment variable ETCD_NAME=etcd1
2025-02-03 13:56:54.190631 I | pkg/flags: recognized and used environment variable ETCD_PEER_CERT_FILE=/etc/ssl/etcd/ssl/member-master.pem
2025-02-03 13:56:54.190637 I | pkg/flags: recognized and used environment variable ETCD_PEER_CLIENT_CERT_AUTH=True
2025-02-03 13:56:54.190645 I | pkg/flags: recognized and used environment variable ETCD_PEER_KEY_FILE=/etc/ssl/etcd/ssl/member-master-key.pem
2025-02-03 13:56:54.190651 I | pkg/flags: recognized and used environment variable ETCD_PEER_TRUSTED_CA_FILE=/etc/ssl/etcd/ssl/ca.pem
2025-02-03 13:56:54.190657 I | pkg/flags: recognized and used environment variable ETCD_PROXY=off
2025-02-03 13:56:54.190669 I | pkg/flags: recognized and used environment variable ETCD_SNAPSHOT_COUNT=10000
2025-02-03 13:56:54.190677 I | pkg/flags: recognized and used environment variable ETCD_TRUSTED_CA_FILE=/etc/ssl/etcd/ssl/ca.pem
[WARNING] Deprecated '--logger=capnslog' flag is set; use '--logger=zap' flag instead
2025-02-03 13:56:54.190731 I | etcdmain: etcd Version: 3.4.13
2025-02-03 13:56:54.190735 I | etcdmain: Git SHA: ae9734ed2
2025-02-03 13:56:54.190740 I | etcdmain: Go Version: go1.12.17
2025-02-03 13:56:54.190744 I | etcdmain: Go OS/Arch: linux/amd64
2025-02-03 13:56:54.190749 I | etcdmain: setting maximum number of CPUs to 2, total number of available CPUs is 2
2025-02-03 13:56:54.190867 N | etcdmain: the server is already initialized as member before, starting as etcd member...
[WARNING] Deprecated '--logger=capnslog' flag is set; use '--logger=zap' flag instead
2025-02-03 13:56:54.190919 I | embed: peerTLS: cert = /etc/ssl/etcd/ssl/member-master.pem, key = /etc/ssl/etcd/ssl/member-master-key.pem, trusted-ca = /etc/ssl/etcd/ssl/ca.pem, client-cert-auth = true, crl-file = 
2025-02-03 13:56:54.192260 I | embed: name = etcd1
2025-02-03 13:56:54.192273 I | embed: data dir = /var/lib/etcd
2025-02-03 13:56:54.192280 I | embed: member dir = /var/lib/etcd/member
2025-02-03 13:56:54.192285 I | embed: heartbeat = 250ms
2025-02-03 13:56:54.192290 I | embed: election = 5000ms
2025-02-03 13:56:54.192295 I | embed: snapshot count = 10000
2025-02-03 13:56:54.192308 I | embed: advertise client URLs = https://89.169.135.18:2379
2025-02-03 13:56:54.192362 W | pkg/fileutil: check file permission: directory "/var/lib/etcd" exist, but the permission is "drwxr-xr-x". The recommended permission is "-rwx------" to prevent possible unprivileged access to the data.
2025-02-03 13:56:54.212481 C | etcdmain: --initial-cluster has etcd1=https://10.0.1.15:2380 but missing from --initial-advertise-peer-urls=https://89.169.135.18:2380 ("https://89.169.135.18:2380"(resolved from "https://89.169.135.18:2380") != "https://10.0.1.15:2380"(resolved from "https://10.0.1.15:2380"))
```