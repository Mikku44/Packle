import subprocess

def p2():
    process = subprocess.run(
        "python -c import os",
        
        text=True,
        shell=True, capture_output=True
    )

    print(process)

def test():
    print("HI")