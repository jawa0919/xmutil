class LoginUserResp {
  final String? id;
  final String? accountNo;
  final String? nickName;
  final String? realName;
  final String? headImage;
  final int? isLock;
  final String? remark;
  final String? token;

  const LoginUserResp({
    this.id,
    this.accountNo,
    this.nickName,
    this.realName,
    this.headImage,
    this.isLock,
    this.remark,
    this.token,
  });

  factory LoginUserResp.fromJson(Map<String, dynamic> json) => LoginUserResp(
    id: json['id'],
    accountNo: json['accountNo'],
    nickName: json['nickName'],
    realName: json['realName'],
    headImage: json['headImage'],
    isLock: json['isLock'],
    remark: json['remark'],
    token: json['token'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'accountNo': accountNo,
    'nickName': nickName,
    'realName': realName,
    'headImage': headImage,
    'isLock': isLock,
    'remark': remark,
    'token': token,
  };

  LoginUserResp copyWith({
    String? id,
    String? accountNo,
    String? nickName,
    String? realName,
    String? headImage,
    int? isLock,
    String? remark,
    String? token,
  }) => LoginUserResp(
    id: id ?? this.id,
    accountNo: accountNo ?? this.accountNo,
    nickName: nickName ?? this.nickName,
    realName: realName ?? this.realName,
    headImage: headImage ?? this.headImage,
    isLock: isLock ?? this.isLock,
    remark: remark ?? this.remark,
    token: token ?? this.token,
  );

  @override
  String toString() {
    return 'LoginUserResp{id: $id, accountNo: $accountNo, nickName: $nickName, realName: $realName, headImage: $headImage, isLock: $isLock, remark: $remark, token: $token}';
  }
}
