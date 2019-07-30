Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5D7B58C
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2019 00:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfG3WRF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jul 2019 18:17:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39255 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfG3WRE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jul 2019 18:17:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so30767057pgi.6
        for <linux-arch@vger.kernel.org>; Tue, 30 Jul 2019 15:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NH7v7hQGCDcrcHr7kXmnUcDiXKdZs1vThqRJQtWPV0Y=;
        b=YjhiCDdS++ckTk0XkYI2HEzbofEQ3uA16tqVKn5xFON/94wyuns1fYEvRgfld7vZeD
         Bl+yey9UFJbhBW6TVF85ULg8UkfSkISZJYkPMw0GVLiz8bhEm2h9BVVQD36i7vKZdZPb
         n0JNMtzrSg9WLQf+hQ9PQ6hUQ7InTJi8gDbm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NH7v7hQGCDcrcHr7kXmnUcDiXKdZs1vThqRJQtWPV0Y=;
        b=fWWg94ckX39ul1RF61lg682f9FJnVRNniKQwngaCPHzg1KkuOdXhwIl7KCcUPSsJEg
         ZehZ3r0IxByZHFxdbLsqIK1LXi1wX5k+wFgPObCS8TWvmZMDIp3OYgF1Q4efDHNB4IvC
         2tcUE2+tz263NlriRTKSPZ/GIrrPAsOZN/beNpf2A/e8NbGTrtz9V4hBCAefrAY80KKc
         GO/INXjF8TkIi7dByWev4vSeyN9lEOv2MjU4siV874rwttpgkohgWNHawySARPkbJwlQ
         ccQuwHo4WShTqPbKFh4+sCYUZ5qsJtli5Afu16aMbwBdNuIUzWDF4yz+1+ChqeH4P78O
         MZnw==
X-Gm-Message-State: APjAAAWyihHPCInH0taXM6J2goETihgW4biBXuDHTBBz8AC36A5W9cSF
        xyeGoPWxi1Nh6U25W2+TWA0=
X-Google-Smtp-Source: APXvYqxbPCCPBMjUjr+mPF4OfTVJrWDC2ya3kxrss21RBQu4MHAaBdICZcE/jgDJipxXac1Rg/rAxw==
X-Received: by 2002:a63:5c07:: with SMTP id q7mr58436674pgb.436.1564525023627;
        Tue, 30 Jul 2019 15:17:03 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p7sm71355161pfp.131.2019.07.30.15.17.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 15:17:02 -0700 (PDT)
Date:   Tue, 30 Jul 2019 18:17:01 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
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
Message-ID: <20190730221701.GC254050@google.com>
References: <20190726180201.GE146401@google.com>
 <5826090bf29ec831df620b79d7fe60ef7a705795.1564167643.git.mchehab+samsung@kernel.org>
 <20190727141013.dpvjlcp3juja4see@penguin>
 <20190727123754.5d91d4a4@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727123754.5d91d4a4@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 27, 2019 at 12:37:54PM -0300, Mauro Carvalho Chehab wrote:
> Em Sat, 27 Jul 2019 14:14:53 +0000
> Joel Fernandes <joel@joelfernandes.org> escreveu:
> 
> > On Fri, Jul 26, 2019 at 04:01:37PM -0300, Mauro Carvalho Chehab wrote:
> > > The books at tools/memory-model/Documentation are very well
> > > formatted. Congrats to the ones that wrote them!
> > > 
> > > The manual conversion to ReST is really trivial:
> > > 
> > > 	- Add document titles;
> > > 	- change the bullets on some lists;
> > > 	- mark code blocks.  
> > 
> > Thanks so much, some feedback:
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> > 
> > (1)
> > I could not find the table of contents appear in the HTML output for this.
> > Basically this list in the beginning doesn't render:
> >   1. INTRODUCTION
> >   2. BACKGROUND
> >   3. A SIMPLE EXAMPLE
> >   4. A SELECTION OF MEMORY MODELS
> >   5. ORDERING AND CYCLES
> 
> Yes. It is written as a comment, like:
> 
> 	.. foo  This is a comment block
> 
> 	   Everything on this block
> 
> 	   won't be parsed.
> 
> So it won't be parsed, but having a TOC like this isn't need, as
> Sphinx generates it automatically via "toctree" markup. 

Ok.

> > Could we add a proper TOC with sections? My motivation for ReST here would be
> > to make the sections jumpable since it is a large document.
> 
> Just change the toctree depth at index.rst to 2 and you'll see an index
> produced by Sphinx with both levels 1 (doc name) and level 2 (chapters):
> 
> 	.. toctree::
> 	   :maxdepth: 2

Admittedly, I don't have much time at the moment to do these experiments :(

> > Also could we make the different sections appear as a tree in the left
> > sidebar?
> 
> The sidebar follows the maxdepth too.
> 
> > 
> > (2) Arguably several function names in the document HTML output should appear
> > in monospace fonting and/or referring to the documentation for real function
> > names, but these can be fixed as we go, I guess.
> 
> If you want monospaced fonts, just use: ``monospaced_symbol_foo`` within
> any paragraph, or place the monospaced data inside a code-block:
> 
> 	::
> 
> 		This will be monospaced.
> 
> > 
> > (3) Things like smp_load_acquire() and spin_lock() should probably refer to
> > the documentation for those elsewhere..
> 
> Jon added an automarkup extension on Kernel 5.2. So, all functions that
> are defined elsewhere will automatically generate an hyperlink. For that to
> happen, you need to add the kernel-doc markup at the *.h or *.c file where
> the function is declared and use the kernel-doc markup somewhere within the
> Kernel Documentation/.
> 
> > 
> > (4) I would argue that every occurence of
> > A ->(some dependency) B should be replaced with fixed size font in the HTML
> > results.
> 
> Just place those with ``A -> (some dependency)``. This will make them use
> a fixed size font.

Ok, understood all these. I guess my point was all of these will need to be
done to make this document useful from a ReST conversion standpoint. Until
then it is probably just better off being plain text - since there are so
many of those ``A -> (dep) B`` things.

> > Arguably it is better IMO if the whole document is fixed size font in the
> > HTML output because so many things need to be fixed size, but that my just be
> > my opinion.
> 
> Just my 2 cents here, but having the entire document using a fixed size
> font makes it more boring to read. Having just the symbols with a fixed size
> is a common convention used on technical books, and helps to make easier
> to identify the symbols while reading the docs.
> 
> That's said, Sphinx doesn't have any tag to switch the font for the entire
> document. All it can be done is to define a CSS and apply it for the
> doc - or to place everything within a code-block, with will suppress all
> markup tags, including cross-references for functions.

Ok, got it.

> The problem with CSS is that you need to write both an html CSS file
> and add LaTeX macros associated to this "CSS style" (technically, LaTeX
> doesn't have a CSS concept, but Sphinx emulates it).

Yeah I don't think we want to do CSS here. So the correct thing to do would
be to place all fixed-width things within double backticks, if someone had
the time to do it. I am currently spending time understanding the document's
content itself..

thanks for the effort, it could probably serve as a good future reference,

 - Joel

