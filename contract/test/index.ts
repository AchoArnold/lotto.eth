import {expect} from "chai";
import { ethers } from "hardhat";
import {Lotto} from "../typechain-types";

describe("Lotto", function () {
  it("should increase contract balance by ticket price after playing", async function () {
    // Arrange
    const lottoFactory = await ethers.getContractFactory("Lotto");
    const lotto = await lottoFactory.deploy() as Lotto;
    await lotto.deployed();
    
    // Acct
    const playLottoTransaction = await lotto.play([1,2,3,4,5,7], {
      value: ethers.utils.parseEther("0.001")
    });
    await playLottoTransaction.wait();
    
    // Assert
    expect(await lotto.getBalance()).equal(await lotto.getTicketPrice())
  });

  it("should pay winner if valid number is chosen", async function () {
    // Arrange
    const lottoFactory = await ethers.getContractFactory("Lotto");
    const lotto = await lottoFactory.deploy() as Lotto;
    await lotto.deployed();

    // Acct
    const playLottoTransaction = await lotto.play([1,2,3,4,5,6], {
      value: ethers.utils.parseEther("0.001")
    });
    await playLottoTransaction.wait();

    // Assert
    expect(await lotto.getBalance()).equal(ethers.utils.parseEther("0"))
  });
});
