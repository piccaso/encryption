#!/bin/bash

# generate private key
openssl genrsa -out mykey.pem 4096

# generate public key
openssl rsa -in mykey.pem -pubout -out mykey.pub

MSG="please dont hack me"

echo "The secret Message = $MSG"

ENC=$(echo -n $MSG | openssl rsautl -encrypt -inkey mykey.pub -pubin | base64 --wrap=0)

echo "Encrypted = $ENC";

DEC=$(echo $ENC | base64 -d | openssl rsautl -decrypt -inkey mykey.pem)

echo "Decrypted with rsautl = $DEC"

if [ "$MSG" == "$DEC" ]; then
  echo "Decryption using openssl cli worked!"
else
  echo "Damn! something went wrong..."
fi

if hash python ; then
  PYDEC=$(echo $ENC | python decrypt.py)
  echo "Decrypted using python = $PYDEC"
  if [ "$MSG" == "$PYDEC" ]; then
    echo "Decryption using python worked!"
  else
    echo "Damn! something went wrong..."
  fi
else
  echo 'python not found...'
fi

if hash php ; then
  PHPDEC=$(echo $ENC | php -f decrypt.php )
  echo "Decrypted using php = $PHPDEC"
  if [ "$MSG" == "$PHPDEC" ]; then
    echo "Decryption using php worked!"
  else
    echo "Damn! something went wrong..."
  fi
else
  echo 'php not found...'
fi
