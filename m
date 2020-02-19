Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A34D164952
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSP5h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:57:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBSP5h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6yvAidRA3TLHjv42gpCVRhqEW5bRveqFs50fMEoxkBk=; b=rDG9mDN12+rddoKEScWYeDl+pA
        bOhmjFugOCtij8XkRrbJSrOPOdn/4DgBCYiGl8TG7Ua07+YAh4hfkuhtlVkP5finaxplqZL09vQG5
        oK7AOEvWzGmy85Gqr+x2Xnr8Vf7/XfTePh9dGU9oGimW8VX1k52aTM+wZ+S5KY7bA2v9ck4WVPrg9
        uXatpJ5pPEL9aXDZzYckeX3Y5abUQnuLLP2QDDIXVFPzfDFKeDBYsF/uJMD/8RttBfhCcaKhNm5T6
        xh5t08skZGYJzhpXacP3zUfFHDFVOROjjfK9n+DSqJo2Q+7ykUM7OTkfqYFV/iF/mpcWVlatN85XT
        C48B9vgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Riw-0006Oc-1o; Wed, 19 Feb 2020 15:57:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ADFD03007F2;
        Wed, 19 Feb 2020 16:55:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD026201E47AE; Wed, 19 Feb 2020 16:57:15 +0100 (CET)
Date:   Wed, 19 Feb 2020 16:57:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove() notrace/NOKPROBE
Message-ID: <20200219155715.GD14946@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.604459293@infradead.org>
 <20200219103614.2299ff61@gandalf.local.home>
 <20200219154031.GE18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219154031.GE18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 04:40:31PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2020 at 10:36:14AM -0500, Steven Rostedt wrote:
> > On Wed, 19 Feb 2020 15:47:28 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > --- a/arch/x86/lib/memcpy_32.c
> > > +++ b/arch/x86/lib/memcpy_32.c
> > > @@ -21,7 +21,7 @@ __visible void *memset(void *s, int c, s
> > >  }
> > >  EXPORT_SYMBOL(memset);
> > >  
> > > -__visible void *memmove(void *dest, const void *src, size_t n)
> > > +__visible notrace void *memmove(void *dest, const void *src, size_t n)
> > >  {
> > >  	int d0,d1,d2,d3,d4,d5;
> > >  	char *ret = dest;
> > > @@ -207,3 +207,8 @@ __visible void *memmove(void *dest, cons
> > >  
> > >  }
> > >  EXPORT_SYMBOL(memmove);
> > 
> > Hmm, for things like this, which is adding notrace because of a single
> > instance of it (although it is fine to trace in any other instance), it
> > would be nice to have a gcc helper that could call "memmove+5" which
> > would skip the tracing portion.
> 
> Or just open-code the memmove() in do_double_fault() I suppose. I don't
> think we care about super optimized code there. It's the bloody ESPFIX
> trainwreck.

Something like so, I suppose...

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6ef00eb6fbb9..543de932dc7c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -350,14 +350,20 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 		regs->ip == (unsigned long)native_irq_return_iret)
 	{
 		struct pt_regs *gpregs = (struct pt_regs *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
+		unsigned long *dst = &gpregs->ip;
+		unsigned long *src = (void *)regs->dp;
+		int i, count = 5;
 
 		/*
 		 * regs->sp points to the failing IRET frame on the
 		 * ESPFIX64 stack.  Copy it to the entry stack.  This fills
 		 * in gpregs->ss through gpregs->ip.
-		 *
 		 */
-		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
+		for (i = 0; i < count; i++) {
+			int idx = (dst <= src) ? i : count - i;
+			dst[idx] = src[idx];
+		}
+
 		gpregs->orig_ax = 0;  /* Missing (lost) #GP error code */
 
 		/*
