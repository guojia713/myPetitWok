package com.example.cuisine.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "recipe_step_translations",
       uniqueConstraints = @UniqueConstraint(columnNames = {"step_id", "language"}))
@Getter @Setter @NoArgsConstructor
public class RecipeStepTranslation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "step_id", nullable = false)
    private RecipeStep step;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private Language language;

    // The cooking instruction for this step in this language
    @Column(nullable = false, columnDefinition = "TEXT")
    private String instruction;

    // Optional cooking tip for this step
    // e.g. "The oil should be very hot — you'll hear a loud sizzle"
    @Column(columnDefinition = "TEXT")
    private String tip;
}
