import 'package:dunder_mifflin/config/app_styles.dart';
import 'package:flutter/material.dart';

class SolicitationBottomsheet extends StatefulWidget {
  const SolicitationBottomsheet({
    super.key,
  });

  @override
  State<SolicitationBottomsheet> createState() => _SolicitationBottomsheetState();
}

class _SolicitationBottomsheetState extends State<SolicitationBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        "Solicitação de atendimento",
                        style: TextStyle(
                          letterSpacing: -0.6,
                          fontSize: 24,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Text(
                    "Qual o motivo do atendimento?",
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: -1,
                      height: 1.2,
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFE3E2E6), // Cor da borda
                          width: 2, // Largura da borda
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.flash_on),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Solução de problemas técnicos"),
                        SizedBox(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFE3E2E6), // Cor da borda
                          width: 2, // Largura da borda
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.flash_on),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text("Marcação de visita para solução de problema técnico"),
                        ),
                        SizedBox(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFE3E2E6), // Cor da borda
                          width: 2, // Largura da borda
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.flash_on),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Solução de problemas técnicos"),
                        SizedBox(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFE3E2E6), // Cor da borda
                          width: 2, // Largura da borda
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.flash_on),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Solução de problemas técnicos"),
                        SizedBox(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFE3E2E6), // Cor da borda
                          width: 2, // Largura da borda
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.flash_on),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Solução de problemas técnicos"),
                        SizedBox(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFE3E2E6), // Cor da borda
                          width: 2, // Largura da borda
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.flash_on),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Solução de problemas técnicos"),
                        SizedBox(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFE3E2E6), // Cor da borda
                          width: 2, // Largura da borda
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.flash_on),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Solução de problemas técnicos"),
                        SizedBox(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Color(0xFFE3E2E6), // Cor da borda
                          width: 2, // Largura da borda
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.flash_on),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Solução de problemas técnicos"),
                        SizedBox(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const InkWell(
                      child: Text("Cancelar"),
                    ),
                    InkWell(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: AppStyles.primaryColor,
                          child: Icon(
                            Icons.arrow_forward,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
