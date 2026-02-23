#!/usr/bin/env bash
#
# persona-manager.sh - Persona selection and management for IT Crowd
#
# Handles random persona selection and persona metadata.

# Main personas - eligible for random selection as main agent
MAIN_PERSONAS=(
    "roy"
    "moss"
    "jen"
    "douglas"
)

# Subagent-only personas - delegation targets, never main agent
SUBAGENT_ONLY_PERSONAS=(
    "richmond"
    "denholm"
)

# All personas combined - for delegation roster and hook matching
ALL_PERSONAS=("${MAIN_PERSONAS[@]}" "${SUBAGENT_ONLY_PERSONAS[@]}")

# Backward compat: PERSONAS = MAIN_PERSONAS
PERSONAS=("${MAIN_PERSONAS[@]}")

# Select random persona from available list
select_random_persona() {
    local num_personas=${#PERSONAS[@]}
    local random_index=$((RANDOM % num_personas))
    echo "${PERSONAS[$random_index]}"
}

# Get display name for persona
persona_display_name() {
    local persona="$1"

    case "$persona" in
        "roy")
            echo "Roy Trenneman"
            ;;
        "moss")
            echo "Maurice Moss"
            ;;
        "jen")
            echo "Jen Barber"
            ;;
        "douglas")
            echo "Douglas Reynholm"
            ;;
        "richmond")
            echo "Richmond Avenal"
            ;;
        "denholm")
            echo "Denholm Reynholm"
            ;;
        *)
            echo "Unknown Persona"
            ;;
    esac
}

# Get user name for persona (how persona addresses user)
persona_user_name() {
    local persona="$1"

    case "$persona" in
        "roy")
            echo "mate"
            ;;
        "moss")
            echo "friend"
            ;;
        "jen")
            echo "guys"
            ;;
        "douglas")
            echo "you there"
            ;;
        "richmond")
            echo "mortal"
            ;;
        "denholm")
            echo "Stephanie"
            ;;
        *)
            echo "User"
            ;;
    esac
}

# List all available personas
list_personas() {
    for persona in "${PERSONAS[@]}"; do
        echo "- $persona ($(persona_display_name "$persona"))"
    done
}

# Get task aptitude description for a persona
persona_task_aptitude() {
    local persona="$1"

    case "$persona" in
        "roy")
            echo "Systems setup, web design, video editing, machinery modification, practical troubleshooting"
            ;;
        "moss")
            echo "Hacking, virus removal, firewall repair, circuit design, complex algorithms, deep technical problems"
            ;;
        "jen")
            echo "Documentation, presentations, communication, stakeholder management, non-technical explanations"
            ;;
        "douglas")
            echo "Business decisions, high-level strategy, executive perspective (not technical implementation)"
            ;;
        "richmond")
            echo "Business transformation, strategic pivots, rebranding, unconventional approaches"
            ;;
        "denholm")
            echo "High-level vision, declaring war on problems, authoritative decisions (no implementation)"
            ;;
        *)
            echo "General tasks"
            ;;
    esac
}
