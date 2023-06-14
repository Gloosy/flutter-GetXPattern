
import 'product_model.dart';
class CartModel{
  int? id;
  String? name;
  String? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  Data? product;
  CartModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.img,
    this.isExist,
    this.time,
    this.product
    });
  CartModel.fromJson(Map<String ,dynamic> json){
    id               = json['id'];
    name             = json['name'];
    price            = json['price'];
    img              = json['img'];
    quantity         = json['quantity'];
    isExist          = json['isExist'];
    time             = json['time'];
    product          = Data.fromJson(json['product']);
  }
  Map<String ,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']       = id;
    data['name']     = name;
    data['price']    = price;
    data['img']      = img;
    data['quantity'] = quantity;
    data['isExist']  = isExist;
    data['time']     = time;
    data['product']  = product?.toJson();
    return data;
  }
}