class Admin::DashboardController < AdminController
  def show
    @students_count = Person.joins(:level).where(active: true).where(levels: { name: Level::STUDENT_NAMES }).count
    @teachers_count = Person.joins(:level).where(active: true).where(levels: { name: Level::LEADER_NAMES }).count
    @levels_count = Level.joins(:people).where(name: Level::STUDENT_NAMES).where(people: { active: true }).distinct.count
    @students_level_ids = Level.where(name: Level::STUDENT_NAMES).ids
    @teachers_level_ids = Level.where(name: Level::LEADER_NAMES).ids
    @feast_day, @feast_people = Person.next_feastday_persons.first
  end
end
