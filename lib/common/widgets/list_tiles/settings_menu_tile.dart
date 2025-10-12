import 'package:flutter/material.dart';
import 'package:haybuy_client/utils/constants/colors.dart';

class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onTap != null;

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: ListTile(
        leading: Icon(
          icon,
          size: 28,
          color: isEnabled ? ConstColors.primary : Colors.grey,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: isEnabled ? null : Colors.grey,
          ),
        ),
        subtitle: Text(
          subTitle,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: isEnabled ? null : Colors.grey.shade600,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
        enabled: isEnabled,
      ),
    );
  }
}
