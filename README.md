# Restore Steps:

# Login steps using Azure CLI:

1. az aks get-credentials --resource-group myapp-dl --name myapp-cass-aks --overwrite-existing
2. kubectl get pod
3. kubectl cp /home/dspg/myapp-test-data/ myapp-backend-cassandra-6bffcb6c4-2fkc2:/home/
4. kubectl exec -it myapp-backend-cassandra-6bffcb6c4-2fkc2 -- /bin/bash
5. cd /home/
6. tar -xvf backup.tar.gz
7. cd /home/myapp-test-data/var/lib/cassandra/data/myapp

# To verify snapshots for single table one by one:

1. ls -d /home/myapp-test-data/var/lib/cassandra/data/myapp/*/snapshots/mybackup1

# Restore keyspace and blank table structure:

1. cqlsh -e "SOURCE 'myapp.cql'";

# Copy files into original location:

1. cp /home/myapp-test-data/var/lib/cassandra/data/myapp/def-6815d9401a7c11e9ab97ef8d12218189/snapshots/mybackup1/* /var/lib/cassandra/data/myapp/def-a6bab2c0461d11e9985cf9f82ea3ea1e/
2. cp /home/myapp-test-data/var/lib/cassandra/data/myapp/ghi-75152e201a7c11e9ab97ef8d12218189/snapshots/mybackup1/* /var/lib/cassandra/data/myapp/ghi-ac7b2be0461d11e9985cf9f82ea3ea1e/
3. cp /home/myapp-test-data/var/lib/cassandra/data/myapp/emp-3a74a2a01a7c11e9ab97ef8d12218189/snapshots/mybackup1/* /var/lib/cassandra/data/myapp/emp-ba38c7b0461d11e9985cf9f82ea3ea1e/


# Import using sstableloader utility

1. nodetool status

## Replace ip in below command

1. sstableloader --nodes 10.244.2.3 --verbose /var/lib/cassandra/data/myapp/abc-c37c9b30461d11e9985cf9f82ea3ea1e/
2. sstableloader --nodes 10.244.2.3 --verbose /var/lib/cassandra/data/myapp/def-a6bab2c0461d11e9985cf9f82ea3ea1e/
3. sstableloader --nodes 10.244.2.3 --verbose /var/lib/cassandra/data/myapp/ghi-ac7b2be0461d11e9985cf9f82ea3ea1e/
4. sstableloader --nodes 10.244.2.3 --verbose /var/lib/cassandra/data/myapp/emp-ba38c7b0461d11e9985cf9f82ea3ea1e/


# Verify count of all tables:

1. select count(*) from abc;
2. select count(*) from def;
3. select count(*) from ghi;
4. select count(*) from emp;


