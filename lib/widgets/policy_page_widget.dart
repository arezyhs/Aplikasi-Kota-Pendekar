import 'package:flutter/material.dart';
import 'package:pendekar/constants/constant.dart';
import 'package:pendekar/models/policy_section.dart';

/// Generic widget untuk halaman kebijakan (Privacy Policy, Terms & Conditions, dll)
class PolicyPageWidget extends StatelessWidget {
  final String title;
  final String heading;
  final String subtitle;
  final List<PolicySection> sections;

  const PolicyPageWidget({
    super.key,
    required this.title,
    required this.heading,
    required this.subtitle,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: AppFontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: const TextStyle(
                fontSize: AppTextSize.display,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: AppTextSize.body,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            ...sections.map((section) => _buildSection(section)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(PolicySection section) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: const TextStyle(
              fontSize: AppTextSize.heading,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            section.content,
            style: const TextStyle(
              fontSize: AppTextSize.body,
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
