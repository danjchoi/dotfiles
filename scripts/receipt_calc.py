#!/usr/bin/python3


"""Calculate owed amounts based on receipt."""


def main():
    """Calculate venmo."""
    total_pre_fees = float(input("Subtotal: "))
    total_post_fees = float(input("Total: "))
    lender = input("Who are you paying? ").capitalize()
    num_users = int(input("How many people need to pay? "))
    # fees_divided = (total_post_fees - total_pre_fees) / (num_users + 1)
    extra_fees = total_post_fees - total_pre_fees
    users = {}
    user_names = []
    for user_num in range(num_users):
        name_of_user = input(f"Name of vagabond {user_num + 1}: ").capitalize()
        user_names.append(name_of_user)
        users[name_of_user] = 0
        # users[name_of_user] = fees_divided
        num_items = int(
            input(f"    Number of items purchased by {name_of_user}: ") or 1
        )
        for item_num in range(num_items):
            users[name_of_user] += float(input(f"    Item {item_num + 1} cost: "))

    # - Calculate shared items
    num_shared_items = int(input("Number of shared items: ") or 0)
    shared_item_cost = 0
    for item_num in range(num_shared_items):
        shared_item_cost += float(input(f"    Item {item_num + 1} cost: "))

    for name_of_user in user_names:
        users[name_of_user] += shared_item_cost / (num_users + 1)
        # - Add additional fees
        users[name_of_user] += extra_fees * users[name_of_user] / total_pre_fees

    # - Print summary and Sanity check
    for user, cost in users.items():
        print(f"{user} owes {lender}: {cost}")


if __name__ == "__main__":
    main()
