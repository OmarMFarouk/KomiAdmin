import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:komiadmin/src/app_size.dart';

class CountryTile extends StatelessWidget {
  const CountryTile({
    super.key,
    required this.id,
    required this.country,
  });
  final String country, id;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: AppSize.width(context),
      height: AppSize.height(context) * 0.06,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFF191C24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSize.width(context) * 0.11,
            child: Text(
              id,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const VerticalDivider(
            color: Colors.blueGrey,
            endIndent: 12,
            indent: 12,
          ),
          SizedBox(
            width: AppSize.width(context) * 0.45,
            child: SelectableText(
              country,
              style: TextStyle(fontSize: 16, color: Colors.deepOrange.shade600),
            ),
          ),
          SizedBox(
              width: 25,
              child: CountryFlag(
                country: flagger(country), // OR Language.fromCode('ar')
                height: 25,
              )),
        ],
      ),
    );
  }
}

flagger(country) {
  switch (country) {
    case 'US':
      return Country.us;
    case 'UK':
      return Country.gb;
    case 'GB':
      return Country.gb;
    case 'EG':
      return Country.eg;
    case 'CA':
      return Country.ca;
    case 'DE':
      return Country.de;
    case 'BE':
      return Country.be;
    case 'DZ':
      return Country.dz;
    case 'ES':
      return Country.es;
    case 'FR':
      return Country.fr;
    case 'CH':
      return Country.ch;
    case 'HK':
      return Country.hk;
    case 'IT':
      return Country.it;
    case 'LB':
      return Country.lb;
    case 'LY':
      return Country.ly;
    case 'MA':
      return Country.ma;
    case 'IQ':
      return Country.iq;
    case 'SA':
      return Country.sa;
    case 'IN':
      return Country.c_in;
    case 'YE':
      return Country.ye;
    case 'TR':
      return Country.tr;
    case 'PS':
      return Country.ps;
    case 'PH':
      return Country.ph;
    case 'QA':
      return Country.qa;
    case 'PT':
      return Country.pt;
    case 'TH':
      return Country.th;
    default:
      return Country.eg;
  }
}
