class WordType
  include Mongoid::Document
  field :t, as: :type, type: String
  field :f, as: :frequency, type: Float
  embedded_in :word

  FULLNAME = {
  	a: 'adjective',
  	ad: 'adjective as adverbial',
  	ag: 'adjective morpheme',
  	an: 'adjective with nominal function',
  	b: 'non-predicate adjective',
  	bg: 'non-predicate adjective morpheme',
  	c: 'conjunction',
  	cg: 'conjunction morpheme',
  	d: 'adverb',
  	dg: 'adverb morpheme',
  	e: 'interjection',
  	ew: 'sentential punctuation',
  	f: 'directional locality',
  	fg: 'locality morpheme',
  	g: 'morpheme',
  	h: 'prefix',
  	i: 'idiom',
  	j: 'abbreviation',
  	k: 'suffix',
  	l: 'fixed expressions',
  	m: 'numeral',
  	mg: 'numeric morpheme',
  	n: 'common noun',
  	ng: 'noun morpheme',
  	nr: 'personal name',
  	ns: 'place name',
  	nt: 'organization name',
  	nx: 'nominal character string',
  	nz: 'other proper noun',
  	o: 'onomatopoeia',
  	p: 'preposition',
  	pg: 'preposition morpheme',
  	q: 'classifier',
  	qg: 'classifier morpheme',
  	r: 'pronoun',
  	rg: 'pronoun morpheme',
  	s: 'space word',
  	t: 'time word',
  	tg: 'time word morpheme',
  	u: 'auxiliary',
  	v: 'verb',
  	vd: 'verb as adverbial',
  	vg: 'verb morpheme',
  	vn: 'verb with nominal function',
  	w: 'symbol and non-sentential punctuation',
  	x: 'unclassified items',
  	y: 'modal particle ',
  	yg: 'modal particle morpheme',
  	z: 'descriptive',
  	zg: 'descriptive morpheme'}

  def fullname
  	FULLNAME[type.to_sym]
  end
end
