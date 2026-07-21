import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(child: Icon(Icons.camera_alt_outlined)),
            Text(
              'ZamaBooks branch',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('companyFullAddress'.tr()),
            SizedBox(
              height: 20,
            ),
            Text('الفاتوراتة'),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('invoiceNumberAr'.tr()),
                Text('taxNumberAr'.tr()),
              ],
            ),
            Row(
              children: [Text('352'), Text('443107539740003')],
            ),
            Divider(
              thickness: 1,
            ),
            Text('billToArSample'.tr()),
            Divider(
              thickness: 1,
            ),
            SizedBox(height: 16),

            // Table header
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text('Description',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 1,
                    child: Text('Qty',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 2,
                    child: Text('Price',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 2,
                    child: Text('Subtotal',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            Divider(),

            // Example table rows (replace with dynamic data)
            // Use a `Container` to limit the height of the ListView
            SizedBox(
              height:
                  200, // Set a height or remove if you want it to take as much space as needed
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5, // replace with actual item count
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(flex: 3, child: Text('${'item'.tr()} $index')),
                      Expanded(flex: 1, child: Text('1')),
                      Expanded(flex: 2, child: Text('\$10.00')),
                      Expanded(flex: 2, child: Text('\$10.00')),
                    ],
                  );
                },
              ),
            ),

            Divider(thickness: 1),
            SizedBox(height: 8),

            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$50.00'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tax (5%):',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$2.50'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('\$52.50',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 16),

            // Footer notes
            Text('Thank you for your business!', textAlign: TextAlign.center),
            Icon(
              Icons.qr_code,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
