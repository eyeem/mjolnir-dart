import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'request_builder.dart';
import 'auth.dart';

@immutable
abstract class Account extends Equatable {
  const Account({
    required this.type,
    required this.id,
  });

  final String? type;
  final String? id;

  RequestBuilder sign(RequestBuilder requestBuilder);

  Map<dynamic, dynamic> toJson() {
    final output = Map<dynamic, dynamic>();
    output["type"] = type;
    output["id"] = id;
    return output;
  }

  @override
  List<Object?> get props => [type, id];
}

@immutable
abstract class OAuth2Account extends Account {
  const OAuth2Account({
    this.accessToken,
    String? type,
    String? id,
  }) : super(type: type, id: id);

  final String? accessToken;

  String authorizeUrl();
  String callbackUrl();
  String secret();
  RequestBuilder oauthRequest();

  void requestAccessToken() {
    throw UnimplementedError("OAuth2 flow not implemented");
  }

  OAuth2Account copyWithAuth(Auth auth);

  @override
  Map<dynamic, dynamic> toJson() {
    final output = super.toJson();
    output["accessToken"] = accessToken;
    return output;
  }

  @override
  List<Object?> get props => [...super.props, accessToken];
}
