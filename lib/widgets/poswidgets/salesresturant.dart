import 'package:com_csith_geniuzpos/widgets/oldwidgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/models/oldsobjs/post_model.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SalesResturantPages extends StatelessWidget {
  final Post post;

  const SalesResturantPages({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: isDesktop ? 5.0 : 0.0,
      ),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _PostStats(post: post),
            ),
          ],
        ),
      ),
    );
  }
}

// class _PostHeader extends StatelessWidget {
//   final Post post;

//   const _PostHeader({
//     Key key,
//     @required this.post,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const SizedBox(width: 8.0),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 post.user.name,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Row(
//                 children: [
//                   Text(
//                     '${post.timeAgo} • ',
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 12.0,
//                     ),
//                   ),
//                   Icon(
//                     Icons.public,
//                     color: Colors.grey[600],
//                     size: 12.0,
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//         IconButton(
//           icon: const Icon(Icons.more_horiz),
//           onPressed: () => print('More'),
//         ),
//       ],
//     );
//   }
// }

class _PostStats extends StatelessWidget {
  final Post post;

  const _PostStats({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _PostButton(
              icon: Icon(
                MdiIcons.thumbUpOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Like',
              onTap: () => print('Like'),
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Comment',
              onTap: () => print('Comment'),
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'Share',
              onTap: () => print('Share'),
            )
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const _PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
