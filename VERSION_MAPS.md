<h1>Head UV Mappings</h1>
<h5>
In normal Minecraft shaders, the UVs of the head are mapped differently compared to sodium, for maintainability and documentation purpose, I attempt to list both mappings here per version in case they change it...
</h5>

<hr />

<p>
Besides the possibily of changing mappings, we have 2 locations for the <code>rendertype_entity_translucent.vsh</code> and <code>rendertype_entity_translucent.vsh</code> files:
<ol>
<li><code>assets/minecraft/shaders/</code></li>
<li><code>assets/minecraft/shaders/core/</code></li>
</ol>
</p>
With the <code>core</code> folder bringing support to versions <code><=1.21.1</code>.
While modern versions use the files that are directly in the <code>shaders</code> directory.
<hr />

<table>
  <tr>
    <th>Version</th>
    <th></th>
    <th>Left</th>
    <th>Right</th>
    <th>Up</th>
    <th>Down</th>
    <th>Front</th>
    <th>Back</th>
  </tr>
  <tr>

  </tr>
  <tr>
    <td><b>Sodium 1.21.x</b></td>
    <td></td>
    <td>2</td>
    <td>4</td>
    <td>0</td>
    <td>1</td>
    <td>3</td>
    <td>5</td>
  </tr>
</table>