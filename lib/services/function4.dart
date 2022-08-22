import 'package:dino_run/Utils/constant.dart';
import 'package:dino_run/services/function1.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> dynoContract() async {
  String abi = await rootBundle.loadString('assets/abi/stDYON.json');
  String contractAddress = DynoStaking_Smart_Contract;
  final contract = DeployedContract(ContractAbi.fromJson(abi, 'DynoStaking'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callFunction(String funcname, List<dynamic> args,
    Web3Client maticClient, String PrivateKey) async {
  EthPrivateKey credential = EthPrivateKey.fromHex(PrivateKey);

  DeployedContract contract = await loadcontract();
  final ethfunction = contract.function(funcname);
  final result = await maticClient.sendTransaction(
    credential,
    Transaction.callContract(
        contract: contract, function: ethfunction, parameters: args),
    chainId: null,
    fetchChainIdFromNetworkId: true,
  );

  return result;
}

Future<String> stake(int tokenId, Web3Client maticClient) async {
  var response = await callFunction(
      'stake', [BigInt.from(tokenId)], maticClient, player_private_key);
  print('minted successfully');
  return response;
}

Future<String> calculateStakingYield(
    int tokenId, Web3Client maticClient) async {
  var result = await callFunction('calculateStakingYield',
      [BigInt.from(tokenId)], maticClient, player_private_key);
  return result;
}

Future<String> unstake(int tokenId, Web3Client maticClient) async {
  var response = await callFunction(
      'unstake', [BigInt.from(tokenId)], maticClient, player_private_key);
  print('minted successfully');
  return response;
}
