import mysql.connector


def connect_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="1234",
        database="techwheels"
    )


def print_table(cursor, rows):
    if not rows:
        print("No records found.")
        return

    columns = [desc[0] for desc in cursor.description]
    data = [[str(value) if value is not None else "NULL" for value in row] for row in rows]

    widths = []
    for i, col in enumerate(columns):
        max_width = len(col)
        for row in data:
            max_width = max(max_width, len(row[i]))
        widths.append(max_width)

    header = " | ".join(columns[i].ljust(widths[i]) for i in range(len(columns)))
    line = "-+-".join("-" * widths[i] for i in range(len(columns)))

    print(header)
    print(line)

    for row in data:
        print(" | ".join(row[i].ljust(widths[i]) for i in range(len(row))))

    print(f"\nTotal Records: {len(rows)}")


def read_database(cursor):
    while True:
        print("\n===== Read Database =====")
        print("1. Members")
        print("2. Vehicle")
        print("3. Reservations")
        print("4. Trip")
        print("5. Staff")
        print("6. Membership_Tier")
        print("7. Hubs")
        print("8. Maintenance_Record")
        print("9. Incident_Report")
        print("10. All Main Tables")
        print("11. Back to Main Menu")

        choice = input("Select a table to view: ")

        tables = {
            "1": "Members",
            "2": "Vehicle",
            "3": "Reservations",
            "4": "Trip",
            "5": "Staff",
            "6": "Membership_Tier",
            "7": "Hubs",
            "8": "Maintenance_Record",
            "9": "Incident_Report"
        }

        if choice in tables:
            table = tables[choice]
            cursor.execute(f"SELECT * FROM {table}")
            rows = cursor.fetchall()

            print(f"\n===== {table} Table =====")
            print_table(cursor, rows)

        elif choice == "10":
            for table in tables.values():
                cursor.execute(f"SELECT * FROM {table}")
                rows = cursor.fetchall()

                print(f"\n===== {table} Table =====")
                print_table(cursor, rows)

        elif choice == "11":
            break

        else:
            print("Invalid choice.")


def create_record(conn, cursor):
    while True:
        print("\n===== Create Database =====")
        print("1. Member")
        print("2. Vehicle")
        print("3. Reservation")
        print("4. Staff")
        print("5. Maintenance Record")
        print("6. Back to Main Menu")

        choice = input("Choose option: ")

        if choice == "6":
            break

        try:
            if choice == "1":
                member_id = input("Member ID: ")
                cuny_id = input("CUNY ID Number: ")
                name = input("Full Name: ")
                email = input("Campus Email: ")
                address = input("Home Address: ")
                license_num = input("Driver License Number: ")
                license_date = input("License Expiration Date (YYYY-MM-DD): ")
                tier_id = input("Tier ID: ")

                cursor.execute("""
                    INSERT INTO Members
                    (member_id, cuny_id_number, full_name, campus_email,
                     home_address, driver_license_number, license_expiration_date, tier_id)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """, (member_id, cuny_id, name, email, address,
                      license_num, license_date, tier_id))

                conn.commit()
                print("Member created successfully.")

            elif choice == "2":
                vehicle_id = input("Vehicle ID: ")
                make = input("Make: ")
                model = input("Model: ")
                year = input("Year: ")
                color = input("Color: ")
                plate = input("License Plate Number: ")
                vehicle_type = input("Vehicle Type: ")
                fuel_type = input("Fuel/Power Type: ")
                seats = input("Seating Capacity: ")
                mileage = input("Current Mileage: ")
                status = input("Vehicle Status: ")
                restricted = input("Restricted (Yes/No): ")

                cursor.execute("""
                    INSERT INTO Vehicle
                    (vehicle_id, make, model, year, color, license_plate_number,
                     vehicle_type, fuel_power_type, seating_capacity,
                     current_mileage, vehicle_status, restricted)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """, (vehicle_id, make, model, year, color, plate,
                      vehicle_type, fuel_type, seats, mileage, status, restricted))

                conn.commit()
                print("Vehicle created successfully.")

            elif choice == "3":
                reservation_id = input("Reservation ID: ")
                vehicle_type = input("Required Vehicle Type: ")
                pickup_time = input("Scheduled Pickup Time (YYYY-MM-DD HH:MM:SS): ")
                return_time = input("Expected Return Time (YYYY-MM-DD HH:MM:SS): ")
                status = input("Reservation Status: ")
                member_id = input("Member ID: ")
                vehicle_id = input("Vehicle ID: ")
                hub_id = input("Pickup Hub ID: ")

                cursor.execute("""
                    INSERT INTO Reservations
                    (reservation_id, required_vehicle_type, scheduled_pickup_time,
                     expected_return_time, reservation_status, member_id,
                     vehicle_id, pickup_hub_id)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """, (reservation_id, vehicle_type, pickup_time, return_time,
                      status, member_id, vehicle_id, hub_id))

                conn.commit()
                print("Reservation created successfully.")

            elif choice == "4":
                employee_id = input("Employee ID: ")
                staff_name = input("Staff Name: ")
                staff_role = input("Staff Role: ")
                hire_date = input("Hire Date (YYYY-MM-DD): ")

                cursor.execute("""
                    INSERT INTO Staff
                    (employee_id, staff_name, staff_role, hire_date)
                    VALUES (%s, %s, %s, %s)
                """, (employee_id, staff_name, staff_role, hire_date))

                conn.commit()
                print("Staff created successfully.")

            elif choice == "5":
                maintenance_id = input("Maintenance ID: ")
                vehicle_id = input("Vehicle ID: ")
                maintenance_date = input("Maintenance Date (YYYY-MM-DD): ")
                description = input("Work Performed Description: ")
                cost = input("Maintenance Cost: ")
                staff_id = input("Performed Staff ID: ")

                cursor.execute("""
                    INSERT INTO Maintenance_Record
                    (maintenance_id, vehicle_id, maintenance_date,
                     work_performed_description, maintenance_cost, performed_staff_id)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """, (maintenance_id, vehicle_id, maintenance_date,
                      description, cost, staff_id))

                conn.commit()
                print("Maintenance record created successfully.")

            else:
                print("Invalid choice.")

        except mysql.connector.Error as err:
            conn.rollback()
            print("Error:", err)


def update_record(conn, cursor):
    while True:
        print("\n===== Update Database =====")
        print("1. Member tier")
        print("2. Vehicle status")
        print("3. Reservation status")
        print("4. Staff role")
        print("5. Vehicle mileage")
        print("6. Back to Main Menu")

        choice = input("Choose option: ")

        if choice == "6":
            break

        try:
            if choice == "1":
                member_id = input("Member ID: ")
                tier_id = input("New Tier ID: ")

                cursor.execute("""
                    UPDATE Members
                    SET tier_id = %s
                    WHERE member_id = %s
                """, (tier_id, member_id))

            elif choice == "2":
                vehicle_id = input("Vehicle ID: ")
                status = input("New Vehicle Status: ")

                cursor.execute("""
                    UPDATE Vehicle
                    SET vehicle_status = %s
                    WHERE vehicle_id = %s
                """, (status, vehicle_id))

            elif choice == "3":
                reservation_id = input("Reservation ID: ")
                status = input("New Reservation Status: ")

                cursor.execute("""
                    UPDATE Reservations
                    SET reservation_status = %s
                    WHERE reservation_id = %s
                """, (status, reservation_id))

            elif choice == "4":
                employee_id = input("Employee ID: ")
                role = input("New Staff Role: ")

                cursor.execute("""
                    UPDATE Staff
                    SET staff_role = %s
                    WHERE employee_id = %s
                """, (role, employee_id))

            elif choice == "5":
                vehicle_id = input("Vehicle ID: ")
                mileage = input("New Current Mileage: ")

                cursor.execute("""
                    UPDATE Vehicle
                    SET current_mileage = %s
                    WHERE vehicle_id = %s
                """, (mileage, vehicle_id))

            else:
                print("Invalid choice.")
                continue

            conn.commit()

            if cursor.rowcount == 0:
                print("No matching record found.")
            else:
                print("Record updated successfully.")

        except mysql.connector.Error as err:
            conn.rollback()
            print("Error:", err)


def delete_record(conn, cursor):
    while True:
        print("\n===== Delete Database =====")
        print("1. Member")
        print("2. Vehicle")
        print("3. Reservation")
        print("4. Staff")
        print("5. Maintenance Record")
        print("6. Back to Main Menu")

        choice = input("Choose option: ")

        if choice == "6":
            break

        try:
            if choice == "1":
                member_id = input("Member ID: ")
                cursor.execute("DELETE FROM Members WHERE member_id = %s", (member_id,))

            elif choice == "2":
                vehicle_id = input("Vehicle ID: ")
                cursor.execute("DELETE FROM Vehicle WHERE vehicle_id = %s", (vehicle_id,))

            elif choice == "3":
                reservation_id = input("Reservation ID: ")
                cursor.execute("DELETE FROM Reservations WHERE reservation_id = %s", (reservation_id,))

            elif choice == "4":
                employee_id = input("Employee ID: ")
                cursor.execute("DELETE FROM Staff WHERE employee_id = %s", (employee_id,))

            elif choice == "5":
                maintenance_id = input("Maintenance ID: ")
                cursor.execute("DELETE FROM Maintenance_Record WHERE maintenance_id = %s", (maintenance_id,))

            else:
                print("Invalid choice.")
                continue

            conn.commit()

            if cursor.rowcount == 0:
                print("No matching record found.")
            else:
                print("Record deleted successfully.")

        except mysql.connector.Error as err:
            conn.rollback()
            print("Error:", err)
            print("Note: Delete may fail if this record is referenced by another table through a foreign key.")


def search_record(cursor):
    while True:
        print("\n===== Search Database =====")
        print("1. Search member by name")
        print("2. Search vehicle by type")
        print("3. Search vehicle by status")
        print("4. Search reservation by member ID")
        print("5. Search maintenance by vehicle ID")
        print("6. Back to Main Menu")

        choice = input("Choose option: ")

        if choice == "6":
            break

        if choice == "1":
            name = input("Enter member name keyword: ")

            cursor.execute("""
                SELECT *
                FROM Members
                WHERE full_name LIKE %s
            """, ("%" + name + "%",))

        elif choice == "2":
            vehicle_type = input("Enter vehicle type keyword: ")

            cursor.execute("""
                SELECT *
                FROM Vehicle
                WHERE vehicle_type LIKE %s
            """, ("%" + vehicle_type + "%",))

        elif choice == "3":
            status = input("Enter vehicle status keyword: ")

            cursor.execute("""
                SELECT *
                FROM Vehicle
                WHERE vehicle_status LIKE %s
            """, ("%" + status + "%",))

        elif choice == "4":
            member_id = input("Enter member ID: ")

            cursor.execute("""
                SELECT *
                FROM Reservations
                WHERE member_id = %s
            """, (member_id,))

        elif choice == "5":
            vehicle_id = input("Enter vehicle ID: ")

            cursor.execute("""
                SELECT *
                FROM Maintenance_Record
                WHERE vehicle_id = %s
            """, (vehicle_id,))

        else:
            print("Invalid choice.")
            continue

        rows = cursor.fetchall()
        print_table(cursor, rows)


def report(cursor):
    while True:
        print("\n===== Reports =====")
        print("1. Fleet Utilization Report")
        print("2. Maintenance Cost by Vehicle")
        print("3. Back to Main Menu")

        choice = input("Choose report: ")

        if choice == "3":
            break

        if choice == "1":
            cursor.execute("""
                SELECT vehicle_status, COUNT(*) AS number_of_vehicles
                FROM Vehicle
                GROUP BY vehicle_status
            """)

        elif choice == "2":
            cursor.execute("""
                SELECT vehicle_id, SUM(maintenance_cost) AS total_maintenance_cost
                FROM Maintenance_Record
                GROUP BY vehicle_id
            """)

        else:
            print("Invalid choice.")
            continue

        rows = cursor.fetchall()
        print_table(cursor, rows)


def main():
    conn = None
    cursor = None

    try:
        conn = connect_db()
        cursor = conn.cursor()

        print("Connected to TechWheels database successfully.")

        while True:
            print("\n===================================")
            print("   TechWheels Database Application")
            print("===================================")
            print("1. Read Database")
            print("2. Create Database")
            print("3. Update Database")
            print("4. Delete Database")
            print("5. Search Database")
            print("6. Generate Report")
            print("7. Exit")

            choice = input("Enter your choice: ")

            if choice == "1":
                read_database(cursor)

            elif choice == "2":
                create_record(conn, cursor)

            elif choice == "3":
                update_record(conn, cursor)

            elif choice == "4":
                delete_record(conn, cursor)

            elif choice == "5":
                search_record(cursor)

            elif choice == "6":
                report(cursor)

            elif choice == "7":
                print("Exiting application.")
                break

            else:
                print("Invalid choice.")

    except mysql.connector.Error as err:
        print("Database error:", err)

    finally:
        if cursor is not None:
            cursor.close()

        if conn is not None and conn.is_connected():
            conn.close()
            print("Database connection closed.")


main()