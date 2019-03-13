package com.vironit.airticketsbooking.springapp.entity;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;


import javax.persistence.*;
import javax.validation.constraints.*;
import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;


@Getter
@Setter
@EqualsAndHashCode
@ToString(exclude = {"ordersOfUser"})
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "air_ticket_booking_system.users")
@Component
public class User implements Serializable {

    private static final long serialVersionUID = 2777593605973065364L;

    @Id
    @GeneratedValue
    private Long id;
    @Column
    @NotNull
    @Email(message = "Enter correct email")
    private String email;
    @Column
    @NotNull
    @Pattern(regexp = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,100}",
            message = "Password must have 6+ chars (at least one number, one upper and lower case letter, max 30 chars)")
    private String password;
    @Column
    @NotNull
    @Size(min = 2, max = 20, message = "Name must be between 1 and 20 characters")
    private String name;
    @Column
    @NotNull
    @Size(min = 2, max = 20, message = "Name must be between 1 and 20 characters")
    private String surname;
    @Column
    @NotNull
    @Size(min = 10, max = 20, message = "Passport number must be between 10 and 20 characters")
    private String passport_number;
    @Column
    @NotNull
    @DateTimeFormat(pattern = "YYYY-MM-DD")
    private Date dob;
    @Column
    @NotNull
    private String sex;
    @Column
    @NotNull
    @Pattern(regexp = "[+]\\d{3}[(]\\d{2}[)]\\d{3}[-]\\d{2}[-]\\d{2}",
            message = "Enter phone number in correct format: +375(29)777-77-77")
    private String phone_number;
    @Enumerated(EnumType.STRING)
    @Column
    private Role role;
    @Column
    @NotNull
    @Min(value = 10, message = "Balance should not be less than 10")
    @Max(value = 1000, message = "Balance should not be more than 1000")
    private double balance;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Order> ordersOfUser = new ArrayList<>();

    public User(String email, String password, String name, String surname, String passport_number, Date dob, String sex, String phone_number, Role role, double balance) {
        this.email = email;
        this.password = password;
        this.name = name;
        this.surname = surname;
        this.passport_number = passport_number;
        this.dob = dob;
        this.sex = sex;
        this.phone_number = phone_number;
        this.role = role;
        this.balance = balance;
    }

    public enum Role {
        ADMIN, USER
    }

}
