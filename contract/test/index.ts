import { expect } from "chai";
import { ethers } from "hardhat";
import {Lotto} from "../typechain-types";

describe("Lotto", function () {
  it("Should return the new greeting once it's changed", async function () {
    const lottoFactory = await ethers.getContractFactory("Lotto");
    const lotto = await lottoFactory.deploy({
      value: ethers.utils.parseEther("0.01"),
    }) as Lotto;
    
    await lotto.deployed();

    const setGreetingTx = await lotto.play([1,2,3,4,5,6]);

    // wait until the transaction is mined
    await setGreetingTx.wait();
  });
});
