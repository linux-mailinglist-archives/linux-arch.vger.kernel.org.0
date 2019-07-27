Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E8977A50
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2019 17:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbfG0PiG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jul 2019 11:38:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387673AbfG0PiF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Jul 2019 11:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9zYuzthuf2nX5/BCPAhm8DHdx0y9b8nhU7td1YRW+rk=; b=jvEjp6+SbQcqxLBeXB+QX8M3q
        OAnOqE3wbt2wO3EDiwTJvi2g4vV/NRii7ORAgqekYEOJQMwSRnpYUvZmZFcrz8lVXso/1isN6QoWn
        X+mKh/RhFZvZqT/IRK78jhL5o1SBQgXnmLAHuxCoseUwQVkEt7BdRsA8MxZkZhx+2WvbtbjvZn49Z
        8AtlArRC08OL4ALTrRYp9os+zGt6rRV4eU5mAF8KKWpVMcSuvuMPQTxN3Jp4gnAERoRkKPO70xnK8
        X8ua/nRxS8/d2mGPQDDr3xfvSvmftU3i4t977I/EVFUtFnBNPjVeWneZwDJA+SXM4zNFsTWONpvMK
        EjVMkPAsQ==;
Received: from 177.41.114.203.dynamic.adsl.gvt.net.br ([177.41.114.203] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hrOlm-0001aR-0x; Sat, 27 Jul 2019 15:38:02 +0000
Date:   Sat, 27 Jul 2019 12:37:54 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        SeongJae Park <sj38.park@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools: memory-model: add it to the Documentation body
Message-ID: <20190727123754.5d91d4a4@coco.lan>
In-Reply-To: <20190727141013.dpvjlcp3juja4see@penguin>
References: <20190726180201.GE146401@google.com>
        <5826090bf29ec831df620b79d7fe60ef7a705795.1564167643.git.mchehab+samsung@kernel.org>
        <20190727141013.dpvjlcp3juja4see@penguin>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em Sat, 27 Jul 2019 14:14:53 +0000
Joel Fernandes <joel@joelfernandes.org> escreveu:

> On Fri, Jul 26, 2019 at 04:01:37PM -0300, Mauro Carvalho Chehab wrote:
> > The books at tools/memory-model/Documentation are very well
> > formatted. Congrats to the ones that wrote them!
> > 
> > The manual conversion to ReST is really trivial:
> > 
> > 	- Add document titles;
> > 	- change the bullets on some lists;
> > 	- mark code blocks.  
> 
> Thanks so much, some feedback:
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> (1)
> I could not find the table of contents appear in the HTML output for this.
> Basically this list in the beginning doesn't render:
>   1. INTRODUCTION
>   2. BACKGROUND
>   3. A SIMPLE EXAMPLE
>   4. A SELECTION OF MEMORY MODELS
>   5. ORDERING AND CYCLES

Yes. It is written as a comment, like:

	.. foo  This is a comment block

	   Everything on this block

	   won't be parsed.

So it won't be parsed, but having a TOC like this isn't need, as
Sphinx generates it automatically via "toctree" markup. 

> Could we add a proper TOC with sections? My motivation for ReST here would be
> to make the sections jumpable since it is a large document.

Just change the toctree depth at index.rst to 2 and you'll see an index
produced by Sphinx with both levels 1 (doc name) and level 2 (chapters):

	.. toctree::
	   :maxdepth: 2

> Also could we make the different sections appear as a tree in the left
> sidebar?

The sidebar follows the maxdepth too.

> 
> (2) Arguably several function names in the document HTML output should appear
> in monospace fonting and/or referring to the documentation for real function
> names, but these can be fixed as we go, I guess.

If you want monospaced fonts, just use: ``monospaced_symbol_foo`` within
any paragraph, or place the monospaced data inside a code-block:

	::

		This will be monospaced.

> 
> (3) Things like smp_load_acquire() and spin_lock() should probably refer to
> the documentation for those elsewhere..

Jon added an automarkup extension on Kernel 5.2. So, all functions that
are defined elsewhere will automatically generate an hyperlink. For that to
happen, you need to add the kernel-doc markup at the *.h or *.c file where
the function is declared and use the kernel-doc markup somewhere within the
Kernel Documentation/.

> 
> (4) I would argue that every occurence of
> A ->(some dependency) B should be replaced with fixed size font in the HTML
> results.

Just place those with ``A -> (some dependency)``. This will make them use
a fixed size font.

> Arguably it is better IMO if the whole document is fixed size font in the
> HTML output because so many things need to be fixed size, but that my just be
> my opinion.

Just my 2 cents here, but having the entire document using a fixed size
font makes it more boring to read. Having just the symbols with a fixed size
is a common convention used on technical books, and helps to make easier
to identify the symbols while reading the docs.

That's said, Sphinx doesn't have any tag to switch the font for the entire
document. All it can be done is to define a CSS and apply it for the
doc - or to place everything within a code-block, with will suppress all
markup tags, including cross-references for functions.

The problem with CSS is that you need to write both an html CSS file
and add LaTeX macros associated to this "CSS style" (technically, LaTeX
doesn't have a CSS concept, but Sphinx emulates it).

Thanks,
Mauro
