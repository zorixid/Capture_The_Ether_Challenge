const ethers = require('ethers');

const converter = async (args) => {
  const dataToConvert = args[0];

  if (args[1] === 'to32') {
    const bytes = ethers.utils.formatBytes32String(dataToConvert);
    console.log('Bytes32: ', bytes);
  } else if (args[1] === 'from32') {
    const convertedStr = ethers.utils.parseBytes32String(dataToConvert);
    console.log('String: ', convertedStr);
  }
};

converter(process.argv.slice(2));


//node bytes32converter 0x6a757374696e0000000000000000000000000000000000000000000000000000 from32
//node bytes32converter justin to32

//node bytes32converter bbdd to32
//Bytes32:  0x6262646400000000000000000000000000000000000000000000000000000000