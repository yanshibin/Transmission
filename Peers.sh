while true; do

# 获取Transmission的Session ID，不然后续请求无效
TSID=`curl -sI 'http://localhost:3000/transmission/rpc' |grep -Fi "X-Transmission-Session-Id" | tr -d '\r'`
echo $TSID

# 获取当前任务的ID列表，通过jq工具解析Json
TDATA=`curl -s 'http://localhost:3000/transmission/rpc' -H 'Origin: http://localhost:3000' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: zh-CN,zh;q=0.9' -H "$TSID" -H 'Content-Type: json' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: http://localhost:3000/transmission/web/' -H 'X-Requested-With: XMLHttpRequest' -H 'DNT: 1' --data-binary '{"method":"torrent-get","arguments":{"fields":["id"],"ids":"recently-active"}}' --compressed | jq -c '{"method":"torrent-reannounce","arguments":{ids: [.arguments.torrents[].id]}}' | tr -d '\r'`
echo $TDATA

# 发出刷新Peers列表的请求
curl 'http://localhost:3000/transmission/rpc' -H 'Origin: http://localhost:3000' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: zh-CN,zh;q=0.9' -H "$TSID" -H 'Content-Type: json' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: http://localhost:3000/transmission/web/' -H 'X-Requested-With: XMLHttpRequest' -H 'DNT: 1' --data-binary "$TDATA" --compressed

# 每隔一分钟刷新一次
sleep 60
done