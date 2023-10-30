class ResultModel {
  int? statusCode;
  String? testId;
  int? captureTime;
  String? uId;
  bool? processedFlag;
  bool? isComplete;
  String? firstName;
  String? lastName;
  String? gender;
  String? dateOfBirth;
  String? kitType;
  Panels? panels;

  ResultModel({
    this.statusCode,
    this.testId,
    this.captureTime,
    this.uId,
    this.processedFlag,
    this.isComplete,
    this.firstName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.kitType,
    this.panels,
  });

  ResultModel.fromJson(Map<String, dynamic> json) {
    statusCode = json["status_code"] as int?;
    testId = json["testId"] as String?;
    captureTime = json["captureTime"] as int?;
    uId = json["uId"] as String?;
    processedFlag = json["processed_flag"] as bool?;
    isComplete = json["isComplete"] as bool?;
    firstName = json["firstName"] as String?;
    lastName = json["lastName"] as String?;
    gender = json["gender"] as String?;
    dateOfBirth = json["dateOfBirth"] as String?;
    kitType = json["kit_type"] as String?;
    panels = json["panels"] == null
        ? null
        : Panels.fromJson(json["panels"] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status_code"] = statusCode;
    data["testId"] = testId;
    data["captureTime"] = captureTime;
    data["uId"] = uId;
    data["processed_flag"] = processedFlag;
    data["isComplete"] = isComplete;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["gender"] = gender;
    data["dateOfBirth"] = dateOfBirth;
    data["kit_type"] = kitType;
    if (panels != null) {
      data["panels"] = panels?.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ResultModel(statusCode: $statusCode, testId: $testId, captureTime: $captureTime, uId: $uId, processedFlag: $processedFlag, isComplete: $isComplete, firstName: $firstName, lastName: $lastName, gender: $gender, dateOfBirth: $dateOfBirth, kitType: $kitType, panels: $panels)';
  }
}

class Panels {
  Wellness? wellness;

  Panels({this.wellness});

  Panels.fromJson(Map<String, dynamic> json) {
    wellness = json["wellness"] == null
        ? null
        : Wellness.fromJson(json["wellness"] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wellness != null) {
      data["wellness"] = wellness?.toJson();
    }
    return data;
  }

  @override
  String toString() => 'Panels(wellness: $wellness)';
}

class Wellness {
  String? displayName;
  String? description;
  Insights? insights;
  String? status;
  String? hexcode;
  int? index;
  int? score;
  String? inactiveIcon;
  String? panelId;
  Details? details;
  List<String>? biomarkerName;
  List<dynamic>? science;
  String? inactiveIconDark;
  String? activeIcon;

  Wellness({
    this.displayName,
    this.description,
    this.insights,
    this.status,
    this.hexcode,
    this.index,
    this.score,
    this.inactiveIcon,
    this.panelId,
    this.details,
    this.biomarkerName,
    this.science,
    this.inactiveIconDark,
    this.activeIcon,
  });

  Wellness.fromJson(Map<String, dynamic> json) {
    displayName = json["display_name"] as String?;
    description = json["description"] as String?;
    insights = json["insights"] == null
        ? null
        : Insights.fromJson(json["insights"] as Map<String, dynamic>);
    status = json["status"] as String?;
    hexcode = json["hexcode"] as String?;
    index = json["index"] as int?;
    score = json["score"] as int?;
    inactiveIcon = json["inactive_icon"] as String?;
    panelId = json["panel_id"] as String?;
    details = json["details"] == null
        ? null
        : Details.fromJson(json["details"] as Map<String, dynamic>);
    biomarkerName = json["biomarker_name"] == null
        ? null
        : List<String>.from(json["biomarker_name"] as List);
    science = json["sceince"] as List;
    inactiveIconDark = json["inactive_icon_dark"] as String?;
    activeIcon = json["active_icon"] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["display_name"] = displayName;
    data["description"] = description;
    if (insights != null) {
      data["insights"] = insights?.toJson();
    }
    data["status"] = status;
    data["hexcode"] = hexcode;
    data["index"] = index;
    data["score"] = score;
    data["inactive_icon"] = inactiveIcon;
    data["panel_id"] = panelId;
    if (details != null) {
      data["details"] = details?.toJson();
    }
    if (biomarkerName != null) {
      data["biomarker_name"] = biomarkerName;
    }
    if (science != null) {
      data["sceince"] = science;
    }
    data["inactive_icon_dark"] = inactiveIconDark;
    data["active_icon"] = activeIcon;
    return data;
  }

  @override
  String toString() {
    return 'Wellness(displayName: $displayName, description: $description, insights: $insights, status: $status, hexcode: $hexcode, index: $index, score: $score, inactiveIcon: $inactiveIcon, panelId: $panelId, details: $details, biomarkerName: $biomarkerName, science: $science, inactiveIconDark: $inactiveIconDark, activeIcon: $activeIcon)';
  }
}

class Details {
  List<BiomarkerDetails>? biomarkerDetails;

  Details({this.biomarkerDetails});

  Details.fromJson(Map<String, dynamic> json) {
    biomarkerDetails = json["biomarker_details"] == null
        ? null
        : (json["biomarker_details"] as List)
            .map((e) => BiomarkerDetails.fromJson(e as Map<String, dynamic>))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (biomarkerDetails != null) {
      data["biomarker_details"] =
          biomarkerDetails?.map((e) => e.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => 'Details(biomarkerDetails: $biomarkerDetails)';
}

class BiomarkerDetails {
  Legend? legend;
  String? userValueFlagText;
  String? method;
  String? displayValue;
  String? unit;
  String? dateOfTest;
  int? index;
  int? userValueFlag;
  RefRanges? refRanges;
  String? referenceRange;
  String? displayName;
  num? estimatedValue;
  Insights1? insights;

  BiomarkerDetails({
    this.legend,
    this.userValueFlagText,
    this.method,
    this.displayValue,
    this.unit,
    this.dateOfTest,
    this.index,
    this.userValueFlag,
    this.refRanges,
    this.referenceRange,
    this.displayName,
    this.estimatedValue,
    this.insights,
  });

  BiomarkerDetails.fromJson(Map<String, dynamic> json) {
    legend = json["legend"] == null
        ? null
        : Legend.fromJson(json["legend"] as Map<String, dynamic>);
    userValueFlagText = json["user_value_flag_text"] as String?;
    method = json["method"] as String?;
    displayValue = json["display_value"] as String?;
    unit = json["unit"] as String?;
    dateOfTest = json["date_of_test"] as String?;
    index = json["index"] as int?;
    userValueFlag = json["user_value_flag"] as int?;
    refRanges = json["ref_ranges"] == null
        ? null
        : RefRanges.fromJson(json["ref_ranges"] as Map<String, dynamic>);
    referenceRange = json["reference_range"] as String?;
    displayName = json["display_name"] as String?;
    estimatedValue = json["estimated_value"] as num?;
    insights = json["insights"] == null
        ? null
        : Insights1.fromJson(json["insights"] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (legend != null) {
      data["legend"] = legend?.toJson();
    }
    data["user_value_flag_text"] = userValueFlagText;
    data["method"] = method;
    data["display_value"] = displayValue;
    data["unit"] = unit;
    data["date_of_test"] = dateOfTest;
    data["index"] = index;
    data["user_value_flag"] = userValueFlag;
    if (refRanges != null) {
      data["ref_ranges"] = refRanges?.toJson();
    }
    data["reference_range"] = referenceRange;
    data["display_name"] = displayName;
    data["estimated_value"] = estimatedValue;
    if (insights != null) {
      data["insights"] = insights?.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'BiomarkerDetails(legend: $legend, userValueFlagText: $userValueFlagText, method: $method, displayValue: $displayValue, unit: $unit, dateOfTest: $dateOfTest, index: $index, userValueFlag: $userValueFlag, refRanges: $refRanges, referenceRange: $referenceRange, displayName: $displayName, estimatedValue: $estimatedValue, insights: $insights)';
  }
}

class Insights1 {
  About? about;
  Tips? tips;
  Importance? importance;

  Insights1({this.about, this.tips, this.importance});

  Insights1.fromJson(Map<String, dynamic> json) {
    about = json["about"] == null
        ? null
        : About.fromJson(json["about"] as Map<String, dynamic>);
    tips = json["tips"] == null
        ? null
        : Tips.fromJson(json["tips"] as Map<String, dynamic>);
    importance = json["importance"] == null
        ? null
        : Importance.fromJson(json["importance"] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (about != null) {
      data["about"] = about?.toJson();
    }
    if (tips != null) {
      data["tips"] = tips?.toJson();
    }
    if (importance != null) {
      data["importance"] = importance?.toJson();
    }
    return data;
  }

  @override
  String toString() =>
      'Insights1(about: $about, tips: $tips, importance: $importance)';
}

class Importance {
  String? url;
  String? heading;
  List<String>? content;

  Importance({this.url, this.heading, this.content});

  Importance.fromJson(Map<String, dynamic> json) {
    url = json["url"] as String?;
    heading = json["heading"] as String?;
    content = json["content"] == null
        ? null
        : List<String>.from(json["content"] as List);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["url"] = url;
    data["heading"] = heading;
    if (content != null) {
      data["content"] = content;
    }
    return data;
  }

  @override
  String toString() =>
      'Importance(url: $url, heading: $heading, content: $content)';
}

class Tips {
  Tips();

  Tips.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}

class About {
  String? heading;
  List<String>? content;

  About({this.heading, this.content});

  About.fromJson(Map<String, dynamic> json) {
    heading = json["heading"] as String?;
    content = json["content"] == null
        ? null
        : List<String>.from(json["content"] as List);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["heading"] = heading;
    if (content != null) {
      data["content"] = content;
    }
    return data;
  }

  @override
  String toString() => 'About(heading: $heading, content: $content)';
}

class RefRanges {
  num? maxValue;
  num? minValue;
  num? ub;
  num? ubIdeal;
  num? lbIdeal;
  num? lb;

  RefRanges({
    this.maxValue,
    this.minValue,
    this.ub,
    this.ubIdeal,
    this.lbIdeal,
    this.lb,
  });

  RefRanges.fromJson(Map<String, dynamic> json) {
    maxValue = json["max_value"] as num?;
    minValue = json["min_value"] as num?;
    ub = json["ub"] as num?;
    ubIdeal = json["ub_ideal"] as num?;
    lbIdeal = json["lb_ideal"] as num?;
    lb = json["lb"] as num?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["max_value"] = maxValue;
    data["min_value"] = minValue;
    data["ub"] = ub;
    data["ub_ideal"] = ubIdeal;
    data["lb_ideal"] = lbIdeal;
    data["lb"] = lb;
    return data;
  }

  @override
  String toString() {
    return 'RefRanges(maxValue: $maxValue, minValue: $minValue, ub: $ub, ubIdeal: $ubIdeal, lbIdeal: $lbIdeal, lb: $lb)';
  }
}

class Legend {
  String? good;
  String? low;
  String? high;

  Legend({this.good, this.low, this.high});

  Legend.fromJson(Map<String, dynamic> json) {
    good = json["good"] as String?;
    low = json["low"] as String?;
    high = json["high"] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["good"] = good;
    data["low"] = low;
    data["high"] = high;
    return data;
  }

  @override
  String toString() => 'Legend(good: $good, low: $low, high: $high)';
}

class Insights {
  String? title;
  String? description;
  String? hexcode;

  Insights({this.title, this.description, this.hexcode});

  Insights.fromJson(Map<String, dynamic> json) {
    title = json["title"] as String?;
    description = json["description"] as String?;
    hexcode = json["hexcode"] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["description"] = description;
    data["hexcode"] = hexcode;
    return data;
  }

  @override
  String toString() =>
      'Insights(title: $title, description: $description, hexcode: $hexcode)';
}
