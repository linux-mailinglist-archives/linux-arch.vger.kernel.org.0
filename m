Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC9453CB62
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbiFCONE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 10:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbiFCOND (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 10:13:03 -0400
Received: from mailout1.rbg.tum.de (mailout1.rbg.tum.de [131.159.0.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3233B280;
        Fri,  3 Jun 2022 07:12:46 -0700 (PDT)
Received: from mailrelay1.rbg.tum.de (mailrelay1.in.tum.de [131.159.254.14])
        by mailout1.rbg.tum.de (Postfix) with ESMTPS id 128D4B0F;
        Fri,  3 Jun 2022 16:12:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.tum.de;
        s=20220209; t=1654265564;
        bh=ZpW3H/xbyfM4w1mopp7lcoc+iJJUqmE9TJDSlh7rVIQ=;
        h=Date:From:To:Cc:Subject:From;
        b=md+BKngkvMLwdcwW4W+gUTaEWzVlsJ3RjiNBcPO/OwIGgeHrc5QPlVuIOKmtT9BgY
         vHuqoZ3z2aMSteMa5w7UIh9/bcuYnncFADhio5OXQrG5RymnYLgPZl7j0YHeH2/Cjv
         3ZovTzodgXgqnI/hovwo2Mv+V1hicaWcWF6k9eqvEeJSnPdbZHvNJ6RpiSNuPYa/fP
         hJa7AahwxMCwhDKjHpkgwY99Fjxg4z/QyDxI9i1pEBAobz9BmCpH07g9VpqkkAIKAj
         W8APNA2FHkaYqUup/duGvRmTUy4jHFbtKLTDABByTK5i2MzuxvgUr1KBfmhhiwIZp0
         xH/VUPGzU0y8A==
Received: by mailrelay1.rbg.tum.de (Postfix, from userid 112)
        id 0CC1928B; Fri,  3 Jun 2022 16:12:44 +0200 (CEST)
Received: from mailrelay1.rbg.tum.de (localhost [127.0.0.1])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTP id DFA9728A;
        Fri,  3 Jun 2022 16:12:43 +0200 (CEST)
Received: from mail.in.tum.de (vmrbg426.in.tum.de [131.159.0.73])
        by mailrelay1.rbg.tum.de (Postfix) with ESMTPS id DC79A286;
        Fri,  3 Jun 2022 16:12:43 +0200 (CEST)
Received: by mail.in.tum.de (Postfix, from userid 112)
        id D54884A02E6; Fri,  3 Jun 2022 16:12:43 +0200 (CEST)
Received: (Authenticated sender: heidekrp)
        by mail.in.tum.de (Postfix) with ESMTPSA id 826104A02B0;
        Fri,  3 Jun 2022 16:12:43 +0200 (CEST)
        (Extended-Queue-bit xtech_fq@fff.in.tum.de)
Date:   Fri, 3 Jun 2022 16:12:37 +0200
From:   Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Marco Elver <elver@google.com>
Subject: (Non-) Ctrl Dependency in litmus-tests.txt?
Message-ID: <YpoW1deb/QeeszO1@ethstick13.dse.in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

I was going through litmus-tests.txt and came across the following:

> LIMITATIONS
> ===========
> 
> Limitations of the Linux-kernel memory model (LKMM) include:
> 
> 1.Compiler optimizations are not accurately modeled.  Of course,
> 	the use of READ_ONCE() and WRITE_ONCE() limits the compiler's
> 	ability to optimize, but under some circumstances it is possible
> 	for the compiler to undermine the memory model.  For more
> 	information, see Documentation/explanation.txt (in particular,
> 	the "THE PROGRAM ORDER RELATION: po AND po-loc" and "A WARNING"
> 	sections).
> 
> 	Note that this limitation in turn limits LKMM's ability to
> 	accurately model address, control, and data dependencies.
> 	For example, if the compiler can deduce the value of some variable
> 	carrying a dependency, then the compiler can break that dependency
> 	by substituting a constant of that value.
> 
> 	Conversely, LKMM sometimes doesn't recognize that a particular
> 	optimization is not allowed, and as a result, thinks that a
> 	dependency is not present (because the optimization would break it).
> 	The memory model misses some pretty obvious control dependencies
> 	because of this limitation.  A simple example is:
> 
> 		r1 = READ_ONCE(x);
> 		if (r1 == 0)
> 			smp_mb();
> 		WRITE_ONCE(y, 1);
> 
> 	There is a control dependency from the READ_ONCE to the WRITE_ONCE,
> 	even when r1 is nonzero, but LKMM doesn't realize this and thinks
> 	that the write may execute before the read if r1 != 0.  (Yes, that
> 	doesn't make sense if you think about it, but the memory model's
> 	intelligence is limited.)

I'm unclear as to why the documentation sees a control dependency from
the READ_ONCE() to the WRITE_ONCE() here.

Quoting from explanation.txt:
> Finally, a read event and another memory access event are linked by a
> control dependency if the value obtained by the read affects whether
> the second event is executed at all.

Architectures might consider this control-dependent, yes, but since the
value of the if condition does not affect whether the WRITE_ONCE() is
executed at all, I'm not sure why this should be considered
control-dependent in LKMM? 

I might have another question about explanation.txt's definition of
control dependencies as per above, but will address it more thoroughly
in another email :-)

Many thanks,
Paul 
