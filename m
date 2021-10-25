Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D22E43A4E4
	for <lists+linux-arch@lfdr.de>; Mon, 25 Oct 2021 22:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhJYUpN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 16:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhJYUpN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Oct 2021 16:45:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77C1C061745;
        Mon, 25 Oct 2021 13:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OZ3sXa5W5LKoK68CV6cLI60WYGmCrZAiYPql/iGcsZk=; b=Rw/uWqthQJhk7xelE+mjEOhsxY
        mXW3XpEPfjFPib8sFG6dgHGK4g0BR2lGgNL7ydITKuwjAAhjL6JGvJNIGlGQoih/9iTpuE7OCZrjm
        wEQFMMnM8ifnvOhnUHdSa/qD4urDCSMIp8HGTbR9DZbiKa5b6Ig0oO6KSBM/ffITgyRUWoDWeocsC
        7XbY9Kv9tGz3gXRnK1+PzFrgibUAMbmn7E4f8s2nfTjrRkYxf8wj6My02cFKOKS32kVyx9JS+mlc5
        jcfHECVc0zRgn8zoSnnFn2zZuwyr93PpsHAYkFn9dF84DjFgRVnMcXcnxUnAM+UqA1+A3xsJeylSP
        WkGKjUzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf6jr-00GQxi-23; Mon, 25 Oct 2021 20:38:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AAE2F3002AE;
        Mon, 25 Oct 2021 22:38:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A8582CCDBA64; Mon, 25 Oct 2021 22:38:33 +0200 (CEST)
Date:   Mon, 25 Oct 2021 22:38:33 +0200
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
Message-ID: <YXcVySsxQO4Iakbq@hirez.programming.kicks-ass.net>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.215612498@infradead.org>
 <202110220919.46F58199D@keescook>
 <20211022165431.GF86184@C02TD0UTHF1T.local>
 <20211022170135.GF174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022170135.GF174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 22, 2021 at 07:01:35PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 22, 2021 at 05:54:31PM +0100, Mark Rutland wrote:
> 
> > > Pardon my thin understanding of the scheduler, but I assume this change
> > > doesn't mean stack_trace_save_tsk() stops working for "current", right?
> > > In trying to answer this for myself, I couldn't convince myself what value
> > > current->__state have here. Is it one of TASK_(UN)INTERRUPTIBLE ?
> > 
> > Regardless of that, current->on_rq will be non-zero, so you're right that this
> > causes stack_trace_save_tsk() to not work for current, e.g.
> > 
> > | # cat /proc/self/stack 
> > | # wc  /proc/self/stack 
> > |         0         0         0 /proc/self/stack
> > 
> > TBH, I think that (taking a step back from this issue in particular)
> > stack_trace_save_tsk() *shouldn't* work for current, and callers *should* be
> > forced to explicitly handle current separately from blocked tasks.
> 
> That..

So I think I'd prefer the following approach to that (and i'm not
currently volunteering for it):

 - convert all archs to ARCH_STACKWALK; this gets the semantics out of
   arch code and into the single kernel/stacktrace.c file.

 - bike-shed a new/improved stack_trace_save*() API and implement it
   *once* in generic code based on arch_stack_walk().

 - convert users; delete old etc..

For now, current users of stack_trace_save_tsk() very much expect
tsk==current to work.

> > So we could fix this in the stacktrace code with:
> > 
> > | diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> > | index a1cdbf8c3ef8..327af9ff2c55 100644
> > | --- a/kernel/stacktrace.c
> > | +++ b/kernel/stacktrace.c
> > | @@ -149,7 +149,10 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
> > |                 .skip   = skipnr + (current == tsk),
> > |         };
> > |  
> > | -       task_try_func(tsk, try_arch_stack_walk_tsk, &c);
> > | +       if (tsk == current)
> > | +               try_arch_stack_walk_tsk(tsk, &c);
> > | +       else
> > | +               task_try_func(tsk, try_arch_stack_walk_tsk, &c);
> > |  
> > |         return c.len;
> > |  }
> > 
> > ... and we could rename task_try_func() to blocked_task_try_func(), and
> > later push the distinction into higher-level callers.
> 
> I think I favour this fix if we have to. But that's for next week :-)

I ended up with the below delta to this patch.

--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -101,7 +101,7 @@ static bool stack_trace_consume_entry_no
 }
 
 /**
- * stack_trace_save - Save a stack trace into a storage array
+ * stack_trace_save - Save a stack trace (of current) into a storage array
  * @store:	Pointer to storage array
  * @size:	Size of the storage array
  * @skipnr:	Number of entries to skip at the start of the stack trace
@@ -132,7 +132,7 @@ static int try_arch_stack_walk_tsk(struc
 
 /**
  * stack_trace_save_tsk - Save a task stack trace into a storage array
- * @task:	The task to examine
+ * @task:	The task to examine (current allowed)
  * @store:	Pointer to storage array
  * @size:	Size of the storage array
  * @skipnr:	Number of entries to skip at the start of the stack trace
@@ -149,13 +149,25 @@ unsigned int stack_trace_save_tsk(struct
 		.skip	= skipnr + (current == tsk),
 	};
 
-	task_try_func(tsk, try_arch_stack_walk_tsk, &c);
+	/*
+	 * If the task doesn't have a stack (e.g., a zombie), the stack is
+	 * empty.
+	 */
+	if (!try_get_task_stack(tsk))
+		return 0;
+
+	if (tsk == current)
+		try_arch_stack_walk_tsk(tsk, &c);
+	else
+		task_try_func(tsk, try_arch_stack_walk_tsk, &c);
+
+	put_task_stack(tsk);
 
 	return c.len;
 }
 
 /**
- * stack_trace_save_regs - Save a stack trace based on pt_regs into a storage array
+ * stack_trace_save_regs - Save a stack trace (of current) based on pt_regs into a storage array
  * @regs:	Pointer to pt_regs to examine
  * @store:	Pointer to storage array
  * @size:	Size of the storage array
