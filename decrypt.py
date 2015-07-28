#imports begin
from M2Crypto import RSA
from sys import stdin
#end imports

encryptedText = stdin.read()
priv = RSA.load_key("mykey.pem")
decodeEncryptedText = encryptedText.decode('base64')
decryptedText = priv.private_decrypt(decodeEncryptedText, RSA.pkcs1_padding)
print decryptedText
