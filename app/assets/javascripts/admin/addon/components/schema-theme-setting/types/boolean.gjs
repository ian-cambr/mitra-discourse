import Component from "@glimmer/component";
import { Input } from "@ember/component";
import { on } from "@ember/modifier";
import { action } from "@ember/object";

export default class SchemaThemeSettingTypeBoolean extends Component {
  @action
  onInput(event) {
    this.args.onChange(event.currentTarget.checked);
  }

  <template>
    <Input @checked={{@value}} {{on "input" this.onInput}} @type="checkbox" />
  </template>
}
