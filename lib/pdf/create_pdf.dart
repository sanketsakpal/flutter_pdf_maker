import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neodocs/model/result_model.dart';
import 'package:neodocs/pdf/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class CreatePdfApi {
  static Future<File> generate(ResultModel resultModel) async {
    final theme = ThemeData.withFont(
      base: Font.ttf(await rootBundle.load("assets/fonts/Rubik-Regular.ttf")),
      bold: Font.ttf(await rootBundle.load("assets/fonts/Rubik-Regular.ttf")),
    );
    final pdf = Document(theme: theme);
    const String svgRaw = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 138.67 33.771"><g id="Layer_2" data-name="Layer 2"><g id="Layer_1-2" data-name="Layer 1"><path d="M133.852,4.113h-.913V3.64h2.34v.473h-.913V6.49h-.514Z" fill="#fff"/><path d="M135.758,3.64h.518l.938,1.738.941-1.738h.515V6.49h-.515v-1.9l-.941,1.738-.938-1.738v1.9h-.518Z" fill="#fff"/><path d="M24.772,14.11a2.745,2.745,0,1,1-1.941.8,2.726,2.726,0,0,1,1.941-.8m0-1.177a3.922,3.922,0,1,0,2.772,1.149,3.908,3.908,0,0,0-2.772-1.149ZM16.9,20.651a13.4,13.4,0,0,0,1.471,1.685c.088.088.178.172.3.278.057.05.115.1.173.158a2.746,2.746,0,1,1-3.888.006c.064-.063.122-.114.2-.187s.184-.167.272-.255A13.4,13.4,0,0,0,16.9,20.651m0-3.793c0,2.02-.762,3.105-2.3,4.646-.071.072-.145.14-.221.207s-.16.141-.249.229a3.919,3.919,0,1,0,5.546,0c-.089-.088-.169-.158-.249-.229s-.15-.135-.221-.207c-1.541-1.541-2.3-2.626-2.3-4.646Zm0-10.6a2.739,2.739,0,0,1,1.947,4.672c-.063.062-.121.113-.2.187s-.184.166-.272.255A13.391,13.391,0,0,0,16.9,13.052a13.462,13.462,0,0,0-1.471-1.684c-.088-.089-.178-.172-.3-.279-.057-.05-.115-.1-.172-.158A2.74,2.74,0,0,1,16.9,6.254m0-1.176a3.916,3.916,0,0,0-2.773,6.685c.089.088.169.158.249.229s.15.136.221.208c1.541,1.54,2.3,2.625,2.3,4.645,0-2.02.762-3.1,2.3-4.645.071-.072.145-.14.221-.208s.16-.141.249-.229A3.916,3.916,0,0,0,16.9,5.078Zm-.015-3.9A7.787,7.787,0,0,1,22.4,3.464l7.9,7.9a7.809,7.809,0,0,1,0,11.044l-7.9,7.9a7.811,7.811,0,0,1-11.045,0l-7.9-7.9a7.811,7.811,0,0,1,0-11.044l7.9-7.9a7.786,7.786,0,0,1,5.522-2.288m0-1.176a8.926,8.926,0,0,0-6.353,2.632l-7.9,7.9a9,9,0,0,0,0,12.708l7.9,7.9a8.984,8.984,0,0,0,12.707,0l7.9-7.9a8.986,8.986,0,0,0,0-12.708l-7.9-7.9A8.926,8.926,0,0,0,16.881,0ZM9.021,14.11a2.745,2.745,0,1,1-1.941.8,2.724,2.724,0,0,1,1.941-.8m0-1.177a3.922,3.922,0,1,0,2.773,1.149,3.906,3.906,0,0,0-2.773-1.149Z" fill="#28bdbf"/><path d="M38,24.294h.716l2.34,4.395,2.34-4.395h.716v6.3H43.4V25.836l-2.34,4.4-2.34-4.4V30.6H38Z" fill="#8e9098"/><path d="M49.1,29.414l.422.45a2.833,2.833,0,0,1-1.909.734,2.439,2.439,0,0,1-2.4-2.5,2.386,2.386,0,0,1,2.34-2.469c1.431,0,2.248,1.083,2.248,2.745H45.916a1.685,1.685,0,0,0,1.689,1.605A2.225,2.225,0,0,0,49.1,29.414Zm-3.176-1.651h3.194a1.516,1.516,0,0,0-1.542-1.515A1.66,1.66,0,0,0,45.925,27.763Z" fill="#8e9098"/><path d="M54.577,27.6v2.89h-.688v-.743a1.983,1.983,0,0,1-1.67.853,1.551,1.551,0,0,1-1.735-1.514,1.7,1.7,0,0,1,1.863-1.579,5.181,5.181,0,0,1,1.542.267V27.6A1.211,1.211,0,0,0,52.6,26.221a3.176,3.176,0,0,0-1.385.431l-.276-.56a3.847,3.847,0,0,1,1.707-.459A1.785,1.785,0,0,1,54.577,27.6ZM53.889,29v-.725a5.371,5.371,0,0,0-1.432-.193c-.706,0-1.3.4-1.3.973,0,.587.514.936,1.184.936A1.56,1.56,0,0,0,53.889,29Z" fill="#8e9098"/><path d="M55.493,29.892l.358-.5a2.746,2.746,0,0,0,1.606.6c.624,0,1.046-.293,1.046-.743,0-.514-.55-.679-1.193-.862-1.147-.331-1.587-.67-1.587-1.35a1.471,1.471,0,0,1,1.66-1.395,3.169,3.169,0,0,1,1.7.533l-.33.532a2.588,2.588,0,0,0-1.368-.45c-.532,0-.972.239-.972.7,0,.413.349.542,1.229.826.762.238,1.551.5,1.551,1.4,0,.872-.752,1.431-1.734,1.431A3.227,3.227,0,0,1,55.493,29.892Z" fill="#8e9098"/><path d="M64.154,25.743v4.745h-.688v-.762a1.8,1.8,0,0,1-1.56.872,1.735,1.735,0,0,1-1.78-1.835v-3.02h.688v2.928A1.2,1.2,0,0,0,62,29.983a1.379,1.379,0,0,0,1.468-1.22v-3.02Z" fill="#8e9098"/><path d="M67.942,25.743v.615a1.658,1.658,0,0,0-1.835,1.588V30.6h-.688V25.854h.688v.927A1.911,1.911,0,0,1,67.942,25.743Z" fill="#8e9098"/><path d="M72.328,29.414l.422.45a2.833,2.833,0,0,1-1.909.734,2.439,2.439,0,0,1-2.4-2.5,2.386,2.386,0,0,1,2.34-2.469c1.431,0,2.248,1.083,2.248,2.745H69.143a1.685,1.685,0,0,0,1.689,1.605A2.225,2.225,0,0,0,72.328,29.414Zm-3.176-1.651h3.194A1.516,1.516,0,0,0,70.8,26.248,1.66,1.66,0,0,0,69.152,27.763Z" fill="#8e9098"/><path d="M76.05,24.294h.808L78.6,29.4l1.67-5.1h.8l1.67,5.1,1.744-5.1h.807l-2.156,6.3h-.707L80.675,25.23,78.913,30.6h-.706Z" fill="#8e9098"/><path d="M90.161,27.579V30.6h-.689V27.671a1.2,1.2,0,0,0-1.184-1.313,1.379,1.379,0,0,0-1.468,1.221V30.6h-.688V24.184h.688v2.432a1.8,1.8,0,0,1,1.56-.873A1.736,1.736,0,0,1,90.161,27.579Z" fill="#8e9098"/><path d="M95.205,27.6v2.89h-.688v-.743a1.983,1.983,0,0,1-1.67.853,1.55,1.55,0,0,1-1.734-1.514,1.7,1.7,0,0,1,1.862-1.579,5.175,5.175,0,0,1,1.542.267V27.6a1.211,1.211,0,0,0-1.285-1.377,3.176,3.176,0,0,0-1.385.431l-.276-.56a3.847,3.847,0,0,1,1.708-.459A1.784,1.784,0,0,1,95.205,27.6ZM94.517,29v-.725a5.364,5.364,0,0,0-1.431-.193c-.707,0-1.3.4-1.3.973,0,.587.514.936,1.184.936A1.56,1.56,0,0,0,94.517,29Z" fill="#8e9098"/><path d="M98.828,30.3a1.442,1.442,0,0,1-.88.3,1.139,1.139,0,0,1-1.157-1.211V26.358h-.743v-.615h.743v-1.3h.689v1.3h1.165v.615H97.48v3.029a.552.552,0,0,0,.514.6.682.682,0,0,0,.5-.192Z" fill="#8e9098"/><path d="M102.222,24.294h.716l2.34,4.395,2.34-4.395h.716v6.3h-.716V25.836l-2.34,4.4-2.34-4.4V30.6h-.716Z" fill="#8e9098"/><path d="M113.543,27.6v2.89h-.688v-.743a1.986,1.986,0,0,1-1.671.853,1.55,1.55,0,0,1-1.734-1.514,1.7,1.7,0,0,1,1.863-1.579,5.186,5.186,0,0,1,1.542.267V27.6a1.212,1.212,0,0,0-1.285-1.377,3.18,3.18,0,0,0-1.386.431l-.275-.56a3.844,3.844,0,0,1,1.707-.459A1.785,1.785,0,0,1,113.543,27.6Zm-.688,1.4v-.725a5.377,5.377,0,0,0-1.432-.193c-.707,0-1.3.4-1.3.973,0,.587.514.936,1.183.936A1.561,1.561,0,0,0,112.855,29Z" fill="#8e9098"/><path d="M117.166,30.3a1.447,1.447,0,0,1-.881.3,1.138,1.138,0,0,1-1.156-1.211V26.358h-.744v-.615h.744v-1.3h.688v1.3h1.165v.615h-1.165v3.029a.552.552,0,0,0,.514.6.682.682,0,0,0,.495-.192Z" fill="#8e9098"/><path d="M120.358,30.3a1.445,1.445,0,0,1-.881.3,1.138,1.138,0,0,1-1.156-1.211V26.358h-.744v-.615h.744v-1.3h.688v1.3h1.166v.615h-1.166v3.029a.553.553,0,0,0,.514.6.68.68,0,0,0,.5-.192Z" fill="#8e9098"/><path d="M124.762,29.414l.422.45a2.833,2.833,0,0,1-1.909.734,2.439,2.439,0,0,1-2.4-2.5,2.386,2.386,0,0,1,2.34-2.469c1.431,0,2.248,1.083,2.248,2.745h-3.882a1.685,1.685,0,0,0,1.689,1.605A2.225,2.225,0,0,0,124.762,29.414Zm-3.176-1.651h3.194a1.516,1.516,0,0,0-1.542-1.515A1.66,1.66,0,0,0,121.586,27.763Z" fill="#8e9098"/><path d="M128.972,25.743v.615a1.658,1.658,0,0,0-1.835,1.588V30.6h-.688V25.854h.688v.927A1.911,1.911,0,0,1,128.972,25.743Z" fill="#8e9098"/><path d="M129.255,29.892l.358-.5a2.743,2.743,0,0,0,1.606.6c.624,0,1.046-.293,1.046-.743,0-.514-.55-.679-1.193-.862-1.147-.331-1.587-.67-1.587-1.35a1.471,1.471,0,0,1,1.66-1.395,3.171,3.171,0,0,1,1.7.533l-.33.532a2.588,2.588,0,0,0-1.368-.45c-.532,0-.972.239-.972.7,0,.413.349.542,1.229.826.762.238,1.551.5,1.551,1.4,0,.872-.752,1.431-1.734,1.431A3.227,3.227,0,0,1,129.255,29.892Z" fill="#8e9098"/><polygon points="50.305 20.035 40.307 6.91 40.307 20.035 37.988 20.035 37.988 3.173 40.237 3.173 50.235 16.323 50.235 3.173 52.554 3.173 52.554 20.035 50.305 20.035" fill="#fff"/><path d="M60.608,20.035a6.253,6.253,0,0,1-5.594-3.273,7.072,7.072,0,0,1-.846-3.474A7.331,7.331,0,0,1,54.987,9.8a6.3,6.3,0,0,1,2.257-2.426,6.064,6.064,0,0,1,3.237-.888,5.861,5.861,0,0,1,3.226.852,5.084,5.084,0,0,1,1.968,2.489,9.508,9.508,0,0,1,.506,3.975l-.007.131H56.5a5.1,5.1,0,0,0,.652,1.985,3.9,3.9,0,0,0,1.43,1.418,4.035,4.035,0,0,0,2.023.5,3.465,3.465,0,0,0,2.125-.648,3.258,3.258,0,0,0,1.187-1.7l.03-.1h2.18l-.027.161a5.4,5.4,0,0,1-.929,2.291,5.152,5.152,0,0,1-1.888,1.6A5.9,5.9,0,0,1,60.608,20.035ZM63.8,11.823a3.335,3.335,0,0,0-1.028-2.309,3.251,3.251,0,0,0-2.216-.833,3.82,3.82,0,0,0-2.564.885,4.308,4.308,0,0,0-1.343,2.257Z" fill="#fff"/><path d="M73.856,20.035a6.382,6.382,0,0,1-3.129-.808,6.225,6.225,0,0,1-2.362-2.335,6.992,6.992,0,0,1-.9-3.6,7,7,0,0,1,.9-3.6,6.415,6.415,0,0,1,2.359-2.359,6.239,6.239,0,0,1,3.132-.835,6.161,6.161,0,0,1,3.117.835,6.362,6.362,0,0,1,2.335,2.359,7.09,7.09,0,0,1,.886,3.6,7.081,7.081,0,0,1-.886,3.6,6.171,6.171,0,0,1-2.336,2.336A6.314,6.314,0,0,1,73.856,20.035Zm0-11.354a3.894,3.894,0,0,0-1.96.53,4.143,4.143,0,0,0-1.519,1.557,4.993,4.993,0,0,0-.593,2.52,5.024,5.024,0,0,0,.581,2.5,3.939,3.939,0,0,0,1.516,1.542,4.044,4.044,0,0,0,1.975.518,3.9,3.9,0,0,0,1.947-.517,4,4,0,0,0,1.491-1.543,5.018,5.018,0,0,0,.581-2.5,5.021,5.021,0,0,0-.581-2.5A4.186,4.186,0,0,0,75.8,9.223,3.755,3.755,0,0,0,73.856,8.681Z" fill="#fff"/><path d="M81.439,20.035V3.173h5.523a11.976,11.976,0,0,1,4.246.66A7,7,0,0,1,93.98,5.669a7.24,7.24,0,0,1,1.509,2.68,10.747,10.747,0,0,1,.465,3.178,10.418,10.418,0,0,1-.492,3.207A7.235,7.235,0,0,1,91.1,19.349a11.13,11.13,0,0,1-4.133.686Zm5.523-2.191a8.438,8.438,0,0,0,3.275-.55,5.222,5.222,0,0,0,2.027-1.453,5.5,5.5,0,0,0,1.058-2.029,8.542,8.542,0,0,0,.313-2.285,8.271,8.271,0,0,0-.313-2.258,5.28,5.28,0,0,0-1.057-1.977,5.15,5.15,0,0,0-2.026-1.4,8.792,8.792,0,0,0-3.277-.526h-3.2v12.48Z" fill="#28bdbf"/><path d="M103.219,20.035a6.388,6.388,0,0,1-3.129-.808,6.222,6.222,0,0,1-2.361-2.335,6.992,6.992,0,0,1-.9-3.6,7,7,0,0,1,.9-3.6,6.415,6.415,0,0,1,2.359-2.359,6.238,6.238,0,0,1,3.131-.835,6.161,6.161,0,0,1,3.118.835,6.352,6.352,0,0,1,2.334,2.359,7.08,7.08,0,0,1,.887,3.6,7.071,7.071,0,0,1-.887,3.6,6.168,6.168,0,0,1-2.335,2.336A6.315,6.315,0,0,1,103.219,20.035Zm0-11.354a3.89,3.89,0,0,0-1.959.53,4.143,4.143,0,0,0-1.519,1.557,4.993,4.993,0,0,0-.593,2.52,5.024,5.024,0,0,0,.581,2.5,3.933,3.933,0,0,0,1.516,1.542,4.043,4.043,0,0,0,1.974.518,3.9,3.9,0,0,0,1.948-.517,4,4,0,0,0,1.491-1.543,5.018,5.018,0,0,0,.581-2.5,5.021,5.021,0,0,0-.581-2.5,4.194,4.194,0,0,0-1.494-1.569A3.759,3.759,0,0,0,103.219,8.681Z" fill="#28bdbf"/><path d="M116.823,20.035a6.388,6.388,0,0,1-3.129-.808,6.222,6.222,0,0,1-2.361-2.335,6.992,6.992,0,0,1-.9-3.6,7,7,0,0,1,.9-3.6,6.415,6.415,0,0,1,2.359-2.359,6.236,6.236,0,0,1,3.131-.835,6.155,6.155,0,0,1,2.754.627,5.721,5.721,0,0,1,3.175,4.52l.021.157h-2.124l-.029-.1a4.271,4.271,0,0,0-1.458-2.214,3.742,3.742,0,0,0-2.339-.8,3.953,3.953,0,0,0-2,.543,4.028,4.028,0,0,0-1.5,1.567,5.111,5.111,0,0,0-.569,2.5,5.045,5.045,0,0,0,.569,2.471,3.907,3.907,0,0,0,3.5,2.085,3.682,3.682,0,0,0,2.449-.8,4.522,4.522,0,0,0,1.373-2.242l.03-.1h2.095l-.017.154a5.748,5.748,0,0,1-1.034,2.784,5.622,5.622,0,0,1-2.132,1.778A6.339,6.339,0,0,1,116.823,20.035Z" fill="#28bdbf"/><path d="M128.513,20.035a6.477,6.477,0,0,1-2.177-.326,4.634,4.634,0,0,1-1.512-.87,4.3,4.3,0,0,1-.936-1.147,4.012,4.012,0,0,1-.435-1.189,3.234,3.234,0,0,1-.052-.988l.016-.12h2.138l.009.129a2.419,2.419,0,0,0,.785,1.694,3.009,3.009,0,0,0,2.088.652,3.215,3.215,0,0,0,1.307-.217,1.443,1.443,0,0,0,.666-.569,1.6,1.6,0,0,0,.21-.81,1.262,1.262,0,0,0-.26-.842,2.151,2.151,0,0,0-.743-.538,10.012,10.012,0,0,0-1.12-.428c-.5-.189-1.008-.39-1.529-.6a8.685,8.685,0,0,1-1.478-.778,3.749,3.749,0,0,1-1.126-1.139,3.053,3.053,0,0,1-.429-1.643,3.615,3.615,0,0,1,.319-1.5,3.54,3.54,0,0,1,.916-1.221,4.4,4.4,0,0,1,1.395-.8,5.2,5.2,0,0,1,1.77-.289,4.394,4.394,0,0,1,2.226.529,3.56,3.56,0,0,1,1.406,1.5,5.108,5.108,0,0,1,.513,2.216l0,.142h-2.02l-.018-.118a2.744,2.744,0,0,0-.686-1.592,2.065,2.065,0,0,0-1.474-.485,2.361,2.361,0,0,0-1.52.428,1.36,1.36,0,0,0-.51,1.118,1.06,1.06,0,0,0,.362.828,3.938,3.938,0,0,0,1.024.64q.646.293,1.386.6t1.432.613a6.336,6.336,0,0,1,1.253.731,3.22,3.22,0,0,1,.893,1.053,3.317,3.317,0,0,1,.335,1.558,3.764,3.764,0,0,1-.518,1.972,3.462,3.462,0,0,1-1.512,1.342A5.527,5.527,0,0,1,128.513,20.035Z" fill="#28bdbf"/></g></g></svg>
''';

// use this for google fonts

// final ttf = await PdfGoogleFonts.abelRegular();

    pdf.addPage(
      MultiPage(
        margin: EdgeInsets.zero,
        pageFormat: PdfPageFormat.a3,
        header: (context) => Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          height: 100.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                PdfColor.fromHex('#131847'),
                PdfColor.fromHex('#000749'),
                PdfColor.fromHex('#6C61F2'),
              ],
              begin: Alignment.centerRight,
              end: const Alignment(-1.5, 0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgImage(svg: svgRaw),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Test Report",
                  style: TextStyle(
                    color: PdfColors.white,
                    fontWeight: FontWeight.bold,
                    fontFallback: [Font.helvetica(), Font.courier()],
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        build: (context) => [
          SizedBox(height: 20.h),
          buildPatientInfo(resultModel),
          SizedBox(height: 20.h),
          Divider(),
          SizedBox(height: 20.h),
          buildTitleName(resultModel),
          SizedBox(height: 20.h),
          buildExaminationName(resultModel),
          SizedBox(height: 20.h),
          buildTable(resultModel),
        ],
        footer: (context) => Column(
          children: [
            buildNote(resultModel),
            SizedBox(height: 20.h),
            Divider(),
            SizedBox(height: 10.h),
            buildFooter(resultModel),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );

    return PdfApi().saveDocument(name: 'Wellness.pdf', pdf: pdf);
  }

  Widget buildTitle(ResultModel resultModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NeoDocs',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              fontFallback: [Font.helvetica(), Font.courier()],
            ),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(resultModel.dateOfBirth!),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildPatientInfo(ResultModel resultModel) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name:",
                          style: TextStyle(
                            color: PdfColors.black,
                            fontWeight: FontWeight.bold,
                            fontFallback: [Font.helvetica(), Font.courier()],
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          "Age:",
                          style: TextStyle(
                            color: PdfColors.black,
                            fontWeight: FontWeight.bold,
                            fontFallback: [Font.helvetica(), Font.courier()],
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          "Gender:",
                          style: TextStyle(
                            color: PdfColors.black,
                            fontWeight: FontWeight.bold,
                            fontFallback: [Font.helvetica(), Font.courier()],
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          "Reference:",
                          style: TextStyle(
                            color: PdfColors.black,
                            fontWeight: FontWeight.bold,
                            fontFallback: [Font.helvetica(), Font.courier()],
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Avinash joshi",
                          style: TextStyle(
                            color: PdfColors.black,
                            fontFallback: [Font.helvetica(), Font.courier()],
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          "34 , years",
                          style: TextStyle(
                            color: PdfColors.black,
                            fontFallback: [Font.helvetica(), Font.courier()],
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          "MALE",
                          style: TextStyle(
                            color: PdfColors.black,
                            fontFallback: [Font.helvetica(), Font.courier()],
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          "Self",
                          style: TextStyle(
                            color: PdfColors.black,
                            fontFallback: [Font.helvetica(), Font.courier()],
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 36.w),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Report ID:",
                      style: TextStyle(
                        color: PdfColors.black,
                        fontWeight: FontWeight.bold,
                        fontFallback: [Font.helvetica(), Font.courier()],
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "Sample type:",
                      style: TextStyle(
                        color: PdfColors.black,
                        fontWeight: FontWeight.bold,
                        fontFallback: [Font.helvetica(), Font.courier()],
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "Sample collected on:",
                      style: TextStyle(
                        color: PdfColors.black,
                        fontWeight: FontWeight.bold,
                        fontFallback: [Font.helvetica(), Font.courier()],
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "Report generated on :",
                      style: TextStyle(
                        color: PdfColors.black,
                        fontWeight: FontWeight.bold,
                        fontFallback: [Font.helvetica(), Font.courier()],
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "dfdsfs",
                      style: TextStyle(
                        color: PdfColors.black,
                        fontFallback: [Font.helvetica(), Font.courier()],
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "Urine",
                      style: TextStyle(
                        color: PdfColors.black,
                        fontFallback: [Font.helvetica(), Font.courier()],
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "30/06/023 , 11:47:21 AM",
                      style: TextStyle(
                        color: PdfColors.black,
                        fontFallback: [Font.helvetica(), Font.courier()],
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "30/06/023 , 11:47:21 AM",
                      style: TextStyle(
                        color: PdfColors.black,
                        fontFallback: [Font.helvetica(), Font.courier()],
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  static Widget buildFooter(ResultModel resultModel) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Row(
          children: [
            Text(
              "Download the\nNeodocs App",
              style: TextStyle(
                fontFallback: [Font.helvetica(), Font.courier()],
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Container(
              height: 50,
              width: 50,
              child: BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: "https://play.google.com/store/search?q=neodocs&c=apps",
              ),
            ),
          ],
        ),
      );

  static Widget buildTitleName(ResultModel resultModel) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Wellness Test Report",
            style: TextStyle(
              color: PdfColors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              fontFallback: [Font.helvetica(), Font.courier()],
            ),
          ),
        ],
      );

  static Widget buildExaminationName(ResultModel resultModel) => Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Urine Examination",
                  style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    fontFallback: [Font.helvetica(), Font.courier()],
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "CHEMICAL EXAMINATION",
                  style: TextStyle(
                    color: PdfColors.grey400,
                    fontFallback: [Font.helvetica(), Font.courier()],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  static Widget buildTable(ResultModel resultModel) {
    final headers = [
      'Investigation',
      'Observed Value',
      'Unit',
      'Reference Range',
    ];
    final data =
        resultModel.panels?.wellness?.details?.biomarkerDetails?.map((e) {
      e.toString();

      return [
        e.displayName,
        e.referenceRange,
        e.dateOfTest,
        e.displayValue,
      ];
    }).toList();

    return TableHelper.fromTextArray(
      cellPadding: EdgeInsets.symmetric(horizontal: 16.w),
      headers: headers,
      data: data ?? [],
      border: TableBorder.all(width: 0.1, color: PdfColors.grey300),
      headerStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontFallback: [Font.helvetica(), Font.courier()],
        fontSize: 16.sp,
      ),
      cellHeight: 30.h,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.centerLeft,
        4: Alignment.centerLeft,
        5: Alignment.centerLeft,
      },
    );
  }

  static Widget buildNote(ResultModel resultModel) => Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Note",
              style: TextStyle(
                color: PdfColors.black,
                fontFallback: [Font.helvetica(), Font.courier()],
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            ListView.builder(
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      width: 5.w,
                      height: 5.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: PdfColors.black,
                      ),
                    ),
                    SizedBox(width: 6.h),
                    Text(
                      "the urine routine is a screening test",
                      style: TextStyle(
                        fontFallback: [Font.helvetica(), Font.courier()],
                        color: PdfColors.grey400,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                );
              },
              itemCount: 5,
            ),
          ],
        ),
      );
}
