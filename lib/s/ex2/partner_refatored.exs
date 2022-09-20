defmodule Email do
  alias __MODULE__, as: Email

  defstruct [:value]

  @type t :: %Email{
    value: String.t(),
  }

  def new(email) do
    unless String.contains?(email, "@") do
      raise ArgumentError, message: "invalid email"
    end

    %Email{
      value: email
    }
  end
end

defmodule Cnpj do
  alias __MODULE__, as: Cnpj

  defstruct [:value]

  @type t :: %Cnpj{
    value: String.t(),
  }

  def new(cnpj) do
    unless String.contains?(cnpj, ".") do
      raise ArgumentError, message: "invalid email"
    end

    %Cnpj{
      value: cnpj
    }
  end
end

defmodule Partner do
  alias __MODULE__, as: Partner

  defstruct [:id, :name, :cnpj, :email, :installed_projects]

  @type t :: %Partner{
    id: String.t(),
    name: String.t(),
    email: Email.t(),
    cnpj: Cnpj.t(),
    installed_projects: integer()
  }

  @spec new(String.t(), Email.t(), Cnpj.t(), integer()) :: t()
  def new(name, %Email{} = email, %Cnpj{} = cnpj, installed_projects) do
    %Partner{
      id: "6efdb246-8e01-485f-b814-3ab3fad87c3e",
      name: name,
      email: email,
      cnpj: cnpj,
      installed_projects: installed_projects
    }
  end

  def change_email(%Partner{} = partner, %Email{} = email) do
    %{partner | email: email}
  end

  def change_cnpj(%Partner{} = partner, %Cnpj{} = cnpj) do
    %{partner | cnpj: cnpj}
  end
end

Partner.new(
  "Lucas",
  Email.new("lucas-matsui@hotmail.com"),
  Cnpj.new("490.359.249/02"),
  9
)
|> Partner.change_email(Email.new("kenzo@gmail.com"))
|> Partner.change_cnpj(Cnpj.new("420.239.425/92"))
