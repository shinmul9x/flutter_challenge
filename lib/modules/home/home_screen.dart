import 'package:base/library.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Home',
        showLeading: false,
        actions: actions,
      ),
      backgroundColor: AppColors.wildSand,
      body: RefreshListView(
        onRefesh: () {},
        children: [
          ListView.separated(
            itemBuilder: (context, index) {
              return _item(index);
            },
            shrinkWrap: true,
            physics: ScrollPhysics(),
            separatorBuilder: (context, index) => space(height: 16.dp),
            itemCount: 2,
            padding: EdgeInsets.only(bottom: 64.dp, top: 16.dp),
          )
        ],
      ),
    );
  }

  Widget _item(int index) {
    if (index % 2 == 1)
      return InkWell(
        onTap: () => Get.toNamed(AppRoute.topic, arguments: {'id': 2}),
        child: TopicItem(
          showImages: false,
          title: '23 địa điểm tham quan du lịch ở Hà Nội hấp dẫn nhất',
          content:
              'Những địa điểm du lịch Hà Nội luôn có sức hút rất lớn với các du khách. Giờ hãy cùng Vntrip.vn điểm danh 23 điểm du lịch Hà Nội thú vị và hấp dẫn nhất để cùng gia đình và bạn bè khám phá dịp cuối tuần nhé!',
        ),
      );
    return InkWell(
      onTap: () => Get.toNamed(AppRoute.topic, arguments: {'id': 1}),
      child: TopicItem(
        title:
            'TỔNG HỢP kinh nghiệm du lịch Nha Trang tự túc 2021 Siêu Chi Tiết',
        content:
            'Mình vừa mới trở lại Nha Trang vào đầu năm nay và có ở lại 15 ngày. Tính cả lần này thì đây là lần thứ 6 mình đi. Tính cả lần này thì đây là lần thứ 6 mình đi.',
      ),
    );
  }

  List<Widget> get actions {
    return [
      IconButton(
        icon: SvgAssetIcon(AppImages.icEdit),
        onPressed: () {},
      ),
      IconButton(
        icon: SvgAssetIcon(AppImages.icSearch),
        onPressed: () {},
      ),
    ];
  }
}

class TopicItem extends StatelessWidget {
  final bool showImages;
  final String title;
  final String content;

  const TopicItem({
    Key? key,
    this.showImages = true,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showImages)
          Image.asset(
            AppImages.imgNhaTrang,
            fit: BoxFit.cover,
            width: Get.width,
          ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
          padding: EdgeInsets.all(16.dp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextTheme.t16W500(AppColors.emperor),
              ),
              space(height: 12.dp),
              Text(
                content,
                style: AppTextTheme.t14W400(AppColors.silverChalice),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              space(height: 36.dp),
              _buildActions(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildLikeShareButton(), _detailButton()],
    );
  }

  Widget _detailButton() {
    return Row(
      children: [
        Text(
          'Detail',
          style: AppTextTheme.t14W500(Get.theme.primaryColor),
        ),
        SvgAssetIcon(AppImages.icRightArrow, padding: EdgeInsets.zero),
      ],
    );
  }

  Widget _buildLikeShareButton() {
    return Row(
      children: [
        _button(
          icon: SvgAssetIcon(AppImages.icLike, padding: EdgeInsets.zero),
          label: '69',
          color: AppColors.silver,
          onTap: () {},
        ),
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
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          Text(label, style: AppTextTheme.t14W500(color)),
        ],
      ),
    );
  }
}
