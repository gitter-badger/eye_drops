defmodule EyeDrops.TasksTest do
	use ExUnit.Case
	import ExUnit.CaptureIO

	setup do
		tasks = [%{
			id: :demo1,
			name: "demo1",
			cmd: "echo demo1",
			paths: ["lib/*"]
		},
		%{
			id: :demo2,
			name: "demo2",
			cmd: "echo demo2",
			paths: ["lib/*"]
		}]
		{:ok, %{:tasks => tasks}}
	end

	test "Get tasks to run if expected file has changed" do
		tasks = EyeDrops.Tasks.to_run("some/path/lib/eye_drops.ex")
		assert Enum.at(tasks,0).id == :unit_tests
	end

	test "No tasks to run" do
		assert EyeDrops.Tasks.exec([]) == :ok
	end

	test "Run one task with expected output", %{:tasks => tasks} do
		task = Enum.at(tasks,0)
		printed = capture_io(fn ->
				EyeDrops.Tasks.exec([task])
		end)
		assert printed == "Running #{task.name}...\ndemo1\r\nFinished #{task.name}...\n"
	end

	test "Run expected tasks with expected output", %{:tasks => tasks} do
		printed = capture_io(fn ->
				EyeDrops.Tasks.exec(tasks)
		end)
		task1 = Enum.at(tasks,0)
		task2 = Enum.at(tasks,1)
		assert printed == "Running #{task1.name}...\ndemo1\r\nFinished #{task1.name}...\nRunning #{task2.name}...\ndemo2\r\nFinished #{task2.name}...\n"
	end
end