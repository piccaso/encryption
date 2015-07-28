<?php
  $decrypted='';
  openssl_private_decrypt(
    base64_decode(file_get_contents("php://stdin")),
    $decrypted,
    openssl_get_privatekey(file_get_contents("mykey.pem"))
  );
  echo $decrypted;
