defmodule Mix.Tasks.EyeDrops.Mixfile do
  use Mix.Project

  def project do
    [app: :eye_drops,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     test_paths: ["lib"],
     aliases: aliases]
  end

  def application do
    [applications: [:logger, :fs]]
  end

  defp aliases do
    [hello: &hello/1]
  end

  defp hello(_) do
    Mix.shell.info "Hello world"
  end

  defp deps do
    [
      {:fs, "~> 0.9.1"}
    ]
  end
end
