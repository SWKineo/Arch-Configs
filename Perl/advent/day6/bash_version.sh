for i in {1..8}; do cat input | cut -c$i | sort | uniq -c | sort | tail -n1 | awk '{print $2}' ; done | tr -d '\n'
