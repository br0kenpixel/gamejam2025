extends Resource
class_name InsectCategories

enum InsectCategory {
    Volans,
    Anteater,
    Filth,
    Perditor,
}

const DAMAGE_MAP_LUT := {
    [InsectCategory.Volans, InsectCategory.Volans]: 1.00,
    [InsectCategory.Volans, InsectCategory.Anteater]: 1.20,
    [InsectCategory.Volans, InsectCategory.Filth]: 0.80,
    [InsectCategory.Volans, InsectCategory.Perditor]: 1.00,

    [InsectCategory.Anteater, InsectCategory.Anteater]: 0.80,
    [InsectCategory.Anteater, InsectCategory.Filth]: 1.20,
    [InsectCategory.Anteater, InsectCategory.Perditor]: 1.00,

    [InsectCategory.Filth, InsectCategory.Filth]: 0.80,
    [InsectCategory.Filth, InsectCategory.Perditor]: 1.00,

    [InsectCategory.Perditor, InsectCategory.Anteater]: 1.20,
    [InsectCategory.Perditor, InsectCategory.Perditor]: 0.70,
}

static func get_category_damage(first: InsectCategory, second: InsectCategory) -> float:
    if DAMAGE_MAP_LUT.has([first, second]):
        return DAMAGE_MAP_LUT.get([first, second])
    elif DAMAGE_MAP_LUT.has([second, first]):
        return DAMAGE_MAP_LUT.get([second, first])
    else:
        push_error("Undefined damage for categories: ", first, ", ", second)
        return 0

static func category_to_string(category: InsectCategory) -> String:
    match category:
        InsectCategory.Volans:
            return "Volans"
        InsectCategory.Anteater:
            return "Anteater"
        InsectCategory.Filth:
            return "Filth"
        InsectCategory.Perditor:
            return "Perditor"
        _:
            return "<UNKNOWN>"