defmodule Partner do
  alias __MODULE__, as: Partner

  defstruct [:id, :name, :cnpj, :email, :installed_projects, :level]

  @type t :: %Partner{
    id: String.t(),
    name: String.t(),
    email: String.t(),
    cnpj: String.t(),
    installed_projects: integer(),
    level: integer(),
  }

  @spec new(String.t(), String.t(), String.t(), integer(), integer()) :: t()
  def new(name, email, cnpj, installed_projects, level) do
    %Partner{
      id: "6efdb246-8e01-485f-b814-3ab3fad87c3e",
      name: name,
      email: email,
      cnpj: cnpj,
      installed_projects: installed_projects,
      level: level
    }
  end

  def change_email(%Partner{} = partner, email) do
    %{partner | email: email}
  end

  def change_cnpj(%Partner{} = partner, cnpj) do
    %{partner | cnpj: cnpj}
  end

  def calculate_benefit_points(%Partner{} = partner) do
    cond do
      partner.level == 1 ->
        partner.installed_projects * 0.1 |> IO.inspect(label: "Nivel 1")
      partner.installed_projects >= 5 and partner.level == 2 ->
        partner.installed_projects * 0.2 |> IO.inspect(label: "Nivel 2")
      partner.level == 3 ->
        partner.installed_projects * 0.3 |> IO.inspect(label: "Nivel 3")
      partner.installed_projects >= 8 and partner.level == 4 ->
        partner.installed_projects * 0.4 |> IO.inspect(label: "Nivel 4")
      partner.installed_projects >= 15 and partner.level == 5 ->
        partner.installed_projects * 0.5 |> IO.inspect(label: "Nivel 5")
      partner.installed_projects >= 35 and partner.level == 6 ->
        partner.installed_projects * 0.8 |> IO.inspect(label: "Nivel 6")
      true ->
        0 |> IO.inspect(label: "Nao ganhou nenhum ponto")
    end
  end
end

partner =
  Partner.new(
    "Lucas",
    "lucas-matsui@hotmail.com",
    "84.752.970/0001-33",
    8,
    4
  )

Partner.calculate_benefit_points(partner)
