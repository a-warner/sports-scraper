module PlayerHelper
  def link_to_player(player)
    return unless player
    (link_to(player.name, player) + ' ' + '(' + link_to('ESPN', player.url, target: '_blank') + ')').html_safe
  end
end
