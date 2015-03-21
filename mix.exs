defmodule ElixirChat.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_chat,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {ElixirChat, []},
     applications: [:phoenix, :cowboy, :logger]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
     {:phoenix, "0.10.0"},
     {:cowlib,  "1.0.0"},
     {:cowboy,  "~> 1.0"},
     {:poolboy, "~> 1.4.2", optional: true},
     {:eredis, github: "wooga/eredis", optional: true},
     {:uuid,    "~> 0.1.5" },
     {:exactor, "~> 2.0.0" },
     {:exrm, "~> 0.14.16"},
      ]
  end
end
