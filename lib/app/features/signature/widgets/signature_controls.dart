import 'package:codasign/app/ui/colors.dart';
import 'package:flutter/material.dart';

class SignatureControls extends StatelessWidget {
  const SignatureControls({
    required this.selectedColor,
    required this.selectedThickness,
    required this.onColorChanged,
    required this.onThicknessChanged,
    super.key,
  });

  final Color selectedColor;
  final double selectedThickness;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<double> onThicknessChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlpha,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pen Color',
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _ColorOption(
                color: Colors.black,
                label: 'Black',
                isSelected: selectedColor == Colors.black,
                onTap: () => onColorChanged(Colors.black),
              ),
              const SizedBox(width: 12),
              _ColorOption(
                color: Colors.blue,
                label: 'Blue',
                isSelected: selectedColor == Colors.blue,
                onTap: () => onColorChanged(Colors.blue),
              ),
              const SizedBox(width: 12),
              _ColorOption(
                color: AppColors.primary,
                label: 'Cyan',
                isSelected: selectedColor == AppColors.primary,
                onTap: () => onColorChanged(AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Pen Thickness',
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _ThicknessOption(
                thickness: 1,
                label: 'Thin',
                isSelected: selectedThickness == 1,
                onTap: () => onThicknessChanged(1),
              ),
              const SizedBox(width: 12),
              _ThicknessOption(
                thickness: 3,
                label: 'Medium',
                isSelected: selectedThickness == 3,
                onTap: () => onThicknessChanged(3),
              ),
              const SizedBox(width: 12),
              _ThicknessOption(
                thickness: 6,
                label: 'Thick',
                isSelected: selectedThickness == 6,
                onTap: () => onThicknessChanged(6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColorOption extends StatelessWidget {
  const _ColorOption({
    required this.color,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? color.withValues(alpha: 0.1)
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThicknessOption extends StatelessWidget {
  const _ThicknessOption({
    required this.thickness,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final double thickness;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary.withValues(alpha: 0.1)
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                child: Container(
                  width: 4 + thickness,
                  height: 4 + thickness,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
