import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(this._updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final product = ModalRoute.of(context).settings.arguments as Product;
      if (product != null) {
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;
        _imageUrlController.text = _formData['imageUrl'];
      } else {
        _formData['price'] = '';
      }
    }
  }

  void _updateImage() {
    // just update the user graphical interface
    if (isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

  bool isValidImageUrl(String url) {
    bool isStartsWithHttp = url.toLowerCase().startsWith('http://');
    bool isStartsWithHttps = url.toLowerCase().startsWith('https://');
    bool isEndsWithPng = url.toLowerCase().endsWith('.png');
    bool isEndsWithJpg = url.toLowerCase().endsWith('.jpg');
    bool isEndsWithJpeg = url.toLowerCase().endsWith('.jpeg');
    return (isStartsWithHttp || isStartsWithHttps) &&
        (isEndsWithPng || isEndsWithJpg || isEndsWithJpeg);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(this._updateImage);
    _imageUrlFocusNode.dispose();
  }

  void _saveForm() {
    var isValidForm = _form.currentState.validate();
    if (!isValidForm) {
      return;
    }

    _form.currentState.save();

    final product = Product(
      id: _formData['id'],
      title: _formData['title'],
      description: _formData['description'],
      price: _formData['price'],
      imageUrl: _formData['imageUrl'],
    );

    print('salvando produto');
    print(product.title);
    print(product.imageUrl);

    final productsProvider = Provider.of<Products>(context, listen: false);
    if (product.id == null) {
      productsProvider.addProduct(product);
    } else {
      productsProvider.updateProduct(product);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Produto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: this._formData['title'],
                decoration: InputDecoration(labelText: 'Título'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) => _formData['title'] = value,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Informe um título válido';
                  }
                  if (value.trim().length < 3) {
                    return 'Informe um título com no mínimo 3 letras';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: this._formData['price'].toString(),
                decoration: InputDecoration(labelText: 'Preço'),
                focusNode: _priceFocusNode,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) => _formData['price'] = double.parse(value),
                validator: (value) {
                  bool isEmpty = value.trim().isEmpty;
                  var newPrice = double.tryParse(value);
                  bool isInvalid = newPrice == null || newPrice <= 0;
                  if (isEmpty || isInvalid) {
                    return 'Informe um preço válido';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: this._formData['description'],
                decoration: InputDecoration(labelText: 'Descrição'),
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) => _formData['description'] = value,
                validator: (value) {
                  bool isEmpty = value.trim().isEmpty;
                  bool isInvalid = value.trim().length <= 10;
                  if (isEmpty || isInvalid) {
                    return 'Informe uma descrição válida com no minimo 10 caracteres';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'URL da imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) => _formData['imageUrl'] = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        bool isInvalid = !this.isValidImageUrl(value.trim());

                        if (isEmpty || isInvalid) {
                          return 'Informe uma Url válida para a imagem';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 8, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? Text('Informe a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
