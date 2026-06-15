import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'section_header.dart';
import '../../../core/utils/fade_in_on_scroll.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  
  bool _isSending = false;
  bool _isSent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      final name = _nameController.text;
      final email = _emailController.text;
      final message = _messageController.text;

      try {
        final response = await http.post(
          Uri.parse('https://formspree.io/f/mqeogyen'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'name': name,
            'email': email,
            'message': message,
          }),
        );

        if (mounted) {
          if (response.statusCode == 200 || response.statusCode == 201) {
            setState(() {
              _isSent = true;
            });
            _nameController.clear();
            _emailController.clear();
            _messageController.clear();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to send message. Please try again later.'),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An error occurred. Please check your internet connection.'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSending = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SectionHeader(title: 'Get In Touch', center: true),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 900;
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildContactInfo(context)),
                            const SizedBox(width: 80),
                            Expanded(flex: 1, child: _buildForm(context)),
                          ],
                        )
                      : Column(
                          children: [
                            _buildContactInfo(context),
                            const SizedBox(height: 60),
                            _buildForm(context),
                          ],
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInOnScroll(
          delay: 0.1,
          child: Text(
            "Let's Build Something\nAmazing Together.",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 24),
        FadeInOnScroll(
          delay: 0.2,
          child: Text(
            "I'm currently looking for new opportunities and my inbox is always open. Whether you have a question, a project idea, or just want to say hi, I'll try my best to get back to you!",
            style: GoogleFonts.inter(
              fontSize: 16,
              height: 1.6,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
        const SizedBox(height: 40),
        FadeInOnScroll(
          delay: 0.3,
          child: _ContactItem(
            icon: Icons.email_rounded,
            title: "Email",
            text: "younis4707@gmail.com",
          ),
        ),
        const SizedBox(height: 16),
        FadeInOnScroll(
          delay: 0.4,
          child: _ContactItem(
            icon: Icons.phone_rounded,
            title: "Phone",
            text: "+92 345 345 4707",
          ),
        ),
        const SizedBox(height: 16),
        FadeInOnScroll(
          delay: 0.5,
          child: _ContactItem(
            icon: Icons.location_on_rounded,
            title: "Location",
            text: "Multan, Pakistan",
          ),
        ),
        const SizedBox(height: 48),
        FadeInOnScroll(
          delay: 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Connect with me",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _SocialBadge(
                    icon: Icons.work_rounded, // fallback for LinkedIn
                    label: "LinkedIn",
                    url: "https://www.linkedin.com/in/myounis007", // Ensure correct URL
                  ),
                  _SocialBadge(
                    icon: Icons.code_rounded,
                    label: "GitHub",
                    url: "https://github.com/myounis007",
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return FadeInOnScroll(
      delay: 0.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Ambient Glowing Orbs
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.4),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha: 0.2),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          // Form Glass Container
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1.5,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                  child: _isSent
                      ? _buildSuccessUI()
                      : Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Send a Message",
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 32),
                              _buildTextField(
                                context: context,
                                label: 'Your Name',
                                icon: Icons.person_outline_rounded,
                                controller: _nameController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                context: context,
                                label: 'Email Address',
                                icon: Icons.email_outlined,
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                context: context,
                                label: 'Your Message',
                                icon: Icons.message_outlined,
                                controller: _messageController,
                                maxLines: 4,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter a message';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                width: double.infinity,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                                        blurRadius: 20,
                                        spreadRadius: 0,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _isSending ? null : _sendMessage,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).primaryColor,
                                      disabledBackgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.6),
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: _isSending
                                        ? const SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Send Message',
                                                style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.0,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessUI() {
    return Container(
      key: const ValueKey('success_ui'),
      padding: const EdgeInsets.symmetric(vertical: 40),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3), width: 2),
            ),
            child: const Icon(Icons.check_rounded, color: Color(0xFF10B981), size: 48),
          ),
          const SizedBox(height: 32),
          Text(
            'Message Sent!',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Thank you for reaching out. I'll get back to you as soon as possible.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 40),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _isSent = false;
              });
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(
              'Send Another Message',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.inter(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        alignLabelWithHint: maxLines > 1,
        contentPadding: const EdgeInsets.all(24),
        prefixIcon: maxLines == 1 ? Icon(icon, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5), size: 20) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.redAccent.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.2), // Deep glassy look inside inputs
      ),
    );
  }
}

class _ContactItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String text;

  const _ContactItem({required this.icon, required this.title, required this.text});

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(
          _isHovered ? 8.0 : 0.0,
          0.0,
          0.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(
            alpha: _isHovered ? 0.4 : 0.2,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered 
                ? primaryColor.withValues(alpha: 0.4) 
                : Colors.white.withValues(alpha: 0.05),
            width: 1.5,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.15),
                blurRadius: 30,
                spreadRadius: 0,
              ),
          ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: _isHovered ? 0.2 : 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryColor.withValues(alpha: _isHovered ? 0.5 : 0.2),
                ),
              ),
              child: Icon(
                widget.icon, 
                color: primaryColor, 
                size: 24,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.text,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialBadge extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialBadge({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_SocialBadge> createState() => _SocialBadgeState();
}

class _SocialBadgeState extends State<_SocialBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered 
                ? Theme.of(context).primaryColor 
                : Theme.of(context).colorScheme.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _isHovered 
                  ? Theme.of(context).primaryColor 
                  : Colors.white.withValues(alpha: 0.1),
              width: 1.5,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon, 
                size: 18, 
                color: _isHovered ? Colors.white : Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: _isHovered ? Colors.white : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
