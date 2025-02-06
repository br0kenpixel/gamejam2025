extends Resource
class_name InsectCategories

enum InsectCategory {
    Volans,
    Anteater,
    Filth,
    Perditor,
}

const DAMAGE_MAP_LUT := {
    [InsectCategory.Volans, InsectCategory.Volans]: 100,
    [InsectCategory.Volans, InsectCategory.Anteater]: 120,
    [InsectCategory.Volans, InsectCategory.Filth]: 80,
    [InsectCategory.Volans, InsectCategory.Perditor]: 100,

    [InsectCategory.Anteater, InsectCategory.Anteater]: 80,
    [InsectCategory.Anteater, InsectCategory.Filth]: 120,
    [InsectCategory.Anteater, InsectCategory.Perditor]: 100,

    [InsectCategory.Filth, InsectCategory.Filth]: 80,
    [InsectCategory.Filth, InsectCategory.Perditor]: 100,

    [InsectCategory.Perditor, InsectCategory.Anteater]: 120,
    [InsectCategory.Perditor, InsectCategory.Perditor]: 70,
}

func get_category_damage(first: InsectCategory, second: InsectCategory) -> int:
    if DAMAGE_MAP_LUT.has([first, second]):
        return DAMAGE_MAP_LUT.get([first, second])
    elif DAMAGE_MAP_LUT.has([second, first]):
        return DAMAGE_MAP_LUT.get([second, first])
    else:
        push_error("Undefined damage for categories: ", first, ", ", second)
        return 0
