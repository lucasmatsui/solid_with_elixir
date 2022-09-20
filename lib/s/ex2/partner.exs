defmodule Partner do
  alias __MODULE__, as: Partner

  defstruct [:id, :name, :cnpj, :email, :installed_projects]

  @type t :: %Partner{
    id: String.t(),
    name: String.t(),
    email: String.t(),
    cnpj: String.t(),
    installed_projects: integer()
  }

  @spec new(String.t(), String.t(), String.t(), integer()) :: t()
  def new(name, email, cnpj, installed_projects) do
    %Partner{
      id: "6efdb246-8e01-485f-b814-3ab3fad87c3e",
      name: name,
      email: email,
      cnpj: cnpj,
      installed_projects: installed_projects
    }
  end

  def valid_email(%Partner{email: email} = partner) do
    unless String.contains?(email, "@") do
      raise ArgumentError, message: "invalid email"
    end

    partner
  end

  def valid_cnpj(%Partner{cnpj: cnpj} = partner) do
    unless String.contains?(cnpj, ".") do
      raise ArgumentError, message: "invalid cnpj"
    end

    partner
  end

  def change_email(%Partner{} = partner, email) do
    %{partner | email: email}
  end

  def change_cnpj(%Partner{} = partner, cnpj) do
    %{partner | cnpj: cnpj}
  end
end

Partner.new(
  "Lucas",
  "lucas-matsui@hotmail.com",
  "490.359.249/02",
  9
)
|> Partner.valid_email()
|> Partner.valid_cnpj()
|> Partner.change_email("kenzo@gmail.com")
|> Partner.change_cnpj("420.239.425/92")
|> Partner.valid_email()
|> Partner.valid_cnpj()
|> IO.inspect()
