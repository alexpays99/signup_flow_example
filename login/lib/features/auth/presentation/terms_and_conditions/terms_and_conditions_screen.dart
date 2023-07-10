import 'package:flutter/material.dart';
import 'package:login/core/utils/styles/colors.dart';
import 'package:login/core/keys/asset_path.dart';
import '../../../../core/utils/helpers/parser.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  Map<String, dynamic> terms = {};
  final parser = Parser.instance;

  @override
  void initState() {
    super.initState();
    parser.decodeTermsData(AssetPath.termsDataPath).then((value) {
      terms = value;
      setState(() {
        terms;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    terms["title"],
                    style: style.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: CustomPalette.black,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  terms["intro"]["firstParagraph"],
                  style:
                      style.titleSmall?.copyWith(color: CustomPalette.black65),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  terms["intro"]['firstText'],
                  style:
                      style.titleSmall?.copyWith(color: CustomPalette.black65),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  terms['theInterngramService']['title'],
                  style: style.titleMedium?.copyWith(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  terms['theInterngramService']['firstParagraph'],
                  style:
                      style.titleSmall?.copyWith(color: CustomPalette.black65),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['theInterngramService']['serviceList'][0],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['theInterngramService']['serviceList'][1],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['theInterngramService']['serviceList'][2],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['theInterngramService']['serviceList'][3],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['theInterngramService']['serviceList'][4],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['theInterngramService']['serviceList'][5],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['theInterngramService']['serviceList'][6],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  terms['yourCommitment']['title'],
                  style: style.titleMedium?.copyWith(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  terms['yourCommitment']['firstParagraph'],
                  style:
                      style.titleSmall?.copyWith(color: CustomPalette.black65),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['yourCommitment']['commitmentFirstList'][0],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('•'),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-36, 0),
                  child: Text(
                    terms['yourCommitment']['commitmentFirstList'][1],
                    style: style.titleSmall
                        ?.copyWith(color: CustomPalette.black65),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('•'),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-36, 0),
                  child: Text(
                    terms['yourCommitment']['commitmentFirstList'][2],
                    style: style.titleSmall
                        ?.copyWith(color: CustomPalette.black65),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('•'),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-36, 0),
                  child: Text(
                    terms['yourCommitment']['commitmentFirstList'][3],
                    style: style.titleSmall
                        ?.copyWith(color: CustomPalette.black65),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  terms['yourCommitment']['secondParagraph'],
                  style:
                      style.titleSmall?.copyWith(color: CustomPalette.black65),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['yourCommitment']['commitmentSecondList'][0],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['yourCommitment']['commitmentSecondList'][1],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['yourCommitment']['commitmentSecondList'][2],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['yourCommitment']['commitmentSecondList'][3],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['yourCommitment']['commitmentSecondList'][4],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['yourCommitment']['commitmentSecondList'][5],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['yourCommitment']['commitmentSecondList'][6],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['yourCommitment']['commitmentSecondList'][7],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('•'),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-36, 0),
                  child: Text(
                    terms['yourCommitment']['commitmentSecondList'][8],
                    style: style.titleSmall
                        ?.copyWith(color: CustomPalette.black65),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  terms['permisions']['title'],
                  style: style.titleMedium?.copyWith(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  terms['permisions']['firstParagraph'],
                  style:
                      style.titleSmall?.copyWith(color: CustomPalette.black65),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['permisions']['permisionsList'][0],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['permisions']['permisionsList'][1],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('•'),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-36, 0),
                  child: Text(
                    terms['permisions']['permisionsList'][2],
                    style: style.titleSmall
                        ?.copyWith(color: CustomPalette.black65),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  terms['additionalRights']['title'],
                  style: style.titleMedium?.copyWith(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['additionalRights']['rightsList'][0],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['additionalRights']['rightsList'][1],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['additionalRights']['rightsList'][2],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  terms['contentAndAccount']['title'],
                  style: style.titleMedium?.copyWith(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['contentAndAccount']['contentAndAccountList'][0],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['contentAndAccount']['contentAndAccountList'][1],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16.0),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['contentAndAccount']['contentAndAccountList'][2][0],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16.0),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['contentAndAccount']['contentAndAccountList'][2][1],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['contentAndAccount']['contentAndAccountList'][2][2],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['contentAndAccount']['contentAndAccountList'][2][3]
                          [0],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['contentAndAccount']['contentAndAccountList'][2][3]
                          [1],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['contentAndAccount']['contentAndAccountList'][2][3]
                          [2],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['contentAndAccount']['contentAndAccountList'][2][3]
                          [3],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['contentAndAccount']['contentAndAccountList'][2][4],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('•'),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-36, 0),
                  child: Text(
                    terms['contentAndAccount']['contentAndAccountList'][3],
                    style: style.titleSmall
                        ?.copyWith(color: CustomPalette.black65),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  terms['agreement']['title'],
                  style: style.titleMedium?.copyWith(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  terms['agreement']['firstParagraph'],
                  style:
                      style.titleSmall?.copyWith(color: CustomPalette.black65),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['agreement']['agreementList'][0],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('•'),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-36, 0),
                  child: Text(
                    terms['agreement']['agreementList'][1],
                    style: style.titleSmall
                        ?.copyWith(color: CustomPalette.black65),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('•'),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-36, 0),
                  child: Text(
                    terms['agreement']['agreementList'][2],
                    style: style.titleSmall
                        ?.copyWith(color: CustomPalette.black65),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  terms['rightsOfAgreement']['title'],
                  style: style.titleMedium?.copyWith(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['rightsOfAgreement']['rightsOfAgreementList'][0],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('•'),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-36, 0),
                  child: Text(
                    terms['rightsOfAgreement']['rightsOfAgreementList'][1],
                    style: style.titleSmall
                        ?.copyWith(color: CustomPalette.black65),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('•'),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-36, 0),
                  child: Text(
                    terms['rightsOfAgreement']['rightsOfAgreementList'][2],
                    style: style.titleSmall
                        ?.copyWith(color: CustomPalette.black65),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  terms['responsibility']['title'],
                  style: style.titleMedium?.copyWith(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ListTile(
                  leading: const Text('•'),
                  contentPadding: const EdgeInsets.all(0),
                  title: Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Text(
                      terms['responsibility']['responsibilityList'][0],
                      style: style.titleSmall
                          ?.copyWith(color: CustomPalette.black65)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('•'),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-36, 0),
                  child: Text(
                    terms['responsibility']['responsibilityList'][1],
                    style: style.titleSmall
                        ?.copyWith(color: CustomPalette.black65),
                  ),
                ),
              ),
              ListTile(
                leading: const Text('•'),
                contentPadding: const EdgeInsets.all(0),
                title: Transform.translate(
                  offset: const Offset(-36, 0),
                  child: Text(
                    terms['responsibility']['responsibilityList'][2],
                    style: style.titleSmall
                        ?.copyWith(color: CustomPalette.black65),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  terms['handleDisputes']['title'],
                  style: style.titleMedium?.copyWith(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  terms['handleDisputes']['firstParagraph'],
                  style:
                      style.titleSmall?.copyWith(color: CustomPalette.black65),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  terms['unsolicitedMaterial']['title'],
                  style: style.titleMedium?.copyWith(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  terms['unsolicitedMaterial']['firstParagraph'],
                  style:
                      style.titleSmall?.copyWith(color: CustomPalette.black65),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  terms['updatingTerms']['title'],
                  style: style.titleMedium?.copyWith(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  terms['updatingTerms']['firstParagraph'],
                  style:
                      style.titleSmall?.copyWith(color: CustomPalette.black65),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  terms['bottomText'],
                  style:
                      style.titleSmall?.copyWith(color: CustomPalette.black65),
                ),
              ),
              const SizedBox(height: 96),
            ],
          ),
        ),
      ),
    );
  }
}
