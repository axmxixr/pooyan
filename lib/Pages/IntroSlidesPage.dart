import 'package:intro_slider/intro_slider.dart';

import 'package:flutter/material.dart';

class IntroSlides extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IntroSlidesState();
}

class IntroSlidesState extends State<IntroSlides> {
  List<Slide> introSlide = new List();

  @override
  void initState() {
    super.initState();

    introSlide.add(
      new Slide(
        title: "به نرم افزار نرم افزار مطلب خوش آمدید",
        description:
            "بخوانید یاد بگیرید با دوستان خود مسابقه دهید....",
        backgroundColor: Colors.green,
      ),
    );
    introSlide.add(
      new Slide(
        title: "نرم افزار آنلاین",
        description:
            "برای استفاده از نرم افزار ما نیاز به اتصال به اینترنت در هنگام استفاده دارید برای بهره مند شدن از کسفیت بهتر اینتر نت پر سرعت تری را انتخاب کنید و VPN خود را غیر فعال کنید",

        backgroundColor: Colors.purple,

      ),
    );
    introSlide.add(
      new Slide(
        title: "دعوت دوستان و مسابقه دادن با آنها",
        description:
            "میتوانید دوستان خود را به مطلب دعوت کرده و علاوه بر بهره مندی از جوایز ما با دوستانتان مسابقه دهید . دقت سرعت عمل و هوش خود را محک بزنید",
        backgroundColor: Colors.lightBlue,
      ),
    );
    introSlide.add(
      new Slide(
        title: "مطالب",
        description:
        "مطالبی که ما در اختیار شما قرار می دهیم کاملا تایید شده و معتر هستند . لازم به ذکر است این مطالب صرفا جهن افزایش آگاهی شما بوده و در صورت استفاده غیر صحیح کلیه عواقب آن به عهده شما می باشد . توصیه ما مراجعه به پزشک جهت معاینات دقیق تر و درمان اصولی می باشد",
        backgroundColor: Colors.orange,

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: introSlide,colorActiveDot: Colors.yellow,colorDot: Colors.brown,
      sizeDot: 15.0,
      isShowSkipBtn: false,
      highlightColorDoneBtn: Colors.purple,
      nameDoneBtn: "فهمیدم",
      onDonePress: (){
        Navigator.pushReplacementNamed(context, "/account/login");
      },
    );
  }
}
