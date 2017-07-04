'use strict';
const Web3 = require('web3');

//const host = "localhost";
const host = "60.226.74.183";
const port = "8545";
const defaultContractAddress = "0x57AA24A3410c8f557451Db8D1EE23c4C8C3dC509";
const gas = 1000000;

// create an instance of web3 using the HTTP provider.
const web3 = new Web3(new Web3.providers.HttpProvider('http://${host}:${port}'));
let aiCoinContractAddress;

function init(contractAddress)
{
    const aiCoinContractAddress = contractAddress || defaultContractAddress;

    aiCoinContractAddress = web3.eth.contract([{"constant":false,"inputs":[{"name":"eventType","type":"string"},{"name":"severity","type":"int8"},{"name":"latitude","type":"string"},{"name":"longitude","type":"string"},{"name":"time","type":"uint64"},{"name":"vehicleId","type":"string"}],"name":"logEvent","outputs":[],"payable":false,"type":"function"},{"anonymous":false,"inputs":[{"indexed":false,"name":"observer","type":"address"},{"indexed":false,"name":"logType","type":"string"},{"indexed":false,"name":"Severity","type":"int8"},{"indexed":false,"name":"latitude","type":"string"},{"indexed":false,"name":"longitude","type":"string"},{"indexed":false,"name":"time","type":"uint64"},{"indexed":false,"name":"vehicleId","type":"string"}],"name":"LogEvent","type":"event"}])
        .at(aiCoinContractAddress);
}

function addBallot(ballot)
{
    console.log('About to log the following to Ethereum: ' + JSON.stringify(ballot.body));
    console.log("message.body.eventType = " + ballot.body.eventType);

    if (!message.body.externallyOwnerAccount)
    {
        return console.log("No externally owned account passed from device");
    }

    // logEvent(LogType eventType, int8 severity, string location, uint64 time, string carId)
    aiCoinContractAddress.AddBallot.sendTransaction(
        message.body.eventType,
        {from: message.body.externallyOwnerAccount,
            gas: gas
        },
        function(err, response)
        {
            if (err)
            {
                return console.log("Failed to send transaction to geth. Error: " + err);
            }

            console.log("Call to geth was successful. Response: " + response);
        }
    );
};

module.exports.init = init;
module.exports.logEvent = logEvent;