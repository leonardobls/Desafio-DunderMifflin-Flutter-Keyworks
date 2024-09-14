import 'package:dunder_mifflin/config/app_styles.dart';
import 'package:dunder_mifflin/data/models/solicitation_model.dart';
import 'package:flutter/material.dart';

class SolicitationBottomsheet extends StatefulWidget {
  const SolicitationBottomsheet({
    super.key,
  });

  @override
  State<SolicitationBottomsheet> createState() => _SolicitationBottomsheetState();
}

class _SolicitationBottomsheetState extends State<SolicitationBottomsheet> {
  List<SolicitationItem> solicitationItems = [
    SolicitationItem(
      title: 'Solução de problemas técnicos',
      icon: const Icon(Icons.flash_on, size: 36),
      isActive: false,
    ),
    SolicitationItem(
      title: 'Marcação de visita para solução de problema técnico',
      icon: const Icon(Icons.accessibility, size: 36),
      isActive: false,
    ),
    SolicitationItem(
      title: 'Dúvidas sobre utilização de algum produto ou serviço',
      icon: const Icon(Icons.accessibility, size: 36),
      isActive: false,
    ),
    SolicitationItem(
      title: 'Cancelamento de pedido',
      icon: const Icon(Icons.cancel, size: 36),
      isActive: false,
    ),
    SolicitationItem(
      title: 'Alteração de pedido',
      icon: const Icon(Icons.refresh, size: 36),
      isActive: false,
    ),
    SolicitationItem(
      title: 'Redirecionamento para todos os setores da empresa',
      icon: const Icon(Icons.accessibility, size: 36),
      isActive: false,
    ),
    SolicitationItem(
      title: 'Informações sobre produtos ou serviços',
      icon: const Icon(Icons.arrow_forward, size: 36),
      isActive: false,
    ),
  ];

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
                const SizedBox(
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
                          fontSize: 24,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close),
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
                      height: 1.2,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: solicitationItems.length,
                  itemBuilder: (context, index) {
                    final item = solicitationItems[index];
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Color(0xFFE3E2E6),
                              width: 2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            item.icon,
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                item.title,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (item.isActive)
                              const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
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
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const InkWell(
                      child: Text("Cancelar"),
                    ),
                    InkWell(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: AppStyles.primaryColor,
                          child: const Icon(
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
