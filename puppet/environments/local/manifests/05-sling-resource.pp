
anchor { 'immerse::sling::begin' : }

$res_props = {
  'jcr:primaryType' => 'nt:unstructured',
  'title'            => 'title string',
  'text'             => 'text string',
  'child'            => {
    'jcr:primaryType' => 'nt:unstructured',
    'property'         => 'value',
    'grandchild'       => {
      'jcr:primaryType' => 'nt:unstructured',
      'child attrib'     => 'another value',
      'array'            => ['this', 'is', 'an', 'array']
    }
  }
}

aem_sling_resource { 'test-node' :
  ensure         => present,
  path           => '/content/testnode',
  properties     => $res_props,
  handle_missing => 'remove',
  home           => '/opt/aem',
  password       => $admin_password,
  username       => 'admin',
  require        => Aem::Instance['aem']
}

anchor { 'immerse::sling::end' : }

Anchor['immerse::agents::end']
-> Anchor['immerse::sling::begin']
-> Aem_Sling_Resource['test-node']
-> Anchor['immerse::sling::end']