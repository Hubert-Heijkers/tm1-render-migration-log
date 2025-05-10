import sys
import json
from jinja2 import Template

def main():
    if len(sys.argv) != 2:
        print("Usage: python render.py <template_file>", file=sys.stderr)
        sys.exit(1)

    template_path = sys.argv[1]

    # Read the template
    with open(template_path, 'r', encoding='utf-8') as f:
        template_content = f.read()

    # Read JSON array from stdin
    try:
        input_data = json.load(sys.stdin)
    except json.JSONDecodeError as e:
        print(f"Invalid JSON input: {e}", file=sys.stderr)
        sys.exit(2)

    # Render template
    template = Template(template_content)
    rendered_output = template.render(value=input_data)

    print(rendered_output)

if __name__ == "__main__":
    main()
