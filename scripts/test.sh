#!/usr/bin/env bash

echo "test if ik is working, make sure you have elasticsearch running!"


echo "delete old index" 
curl -XDELETE http://localhost:9200/ik

# NOTE: delete is async, so the result is not expected .... sleep may help
sleep 1

echo "create index called ik"
curl -XPUT http://localhost:9200/ik?pretty

echo "create index mapping"
curl -XPOST http://localhost:9200/ik/fulltext/_mapping?pretty -d'
{
    "fulltext": {
            "_all": {
            "analyzer": "ik_max_word",
            "search_analyzer": "ik_max_word",
            "term_vector": "no",
            "store": "false"
        },
        "properties": {
            "content": {
                "type": "string",
                "store": "no",
                "term_vector": "with_positions_offsets",
                "analyzer": "ik_max_word",
                "search_analyzer": "ik_max_word",
                "include_in_all": "true",
                "boost": 8
            }
        }
    }
}'

echo "adding doc"
curl -XPOST http://localhost:9200/ik/fulltext/1?pretty -d'
{"content":"小福福玩xbox是不是很搓"}
'

curl -XPOST http://localhost:9200/ik/fulltext/2?pretty -d'
{"content":"小福福是不是很萌"}
'

curl -XPOST http://localhost:9200/ik/fulltext/3?pretty -d'
{"content":"阿姨最萌了"}
'
# the indexing process is async as well ... near real time
sleep 1

# FIXME: hit is empty
# TODO: why pre_tags is an array
echo "searching"
curl -XPOST http://localhost:9200/ik/fulltext/_search?pretty  -d'
{
    "query" : { "term" : { "content" : "萌" }},
    "highlight" : {
        "pre_tags" : ["<tag1>", "<tag2>"],
        "post_tags" : ["</tag1>", "</tag2>"],
        "fields" : {
            "content" : {}
        }
    }
}
'

curl -XPOST http://localhost:9200/ik/fulltext/_search?pretty  -d'
{
    "query" : { "term" : { "content" : "xbox" }},
    "highlight" : {
        "pre_tags" : ["<tag1>", "<tag2>"],
        "post_tags" : ["</tag1>", "</tag2>"],
        "fields" : {
            "content" : {}
        }
    }
}
'