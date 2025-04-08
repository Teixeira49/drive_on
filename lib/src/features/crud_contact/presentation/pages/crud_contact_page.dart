import 'package:flutter/cupertino.dart';

class CRUDContactPage extends StatefulWidget {
  const CRUDContactPage({super.key});

  @override
  CRUDContactState createState() => CRUDContactState();
}

class CRUDContactState extends State<CRUDContactPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ValueNotifier<String?> _relationshipController =
      ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _relationshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
