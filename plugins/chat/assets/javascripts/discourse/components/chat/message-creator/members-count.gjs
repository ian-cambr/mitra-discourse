import Component from "@glimmer/component";
import concatClass from "discourse/helpers/concat-class";
import I18n from "discourse-i18n";
import gte from "truth-helpers/helpers/gte";

export default class MembersCount extends Component {
  get countLabel() {
    return I18n.t("chat.direct_message_creator.members_counter", {
      count: this.args.count,
      max: this.args.max,
    });
  }

  <template>
    <div
      class={{concatClass
        "chat-message-creator__members-count"
        (if (gte @count @max) "-reached-limit")
      }}
    >
      {{this.countLabel}}
    </div>
  </template>
}
