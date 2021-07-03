const ethers = require('ethers');

const bruteHash = () => {
  for (let i = 0; i < 256; i++) {
    const hashedNumber = ethers.utils.keccak256(i);
    if (
      hashedNumber ===
      '0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365'
    ) {
      return console.log('gotIt:', i);
    } else {
      console.log('looking..', hashedNumber);
    }
  }
};
bruteHash();


// 8 bit 0 - 255
// 16 bit 0 - 65535
// 32 bit 0 - 4294967295

