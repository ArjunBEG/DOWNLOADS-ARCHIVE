<?php

class ForgeMDParser {
	
	protected $data;
	protected $xml;
	
	protected $options;
	protected $sections = array();
	protected $arbitrarySections = array();
	protected $images = array();
	protected $plugin = array(
		'name' => null,
		'description' => null,
		'screenshot' => null,
	);
	
	public function __construct($data, $options = array()){
		$this->options = array_merge(array(
			'defaultSections' => array('how-to-use'),
		), $options);
		
		$this->data = $data;
		$this->parse();
	}
	
	protected function getSectionName($section){
		return preg_replace('/[^A-z0-9]/', '-', strtolower(strip_tags($section)));
	}
	
	protected function endSection($section, $stack){
		if($section['tag']=='h1') $this->plugin['description'] = implode($stack);
		else $this->sections[$this->getSectionName($section['content'])] = $section['content'].implode($stack);
	}
	
	public function parse(){
		$html = sfMarkdown::doConvert($this->data);
		
		// TODO: Parse <pre> to <pre class="js"> etc.
		$this->xml = simplexml_load_string('<div>'.$html.'</div>');
		
		$stack = array();
		$section = null;
		foreach($this->xml as $node){
			$content = (string)$node->asXml();
			switch($tag = strtolower($node->getName())){
				case 'h1':
					$this->plugin['name'] = strip_tags($content);
				case 'h2':
					if($section){
						$this->endSection($section, $stack);
						if($section['tag']=='h1'){
							$img = $section['node']->xpath('//img');
							if(!empty($img) && $img[0]) $this->plugin['screenshot'] = (string)$img[0]->asXml();
						}
						$stack = array();
					}
					$section = array(
						'tag' => $tag,
						'content' => $content,
						'node' => $node,
					);
					break;
				default:
					$stack[] = $content;
					break;
					
			}
		}
		
		$this->endSection($section, $stack);
		
		foreach($this->sections as $name => $content)
			if(!in_array($name, $this->options['defaultSections']))
				$this->arbitrarySections[$name] = $content;
		
		$images = $this->xml->xpath('//img');
		foreach($images as $img)
			$this->images[(string)$img->attributes()->src] = (string)$img->attributes()->alt;
		
	}
	
	public function getPluginName(){
		return $this->plugin['name'];
	}
	
	public function getDescription(){
		return $this->plugin['description'];
	}
	
	public function getScreenshot(){
		return $this->plugin['screenshot'];
	}
	
	public function getScreenshots(){
		return $this->images;
	}
	
	public function getSection($name){
		return !empty($this->sections[$name = $this->getSectionName($name)]) ? $this->sections[$name] : null;
	}
	
	public function getSections(){
		return $this->sections;
	}
	
	public function getArbitrarySections(){
		return $this->arbitrarySections;
	}
	
}