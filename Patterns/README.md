# Patterns for lexico-semantic relations

Patterns indicating lexico-semantic relations in Portuguese, to be used in BERT (Masked Language Modelling) or GPT (Text Completion) models for discovering related arguments:

* Relation names are those covered in [TALES](https://github.com/NLP-CISUC/PT-LexicalSemantics/tree/master/TALESv1.1).
* Before usage, &lt;r&gt; is to be replaced by a word, i.e., the first argument of the relation.
* In BERT, arguments will be predicted for the [MASK] token.
* In GPT-2, the pattern will be automatically completed, and it is up to the programmer to select the argument.

BERT patterns were used with [BERTimbau](https://huggingface.co/neuralmind/bert-base-portuguese-cased) and results are reported in a paper to be published in the 15th International Conference on Computational Processing of Portuguese (PROPOR 2022):
 
[Gonçalo Oliveira, H. (2022). *Drilling lexico-semantic knowledge in Portuguese from BERT*. In Computational Processing of the Portuguese Language – 14th International Conference, PROPOR 2022, volume 12037 of LNCS, pages 387—397. Springer.](https://link.springer.com/chapter/10.1007/978-3-030-98305-5_36)

BERT patterns v2 were also used with [BERTimbau](https://huggingface.co/neuralmind/bert-base-portuguese-cased) and results are reported in a paper to be published in the Global WordNet Conference 2023 (GWC 2023).

Hugo Gonçalo Oliveira (2023). *Studying the Acquisition of WordNet Relations from Pretrained Masked Language Models for Portuguese*.

For any question, contact: hroliv(a)dei(.)uc(.)pt
