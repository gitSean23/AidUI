with open('requirements.txt', 'r') as f:
    lines = f.readlines()

lines = [line for line in lines if line.strip()]

with open('requirements.txt', 'w') as f:
    f.writelines(lines)