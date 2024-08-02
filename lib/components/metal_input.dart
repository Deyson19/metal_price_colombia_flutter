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
    currentPrice = widget.precioVenta;
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
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
                  color: Colors.amber,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: textController,
              keyboardAppearance: Brightness.dark,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cantidad en gramos',
                suffixIcon: Icon(Icons.money_off_outlined),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: _btnCalcular(context),
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton _btnCalcular(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        metalPrice = double.parse(textController.text);
        metalPrice = metalPrice * currentPrice;
        final mySnackBar = SnackBar(
          duration: const Duration(milliseconds: 5500),
          content: Column(
            children: [
              const Text(
                "Resultado Obtenido:",
                style: TextStyle(color: Colors.green, fontSize: 21),
              ),
              const SizedBox(),
              Text(metalPrice.toString())
            ],
          ),
          action: SnackBarAction(
            label: 'Cerrar',
            onPressed: () {},
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.black,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
      },
      child: const Text(
        "Calcular",
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2),
      ),
    );
  }
}
