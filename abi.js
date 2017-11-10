var abi = require('ethereumjs-abi')

var parameterTypes = ["address", "uint256", "bool"];
var parameterValues = ["0x1234567812345678", "0x314159268", true];

var encoded = abi.rawEncode(parameterTypes, parameterValues);

console.log(encoded.toString('hex'));