#! /bin/bash
while IFS="," read -r alias_val did_val verkey_val
do
    peer chaincode invoke -n $CC_NAME -C $CHANNEL_NAME -c '{"args" : ["Init","[{\"alias\":\"$alias_val\",\"dest\":\"$did_val\",\"verkey\":\"$verkey_val\"}]"]}' \
                            -o $ORDERER_ENDPOINT \
                            --tls --cafile $ORDERER_CA \
                            --peerAddresses $CORE_PEER_ADDRESS \
                            --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE \
                            --peerAddresses "localhost:7051" \
                            --tlsRootCertFiles $ORG1_CA \
                            --waitForEvent \
                            --isInit
done < <(tail -n +1 data.csv)