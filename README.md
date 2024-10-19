# SchoolRP++ Resource Pack
To begin with, even though I am a developer for the SchoolRP server, this pack is in no way affiliated with the server.
This is a personal project that I have been working on for some time now. And I am happy to share it with the community.

The main goal of this pack is to provide a better, smoother experience for the players of the SchoolRP server.
Personally, I dislike (to put it mildly) the default textures of most stone-like blocks like granite and diorite.
By smoothening them out, I hope to achieve a better experience. Especially because the SchoolRP pack does not 
override the most commonly used blocks in the map.

Here are some useful commands in case you want to use custom models / items I wanted to test out for SchoolRP:
```
/minecraft:give @p minecraft:leather_horse_armor[minecraft:custom_model_data=1,minecraft:dyed_color=8798368]
```
Note that above command also shows how leather armor can get a color (`8798368` here)
Use this site to get certain colors easily: https://minecraft.tools/en/armor.php
Use below command to put items on your head:
```
/minecraft:item replace entity @p armor.head with leather_horse_armor[minecraft:custom_model_data=1,minecraft:dyed_color=8798368]
```
And this below is an example of how we can use custom models:
```
{
	"parent": "item/generated",
	"textures": {
		"layer0": "item/leather_horse_armor"
	},
	"overrides": [
		{"predicate": {"custom_model_data":1}, "model": "item/custom/hat"},
		{"predicate": {"custom_model_data":2}, "model": "item/custom/hood"},
	]
}
```

# Credits

- ErLeMo - Better Weather - https://www.planetminecraft.com/texture-pack/nature-plus-v2-1-0-all-versions/ 
- Vixel  - Better GUIs    - https://modrinth.com/user/Vixel
- Kubban - Better Plants  - https://www.planetminecraft.com/texture-pack/kubban-s-flowers/