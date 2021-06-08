Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594EA39F4DD
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 13:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhFHL0S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 07:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhFHL0S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jun 2021 07:26:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B054BC061574;
        Tue,  8 Jun 2021 04:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UNAlibUDpLLDX1KGFQEYjEdmHvc7ohyIDGXvDQ+DvHA=; b=ba+NSooc4JLoWZ7eNvZsLS0naT
        9hfvDe3vU8rUQlf0Uqu6tIqJsEoX3R6MbmUiEw47HmRx07zM3nrD6XVUK6o2szDv7DfCoRvVDqfuu
        zrJC27G4D6VdE9xS4tpNGE9f7/ncwJTol8OFaN3CKH36WFm1rjwTI15Gojfu9xmALpCr4D79MGMMv
        HiWU/evjC48blz+xIAiq4jjnS3HwiEjocRU0ybUu3V0CGzr+cxqreQ8yfvD6y6Wobuh9v7hH8v+KU
        dxfhWjMBbq/yO9gIzQqhlylwxmgGTHsFgwFnlHerv5TwsHce02KokYq1ebh8yd6y9vN01uZTI3EsM
        ZrTZH7zg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqZoz-00GsA3-II; Tue, 08 Jun 2021 11:23:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F002F3001E3;
        Tue,  8 Jun 2021 13:22:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFD5420245F9F; Tue,  8 Jun 2021 13:22:58 +0200 (CEST)
Date:   Tue, 8 Jun 2021 13:22:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
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
Message-ID: <YL9TEqealhxBBhoS@hirez.programming.kicks-ass.net>
References: <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
 <20210606185922.GF7746@tucnak>
 <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
 <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru>
 <CANpmjNMwq6ENUtBunP-rw9ZSrJvZnQw18rQ47U3JuqPEQZsaXA@mail.gmail.com>
 <20210607152806.GS4397@paulmck-ThinkPad-P17-Gen-1>
 <YL5Risa6sFgnvvnG@elver.google.com>
 <CANpmjNNtDX+eBEpuP9-NgT6RAwHK5OgbQHT9b+8LZQJtwWpvPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNtDX+eBEpuP9-NgT6RAwHK5OgbQHT9b+8LZQJtwWpvPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 08, 2021 at 11:30:36AM +0200, Marco Elver wrote:

> The cleaner approach would be an expression wrapper, e.g. "if
> (ctrl_depends(A) && B) { ... }".
> 
> I imagine syntactically it'd be similar to __builtin_expect(..). I
> think that's also easier to request an extension for, say
> __builtin_ctrl_depends(expr). (If that is appealing, we can try and
> propose it as std::ctrl_depends() along with std::dependent_ptr<>.)
> 
> Thoughts?

Works for me; and note how it mirrors how we implemented volatile_if()
in the first place, by doing an expression wrapper.

__builtin_ctrl_depends(expr) would have to:

 - ensure !__builtin_const_p(expr)	(A)
 - imply an acquire compiler fence	(B)
 - ensure cond-branch is emitted	(C)

*OR*

 - ensure !__builtin_const_p(expr);		(A)
 - upgrade the load in @expr to load-acquire	(D)


A)

This all hinges on there actually being a LOAD, if expr is constant, we
have a malformed program and can emit a compiler error.

B)

We want to capture any store, not just volatile stores that come after.

The example here is a ring-buffer that loads the (head and) tail pointer
to check for space and then writes data elements. It would be
'cumbersome' to have all the data writes as volatile.

C)

We depend on the load-to-branch data dependency to guard the store to
provide the LOAD->STORE memory order.

D)

Upgrading LOAD to LOAD-ACQUIRE also provides LOAD->STORE ordering, but
it does require that the compiler has access to the LOAD in the first
place, which isn't a given seeing how much asm() we have around. Also
the achitecture should have a sheep LOAD-ACQUIRE in the first place,
otherwise there's no point.

If this is done, the branch is allowed to be optimized away if the
compiler so wants.

Now, Will will also want to allow the load-acquire to be run-time
patched between the RCsc and RCpc variant depending on what ARMv8
extentions are available, which will be 'interesting' (although I can
think of ways to actually do that, one would be to keep a special
section that tracks the location of these __builtin_ctrl_depends()
generated load-acquire instruction).


