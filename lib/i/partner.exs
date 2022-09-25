defmodule User do
  @callback change_name(struct(), String.t()) :: struct()
  @callback auth :: boolean()
  @callback change_cnpj(struct(), String.t()) :: struct()
  @callback buy_solar_panel(struct(), String.t()) :: number()
end

defmodule Partner do
  alias __MODULE__, as: Partner

  @behaviour User

  defstruct [:id, :name, :cnpj]

  def auth do
    true
  end

  def change_name(%Partner{} = partner, name) do
    %{partner | name: name}
  end

  def change_cnpj(%Partner{} = partner, cnpj) do
    %{partner | cnpj: cnpj}
  end

  def buy_solar_panel(%Partner{} = _partner, amount) do
    amount
  end
end

defmodule Customer do
  alias __MODULE__, as: Customer

  @behaviour User

  defstruct [:id, :name, :cpf]

  def auth do
    true
  end

  def change_name(%Customer{} = customer, name) do
    %{customer | name: name}
  end

  def change_cpf(%Customer{} = customer, cpf) do
    %{customer | cpf: cpf}
  end
end
