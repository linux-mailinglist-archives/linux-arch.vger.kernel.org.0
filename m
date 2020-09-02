Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A02825A5F5
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 09:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgIBHDM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 03:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIBHDM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Sep 2020 03:03:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1181C061244;
        Wed,  2 Sep 2020 00:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wETnSd18KmVdHGiQrOod3fMaukGGVo26iGV8/eRIszM=; b=CLBKV4PGA/m9rvGdAFkFNGKZjc
        lyqcoXfM+nT2VZltV4ENPo/Wbd66EiRaInTSiAHgTc3YpYFkpzJo79C8gXhwNgWjKmUMfdWL2st7/
        CiwzilPZ3XU5h7ZktGAdRFFpU5FHY0Noq8TOskFZDyLMKW8rXGZ3sw8/IHhg1Xd6EG2y4vvQEFSQC
        CdurELo2ykFBaUROmKYFFzGWMlVcCdHp2+ULoyTNsEQLCXooNQ9dJrZ4kdzbuqMgQhfD1CEGX2DMN
        HtrWjfaV2ImjScJ6JuOyqAkgUCY9pczdm709LqLVd/ZLsFx+ewG3jMKD7iaj78+WR9ece9/IQ0RQA
        doMVzapQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDMmr-0005hv-IF; Wed, 02 Sep 2020 07:02:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D6703012DF;
        Wed,  2 Sep 2020 09:02:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D12B2B774673; Wed,  2 Sep 2020 09:02:26 +0200 (CEST)
Date:   Wed, 2 Sep 2020 09:02:26 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Message-ID: <20200902070226.GG2674@hirez.programming.kicks-ass.net>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
 <20200901190808.GK29142@worktop.programming.kicks-ass.net>
 <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 02, 2020 at 09:37:39AM +0900, Masami Hiramatsu wrote:
> On Tue, 1 Sep 2020 21:08:08 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Sat, Aug 29, 2020 at 09:59:49PM +0900, Masami Hiramatsu wrote:
> > > Masami Hiramatsu (16):
> > >       kprobes: Add generic kretprobe trampoline handler
> > >       x86/kprobes: Use generic kretprobe trampoline handler
> > >       arm: kprobes: Use generic kretprobe trampoline handler
> > >       arm64: kprobes: Use generic kretprobe trampoline handler
> > >       arc: kprobes: Use generic kretprobe trampoline handler
> > >       csky: kprobes: Use generic kretprobe trampoline handler
> > >       ia64: kprobes: Use generic kretprobe trampoline handler
> > >       mips: kprobes: Use generic kretprobe trampoline handler
> > >       parisc: kprobes: Use generic kretprobe trampoline handler
> > >       powerpc: kprobes: Use generic kretprobe trampoline handler
> > >       s390: kprobes: Use generic kretprobe trampoline handler
> > >       sh: kprobes: Use generic kretprobe trampoline handler
> > >       sparc: kprobes: Use generic kretprobe trampoline handler
> > >       kprobes: Remove NMI context check
> > >       kprobes: Free kretprobe_instance with rcu callback
> > >       kprobes: Make local used functions static
> > > 
> > > Peter Zijlstra (5):
> > >       llist: Add nonatomic __llist_add() and __llist_dell_all()
> > >       kprobes: Remove kretprobe hash
> > >       asm-generic/atomic: Add try_cmpxchg() fallbacks
> > >       freelist: Lock less freelist
> > >       kprobes: Replace rp->free_instance with freelist
> > 
> > This looks good to me, do you want me to merge them through -tip? If so,
> > do we want to try and get them in this release still?
> 
> Yes, thanks. For the kretprobe missing issue, we will need the first half
> (up to "kprobes: Remove NMI context check"), so we can split the series
> if someone think the lockless is still immature.

Ok, but then lockdep will yell at you if you have that enabled and run
the unoptimized things.

> > Ingo, opinions? This basically fixes a regression cauesd by
> > 
> >   0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
> > 
> 
> Oops, I missed Ingo in CC. 

You had x86@, he'll have a copy :-)
