Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F5716A5C3
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 13:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBXMNg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 07:13:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:57982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbgBXMNg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Feb 2020 07:13:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E660CAECE;
        Mon, 24 Feb 2020 12:13:32 +0000 (UTC)
Date:   Mon, 24 Feb 2020 13:13:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        mhiramat@kernel.org, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 02/27] hardirq/nmi: Allow nested nmi_enter()
Message-ID: <20200224121331.tnkvp6mmjchm4s2i@pathway.suse.cz>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.149193474@infradead.org>
 <20200221222129.GB28251@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221222129.GB28251@lenoir>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri 2020-02-21 23:21:30, Frederic Weisbecker wrote:
> On Fri, Feb 21, 2020 at 02:34:18PM +0100, Peter Zijlstra wrote:
> > Since there are already a number of sites (ARM64, PowerPC) that
> > effectively nest nmi_enter(), lets make the primitive support this
> > before adding even more.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > Acked-by: Will Deacon <will@kernel.org>
> > Acked-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/include/asm/hardirq.h |    4 ++--
> >  arch/arm64/kernel/sdei.c         |   14 ++------------
> >  arch/arm64/kernel/traps.c        |    8 ++------
> >  arch/powerpc/kernel/traps.c      |   22 ++++++----------------
> >  include/linux/hardirq.h          |    5 ++++-
> >  include/linux/preempt.h          |    4 ++--
> >  kernel/printk/printk_safe.c      |    6 ++++--
> >  7 files changed, 22 insertions(+), 41 deletions(-)
> > 
> > --- a/kernel/printk/printk_safe.c
> > +++ b/kernel/printk/printk_safe.c
> > @@ -296,12 +296,14 @@ static __printf(1, 0) int vprintk_nmi(co
> >  
> >  void notrace printk_nmi_enter(void)
> >  {
> > -	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> > +	if (!in_nmi())
> > +		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> >  }
> >  
> >  void notrace printk_nmi_exit(void)
> >  {
> > -	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
> > +	if (!in_nmi())
> > +		this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
> >  }
> 
> If the outermost NMI is interrupted while between printk_nmi_enter()
> and preempt_count_add(), there is still a risk that we race and clear?

Great catch!

There is plenty of space in the printk_context variable. I would
reserve one byte there for the NMI context to be on the safe side
and be done with it.

It should never overflow. The BUG_ON(in_nmi() == NMI_MASK)
in nmi_enter() will trigger much earlier.

Also I hope that printk_context will get removed with
the lockless printk() implementation soon anyway.


diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index c8e6ab689d42..109c5ab70a0c 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -6,9 +6,11 @@
 
 #ifdef CONFIG_PRINTK
 
-#define PRINTK_SAFE_CONTEXT_MASK	 0x3fffffff
-#define PRINTK_NMI_DIRECT_CONTEXT_MASK	 0x40000000
-#define PRINTK_NMI_CONTEXT_MASK		 0x80000000
+#define PRINTK_SAFE_CONTEXT_MASK	0x007ffffff
+#define PRINTK_NMI_DIRECT_CONTEXT_MASK	0x008000000
+#define PRINTK_NMI_CONTEXT_MASK		0xff0000000
+
+#define PRINTK_NMI_CONTEXT_OFFSET	0x010000000
 
 extern raw_spinlock_t logbuf_lock;
 
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index b4045e782743..e8989418a139 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -296,12 +296,12 @@ static __printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)
 
 void notrace printk_nmi_enter(void)
 {
-	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
+	this_cpu_add(printk_context, PRINTK_NMI_CONTEXT_OFFSET);
 }
 
 void notrace printk_nmi_exit(void)
 {
-	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
+	this_cpu_sub(printk_context, PRINTK_NMI_CONTEXT_OFFSET);
 }
 
 /*

Best Regards,
Petr
