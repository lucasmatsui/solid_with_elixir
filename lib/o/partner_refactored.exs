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

  @rules_calculate_points [
    IsLevel1,
    IsLevel2AndInstalledProjectsMoreThan5,
    IsLevel3,
    IsLevel4AndInstalledProjectsMoreThan8,
    IsLevel5AndInstalledProjectsMoreThan15,
    IsLevel6AndInstalledProjectsMoreThan35,
    NoPointsToCalculate
  ]

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
    CalculateBenefitPointsHandler.execute(@rules_calculate_points, partner)
  end
end

defmodule Contract.CalculateBenefitPoints do
  @type t :: module()
  @callback calculate_points(Partner.t()) :: number()
end

defmodule IsLevel1 do
  @behaviour Contract.CalculateBenefitPoints

  def calculate_points(%Partner{} = partner) when partner.level == 1 do
    partner.installed_projects * 0.1 |> IO.inspect(label: "Nivel 1")
  end

  def calculate_points(_partner), do: -1
end

defmodule IsLevel2AndInstalledProjectsMoreThan5 do
  @behaviour Contract.CalculateBenefitPoints

  def calculate_points(%Partner{} = partner)
    when partner.installed_projects >= 5 and partner.level == 2 do
      partner.installed_projects * 0.2 |> IO.inspect(label: "Nivel 2")
  end

  def calculate_points(_partner), do: -1
end

defmodule IsLevel3 do
  @behaviour Contract.CalculateBenefitPoints

  def calculate_points(%Partner{} = partner) when partner.level == 3 do
    partner.installed_projects * 0.3 |> IO.inspect(label: "Nivel 3")
  end

  def calculate_points(_partner), do: -1
end

defmodule IsLevel4AndInstalledProjectsMoreThan8 do
  @behaviour Contract.CalculateBenefitPoints

  def calculate_points(%Partner{} = partner)
    when partner.level == 4 and partner.installed_projects >= 8 do
      partner.installed_projects * 0.4 |> IO.inspect(label: "Nivel 4")
  end

  def calculate_points(_partner), do: -1
end

defmodule IsLevel5AndInstalledProjectsMoreThan15 do
  @behaviour Contract.CalculateBenefitPoints

  def calculate_points(%Partner{} = partner)
    when partner.level == 5 and partner.installed_projects >= 15 do
      partner.installed_projects * 0.5 |> IO.inspect(label: "Nivel 5")
  end

  def calculate_points(_partner), do: -1
end

defmodule IsLevel6AndInstalledProjectsMoreThan35 do
  @behaviour Contract.CalculateBenefitPoints

  def calculate_points(%Partner{} = partner)
    when partner.level == 6 and partner.installed_projects >= 35 do
      partner.installed_projects * 0.8 |> IO.inspect(label: "Nivel 6")
  end

  def calculate_points(_partner), do: -1
end

defmodule NoPointsToCalculate do
  @behaviour Contract.CalculateBenefitPoints

  def calculate_points(%Partner{} = _partner) do
    0 |> IO.inspect(label: "Nao ganhou nenhum ponto")
  end
end

defmodule CalculateBenefitPointsHandler do
  @spec execute([Contract.CalculateBenefitPoints.t()], Partner.t()) :: number()
  def execute(rules, %Partner{} = partner) do
    Enum.reduce_while(rules, 0, fn rule, acc ->
      result = rule.calculate_points(partner)
      if result == -1, do: {:cont, acc}, else: {:halt, result}
    end)
  end
end

partner =
  Partner.new(
    "Lucas",
    "lucas-matsui@hotmail.com",
    "84.752.970/0001-33",
    5,
    2
  )

Partner.calculate_benefit_points(partner)
