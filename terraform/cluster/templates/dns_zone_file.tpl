
$ORIGIN ${domain}.
$TTL 120

@   IN  SOA ns1.${domain}. admin.${domain}. (
        2025111801
        3600
        1800
        604800
        120
    )

@   IN  NS  ns1.${domain}.

ns1 IN A ${dns_ip}

%{ for ip in worker_ips }
*   IN A ${ip}
%{ endfor }
