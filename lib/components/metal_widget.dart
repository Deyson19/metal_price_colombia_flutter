import 'package:flutter/material.dart';
import 'package:metal_price_colombia/models/metal.dart';

class MetalWidget extends StatefulWidget {
  final Metal metal;
  final Function(Metal)? currentMetal;

  const MetalWidget(
      {super.key,
      required this.metal,
      required this.currentMetal});

  @override
  State<MetalWidget> createState() => _MetalWidgetState();
}

class _MetalWidgetState extends State<MetalWidget> {
  String selectedMetal = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var myWidth = size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: (){
          setState(() {
            selectedMetal = widget.metal.nombre;
          });
          widget.currentMetal!(widget.metal);
        },
        splashColor: Colors.blue,        
        child: Card(
            child: Column(
          children: [
            Icon(
              Icons.monetization_on_outlined,
              size: myWidth/6,
              color: Colors.teal,
            ),
            Text(
              widget.metal.nombre,
              style: TextStyle(
                  color: Colors.blue, fontSize: myWidth/20, fontWeight: FontWeight.bold),
            ),
            Text('Precio: ${widget.metal.precioCompra}',
                style: const TextStyle(color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.bold
                )),
            const SizedBox(
              height: 5,
            ),
          ],
        )),
      ),
    );
  }
}
