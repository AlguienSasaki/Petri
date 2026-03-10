# Para probar
# cd ../ && mix test

ExUnit.start()

defmodule PetriTest do
  use ExUnit.Case

  # Alias para no tener que andar escribiendo Petri.ex1l() cada vez
  setup do
    %{
      red_lista: Petri.ex1l(),
      red_mapa: Petri.ex1m()
    }
  end

  ##  Marcado y Disparo

  test "disparo exitoso de A desde el marcado inicial", %{red_lista: net} do
    m0 = MapSet.new([P0])
    m1 = Petri.fire(net, A, m0)
    
    esperado = MapSet.new([P1, P2])
    assert MapSet.equal?(m1, esperado)
  end

  test "disparo fallido si la transición no está habilitada", %{red_lista: net} do
    m_vacio = MapSet.new([])
    assert Petri.fire(net, A, m_vacio) == m_vacio
  end

  test "disparo de D requiere tokens en P1 Y P2", %{red_lista: net} do
    m_incompleto = MapSet.new([P1])
    assert Petri.fire(net, D, m_incompleto) == m_incompleto
    
    m_completo = MapSet.new([P1, P2])
    m_final = Petri.fire(net, D, m_completo)
    assert MapSet.member?(m_final, P3)
    assert MapSet.member?(m_final, P4)
  end

  ## Funciones enablement

  test "caso del PDF: marcado [P1, P4] habilita solo {B}", %{red_lista: net, red_mapa: mapa} do
    m = MapSet.new([P1, P4])
    
    habilitadas_l = Petri.enablement_list(net, m)
    habilitadas_m = Petri.enablement_map(mapa, m)
    
    esperado = MapSet.new([B])
    assert MapSet.equal?(habilitadas_l, esperado)
    assert MapSet.equal?(habilitadas_m, esperado)
  end

  test "caso del PDF: marcado [P1, P2] habilita {B, C, D}", %{red_lista: net, red_mapa: mapa} do
    m = MapSet.new([P1, P2])
    
    habilitadas_l = Petri.enablement_list(net, m)
    habilitadas_m = Petri.enablement_map(mapa, m)
    
    esperado = MapSet.new([B, C, D])
    assert MapSet.equal?(habilitadas_l, esperado)
    assert MapSet.equal?(habilitadas_m, esperado)
  end

  test "transición E habilitada con tokens en P3 y P4", %{red_lista: net} do
    m = MapSet.new([P3, P4])
    assert MapSet.member?(Petri.enablement_list(net, m), E)
  end
end
