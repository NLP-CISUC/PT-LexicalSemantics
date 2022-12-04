# Patterns for lexico-semantic relations

Patterns indicating lexico-semantic relations in Portuguese, to be used in BERT (Masked Language Modelling) or GPT (Text Completion) models for discovering related arguments:

* Relations names are those covered in [TALES](https://github.com/NLP-CISUC/PT-LexicalSemantics/tree/master/TALESv1.1).
* Before usage, &lt;r&gt; is to be replaced by a word.
* In BERT, arguments will be predicted for the [MASK] token.
* In GPT-2, the pattern will be automatically completed, and it is up to the programmer to select the argument.

BERT patterns were used with [BERTimbau](https://huggingface.co/neuralmind/bert-base-portuguese-cased) and results are reported in a paper to be published in the 15th International Conference on Computational Processing of Portuguese (PROPOR 2022):
  
Hugo Gonçalo Oliveira (2022). *Drilling Lexico-Semantic Knowledge in Portuguese from BERT*.


For any question, contact: hroliv(a)dei(.)uc(.)pt
