#!/bin/bash

ARGS=()


#   8760h ->  1y
#  17520h ->  2y
#  26280h ->  3y
#  43800h ->  5y
#  61320h ->  7y
#  87600h -> 10y
# 122640h -> 14y
# 175200h -> 20y

mkdir -p certs

if [ ! -f ca.crt ]; then

    echo "-----------------------------------------------"
    echo "|            INITIALIZE ROOT CA               |"
    echo "-----------------------------------------------"
    echo '{
    "CN": "Serialize Root CA",
    "hosts": [ 
        "pki.sez23.net", 
        "localhost", 
        "127.0.0.1" 
    ],
    "key": { 
        "algo": "rsa", 
        "size": 4096 
    },
    "names": [{ 
        "OU": "IT", 
        "O": "Serialize", 
        "L": "Stuttgart", 
        "ST": "BaWue", 
        "C": "DE" 
    }],
    "ca": { 
        "expiry": "175200h",
        "pathlen": 3 
    }
}' | cfssl gencert -initca - | cfssljson -bare certs/ca-root -

    rm certs/ca-root.csr
    ln -s certs/ca-root.pem ca.crt
    ln -s certs/ca-root-key.pem ca.key
    ln -s certs/ca-root.pem ca-bundle.crt 



    echo "-----------------------------------------------"
    echo "|        INITIALIZE INTERMEDIATE CA           |"
    echo "-----------------------------------------------"

    echo '{
    "signing": {
        "default": {
            "expiry": "87600h",
            "usages": [
                "signing",
                "digital signature",
                "key encipherment",
                "cert sign",
                "crl sign",
                "server auth",
                "client auth"
            ],
            "expiry": "87600h",
            "ca_constraint": {
                "is_ca": true,
                "max_path_len":2
            }
        }
    }
}
' > config-ca-root.json


    echo '{
    "CN": "Serialize Intermediate CA",
    "hosts": [ 
        "pki.sez23.net", 
        "localhost", 
        "127.0.0.1" 
    ],
    "key": {
        "algo": "rsa",
        "size": 4096
    },
    "names": [{
        "OU": "IT", 
        "O": "Serialize", 
        "L": "Stuttgart", 
        "ST": "BaWue", 
        "C": "DE" 
    }]

}' | cfssl gencert \
        -ca=certs/ca-root.pem \
        -ca-key=certs/ca-root-key.pem \
        -config=config-ca-root.json - | cfssljson -bare certs/ca-int -

    rm certs/ca-int.csr 

    rm ca.crt ca.key
    ln -s certs/ca-int.pem ca.crt
    ln -s certs/ca-int-key.pem ca.key
    ln -s certs/ca-int.pem int-bundle.crt 



    echo "-----------------------------------------------"
    echo "|              INITIALIZE SUB CA              |"
    echo "-----------------------------------------------"

    echo '{
    "signing": {
        "default": {
            "expiry": "87600h",
            "usages": [
                "signing",
                "digital signature",
                "key encipherment",
                "cert sign",
                "crl sign",
                "server auth",
                "client auth"
            ],
            "expiry": "87600h",
            "ca_constraint": {
                "is_ca": true,
                "max_path_len":1
            }
        }
    }
}
' > config-ca-int.json


    echo '{
    "CN": "Serialize Signing CA",
    "hosts": [ 
        "pki.sez23.net", 
        "localhost", 
        "127.0.0.1" 
    ],
    "key": {
        "algo": "rsa",
        "size": 4096
    },
    "names": [{
        "OU": "IT", 
        "O": "Serialize", 
        "L": "Stuttgart", 
        "ST": "BaWue", 
        "C": "DE" 
    }]

}' | cfssl gencert \
        -ca=certs/ca-int.pem \
        -ca-key=certs/ca-int-key.pem \
        -ca-bundle=ca-bundle.crt \
        -config=config-ca-int.json - | cfssljson -bare certs/ca-sign -

    rm certs/ca-sign.csr 

    rm ca.crt ca.key
    ln -s certs/ca-sign.pem ca.crt
    ln -s certs/ca-sign-key.pem ca.key



    echo '{
  "signing": {
    "default": {
      "auth_key": "key1",
      "ocsp_url": "http://pki.sez23.net/oscp",
      "crl_url": "http://pki.sez23.net/crl",
      "expiry": "26280h"
    },
    "profiles": {
      "intermediate": {
        "auth_key": "key1",
        "expiry": "43800h",
        "usages": [
          "signing",
          "key encipherment",
          "cert sign",
          "crl sign"
        ],
        "ca_constraint": {
          "is_ca": true,
          "max_path_len": 0
        }
      },
      "ocsp": {
        "auth_key": "key1",
        "usages": [
          "digital signature",
          "ocsp signing"
        ],
        "expiry": "26280h"
      },
      "serverCA": {
        "auth_key": "key1",
        "expiry": "43800h",
        "usages": [
          "signing",
          "key encipherment",
          "server auth",
          "cert sign",
          "crl sign"
        ]
      },
      "server": {
        "auth_key": "key1",
        "expiry": "17520h",
        "usages": [
          "signing",
          "key encipherment",
          "server auth"
        ]
      },
      "client": {
        "auth_key": "key1",
        "expiry": "8760h",
        "usages": [
          "signing",
          "key encipherment",
          "client auth",
          "email protection"
        ]
      }
    }
  },
  "auth_keys": {
    "key1": {
      "key": "6bbc29488c646f70e96146c6e9739fac",
      "type": "standard"
    }
  }
}' > config-ca-sign.json


fi


if [ ! -f oscp.crt ]; then

    echo "-----------------------------------------------"
    echo "|           INITIALIZE OSCP CERT              |"
    echo "-----------------------------------------------"
    echo '{
    "CN": "Serialize OSCP Server",
    "hosts": [ 
        "pki.sez23.net", 
        "localhost", 
        "127.0.0.1" 
    ],
    "key": { 
        "algo": "rsa", 
        "size": 4096 
    },
    "names": [{ 
        "OU": "IT", 
        "O": "Serialize", 
        "L": "Stuttgart", 
        "ST": "BaWue", 
        "C": "DE" 
    }]
}' | cfssl gencert \
        -ca=certs/ca-sign.pem \
        -ca-key=certs/ca-sign-key.pem \
        -config=config-ca-sign.json \
        -profile="ocsp" - | cfssljson -bare certs/oscp -

    rm certs/oscp.csr 

    ln -s certs/oscp.pem oscp.crt
    ln -s certs/oscp-key.pem oscp.key

fi


if [ ! -f config.json ]; then
    ln -s config-ca-sign.json config.json
fi


if [ ! -f db-config.json ]; then
    cat /usr/local/share/cfssl/sqlite-create.sql | sqlite3 certdb.db
    echo '{"driver":"sqlite3","data_source":"certdb.db"}' > db-config.json
fi


echo "-----------------------------------------------"
echo "|          START SERVING SIGNING CA           |"
echo "-----------------------------------------------"


[ -f ca.crt ] && ARGS+=("-ca=ca.crt")
[ -f ca.key ] && ARGS+=("-ca-key=ca.key")
[ -f ca-bundle.crt ] && ARGS+=("-ca-bundle=ca-bundle.crt")
[ -f int-bundle.crt ] && ARGS+=("-int-bundle=int-bundle.crt")
[ -f oscp.crt ] && ARGS+=("-responder=oscp.crt")
[ -f oscp.key ] && ARGS+=("-responder-key=oscp.key")
[ -f config.json ] && ARGS+=("-config=config.json")
[ -f db-config.json ] && ARGS+=("-db-config=db-config.json")

ARGS+=("-address=0.0.0.0")

exec cfssl "$@" "${ARGS[@]}"

exit 1