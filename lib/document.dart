import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';



class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final String articleText =
      """http://www.theepochtimes.com/n3/23018-china-model-harms-the-world/

 

China’s “neo-colonialism” became a popular topic again when Chinese Communist Party head Xi Jinping visited Africa in mid-March.

Neo-colonialism roughly means: China, exploiting Africa’s resources while disregarding the environmental impact, has also been dumping cheap industrial products into Africa.

China’s economic development has brought few job opportunities for Africans. What’s worse, China’s policy of “unconditional financial aid” and “not interfering with other countries politics,” has broken Western countries’ pattern of providing aid only when certain political requirements are met. This has loosened the reins on some African dictators.

The reason for the viral growth of China’s neo-colonialism in Africa is that Chinese businessmen have introduced the signature element of the China model—collusion between government and business—to Africa, using bribery in order to gain mining rights and market entry.

Fueled by Bribery and Corruption

Shortly before Xi’s visit to Nigeria, Lamido Sanusi, the country’s central bank governor, criticized China on the U.K.’s Financial Times for taking Africa’s primary goods and selling manufactured ones back to Africa, saying China is in Africa not for African interests but its own.

“This was the essence of colonialism,” Sanusi said, adding, “It is a significant contributor to Africa’s de-industrialisation and underdevelopment.”

South African president Jacob Zuma warned in 2012 that the trade pattern between Africa and China is “unsustainable in the long term.”

But such complaints from African governments are rare as benefits to state leaders are often tied to Chinese companies in various ways. Most objections come from grassroots groups.

Anti-corruption organization Transparency International surveyed 3,016 senior business executives from 30 countries on their perceptions of businesses from 28 countries that they had business relationships with.

Based on their ratings on how likely businesses from each country would pay bribes abroad, a Bribe Payers Index (BPI) was calculated for each country to reflect its perceived corruption level. China received the second lowest BPI, indicating the second highest corruption likelihood, after Russia.

The BPI covered 19 sectors, and included countries and regions from all key areas in the world. The 2011 BPI report also suggested that government-controlled high dollar volume industries, including infrastructure, construction, and petroleum and natural gas, are most susceptible to corruption abroad.

The Chinese government has refuted the BPI report, but reality proves that bribery and corruption has been the engine of China’s overseas business expansion.

Between 2008 and 2012, the World Bank’s Sanctions Board put 14 Chinese firms and individuals on its “debarred and cross-debarred list” for fraud and corruption. These firms and individuals were determined to be ineligible to be awarded a World Bank financed contract for two to eight years.

In 2009, the state-run Chinese mining firm Metallurgical Group Corp was accused of bribing the Afghan minister of Mines with 30 million to win the contract of the country’s largest development project.

On March 19, 2013, senior executives of Chinese telecom giant ZTE’s Mongolian branch were investigated on bribery charges. ZTE products and services have been deployed in more than 140 countries. In February, ZTE was accused of bribing officials in Kenya to win a government contract there.

In Algeria, ZTE executives were sentenced to 10 years in prison after being convicted of corruption in June 2012. """;
  final List<String> underlinedWords = ["Qinglian", "recently"];

  Set<String> clickedWords = {};
  Set<int> clickedWordIndices = {}; // 存储被点击的单词的索引

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 16),
            children: _buildTextSpans(articleText),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _buildTextSpans(String text) {
    List<TextSpan> spans = [];
    List<String> words = text.split(' ');
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      bool isUnderlined = underlinedWords.contains(word);
      bool isClicked = clickedWordIndices.contains(i);

      spans.add(
        TextSpan(
          text: word + ' ',
          style: TextStyle(
            backgroundColor: isClicked ? Colors.yellow : Colors.transparent,
            decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              setState(() {
                if (isClicked) {
                  clickedWordIndices.remove(i);
                } else {
                  clickedWordIndices.add(i);
                }
              });
              _showWordDialog(word);
            },
        ),
      );
    }
    return spans;
  }

  void _showWordDialog(String word) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected Word'),
          content: Text(word),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
