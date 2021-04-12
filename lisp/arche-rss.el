(require 'arche-package)
(use-package elfeed)
(global-set-key (kbd "C-x w") #'elfeed)
(setq elfeed-feeds
      '(
        ("https://www.motorsport.com/rss/f1/news/" motorsport)
        ("http://finance.yahoo.com/rss/headline?s=MSFT" finance)
	("https://feeds.bloomberg.com/politics/news.rss" bloomberg-politics)
        ))
(provide 'arche-rss)
