#!/bin/bash

TABLE_LIST=`nodetool cfstats myapp | grep "Table: " | sed -e 's+^.*: ++'`
for TABLE in $TABLE_LIST; do
    echo "Restore table ${TABLE}"
    cd /var/lib/cassandra/data/myapp/${TABLE}*
    if [ -d "snapshots/snapshot1" ]; then
		cqlsh -e 'truncate table ${TABLE};
        sudo cp snapshots/snapshot1/* .
        nodetool refresh -- myapp ${TABLE}
        echo "    Table ${TABLE} restored."
    else
        echo "    >>> Nothing to restore."
    fi
done