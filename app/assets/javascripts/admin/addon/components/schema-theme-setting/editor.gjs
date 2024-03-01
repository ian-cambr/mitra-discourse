import Component from "@glimmer/component";
import { cached, tracked } from "@glimmer/tracking";
import { fn } from "@ember/helper";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import DButton from "discourse/components/d-button";
import I18n from "discourse-i18n";
import FieldInput from "./field";

class Node {
  @tracked text;
  object;
  schema;
  index;
  active = false;
  trees = [];

  constructor({ text, index, object, schema }) {
    this.text = text;
    this.index = index;
    this.object = object;
    this.schema = schema;
  }
}

class Tree {
  propertyName = null;
  nodes = [];
}

export default class SchemaThemeSettingEditor extends Component {
  @tracked activeIndex = 0;
  @tracked backButtonText;
  history = [];

  @cached
  get tree() {
    let schema = this.args.schema;
    let data = this.args.data;

    for (const point of this.history) {
      data = data[point.node.index][point.propertyName];
      schema = schema.properties[point.propertyName].schema;
    }

    const tree = new Tree();

    data.forEach((object, index) => {
      const node = new Node({
        index,
        schema,
        object,
        text: object[schema.identifier],
      });
      if (index === this.activeIndex) {
        node.active = true;
        const childObjectsProperties = this.findChildObjectsProperties(
          schema.properties
        );
        for (const childObjectsProperty of childObjectsProperties) {
          const subtree = new Tree();
          subtree.propertyName = childObjectsProperty.name;
          data[index][childObjectsProperty.name].forEach(
            (childObj, childIndex) => {
              subtree.nodes.push(
                new Node({
                  text: childObj[childObjectsProperty.schema.identifier],
                  index: childIndex,
                  object: childObj,
                  schema: childObjectsProperty.schema,
                })
              );
            }
          );
          node.trees.push(subtree);
        }
      }
      tree.nodes.push(node);
    });
    return tree;
  }

  @cached
  get activeNode() {
    return this.tree.nodes.find((node, index) => {
      return index === this.activeIndex;
    });
  }

  get fields() {
    const node = this.activeNode;
    const list = [];
    for (const [name, spec] of Object.entries(node.schema.properties)) {
      if (spec.type === "objects") {
        continue;
      }
      list.push({
        name,
        spec,
        value: node.object[name],
      });
    }
    return list;
  }

  findChildObjectsProperties(properties) {
    const list = [];
    for (const [name, spec] of Object.entries(properties)) {
      if (spec.type === "objects") {
        list.push({
          name,
          schema: spec.schema,
        });
      }
    }
    return list;
  }

  @action
  onClick(node) {
    this.activeIndex = node.index;
  }

  @action
  onChildClick(node, tree, parentNode) {
    this.history.push({
      propertyName: tree.propertyName,
      node: parentNode,
    });
    this.backButtonText = I18n.t("admin.customize.theme.schema.back_button", {
      name: parentNode.text,
    });
    this.activeIndex = node.index;
  }

  @action
  backButtonClick() {
    const historyPoint = this.history.pop();
    this.activeIndex = historyPoint.node.index;
    if (this.history.length > 0) {
      this.backButtonText = I18n.t("admin.customize.theme.schema.back_button", {
        name: this.history[this.history.length - 1].node.text,
      });
    } else {
      this.backButtonText = null;
    }
  }

  @action
  inputFieldChanged(field, newVal) {
    if (field.name === this.activeNode.schema.identifier) {
      this.activeNode.text = newVal;
    }
    this.activeNode.object[field.name] = newVal;
  }

  <template>
    <div class="schema-editor-navigation">
      {{#if this.backButtonText}}
        <DButton
          @action={{this.backButtonClick}}
          @icon="chevron-left"
          @translatedLabel={{this.backButtonText}}
          class="back-button"
        />
      {{/if}}
      <ul class="tree">
        {{#each this.tree.nodes as |node|}}
          <div class="item-container">
            <li
              role="link"
              class="parent node{{if node.active ' active'}}"
              {{on "click" (fn this.onClick node)}}
            >
              {{node.text}}
            </li>
            {{#each node.trees as |nestedTree|}}
              <ul>
                {{#each nestedTree.nodes as |childNode|}}
                  <li
                    role="link"
                    class="child node"
                    {{on
                      "click"
                      (fn this.onChildClick childNode nestedTree node)
                    }}
                  >{{childNode.text}}</li>
                {{/each}}
              </ul>
            {{/each}}
          </div>
        {{/each}}
      </ul>
      {{#each this.fields as |field|}}
        <FieldInput
          @name={{field.name}}
          @value={{field.value}}
          @spec={{field.spec}}
          @onValueChange={{fn this.inputFieldChanged field}}
        />
      {{/each}}
    </div>
  </template>
}
