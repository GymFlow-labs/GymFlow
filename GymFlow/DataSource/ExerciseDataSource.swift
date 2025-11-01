//
//  ExerciseDataSource.swift
//  GymFlow
//
//  Created by Artem Kriukov on 31.10.2025.
//

import Foundation
// swiftlint:disable line_length
let exercisesDataSource: [Exercise] = [
    Exercise(name: "Snatch", nameRu: "Рывок в сед", category: "strength", description: "Взрывное поднятие штанги с пола над головой одним движением с уходом в глубокий присед", id: "1"),
    Exercise(name: "Power Snatch", nameRu: "Рывок в стойку", category: "strength", description: "Рывок штанги над головой без ухода в глубокий присед", id: "2"),
    Exercise(name: "Squat Clean", nameRu: "Взятие в сед", category: "strength", description: "Подъем штанги с пола на грудь с уходом в глубокий присед", id: "3"),
    Exercise(name: "Power Clean", nameRu: "Взятие в стойку", category: "strength", description: "Взятие штанги на грудь без ухода в глубокий присед", id: "4"),
    Exercise(name: "Clean and Jerk", nameRu: "Толчок", category: "strength", description: "Взятие штанги на грудь с последующим выталкиванием над головой", id: "5"),
    Exercise(name: "Deadlift", nameRu: "Становая тяга", category: "strength", description: "Подъем штанги с пола до полного выпрямления корпуса", id: "6"),
    Exercise(name: "Sumo Deadlift High Pull", nameRu: "Тяга сумо", category: "strength", description: "Тяга штанги из стойки 'сумо' с подтягиванием вдоль тела до уровня подбородка", id: "7"),
    Exercise(name: "Back Squat", nameRu: "Приседания со штангой на спине", category: "strength", description: "Приседания со штангой расположенной на плечах сзади", id: "8"),
    Exercise(name: "Front Squat", nameRu: "Фронтальные приседания", category: "strength", description: "Приседания со штангой расположенной на передних дельтах", id: "9"),
    Exercise(name: "Overhead Squat", nameRu: "Оверхед приседания", category: "strength", description: "Приседания с удержанием штанги на прямых руках над головой на протяжении всего движения", id: "10"),
    Exercise(name: "Shoulder Press", nameRu: "Жим стоя", category: "strength", description: "Строгий жим штанги над головой из положения стоя", id: "11"),
    Exercise(name: "Push Press", nameRu: "Швунг жимовой", category: "strength", description: "Жим штанги над головой с использованием подседа для инерции", id: "12"),
    Exercise(name: "Push Jerk", nameRu: "Швунг толчковый", category: "strength", description: "Выталкивание штанги над головой с уходом под нее в подсед", id: "13"),
    Exercise(name: "Thruster", nameRu: "Трастер", category: "strength", description: "Фронтальный присед с последующим выталкиванием штанги над головой", id: "14"),
    Exercise(name: "Bench Press", nameRu: "Жим лежа", category: "strength", description: "Жим штанги лежа на горизонтальной скамье", id: "15"),
    Exercise(name: "Kettlebell Swing", nameRu: "Махи гирей", category: "strength", description: "Махи гирей двумя руками до уровня глаз", id: "16"),
    Exercise(name: "Turkish Get-Up", nameRu: "Турецкий подъем", category: "strength", description: "Медленный подъем из положения лежа в положение стоя с гирей над головой", id: "17"),
    Exercise(name: "Goblet Squat", nameRu: "Гоблет приседания", category: "strength", description: "Приседания с удержанием гири или гантели двумя руками у груди", id: "18"),
    Exercise(name: "Pull-Up", nameRu: "Подтягивания", category: "gymnastics", description: "Строгие подтягивания на перекладине", id: "19"),
    Exercise(name: "Chest-to-Bar Pull-Up", nameRu: "Подтягивания до груди", category: "gymnastics", description: "Подтягивания с касанием грудью перекладины", id: "20"),
    Exercise(name: "Butterfly Pull-Up", nameRu: "Подтягивания баттерфляй", category: "gymnastics", description: "Подтягивания с маховым движением и киппингом", id: "21"),
    Exercise(name: "Kipping Pull-Up", nameRu: "Подтягивания кипинг", category: "gymnastics", description: "Подтягивания с маятниковым движением тела для создания инерции", id: "22"),
    Exercise(name: "Bar Muscle-Up", nameRu: "Выход силой на турнике", category: "gymnastics", description: "Переход из виса в упор на перекладине одним движением", id: "23"),
    Exercise(name: "Ring Muscle-Up", nameRu: "Выход силой на кольцах", category: "gymnastics", description: "Переход из виса в упор на гимнастических кольцах", id: "24"),
    Exercise(name: "Handstand Push-Up", nameRu: "Строгие отжимания в стойке на руках", category: "gymnastics", description: "Отжимания вниз головой у стены", id: "25"),
    Exercise(name: "Kipping Handstand Push-Up", nameRu: "Отжимания в стойке на руках с киппингом", category: "gymnastics", description: "Отжимания в стойке на руках с использованием махового движения ногами для облегчения подъема", id: "26"),
    Exercise(name: "Handstand Walk", nameRu: "Ходьба на руках", category: "gymnastics", description: "Передвижение в стойке на руках без опоры на ноги", id: "27"),
    Exercise(name: "Toes-to-Bar", nameRu: "Подъем ног к турнику", category: "gymnastics", description: "Подъем прямых ног до касания носками перекладины", id: "28"),
    Exercise(name: "Knees-to-Elbow", nameRu: "Подъем коленей к локтям на турнике", category: "gymnastics", description: "Подъем согнутых ног до касания коленями локтей", id: "29"),
    Exercise(name: "L-Sit", nameRu: "Уголок", category: "gymnastics", description: "Удержание прямых ног под углом 90 градусов в висе или упоре", id: "30"),
    Exercise(name: "Pistol Squat", nameRu: "Приседания на одной ноге", category: "gymnastics", description: "Полные приседания на одной ноге с вытянутой второй ногой", id: "31"),
    Exercise(name: "Push-Up", nameRu: "Отжимания от пола", category: "gymnastics", description: "Классические отжимания от пола с полной амплитудой", id: "32"),
    Exercise(name: "Ring Dip", nameRu: "Отжимания на кольцах", category: "gymnastics", description: "Отжимания в упоре на гимнастических кольцах", id: "33"),
    Exercise(name: "Bar Dip", nameRu: "Отжимания на брусьях", category: "gymnastics", description: "Отжимания на параллельных брусьях", id: "34"),
    Exercise(name: "Air Squat", nameRu: "Приседания без веса", category: "gymnastics", description: "Классические приседания без дополнительного отягощения", id: "35"),
    Exercise(name: "Wall Ball", nameRu: "Броски мяча в стену", category: "gymnastics", description: "Присед с последующим выбросом медбола в мишень на стене", id: "36"),
    Exercise(name: "Sit-Up", nameRu: "Подъемы корпуса", category: "gymnastics", description: "Подъем туловища из положения лежа в положение сидя", id: "37"),
    Exercise(name: "V-Up", nameRu: "Складка", category: "gymnastics", description: "Одновременный подъем прямых ног и корпуса с касанием носков", id: "38"),
    Exercise(name: "Running", nameRu: "Бег", category: "cardio", description: "Бег на различные дистанции по дорожке или пересеченной местности", id: "39"),
    Exercise(name: "Rowing", nameRu: "Гребля", category: "cardio", description: "Гребля на специальном тренажере-гребце", id: "40"),
    Exercise(name: "Assault Bike", nameRu: "Байк", category: "cardio", description: "Интенсивная работа на воздушном велотренажере с подвижными ручками", id: "41"),
    Exercise(name: "Ski Erg", nameRu: "Лыжы", category: "cardio", description: "Имитация лыжных движений на специальном тренажере", id: "42"),
    Exercise(name: "Double Unders", nameRu: "Двойные прыжки на скакалке", category: "cardio", description: "Прыжки через скакалку с двойным прокрутом за один прыжок", id: "43"),
    Exercise(name: "Single Unders", nameRu: "Одиночные прыжки на скакалке", category: "cardio", description: "Классические прыжки через скакалку с одинарным прокрутом", id: "44"),
    Exercise(name: "Box Jump", nameRu: "Запрыгивания на бокс", category: "cardio", description: "Прыжки на возвышение (бокс) с полным выпрямлением вверху", id: "45"),
    Exercise(name: "Burpee", nameRu: "Бёрпи", category: "cardio", description: "Комплексное упражнение: упор лежа, отжимание, прыжок с хлопком", id: "46"),
    Exercise(name: "Pool Swimming", nameRu: "Плавание", category: "cardio", description: "Плавание в бассейне на дистанцию", id: "47")
]
