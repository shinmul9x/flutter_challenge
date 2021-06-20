import 'package:base/library.dart';
import 'package:flutter/material.dart';

class TopicScreen extends StatelessWidget {
  late final TopicController controller;

  TopicScreen({Key? key, required int? id})
      : controller = Get.put(TopicController(id)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: AppColors.wildSand,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Expanded(
              child: RefreshListView(
                onRefesh: controller.loadData,
                padding: EdgeInsets.only(bottom: 64.dp),
                children: [
                  _buildContent(),
                  space(height: 8.dp),
                  _buildComments(),
                ],
              ),
            ),
            divider(color: AppColors.athensGray),
            _buildCommentForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.all(16.0.dp),
      child: Column(
        children: [
          _buildProfile(),
          space(height: 32.dp),
          _buildTitle(),
          space(height: 32.dp),
          _buildDetail(),
          space(height: 36.dp),
          _buildLikeShareButton(),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(AppImages.imgAvatar),
        ),
        space(width: 12.dp),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hay đi linh tinh',
              style: AppTextTheme.t14W500(),
            ),
            Text(
              '14 phút',
              style: AppTextTheme.t12W400(),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildTitle() {
    return Obx(() {
      return Text(
        controller.topic.value.title ?? '',
        style: AppTextTheme.t16W500(AppColors.emperor),
      );
    });
  }

  Widget _buildDetail() {
    return Obx(() {
      var paragraphes = controller.topic.value.paragraphes;
      return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var paragraph = paragraphes?[index];
          return _buildParagraph(
            text: paragraph?.text ?? '',
            image: paragraph?.images == null
                ? null
                : Image.asset(
                    AppImages.imgNhaTrang,
                    fit: BoxFit.cover,
                    width: Get.width,
                  ),
          );
        },
        separatorBuilder: (context, index) => space(height: 20.dp),
        itemCount: paragraphes?.length ?? 0,
      );
    });
  }

  Widget _buildParagraph({Widget? image, required String text}) {
    return Column(
      children: [
        if (image != null) image,
        if (image != null) space(height: 12.dp),
        Text(text, style: AppTextTheme.t14W400(AppColors.silverChalice)),
      ],
    );
  }

  Widget _buildLikeShareButton() {
    return Row(
      children: [
        Obx(() {
          var color = controller.isLiked.value
              ? Get.theme.primaryColor
              : AppColors.silver;

          return _button(
            icon: SvgAssetIcon(
              AppImages.icLike,
              padding: EdgeInsets.zero,
              color: color,
            ),
            label: '${controller.likeCount.value}',
            color: color,
            onTap: controller.likeTopic,
          );
        }),
        SvgAssetIcon(AppImages.dot, padding: EdgeInsets.zero),
        _button(
          icon: SvgAssetIcon(AppImages.icShare, padding: EdgeInsets.zero),
          label: '69',
          color: AppColors.silver,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _button({
    required Widget icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    var labelWidget = Text(label, style: AppTextTheme.t14W500(color));

    return InkWell(onTap: onTap, child: Row(children: [icon, labelWidget]));
  }

  Widget _buildComments() {
    return Obx(() {
      var comments = controller.topic.value.comments;
      return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var comment = comments![index];
          return CommentWidget(
            name: comment.name,
            comment: comment.text ?? '',
            createAt: comment.createAt,
          );
        },
        separatorBuilder: (context, index) => space(height: 8.dp),
        itemCount: comments?.length ?? 0,
      );
    });
  }

  Widget _buildCommentForm() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(vertical: 8.dp, horizontal: 16.dp),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.dp),
          color: AppColors.athensGray,
        ),
        padding: EdgeInsets.all(16.dp),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Viết gì đó',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            space(width: 8.dp),
            InkWell(
              onTap: () {},
              child: SvgAssetIcon(
                AppImages.icSend,
                padding: EdgeInsets.zero,
                color: Get.theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopicController extends GetxController {
  var isLiked = false.obs;
  var likeCount = 69.obs;
  var isShared = false.obs;
  var shareCount = 69.obs;
  var topic = TopicResponse().obs;

  final int? id;

  TopicController(this.id);

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  void loadData() {
    if (id == 1)
      topic.value = TopicResponse(
          title:
              'TỔNG HỢP kinh nghiệm du lịch Nha Trang tự túc 2021 Siêu Chi Tiết',
          paragraphes: [
            Paragraph(
              text:
                  'Kinh nghiệm du lịch Nha Trang tự túc 2021 là điều bạn đang cần? Mình sẽ chia sẻ cực kì chi tiết những kinh nghiệm đi du lịch Nha Trang bằng chính trải nghiệm, hiểu biết của bản thân, qua những lần đi du lịch Nha Trang, xin gửi tới bạn. Mình vừa mới trở lại Nha Trang vào đầu năm nay và có ở lại 15 ngày. Tính cả lần này thì đây là lần thứ 6 mình đi du lịch Nha Trang theo dạng tự túc.',
            ),
            Paragraph(
              images: '   ',
              text:
                  'Lần tới Nha Trang này mình có trải nghiệm thêm một vài khách sạn, quán ăn ngon, đi lại một số điểm du lịch đã từng đi và có đi thêm vài điểm du lịch mới nữa. Và trong bài viết kinh nghiệm du lịch Nha Trang này, mình sẽ chia sẻ tất cả những địa điểm, món ăn ngon, quán hải sản chất lượng, khoảng hơn chục khách sạn từ 2 đến 5 sao, thông tin thuê xe máy, ô tô hay tour ghép trong ngày… dựa trên trải nghiệm của chính bản thân mình. Mình tin chắc rằng những trải nghiệm về du lịch Nha Trang được chia sẻ dưới đây sẽ cực kì hữu ích dành cho bạn đó <3.',
            ),
            Paragraph(
              text:
                  'Nguồn bài viết: https://dulichkhampha24.com/kinh-nghiem-du-lich-nha-trang.html',
            ),
          ],
          comments: [
            Comment(
              name: 'Không thích đi đâu cả',
              createAt: '5 phút',
              text: 'Thật mong chờ đấy. Cơ mà vào rồi................',
            ),
            Comment(
              name: 'Chỉ thích ngồi nhà một mình',
              createAt: '1 phút',
              text:
                  'Nghe hấp dẫn nhỉ! Hết dịch tớ nhất định sẽ tới đây một chuyến',
            ),
            Comment(
              name: 'Cũng muốn đi chơi',
              createAt: 'Vừa xong',
              text: 'Đi Sóc Sơn mý.',
            ),
          ]);
    else if (id == 2)
      topic.value = TopicResponse(
        title:
            'Những địa điểm du lịch Hà Nội hấp dẫn nhất không thể bỏ qua (P1)',
        paragraphes: [
          Paragraph(
            text:
                '''Những địa điểm du lịch Hà Nội luôn có sức hút rất lớn với các du khách. Giờ hãy cùng Vntrip.vn điểm danh 23 điểm du lịch Hà Nội thú vị và hấp dẫn nhất để cùng gia đình và bạn bè khám phá dịp cuối tuần nhé!''',
          ),
          Paragraph(text: '''1. Quảng trường Ba Đình – Lăng Bác
Nếu đã đặt chân tới mảnh đất ngàn năm văn hiến thì Lăng Bác – Quảng trường Ba Đình là địa điểm du lịch ở Hà Nội mà các bạn không thể bỏ qua. Nơi đây là trung tâm chính trị của Việt Nam với nhà Quốc hội, Phủ Chủ tịch, Bảo tàng Hồ Chí Minh,…

Lăng Bác là nơi lưu giữ thi hài của vị lãnh tụ kính yêu. Bên ngoài lăng là những hàng tre xanh bát ngát. Lăng chủ tích mở cửa vào sáng thứ 3,4,5,7 và chủ nhật. Khi vào viếng lăng Bác, bạn chú ý ăn mặc chỉnh tề, không đem theo các thiết bị điện tử ghi hành và giữ trật tự trong lăng.

Quảng trường Ba Đình là quảng trường lớn nhất Việt Nam, nằm trên đường Hùng Vương và trước Lăng Chủ tịch Hồ Chí Minh. Quảng trường này còn là nơi ghi nhận nhiều dấu ấn quan trọng trong lịch sử Việt Nam. Đặc biệt, vào ngày 2 tháng 9 năm 1945, Chủ tịch Chính phủ Cách mạng lâm thời Việt Nam Dân chủ Cộng hòa Hồ Chí Minh đã đọc bản Tuyên ngôn độc lập khai sinh ra nước Việt Nam Dân chủ Cộng hòa. Đây cũng là nơi diễn ra các cuộc diễu hành nhân dịp các ngày lễ lớn của Việt Nam, và cũng là một địa điểm tham quan, vui chơi, dạo mát của du khách và người dân Hà Nội.'''),
          Paragraph(text: '''2. Hồ Gươm
Hồ Gươm hay hồ Hoàn Kiếm là một trong những nơi nên đến ở Hà Nội khi du lịch thủ đô. Nằm ở giữa trung tâm, Hồ Gươm được ví như trái tim của thành phố ngàn năm tuổi này.. Mặt hồ như tấm gương lớn soi bóng những cây cổ thụ, những rặng liễu thướt tha tóc rủ, những mái đền, chùa cổ kính, tháp cũ rêu phong, các toà nhà mới cao tầng vươn lên trời xanh.

Buổi sáng những người dân Hà Nội thường đến Hồ Gươm để tập thể dục như một nét văn hoá riêng đặc trưng của Thủ đô. Ảnh: Đinh Tuấn Văn

Một trải nghiệm thú vị dành cho khách du lịch là đi bộ một vòng hồ, bạn sẽ được thấy một Hà Nội cổ kính nhưng vẫn đầy hiện đại hiện lên thật rõ ràng. Bên cạnh hồ là những công trình kiến trúc như tháp Bút, đài Nghiên, cầu Thê Húc dẫn vào đền Ngọc Sơn, đền vua Lê Thái Tổ, tháp Hoà Phong,…
'''),
          Paragraph(text: '''3. Phố cổ Hà Nội – địa điểm du lịch hấp dẫn
Muốn tìm hiểu về cuộc sống, văn hóa và con người Tràng An thì bạn đừng bỏ qua phố cổ – một trong những địa điểm du lịch ở Hà Nội đầy thú vị và hấp dẫn với du khách. Phố cổ Hà Nội nằm ở phía Tây và phía Bắc của Hồ Hoàn Kiếm, là nơi tập trung đông dân cư sinh sống có 36 phố phường. Mỗi con phố ở đây chủ yếu tập trung bán một loại mặt hàng nhất định. 

Lang thang ở khu phố và thưởng thức ẩm thực phố cổ như phở Bát Đàn, chả cá Lã Vọng, bún chả hàng Mành, mì vằn thắn Đinh Liệt, bún ốc nguội Ô Quan Chưởng,…sẽ khiến chuyến đi của bạn đáng nhớ hơn rất nhiều! 

Vì Phố Cổ và Hồ Gươm rất gần nhau nên bạn có thể lựa chọn các khách sạn ở khu vực này, tiện lưu trú và đi lại gần có thêm thời gian để đi dạo, thử hết các món ngon phố cổ.'''),
        ],
      );
  }

  void likeTopic() {
    if (isLiked.value == true) {
      dislikeTopic();
    } else {
      isLiked.value = true;
      likeCount++;
    }
  }

  void dislikeTopic() {
    isLiked.value = false;
    likeCount--;
  }
}

class TopicResponse {
  final String? title;
  final List<Paragraph>? paragraphes;
  final List<Comment>? comments;

  TopicResponse({this.title, this.paragraphes, this.comments});
}

class Paragraph {
  final String? text;
  final String? images;

  Paragraph({this.text, this.images});
}

class Comment {
  final String name;
  final String createAt;
  final String? text;

  Comment({required this.name, required this.createAt, this.text});
}

class CommentWidget extends StatelessWidget {
  final String name;
  final String createAt;
  final String comment;

  const CommentWidget({
    Key? key,
    required this.name,
    required this.comment,
    required this.createAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.dp),
      color: AppColors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(AppImages.imgAvatar),
          ),
          space(width: 12.dp),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextTheme.t14W500(),
              ),
              Text(
                createAt,
                style: AppTextTheme.t12W400(),
              ),
              space(height: 16.dp),
              Text(
                comment,
                style: AppTextTheme.t12W400(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
