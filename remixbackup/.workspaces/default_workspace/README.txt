Remix is an online Ethereum IDE. It enables full coding, compiling, and launching of smart contracts to JavaScript VM, ethereum test networks (e.g. Rinkeby), and even Ethereum main net & Injected Web3 (i.e. production). 

I'm using the example project to learn the language, you can see my annotated code of the format: 

XX_subject.sol

Where XX iterates from 02 - XX (all lessons I identify and split up), and subject = my summary of the topic at hand. `.sol` is the extension for solidity smart contracts. 

I am taking the following course: (Mastering Ethereum & Solidity with Real World Apps)[https://www.udemy.com/course/master-ethereum-and-solidity-programming-with-real-world-apps].

I definitely recommend it, I'm learning a lot and I'm only 25% of the way done with 5 case studies 

------
REMIX EXAMPLE PROJECT

Remix example project is present when Remix loads very first time or there are no files existing in the File Explorer. 
It contains 3 directories:

1. 'contracts': Holds three contracts with different complexity level, denoted with number prefix in file name.
2. 'scripts': Holds two scripts to deploy a contract. It is explained below.
3. 'tests': Contains one test file for 'Ballot' contract with unit tests in Solidity.

SCRIPTS

The 'scripts' folder contains example async/await scripts for deploying the 'Storage' contract.
For the deployment of any other contract, 'contractName' and 'constructorArgs' should be updated (along with other code if required). 
Scripts have full access to the web3.js and ethers.js libraries.

To run a script, right click on file name in the file explorer and click 'Run'. Remember, Solidity file must already be compiled.

Output from script will appear in remix terminal.
