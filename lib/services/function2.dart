import 'package:dino_run/Utils/constant.dart';
import 'package:dino_run/services/function1.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadcontract() async {
  String abi = await rootBundle.loadString('assets/abi/auction.json');
  String contractAddress = DynoAvatars_Smart_Contract;

  final contract = DeployedContract(ContractAbi.fromJson(abi, ' DynoAuction'),
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

Future<String> init(dynamic tokenId, dynamic duration, dynamic startingPrice,
    Web3Client maticClient) async {
  var response = await callFunction(
      'init',
      [BigInt.from(tokenId), BigInt.from(duration), BigInt.from(startingPrice)],
      maticClient,
      owner_private_key);
  print('');
  return response;
}

Future<List> bid(int tokenId, int amount, Web3Client maticClient) async {
  List<dynamic> response = await ask(
      'bid', [BigInt.from(tokenId), BigInt.from(amount)], maticClient);
  print('bid successful');
  return response;
}

Future<String> close(dynamic tokenId, Web3Client maticClient) async {
  var response = await callFunction(
      'close', [BigInt.from(tokenId)], maticClient, owner_private_key);
  print('');
  return response;
}
