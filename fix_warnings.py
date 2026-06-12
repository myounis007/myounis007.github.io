import os
import re

def fix_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Fix background -> surface in ThemeData/ColorScheme
    content = re.sub(r'\bbackground:\s*bgColor,', '', content)
    content = re.sub(r'\bonBackground:\s*textColor,', '', content)
    
    # Fix usages of .background and .onBackground
    content = content.replace('.colorScheme.background', '.colorScheme.surface')
    content = content.replace('.colorScheme.onBackground', '.colorScheme.onSurface')
    
    # Fix withOpacity
    content = re.sub(r'\.withOpacity\(([^)]+)\)', r'.withValues(alpha: \1)', content)
    
    # Fix multiple underscores in builder arguments
    content = content.replace('(_, currentMode, __)', '(context, currentMode, child)')
    content = content.replace('(_, __, ___)', '(context, anim, secondaryAnim)')
    content = content.replace('(_, anim, __, child)', '(context, anim, secondaryAnim, child)')

    # Fix Matrix4 translate
    content = content.replace('..translate(0.0, _isHovered ? -10.0 : 0.0)', '..translate(0.0, _isHovered ? -10.0 : 0.0, 0.0)') # wait, warning says use translateByVector3 or translateByDouble. 
    # Let's use Matrix4.translationValues
    content = content.replace('Matrix4.identity()..translate(0.0, _isHovered ? -10.0 : 0.0)', 'Matrix4.translationValues(0.0, _isHovered ? -10.0 : 0.0, 0.0)')
    
    # Fix FontAwesomeIcons.externalLinkAlt
    content = content.replace('FontAwesomeIcons.externalLinkAlt', 'FontAwesomeIcons.upRightFromSquare')

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

for root, dirs, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            fix_file(os.path.join(root, file))
