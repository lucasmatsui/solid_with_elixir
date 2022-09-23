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

  def change_email(%Partner{} = partner, email) do
    %{partner | email: email}
  end

  def change_cnpj(%Partner{} = partner, cnpj) do
    %{partner | cnpj: cnpj}
  end

  def calculate_projects_points(%Partner{installed_projects: installed_projects}) do
    installed_projects * 2.9
  end
end

defmodule PartnerRepository do
  def save_in_db(%Partner{} = partner) do
    Repo.save(partner)
    nil
  end

  @spec get_partner_by_id(integer()) :: Partner.t()
  def get_partner_by_id(id) do
    response = Repo.get_by_id(id)

    Partner.new(
      id: response.id,
      name: response.name,
      email: response.email,
      cnpj: response.cnpj,
      installed_projects: response.installed_projects,
    )
  end
end

partner =
  Partner.new(
    "Lucas",
    "lucas-matsui@hotmail.com",
    "490.359.249/02",
    7
  )

PartnerRepository.save_in_db(partner)
PartnerRepository.get_partner_by_id(partner.id)
