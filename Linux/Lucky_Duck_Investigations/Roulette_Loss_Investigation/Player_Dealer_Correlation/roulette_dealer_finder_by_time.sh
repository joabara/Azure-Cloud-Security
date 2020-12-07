grep -E $1.*$2 *$3* | awk "{print $5$6}"

