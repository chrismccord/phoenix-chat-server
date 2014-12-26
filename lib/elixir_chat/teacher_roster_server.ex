defmodule ElixirChat.TeacherRosterServer do
  use GenServer
  alias ElixirChat.TeacherRoster, as: Roster

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :teacher_roster_server)
  end

  def add(teacher) do
    GenServer.call(:teacher_roster_server, {:add, teacher})
  end

  def claim_student(teacher_id, student_id) do
    GenServer.call(:teacher_roster_server, {:claim_student, teacher_id, student_id})
  end

  def stats do
    GenServer.call(:teacher_roster_server, :stats)
  end

  def stats_extended do
    GenServer.call(:teacher_roster_server, :stats_extended)
  end

  def can_accept_more_students?(teacher_id) do
    GenServer.call(:teacher_roster_server, {:can_accept_more_students, teacher_id})
  end

  def chat_finished(teacher_id, student_id) do
    GenServer.call(:teacher_roster_server, {:chat_finished, teacher_id, student_id})
  end

  def init(_) do
    {:ok, Roster.new}
  end

  def handle_call({:add, teacher}, _from, roster) do
    roster = Roster.add(roster, teacher)
    {:reply, teacher, roster}
  end

  def handle_call({:can_accept_more_students, teacher_id}, _from, roster) do
    teacher = Roster.find(roster, teacher_id)
    result  = Roster.can_accept_more_students?(roster, teacher)
    {:reply, result, roster}
  end

  def handle_call({:claim_student, teacher_id, student_id}, _from, roster) do
    roster = Roster.claim_student(roster, teacher_id, student_id)
    {:reply, teacher_id, roster}
  end

  def handle_call({:chat_finished, teacher_id, student_id}, _from, roster) do
    roster = Roster.chat_finished(roster, teacher_id, student_id)
    {:reply, :ok, roster}
  end

  def handle_call(:stats, _from, roster) do
    result = Roster.stats(roster)
    {:reply, result, roster}
  end

  def handle_call(:stats_extended, _from, roster) do
    result = Roster.stats_extended(roster)
    {:reply, result, roster}
  end
end
