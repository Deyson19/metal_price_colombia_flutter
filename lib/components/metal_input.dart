import 'package:flutter/material.dart';

class MetalInput extends StatefulWidget {
  final double precioVenta;
  const MetalInput({super.key, required this.precioVenta});

  @override
  State<MetalInput> createState() => _MetalInputState();
}

class _MetalInputState extends State<MetalInput> {
  double metalPrice = 0;
  double currentPrice = 0;
  bool isValidQuantity = false;

  final textController = TextEditingController();

  @override
  void initState() {
    if (textController.value.text.isNotEmpty) {
      isValidQuantity = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
    metalPrice = 0;
    currentPrice = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      child: Center(
        child: Column(
          children: [
            const Text(
              "Ingresar Cantidad a Calcular:",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: textController,
              keyboardAppearance: Brightness.dark,
              onChanged: (text) {
                setState(() {
                  if (text.isEmpty) {
                    metalPrice = 0;
                  }
                  if (text.isNotEmpty) {
                    try {
                      isValidQuantity = true;
                      metalPrice = double.parse(text);
                      return;
                    } on FormatException {
                      isValidQuantity = false;
                      _mySnackBar("No es correcta la cantidad", Colors.red);
                    }
                  }
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cantidad en gramos',
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                suffixIcon: Icon(Icons.money_off_outlined),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: !isValidQuantity
                  ? textErrorCantidad()
                  : _btnCalcular(context),
            )
          ],
        ),
      ),
    );
  }

  Text textErrorCantidad() => const Text(
        "Por favor ingrese una cantidad",
        style: TextStyle(
            color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
      );

  Widget _btnCalcular(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        try {
          var price = double.parse(textController.text);
          setState(() {
            metalPrice = price * widget.precioVenta;
          });
          final mySnackBar =
              _mySnackBar("Resultado Obtenido: $metalPrice", Colors.green);
          ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
          metalPrice = 0;
        } on FormatException {
          final errorSnackbar =
              _mySnackBar("Error al calcular el precio", Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(errorSnackbar);
        }
      },
      child: const Text(
        "Calcular",
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2),
      ),
    );
  }

  SnackBar _mySnackBar(String message, Color color) {
    return SnackBar(
      duration: const Duration(milliseconds: 5500),
      content: Column(
        children: [
          Text(
            message,
            style: TextStyle(color: color, fontSize: 21),
          ),
        ],
      ),
      action: SnackBarAction(
        label: 'Cerrar',
        onPressed: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
        backgroundColor: Colors.orangeAccent,
        textColor: Colors.black,
      ),
    );
  }
}
