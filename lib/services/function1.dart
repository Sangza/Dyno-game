import 'package:flutter/services.dart';
import 'package:dino_run/Utils/constant.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadcontract() async {
  String abi = await rootBundle.loadString('assets/abi/avatar.json');
  String contractAddress = DynoAvatars_Smart_Contract;

  final contract = DeployedContract(ContractAbi.fromJson(abi, 'DynoAvatars'),
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

Future<List<dynamic>> ask(
    String funcName, List<dynamic> args, Web3Client maticClient) async {
  final contract = await loadcontract();
  final ethFunction = contract.function(funcName);
  final result =
      maticClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future<String> mint(dynamic amount, Web3Client maticClient) async {
  var response = await callFunction(
      'mint', [BigInt.from(amount)], maticClient, player_private_key);
  print('minted successfully');
  return response;
}

Future<String> walletOfOwner(String address, Web3Client maticClient) async {
  var response = await callFunction('walletOfOwner',
      [EthereumAddress.fromHex(address)], maticClient, owner_private_key);
  print('success');
  return response;
}

Future<List> tokenURI(int tokenId, Web3Client maticClient) async {
  List<dynamic> result =
      await ask('tokenURI', [BigInt.from(tokenId)], maticClient);
  return result;
}
