from datetime import datetime

README_FILE = "README.md"

def add_progress(note):
    today = datetime.now().strftime("%Y-%m-%d")
    entry = f"| {get_day_number()} | {today} | {note} |\n"

    with open(README_FILE, "r", encoding="utf-8") as file:
        lines = file.readlines()

    # Insert the entry after the table header
    for i, line in enumerate(lines):
        if line.strip() == "| Day | Date       | Notes |":
            lines.insert(i + 2, entry)
            break

    with open(README_FILE, "w", encoding="utf-8") as file:
        file.writelines(lines)

    print(f"✅ Progress for {today} added!")

def get_day_number():
    with open(README_FILE, "r", encoding="utf-8") as file:
        lines = file.readlines()

    count = 0
    for line in lines:
        if line.startswith("|") and line.strip() != "| Day | Date       | Notes |" and not line.startswith("---"):
            count += 1
    return count + 1

if __name__ == "__main__":
    note = input("Enter your note for today: ")
    add_progress(note)
