import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/neon_button.dart';
import '../widgets/neon_text.dart';
import '../services/api_service.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  File? imagen1;
  File? imagen2;
  String resultado = "";

  final picker = ImagePicker();

  // Seleccionar imagen desde galería
  Future<void> seleccionarImagen(int numero) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (numero == 1) imagen1 = File(pickedFile.path);
        else imagen2 = File(pickedFile.path);
      });
    }
  }

  // Comparar imágenes
  Future<void> compararImagenes() async {
    if (imagen1 == null || imagen2 == null) {
      setState(() => resultado = "Selecciona ambas imágenes antes de comparar.");
      return;
    }

    setState(() => resultado = "Comparando, por favor espera...");

    final respuesta = await ApiService.compararImagenes(imagen1!, imagen2!);

    setState(() {
      if (respuesta['success'] == true) {
        resultado = respuesta['mensaje'] ?? "Comparación exitosa.";
      } else {
        resultado = "Error: ${respuesta['error'] ?? 'Error desconocido.'}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const NeonText(text: "Comparar Imágenes"),
        const SizedBox(height: 20),

        NeonButton(
          text: imagen1 == null ? "Subir Imagen 1" : "Imagen 1 Seleccionada ✅",
          onPressed: () => seleccionarImagen(1),
        ),
        NeonButton(
          text: imagen2 == null ? "Subir Imagen 2" : "Imagen 2 Seleccionada ✅",
          onPressed: () => seleccionarImagen(2),
        ),

        const SizedBox(height: 30),
        NeonButton(
          text: "Comparar",
          onPressed: compararImagenes,
        ),

        const SizedBox(height: 30),
        Text(
          resultado,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
