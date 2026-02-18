import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureCanvas extends StatelessWidget {
  const SignatureCanvas({
    required this.controller,
    super.key,
  });

  final SignatureController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Signature(
              controller: controller,
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 120,
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black.withValues(alpha: 0.1),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Row(
                  children: List.generate(
                    30,
                    (index) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: 1,
                        color: index.isEven
                            ? Colors.black.withValues(alpha: 0.05)
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
