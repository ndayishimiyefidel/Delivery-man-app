import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/controller/profile_controller.dart';
import 'package:sixvalley_delivery_boy/view/base/paginated_list_view.dart';
import 'package:sixvalley_delivery_boy/view/screens/review/widget/review_card.dart';

class ReviewListView extends StatelessWidget {
  final ProfileController profileController;
  final ScrollController scrollController;
  const ReviewListView({Key key, this.profileController, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      reverse: false,
      child: PaginatedListView(
        scrollController: scrollController,
        totalSize: profileController.reviewModel?.totalSize,
        offset: profileController.reviewModel != null ? int.parse(profileController.reviewModel.offset) : null,
        onPaginate: (int offset) async {
          await profileController.getReviewList(offset, reload: false);
        },

        itemView: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          reverse: false,
          itemCount: profileController.reviewModel.review.length,
          itemBuilder: (context, index) {
            return ReviewCard(review : profileController.reviewModel.review[index], index: index);
          },
        ),
      ),
    );
  }
}
