import 'package:flutter/material.dart';
import 'package:metal_price_colombia/components/metal_input.dart';
import 'package:metal_price_colombia/components/metal_widget.dart';
import 'package:metal_price_colombia/models/metal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Metal> metals = [
    Metal(nombre: "Oro", precioCompra: 304163, precioVenta: 320171),
    Metal(nombre: "Plata", precioCompra: 3013, precioVenta: 3767),
    Metal(nombre: "Platino", precioCompra: 122525, precioVenta: 127048)
  ];
  double precio = 0;
  String nombreMetal = '';
  double precioCompra = 0;
  bool hasSelected = false;

  void getPrecio(Metal metal) {
    setState(() {
      hasSelected = true;
      precio = metal.precioVenta;
      nombreMetal = metal.nombre;
      precioCompra = metal.precioCompra;
    });
  }

  @override
  Widget build(BuildContext context) {
    var metalInfo = [
      Text('Precio Compra: $precioCompra',
          style: const TextStyle(fontSize: 20)),
      Text('Metal: $nombreMetal', style: const TextStyle(fontSize: 20)),
      Text('Precio Venta: $precio', style: const TextStyle(fontSize: 20)),
    ];
    return Scaffold(
      backgroundColor: Colors.white30,
        body: Column(children: [
      const Center(
        child: Text('Seleccionar Metal',
            style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
      Center(
          child: Row(children: [
        for (var i = 0; i < metals.length; i++)
          Expanded(
            child: Container(
              margin: const EdgeInsetsDirectional.all(2),
              child: MetalWidget(
                metal: metals[i],
                currentMetal: getPrecio,
              ),
            ),
          )
      ])),
      const SizedBox(height: 20),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: hasSelected ? metalInfo : []),
      const SizedBox(
        height: 10,
      ),
      hasSelected
          ? MetalInput(precioVenta: precio)
          : const Text(
              'No hay metal seleccionado',
              style: TextStyle(fontSize: 20, color: Colors.red),
            )
    ]));
  }
}
