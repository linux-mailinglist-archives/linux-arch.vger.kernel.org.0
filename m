Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38615437B44
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhJVREP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 13:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhJVREP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 13:04:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62246C061766;
        Fri, 22 Oct 2021 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9OTv1C7PwiAbIo13563jwEC2VC4sahI2Vy/R3HQlxTU=; b=NMhmtMsJclTo+qRaZXpkp4D2BM
        844fp3N4c33705qoAYk/qmbqzl6qewVBnhxWrgM6HUwDebpaYqXYd4D4ZMLiuUK79sDbsxulfV23+
        QYLhq4o1Xx0uArZ0+/dSB+/4VgbKGVwSutE3VfeAeCJUoxUrkD9cR2JL8gBB3vIhKV7Ct9J8Tlp94
        tlcOgQVqb6mgo8xQSPRsDyOcyRfVPHH09LdKbcCzysc9KkRRdbbd3ZfHLapfCP1Z5M4rxmrfjIKNv
        ZxrPPN0GLu9JruPqpJiIucx13exSBO8vAJcsUvMfey5XYmo8DeZ6jaOOYa/StZuUwESCIfinFrdT0
        AHkzj2MQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdxvE-00BcF2-FR; Fri, 22 Oct 2021 17:01:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12C64986249; Fri, 22 Oct 2021 19:01:36 +0200 (CEST)
Date:   Fri, 22 Oct 2021 19:01:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        zhengqi.arch@bytedance.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: Re: [PATCH 2/7] stacktrace,sched: Make stack_trace_save_tsk() more
 robust
Message-ID: <20211022170135.GF174703@worktop.programming.kicks-ass.net>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.215612498@infradead.org>
 <202110220919.46F58199D@keescook>
 <20211022165431.GF86184@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022165431.GF86184@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 22, 2021 at 05:54:31PM +0100, Mark Rutland wrote:

> > Pardon my thin understanding of the scheduler, but I assume this change
> > doesn't mean stack_trace_save_tsk() stops working for "current", right?
> > In trying to answer this for myself, I couldn't convince myself what value
> > current->__state have here. Is it one of TASK_(UN)INTERRUPTIBLE ?
> 
> Regardless of that, current->on_rq will be non-zero, so you're right that this
> causes stack_trace_save_tsk() to not work for current, e.g.
> 
> | # cat /proc/self/stack 
> | # wc  /proc/self/stack 
> |         0         0         0 /proc/self/stack
> 
> TBH, I think that (taking a step back from this issue in particular)
> stack_trace_save_tsk() *shouldn't* work for current, and callers *should* be
> forced to explicitly handle current separately from blocked tasks.

That..

> 
> So we could fix this in the stacktrace code with:
> 
> | diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> | index a1cdbf8c3ef8..327af9ff2c55 100644
> | --- a/kernel/stacktrace.c
> | +++ b/kernel/stacktrace.c
> | @@ -149,7 +149,10 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
> |                 .skip   = skipnr + (current == tsk),
> |         };
> |  
> | -       task_try_func(tsk, try_arch_stack_walk_tsk, &c);
> | +       if (tsk == current)
> | +               try_arch_stack_walk_tsk(tsk, &c);
> | +       else
> | +               task_try_func(tsk, try_arch_stack_walk_tsk, &c);
> |  
> |         return c.len;
> |  }
> 
> ... and we could rename task_try_func() to blocked_task_try_func(), and
> later push the distinction into higher-level callers.

I think I favour this fix if we have to. But that's for next week :-)
