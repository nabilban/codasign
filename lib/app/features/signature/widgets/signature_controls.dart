import 'package:codasign/app/ui/colors.dart';
import 'package:codasign/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

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

  static const List<Color> _presetColors = [
    Colors.black,
    Colors.blue,
    AppColors.primary,
  ];

  bool get _isCustomColor =>
      !_presetColors.any((c) => c.toARGB32() == selectedColor.toARGB32());

  Future<void> _openColorPicker(BuildContext context) async {
    var pickedColor = selectedColor;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1B263B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                context.l10n.customColor,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  child: ColorPicker(
                    initialPicker: Picker.hsv,
                    color: pickedColor,
                    onChanged: (value) =>
                        setDialogState(() => pickedColor = value),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(
                    context.l10n.cancel,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white54,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    onColorChanged(pickedColor);
                    Navigator.pop(dialogContext);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(context.l10n.apply),
                ),
              ],
            );
          },
        );
      },
    );
  }

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
            context.l10n.penColor,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              _ColorOption(
                color: Colors.black,
                label: context.l10n.colorBlack,
                isSelected: selectedColor == Colors.black,
                onTap: () => onColorChanged(Colors.black),
              ),
              const SizedBox(width: 8),
              _ColorOption(
                color: Colors.blue,
                label: context.l10n.colorBlue,
                isSelected: selectedColor == Colors.blue,
                onTap: () => onColorChanged(Colors.blue),
              ),
              const SizedBox(width: 8),
              _ColorOption(
                color: AppColors.primary,
                label: context.l10n.colorCyan,
                isSelected: selectedColor == AppColors.primary,
                onTap: () => onColorChanged(AppColors.primary),
              ),
              const SizedBox(width: 8),
              // Custom color option
              Expanded(
                child: GestureDetector(
                  onTap: () => _openColorPicker(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: _isCustomColor
                          ? selectedColor.withValues(alpha: 0.15)
                          : theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _isCustomColor
                            ? selectedColor
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
                            shape: BoxShape.circle,
                            gradient: const SweepGradient(
                              colors: [
                                Colors.red,
                                Colors.yellow,
                                Colors.green,
                                Colors.cyan,
                                Colors.blue,
                                Colors.purple,
                                Colors.red,
                              ],
                            ),
                            border: Border.all(
                              color: _isCustomColor
                                  ? selectedColor
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: _isCustomColor
                              ? Container(
                                  margin: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: selectedColor,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          context.l10n.colorCustom,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            context.l10n.penThickness,
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
                label: context.l10n.thicknessThin,
                isSelected: selectedThickness == 1,
                onTap: () => onThicknessChanged(1),
              ),
              const SizedBox(width: 12),
              _ThicknessOption(
                thickness: 3,
                label: context.l10n.thicknessMedium,
                isSelected: selectedThickness == 3,
                onTap: () => onThicknessChanged(3),
              ),
              const SizedBox(width: 12),
              _ThicknessOption(
                thickness: 6,
                label: context.l10n.thicknessThick,
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
          padding: const EdgeInsets.symmetric(vertical: 4),
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
          padding: const EdgeInsets.symmetric(vertical: 4),
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
