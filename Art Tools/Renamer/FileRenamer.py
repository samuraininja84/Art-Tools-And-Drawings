import os

## String manipulation functions

def capitalize_first(input_string):
  """Capitalizes the first character of a string and converts the rest to lowercase.

  Args:
    input_string: The string to modify.

  Returns:
    The modified string with the first character capitalized and the rest in lowercase.
  """
  return input_string.capitalize()

def title_case(input_string):
    """Converts the first character of each word in a string to uppercase and the rest to lowercase.

    Args:
        input_string: The string to modify.

    Returns:
        The modified string with the first character of each word capitalized and the rest in lowercase.
    """
    return input_string.title()

def swap_case(input_string):
    """Swaps the case of all characters in a string.

    Args:
        input_string: The string to modify.

    Returns:
        The modified string with the case of all characters swapped.
    """
    return input_string.swapcase()

def reverse_string(input_string):
    """Reverses a string.

    Args:
        input_string: The string to modify.

    Returns:
        The modified string with the characters in reverse order.
    """
    return input_string[::-1]

def add_whitespace(input_string):
    """Adds a space before every capitalized letter in a string, except the first letter.

    Args:
        input_string: The string to modify.

    Returns:
        The modified string with a space between each capitalized and lowercase letter.
    """
    return "".join([" " + char if char.isupper() else char for char in input_string]).lstrip()

def remove_whitespace(input_string):
    """Removes all whitespace characters from a string.

    Args:
        input_string: The string to modify.

    Returns:
        The modified string with all whitespace characters removed.
    """
    return "".join(input_string.split())

def space_to_underscore(input_string):
    """Replaces all spaces in a string with underscores.

    Args:
        input_string: The string to modify.

    Returns:
        The modified string with spaces replaced by underscores.
    """
    return input_string.replace(" ", "_")

def underscore_to_space(input_string):
    """Replaces all underscores in a string with spaces.

    Args:
        input_string: The string to modify.

    Returns:
        The modified string with underscores replaced by spaces.
    """
    return input_string.replace("_", " ")

## Rename files in a directory based on user input

def rename_files_to_lowercase(directory):
    """Renames all files in a directory to lowercase."""
    for filename in os.listdir(directory):
        src = os.path.join(directory, filename)
        if os.path.isfile(src):
            dst = os.path.join(directory, filename.lower())
            os.rename(src, dst)
            print(f"Renamed '{filename}' to '{filename.lower()}'")

def rename_files_to_uppercase(directory):
    """Renames all files in a directory to uppercase."""
    for filename in os.listdir(directory):
        src = os.path.join(directory, filename)
        if os.path.isfile(src):
            dst = os.path.join(directory, filename.upper())
            os.rename(src, dst)
            print(f"Renamed '{filename}' to '{filename.upper()}'")

def rename_files_to_capitalize_first(directory):
    """Renames all files in a directory to capitalize the first character."""
    for filename in os.listdir(directory):
        src = os.path.join(directory, filename)
        if os.path.isfile(src):
            dst = os.path.join(directory, capitalize_first(filename))
            os.rename(src, dst)
            print(f"Renamed '{filename}' to '{capitalize_first(filename)}'")

def rename_files_to_swap_case(directory):
    """Renames all files in a directory to swap the case of all characters."""
    for filename in os.listdir(directory):
        src = os.path.join(directory, filename)
        if os.path.isfile(src):
            dst = os.path.join(directory, swap_case(filename))
            os.rename(src, dst)
            print(f"Renamed '{filename}' to '{swap_case(filename)}'")

def rename_files_to_reverse(directory):
    """Renames all files in a directory to reverse the characters."""
    for filename in os.listdir(directory):
        src = os.path.join(directory, filename)
        if os.path.isfile(src):
            dst = os.path.join(directory, reverse_string(filename))
            os.rename(src, dst)
            print(f"Renamed '{filename}' to '{reverse_string(filename)}'")

def rename_files_to_add_whitespace(directory):
    """Renames all files in a directory to add a space before each capitalized letter."""
    for filename in os.listdir(directory):
        src = os.path.join(directory, filename)
        if os.path.isfile(src):
            dst = os.path.join(directory, add_whitespace(filename))
            os.rename(src, dst)
            print(f"Renamed '{filename}' to '{add_whitespace(filename)}'")

def rename_files_to_remove_whitespace(directory):
    """Renames all files in a directory to remove all whitespace characters."""
    for filename in os.listdir(directory):
        src = os.path.join(directory, filename)
        if os.path.isfile(src):
            dst = os.path.join(directory, remove_whitespace(filename))
            os.rename(src, dst)
            print(f"Renamed '{filename}' to '{remove_whitespace(filename)}'")

def rename_files_to_space_to_underscore(directory):
    """Renames all files in a directory to replace spaces with underscores."""
    for filename in os.listdir(directory):
        src = os.path.join(directory, filename)
        if os.path.isfile(src):
            dst = os.path.join(directory, space_to_underscore(filename))
            os.rename(src, dst)
            print(f"Renamed '{filename}' to '{space_to_underscore(filename)}'")

def rename_files_to_underscore_to_space(directory):
    """Renames all files in a directory to replace underscores with spaces."""
    for filename in os.listdir(directory):
        src = os.path.join(directory, filename)
        if os.path.isfile(src):
            dst = os.path.join(directory, underscore_to_space(filename))
            os.rename(src, dst)
            print(f"Renamed '{filename}' to '{underscore_to_space(filename)}'")

def rename_files_to_title_case(directory):
    """Renames all files in a directory to title case."""
    for filename in os.listdir(directory):
        src = os.path.join(directory, filename)
        if os.path.isfile(src):
            dst = os.path.join(directory, title_case(filename))
            os.rename(src, dst)
            print(f"Renamed '{filename}' to '{title_case(filename)}'")

def rename_files_to_split_title_case(directory):
    """Renames all files in a directory to split title case."""
    for filename in os.listdir(directory):
        src = os.path.join(directory, filename)
        if os.path.isfile(src):
            splitName = add_whitespace(filename)
            newName = title_case(splitName)
            dst = os.path.join(directory, newName)
            os.rename(src, dst)
            print(f"Renamed '{filename}' to '{newName}'")

## Ask the user what modifications they want to make to the files in the directory
def choose_file_modifications(directory):
    """Renames all files in a directory based on user input."""
    print("Select the type of modification you want to make to the files in the directory:")
    print("1. Lowercase")
    print("2. Uppercase")
    print("3. Capitalize The First Character")
    print("4. Swap Case")
    print("5. Reverse")
    print("6. Add Whitespace")
    print("7. Remove Whitespace")
    print("8. Space To Underscore")
    print("9. Underscore To Space")
    print("10. Title Case")
    print("11. Split Title Case")
    choice = input("Enter Your Choice: ")
    if choice == "1":
        rename_files_to_lowercase(directory)
    elif choice == "2":
        rename_files_to_uppercase(directory)
    elif choice == "3":
        rename_files_to_capitalize_first(directory)
    elif choice == "4":
        rename_files_to_swap_case(directory)
    elif choice == "5":
        rename_files_to_reverse(directory)
    elif choice == "6":
        rename_files_to_add_whitespace(directory)
    elif choice == "7":
        rename_files_to_remove_whitespace(directory)
    elif choice == "8":
        rename_files_to_space_to_underscore(directory)
    elif choice == "9":
        rename_files_to_underscore_to_space(directory)
    elif choice == "10":
        rename_files_to_title_case(directory)
    elif choice == "11":
        rename_files_to_split_title_case(directory)
    else:
        print("Invalid choice.")

## Main function to rename files in a directory
def rename_files():
  if __name__ == "__main__":
      directory_path = input("Enter the directory path: ")
      if os.path.exists(directory_path):

        # Rename files in the directory based on user input
        choose_file_modifications(directory_path)
        
        # Ask the user if they want to continue renaming files in the directory
        while True:
            continue_choice = input("Do you want to continue renaming files in the directory? (Y/N): ")
            if continue_choice.lower() == "y":
                choose_file_modifications(directory_path)
            elif continue_choice.lower() == "n":
                print("Exiting...")
                break
            else:
                print("Invalid choice.")
      else:
          print("Directory not found, restarting.")
          rename()

## Rename folders in a directory based on user input

def rename_folders_to_lowercase(directory):
    for folder in os.listdir(directory):
        src = os.path.join(directory, folder)
        if os.path.isdir(src):
            dst = os.path.join(directory, folder.lower())
            os.rename(src, dst)
            print(f"Renamed '{folder}' to '{folder.lower()}'")

def rename_folders_to_uppercase(directory):
    for folder in os.listdir(directory):
        src = os.path.join(directory, folder)
        if os.path.isdir(src):
            dst = os.path.join(directory, folder.upper())
            os.rename(src, dst)
            print(f"Renamed '{folder}' to '{folder.upper()}'")

def rename_folders_to_capitalize_first(directory):
    for folder in os.listdir(directory):
        src = os.path.join(directory, folder)
        if os.path.isdir(src):
            dst = os.path.join(directory, capitalize_first(folder))
            os.rename(src, dst)
            print(f"Renamed '{folder}' to '{capitalize_first(folder)}'")

def rename_folders_to_swap_case(directory):
    for folder in os.listdir(directory):
        src = os.path.join(directory, folder)
        if os.path.isdir(src):
            dst = os.path.join(directory, swap_case(folder))
            os.rename(src, dst)
            print(f"Renamed '{folder}' to '{swap_case(folder)}'")

def rename_folders_to_reverse(directory):
    for folder in os.listdir(directory):
        src = os.path.join(directory, folder)
        if os.path.isdir(src):
            dst = os.path.join(directory, reverse_string(folder))
            os.rename(src, dst)
            print(f"Renamed '{folder}' to '{reverse_string(folder)}'")

def rename_folders_to_add_whitespace(directory):
    for folder in os.listdir(directory):
        src = os.path.join(directory, folder)
        if os.path.isdir(src):
            dst = os.path.join(directory, add_whitespace(folder))
            os.rename(src, dst)
            print(f"Renamed '{folder}' to '{add_whitespace(folder)}'")

def rename_folders_to_remove_whitespace(directory):
    for folder in os.listdir(directory):
        src = os.path.join(directory, folder)
        if os.path.isdir(src):
            dst = os.path.join(directory, remove_whitespace(folder))
            os.rename(src, dst)
            print(f"Renamed '{folder}' to '{remove_whitespace(folder)}'")

def rename_folders_to_space_to_underscore(directory):
    for folder in os.listdir(directory):
        src = os.path.join(directory, folder)
        if os.path.isdir(src):
            dst = os.path.join(directory, space_to_underscore(folder))
            os.rename(src, dst)
            print(f"Renamed '{folder}' to '{space_to_underscore(folder)}'")

def rename_folders_to_underscore_to_space(directory):
    for folder in os.listdir(directory):
        src = os.path.join(directory, folder)
        if os.path.isdir(src):
            dst = os.path.join(directory, underscore_to_space(folder))
            os.rename(src, dst)
            print(f"Renamed '{folder}' to '{underscore_to_space(folder)}'")

def rename_folders_to_title_case(directory):
    for folder in os.listdir(directory):
        src = os.path.join(directory, folder)
        if os.path.isdir(src):
            dst = os.path.join(directory, title_case(folder))
            os.rename(src, dst)
            print(f"Renamed '{folder}' to '{title_case(folder)}'")

def rename_folders_to_split_title_case(directory):
    for folder in os.listdir(directory):
        src = os.path.join(directory, folder)
        if os.path.isdir(src):
            splitName = add_whitespace(folder)
            newName = title_case(splitName)
            dst = os.path.join(directory, newName)
            os.rename(src, dst)
            print(f"Renamed '{folder}' to '{newName}'")

## Ask the user what modifications they want to make to the folders in the directory
def choose_folder_modifications(directory):
    print("Select the type of modification you want to make to the folders in the directory:")
    print("1. Lowercase")
    print("2. Uppercase")
    print("3. Capitalize The First Character")
    print("4. Swap Case")
    print("5. Reverse")
    print("6. Add Whitespace")
    print("7. Remove Whitespace")
    print("8. Space To Underscore")
    print("9. Underscore To Space")
    print("10. Title Case")
    print("11. Split Title Case")
    choice = input("Enter Your Choice: ")
    if choice == "1":
        rename_folders_to_lowercase(directory)
    elif choice == "2":
        rename_folders_to_uppercase(directory)
    elif choice == "3":
        rename_folders_to_capitalize_first(directory)
    elif choice == "4":
        rename_folders_to_swap_case(directory)
    elif choice == "5":
        rename_folders_to_reverse(directory)
    elif choice == "6":
        rename_folders_to_add_whitespace(directory)
    elif choice == "7":
        rename_folders_to_remove_whitespace(directory)
    elif choice == "8":
        rename_folders_to_space_to_underscore(directory)
    elif choice == "9":
        rename_folders_to_underscore_to_space(directory)
    elif choice == "10":
        rename_folders_to_title_case(directory)
    elif choice == "11":
        rename_folders_to_split_title_case(directory)
    else:
        print("Invalid choice.")

## Main function to rename folders in a directory
def rename_folders():
    if __name__ == "__main__":
        directory_path = input("Enter the directory path: ")
        if os.path.exists(directory_path):

            # Rename folders in the directory based on user input
            choose_folder_modifications(directory_path)

            # Ask the user if they want to continue renaming folders in the directory
            while True:
                continue_choice = input("Do you want to continue renaming folders in the directory? (Y/N): ")
                if continue_choice.lower() == "y":
                    choose_folder_modifications(directory_path)
                elif continue_choice.lower() == "n":
                    print("Exiting...")
                    break
                else:
                    print("Invalid choice.")
        else:
            print("Directory not found, restarting.")
            rename()

# Ask the user if they want to rename files or folders
def rename():
    print("Select the type of renaming you want to perform:")
    print("1. Rename Files")
    print("2. Rename Folders")
    choice = input("Enter Your Choice: ")
    if choice == "1":
        rename_files()
    elif choice == "2":
        rename_folders()
    else:
        print("Invalid choice.")

# Main function to run the program
rename()

