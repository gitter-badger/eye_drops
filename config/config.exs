use Mix.Config

#     import_config "#{Mix.env}.exs"

config :eye_drops, 
	tasks: [
		%{
			id: :unit_tests,
			name: "unit tests",
			cmd: "mix test",
			paths: ["lib/*"]
		},
		%{
			id: :hello,
			name: "say hello",
			cmd: "mix hello",
			paths: ["lib/*"]
		}
	]