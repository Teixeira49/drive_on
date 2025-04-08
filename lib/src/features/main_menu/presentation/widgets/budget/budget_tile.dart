import 'package:drive_on/src/features/main_menu/data/entities/transaction.dart';
import 'package:drive_on/src/features/main_menu/presentation/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../../core/config/styles/static_colors.dart';
import '../../../../../core/helpers/helpers.dart';
import '../../../../../core/utils/constants/app_constants.dart';

class BudgetTile extends StatelessWidget {
  const BudgetTile({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.attach_money,),
            title: Text(transaction.byT == youTarget
                ? transaction.forT
                : transaction.byT, style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            subtitle: Text(Helper.extractDate(transaction.date)[0]),
            trailing: Text(
              Helper.fixMoney(transaction.operation),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: transaction.operation >= 0
                      ? ColorPalette.receiveMoney
                      : ColorPalette.sendMoney),
            ),
            onTap: () {
              ModalBottomSheetTransaction.show(context, transaction);
            },
          ),
          const Divider(height: 3, indent: 12, endIndent: 12,)
        ]);
  }
}
