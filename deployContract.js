module.paths.push('/usr/lib/node_modules');

var fs = require('fs');
const contract_data = JSON.parse(
    fs.readFileSync('./libs/TwoOwners.json')
);


var openKeyFirstOwner = "openKeyFirstOwner";
var privateKeyFirstOwner = "privateKeyFirstOwner";

var secondOwneropenKey = "secondOwneropenOpenKey";

var Web3 = require('web3');
var web3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/.........."));

web3.eth.accounts.wallet.add("0x" + privateKeyFirstOwner);

var contract = new web3.eth.Contract(contract_data.abi);

contract.deploy({
    data: contract_data.unlinked_binary,
    arguments: [secondOwneropenKey, 1000000]
}).send({
    from: openKeyFirstOwner,
    gas: 1500000,
    gasPrice: '80000000'
}, function (error, transactionHash) {

}).on('error', function (error) {
    console.log('error', error);
}).on('transactionHash', function (transactionHash) {
    console.log('transactionHash', transactionHash);
}).on('receipt', function (receipt) {
    console.log('receipt', receipt.contractAddress);
}).on('confirmation', function (confirmationNumber, receipt) {
    console.log('confirmation', confirmationNumber);
});