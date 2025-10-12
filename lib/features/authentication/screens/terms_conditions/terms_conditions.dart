import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Terms & Conditions'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Last Updated
            Text(
              'Last Updated: October 12, 2025',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: Sizes.spaceBtwSections),

            // Introduction
            _buildSectionTitle(context, '1. Introduction'),
            _buildSectionContent(
              context,
              'Welcome to HayBuy! These Terms and Conditions ("Terms") govern your use of our mobile application and services. By accessing or using HayBuy, you agree to be bound by these Terms. If you do not agree with any part of these Terms, please do not use our services.',
            ),

            // Account Registration
            _buildSectionTitle(context, '2. Account Registration'),
            _buildSectionContent(
              context,
              'To use certain features of HayBuy, you must create an account. You agree to:\n\n'
              '• Provide accurate, current, and complete information during registration\n'
              '• Maintain the security of your password and account\n'
              '• Notify us immediately of any unauthorized use of your account\n'
              '• Accept responsibility for all activities that occur under your account\n\n'
              'You must be at least 18 years old to create an account.',
            ),

            // User Responsibilities
            _buildSectionTitle(context, '3. User Responsibilities'),
            _buildSectionContent(
              context,
              'When using HayBuy, you agree to:\n\n'
              '• Comply with all applicable laws and regulations\n'
              '• Not engage in any fraudulent, abusive, or illegal activities\n'
              '• Not upload or transmit viruses or malicious code\n'
              '• Not interfere with the proper functioning of the application\n'
              '• Respect the intellectual property rights of others\n'
              '• Not impersonate any person or entity',
            ),

            // Products and Services
            _buildSectionTitle(context, '4. Products and Services'),
            _buildSectionContent(
              context,
              'HayBuy provides a platform for users to buy and sell products. We strive to:\n\n'
              '• Display accurate product information and pricing\n'
              '• Process orders and payments securely\n'
              '• Facilitate communication between buyers and sellers\n\n'
              'However, we do not guarantee:\n\n'
              '• Product availability at all times\n'
              '• Accuracy of all seller-provided information\n'
              '• The quality of products sold by third-party sellers',
            ),

            // Payment and Pricing
            _buildSectionTitle(context, '5. Payment and Pricing'),
            _buildSectionContent(
              context,
              'All prices are displayed in Thai Baht (THB) unless otherwise stated. You agree to:\n\n'
              '• Pay all applicable fees and charges\n'
              '• Provide valid payment information\n'
              '• Accept that prices may change without notice\n'
              '• Be responsible for any applicable taxes\n\n'
              'We reserve the right to refuse or cancel any order at our discretion.',
            ),

            // Shipping and Delivery
            _buildSectionTitle(context, '6. Shipping and Delivery'),
            _buildSectionContent(
              context,
              'Delivery times are estimates and may vary. We are not responsible for:\n\n'
              '• Delays caused by shipping carriers\n'
              '• Incorrect addresses provided by customers\n'
              '• Failed delivery attempts\n'
              '• Items lost or damaged during shipping (insurance claims apply)',
            ),

            // Returns and Refunds
            _buildSectionTitle(context, '7. Returns and Refunds'),
            _buildSectionContent(
              context,
              'You may return eligible items within 14 days of receipt for a refund or exchange, subject to:\n\n'
              '• Items being in original condition with tags attached\n'
              '• Proof of purchase being provided\n'
              '• Return shipping costs being covered by the customer (unless item is defective)\n\n'
              'Certain items may not be eligible for return, including:\n\n'
              '• Personalized or custom-made products\n'
              '• Perishable goods\n'
              '• Intimate or sanitary items\n'
              '• Digital downloads',
            ),

            // Privacy and Data Protection
            _buildSectionTitle(context, '8. Privacy and Data Protection'),
            _buildSectionContent(
              context,
              'We collect and process your personal data in accordance with our Privacy Policy. By using HayBuy, you consent to:\n\n'
              '• Collection of necessary personal information\n'
              '• Use of cookies and tracking technologies\n'
              '• Communication via email or push notifications\n'
              '• Data processing for service improvement\n\n'
              'You have the right to access, correct, or delete your personal data at any time.',
            ),

            // Intellectual Property
            _buildSectionTitle(context, '9. Intellectual Property'),
            _buildSectionContent(
              context,
              'All content on HayBuy, including text, graphics, logos, and software, is protected by copyright and other intellectual property laws. You may not:\n\n'
              '• Copy, modify, or distribute our content without permission\n'
              '• Use our trademarks or branding without authorization\n'
              '• Reverse engineer or decompile our software\n'
              '• Create derivative works based on our platform',
            ),

            // Limitation of Liability
            _buildSectionTitle(context, '10. Limitation of Liability'),
            _buildSectionContent(
              context,
              'To the maximum extent permitted by law, HayBuy shall not be liable for:\n\n'
              '• Indirect, incidental, or consequential damages\n'
              '• Loss of profits, data, or business opportunities\n'
              '• Damages resulting from third-party products or services\n'
              '• Service interruptions or technical issues\n\n'
              'Our total liability shall not exceed the amount you paid for the relevant product or service.',
            ),

            // Dispute Resolution
            _buildSectionTitle(context, '11. Dispute Resolution'),
            _buildSectionContent(
              context,
              'In case of any disputes arising from these Terms or your use of HayBuy:\n\n'
              '• First attempt to resolve the issue through our customer support\n'
              '• If unresolved, disputes will be subject to binding arbitration\n'
              '• Arbitration will be conducted under Thai law\n'
              '• You waive the right to participate in class-action lawsuits',
            ),

            // Modifications
            _buildSectionTitle(context, '12. Modifications to Terms'),
            _buildSectionContent(
              context,
              'We reserve the right to modify these Terms at any time. We will:\n\n'
              '• Notify users of significant changes via email or app notification\n'
              '• Post the updated Terms with a new "Last Updated" date\n'
              '• Consider your continued use as acceptance of modified Terms\n\n'
              'We recommend reviewing these Terms periodically.',
            ),

            // Account Termination
            _buildSectionTitle(context, '13. Account Termination'),
            _buildSectionContent(
              context,
              'We may suspend or terminate your account if you:\n\n'
              '• Violate these Terms or our policies\n'
              '• Engage in fraudulent activities\n'
              '• Provide false or misleading information\n'
              '• Fail to pay for products or services\n\n'
              'You may also delete your account at any time through the app settings. Upon termination:\n\n'
              '• Your access to services will be revoked\n'
              '• Outstanding orders will be processed or cancelled\n'
              '• Your data will be deleted or anonymized as per our Privacy Policy',
            ),

            // Governing Law
            _buildSectionTitle(context, '14. Governing Law'),
            _buildSectionContent(
              context,
              'These Terms shall be governed by and construed in accordance with the laws of Thailand. Any legal proceedings shall be conducted in Thai courts with jurisdiction over our registered office.',
            ),

            // Contact Information
            _buildSectionTitle(context, '15. Contact Us'),
            _buildSectionContent(
              context,
              'If you have any questions about these Terms, please contact us:\n\n'
              '• Email: support@haybuy.com\n'
              '• Phone: +66 (0) 2-123-4567\n'
              '• Address: 123 Commerce Street, Bangkok, Thailand 10500\n'
              '• Business Hours: Monday-Friday, 9:00 AM - 6:00 PM (ICT)',
            ),

            // Acceptance
            const SizedBox(height: Sizes.spaceBtwSections),
            Container(
              padding: const EdgeInsets.all(Sizes.md),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
                border: Border.all(
                  color: Colors.blue.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                'By creating an account or using HayBuy, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: Sizes.spaceBtwSections * 2),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Sizes.spaceBtwItems,
        bottom: Sizes.sm,
      ),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.spaceBtwItems),
      child: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
