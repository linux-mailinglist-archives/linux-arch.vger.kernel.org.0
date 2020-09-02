Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D2D25AC2D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 15:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgIBNng (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 09:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgIBNnX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Sep 2020 09:43:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FA0C06125C;
        Wed,  2 Sep 2020 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N5weILa9p2I3E5pwg6IDJSdAHD9ouxJHQ24m98aMNso=; b=X6G591MxEwqrhHW8xjSjoQhjy5
        w+QWnbZEPjQ1vJoOYSWtRE5564LUaXhU27JMzP0i6ZkpKdAWDCAAa83yF8fRhHmvCFBW5MCXfe2Qw
        TYyhTyfI8IvfXbhjPT7Ni+p8obeZ0+24ec14n/7TTb7Og5aT8C/ognpPJy8sKXPVBPRFPrkCyufrH
        v16lnl1WBS5QSgB6UBCiSKh1+a4U0ALBbfQkn13P0yCgJ9uz4IH9Eh8DVtEE37J6uex8ivP4sWtC+
        VL7AeN2+x28P1UHDPs5N3trC031XZq8VJuS2wPoqzAI4FNfHyO9jrB/mZ83fttcAU23pyoLFwKjzk
        gw978Cwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDT2M-0003E1-Bh; Wed, 02 Sep 2020 13:42:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1030A3003E5;
        Wed,  2 Sep 2020 15:42:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD77029A82C1F; Wed,  2 Sep 2020 15:42:52 +0200 (CEST)
Date:   Wed, 2 Sep 2020 15:42:52 +0200
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
Message-ID: <20200902134252.GH1362448@hirez.programming.kicks-ass.net>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
 <20200901190808.GK29142@worktop.programming.kicks-ass.net>
 <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
 <20200902070226.GG2674@hirez.programming.kicks-ass.net>
 <20200902171755.b126672093a3c5d1b3a62a4f@kernel.org>
 <20200902093613.GY1362448@hirez.programming.kicks-ass.net>
 <20200902221926.f5cae5b4ad00b8d8f9ad99c7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902221926.f5cae5b4ad00b8d8f9ad99c7@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 02, 2020 at 10:19:26PM +0900, Masami Hiramatsu wrote:
> On Wed, 2 Sep 2020 11:36:13 +0200
> peterz@infradead.org wrote:
> 
> > On Wed, Sep 02, 2020 at 05:17:55PM +0900, Masami Hiramatsu wrote:
> > 
> > > > Ok, but then lockdep will yell at you if you have that enabled and run
> > > > the unoptimized things.
> > > 
> > > Oh, does it warn for all spinlock things in kprobes if it is unoptimized?
> > > Hmm, it has to be noted in the documentation.
> > 
> > Lockdep will warn about spinlocks used in NMI context that are also used
> > outside NMI context.
> 
> OK, but raw_spin_lock_irqsave() will not involve lockdep, correct?

It will. The distinction between spin_lock and raw_spin_lock is only
that raw_spin_lock stays a spinlock on PREEMPT_RT, while spin_lock will
turn into a (PI) mutex in that case.

But both will call into lockdep. Unlike local_irq_disable() and
raw_local_irq_disable(), where the latter will not. Yes your prefixes
are a mess :/

> > Now, for the kretprobe that kprobe_busy flag prevents the actual
> > recursion self-deadlock, but lockdep isn't smart enough to see that.
> > 
> > One way around this might be to use SINGLE_DEPTH_NESTING for locks when
> > we use them from INT3 context. That way they'll have a different class
> > and lockdep will not see the recursion.
> 
> Hmm, so lockdep warns only when it detects the spinlock in NMI context,
> and int3 is now always NMI, thus all spinlock (except raw_spinlock?)
> in kprobe handlers should get warned, right?
> I have tested this series up to [16/21] with optprobe disabled, but
> I haven't see the lockdep warnings.

There's a bug, that might make it miss it. I have a patch. I'll send it
shortly.

> > pre_handler_kretprobe() is always called from INT3, right?
> 
> No, not always, it can be called from optprobe (same as original code
> context) or ftrace handler.
> But if you set 0 to /proc/sys/debug/kprobe_optimization, and compile
> the kernel without function tracer, it should always be called from
> INT3.

D'oh, ofcourse! Arguably I should make the optprobe context NMI like
too.. but that's for another day.
