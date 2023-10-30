// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neodocs/model/result_model.dart';
import 'package:neodocs/pdf/create_pdf.dart';
import 'package:neodocs/pdf/pdf_api.dart';
import 'package:neodocs/widgets/common_button.dart';

import 'package:pdf/widgets.dart' as pw;

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  ResultModel resultModel = ResultModel();
  final pdf = pw.Document();
  @override
  void initState() {
    super.initState();
    getData();
  }

// Fetch content from the json file
  Future<ResultModel> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/example.json');
    final data = await json.decode(response) as Map<String, dynamic>;
    return ResultModel.fromJson(data);
  }

// adding Data into model

  Future<void> getData() async {
    resultModel = await readJson();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF131847),
                        Color(0xFF000749),
                        Color(0xFF6C61F2),
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment(-1.4, 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 40.h,
                              horizontal: 14.w,
                            ),
                            child: Container(
                              height: 45.h,
                              width: 45.w,
                              decoration: ShapeDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            'Test Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              height: 0.07,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset(
                            "assets/images/wellness.svg",
                            height: 40.h,
                            width: 42.w,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PATIENT DETAILS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontFamily: 'Metropolis',
                                  fontWeight: FontWeight.w500,
                                  height: 0.09,
                                ),
                              ),
                              SizedBox(
                                height: 22.h,
                              ),
                              Text(
                                'Testo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontFamily: 'Metropolis',
                                  // fontWeight: FontWeight.w700,
                                  height: 0.05,
                                ),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              Text(
                                'MALE, 25 years',
                                style: TextStyle(
                                  color: const Color(0xFFDEDEDE),
                                  fontSize: 20.sp,
                                  fontFamily: 'Metropolis',
                                  fontWeight: FontWeight.w500,
                                  height: 0.06,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Buttons(
                              buttonName: ' Share ',
                              buttonIconImage: "assets/images/share.svg",
                              onTap: () async {
                                final pdfFile =
                                    await CreatePdfApi.generate(resultModel);
                                PdfApi.openFile(pdfFile);
                              },
                            ),
                            Buttons(
                              buttonName: ' Download ',
                              buttonIconImage: "assets/images/download.svg",
                              onTap: () async {},
                            ),
                            Buttons(
                              buttonName: ' Print ',
                              buttonIconImage: "assets/images/print.svg",
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.w,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFF2F8FF),
                              Color(
                                0xFFC2CADA,
                              ),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 60.w,
                              ),
                              Text(
                                'Parameters',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(
                                height: 14.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFF2F8FF),
                              Color(
                                0xFFC2CADA,
                              ),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 400.h,
                                child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: resultModel.panels?.wellness
                                      ?.details?.biomarkerDetails?.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.9,
                                    crossAxisSpacing: 14,
                                  ),
                                  itemBuilder: (context, index) {
                                    final resultData = resultModel
                                        .panels
                                        ?.wellness
                                        ?.details
                                        ?.biomarkerDetails?[index];
                                    return Container(
                                      width: 172.w,
                                      height: 57.h,
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  child: Text(
                                                    resultData?.displayName ??
                                                        "",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13.sp,
                                                      fontFamily: 'Manrope',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                  resultData
                                                          ?.userValueFlagText ??
                                                      "",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF56D6B7),
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  resultData?.estimatedValue
                                                          .toString() ??
                                                      "",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFFEFBF71),
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                  resultData?.unit ?? "",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w400,
                                                    height: 0.11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 15.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 260.h,
            child: Container(
              width: 331.w,
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.85),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 12.w,
                  right: 24.w,
                  top: 14.h,
                  bottom: 10.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TEST TAKEN',
                          style: TextStyle(
                            color: const Color(0xFF000749),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Saturday,\n8th April, 2022',
                          style: TextStyle(
                            color: const Color(0xFF000749),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RESULTS STATUS',
                          style: TextStyle(
                            color: const Color(0xFF000749),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Verified',
                              style: TextStyle(
                                color: const Color(0xFF000749),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            SvgPicture.asset(
                              "assets/images/tick.svg",
                              height: 14.h,
                              width: 14.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
