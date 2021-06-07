Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E8039DA2B
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 12:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFGKyP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 06:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhFGKyP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 06:54:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682ACC061766;
        Mon,  7 Jun 2021 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CilZXOP9zbhHcchPXMt+rpxQDZmaLzPt/6xhb1HEpow=; b=GuU3QdJoLbWCt1gG3CAPMW3Zoa
        F319FAFLlxq50vE0gQFdzvBWeffQ7HgcVTs5T8PGTy/lwRkUqdCAkjPK2cwkAsdIJpXyfVenNVsIV
        EDVX34zo/5rFlvFbTUlbUSp8q/MRci2vDzKZQgp7DQafbk8OhN7y2Sr1eVpDre/d8gCwKricdu573
        HlWAQJQzAMRtv0BlIErGybNmfEDx5PhSh3yTEBynjtRmDAlLdLryC3P+exp/kChx8HDlK5RYwJEK4
        ptkX7km2u4UzJc1gwHNRQ/e/erpSSq4kyEfxQ/O7Wv9retxft+Iil9qIwJ5IGdM1i+/VCo0T0fEmo
        y7gZMiBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqCra-004MYx-Dq; Mon, 07 Jun 2021 10:52:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C900430018A;
        Mon,  7 Jun 2021 12:52:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B17102D4D6621; Mon,  7 Jun 2021 12:52:15 +0200 (CEST)
Date:   Mon, 7 Jun 2021 12:52:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <YL36XzUxfs2YGlnw@hirez.programming.kicks-ass.net>
References: <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606184021.GY18427@gate.crashing.org>
 <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
 <20210606195242.GA18427@gate.crashing.org>
 <CAHk-=wgd+Gx9bcmTwxhHbPq=RYb_A_gf=GcmUNOU3vYR1RBxbA@mail.gmail.com>
 <20210606202616.GC18427@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606202616.GC18427@gate.crashing.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 03:26:16PM -0500, Segher Boessenkool wrote:
> On Sun, Jun 06, 2021 at 01:11:53PM -0700, Linus Torvalds wrote:

> > We are very used to just making the compiler generate the code we
> > need. That is, fundamentally, what any use of inline asm is all about.
> > We want the compiler to generate all the common cases and all the
> > regular instructions.
> > 
> > The conditional branch itself - and the instructions leading up to it
> > - are exactly those "common regular instructions" that we'd want the
> > compiler to generate. That is in fact more true here than for most
> > inline asm, exactly because there are so many different possible
> > combinations of conditional branches (equal, not equal, less than,..)
> > and so many ways to generate the code that generates the condition.
> > 
> > So we are much better off letting the compiler do all that for us -
> > it's very much what the compiler is good at.
> 
> Yes, exactly.
> 
> I am saying that if you depend on that some C code you write will result
> in some particular machine code, without actually *forcing* the compiler
> to output that exact machine code, then you will be disappointed.  Maybe
> not today, and maybe it will take years, if you are lucky.
> 
> (s/forcing/instructing/ of course, compilers have feelings too!)

And hence the request for a language extension. Both compilers have a
vast array of language extensions that are outside of the C spec (thank
you!), so can we please get one more?


