Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF637164B5E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBSRDe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:03:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37258 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgBSRDd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 12:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HuGT0b0onNFF+eYgdTRhOWLWmkCfJUhiAbKJ/uOzPwk=; b=0+sv6dEgBUXjauhqDsGQwIsxw3
        ZFr/29TI983O1PEp315TWLrzf/jamZuvHMc8cS7yU3PEdJaJW3UgvkpB42wtcQxRlX3U5k4A4AjCQ
        A3H4efTMWYkwpY4+GQouf6kT28KdDA1wKQaD+bE9WiDCXKlZrC4LkYoXicS7POKZP7QaiMwaBAOK5
        kTtOYc7DWqPBc1bHPW5MNjlVnO2u4S6LL94AIja6M+A9IVcB8YJotJZACAGWCUOsMt8yRERe5PEqf
        YL/5waRiwpbe3NGGR/YqYKX11fObbXfj7F3gf/n+BpG4nockfS/BEk6biTMwP5IPiloHR1mh0htHY
        DunAMNHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Skb-0001bJ-St; Wed, 19 Feb 2020 17:03:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E440A300606;
        Wed, 19 Feb 2020 18:01:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 24ACF202287CD; Wed, 19 Feb 2020 18:03:04 +0100 (CET)
Date:   Wed, 19 Feb 2020 18:03:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 05/22] rcu: Make RCU IRQ enter/exit functions rely on
 in_nmi()
Message-ID: <20200219170304.GG14946@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.661923520@infradead.org>
 <20200219163156.GY2935@paulmck-ThinkPad-P72>
 <20200219163700.GK18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219163700.GK18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 05:37:00PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2020 at 08:31:56AM -0800, Paul E. McKenney wrote:

> > Here is the latest version of that comment, posted by Steve Rostedt.
> > 
> > 							Thanx, Paul
> > 
> > /*
> >  * All functions called in the breakpoint trap handler (e.g. do_int3()
> >  * on x86), must not allow kprobes until the kprobe breakpoint handler
> >  * is called, otherwise it can cause an infinite recursion.
> >  * On some archs, rcu_nmi_enter() is called in the breakpoint handler
> >  * before the kprobe breakpoint handler is called, thus it must be
> >  * marked as NOKPROBE.
> >  */
> 
> Oh right, let me stick that in a separate patch. Best we not loose that
> I suppose ;-)

Having gone over the old thread, I ended up with the below. Anyone
holler if I got it wrong somehow.

---
Subject: rcu: Provide comment for NOKPROBE() on rcu_nmi_enter()
From: Steven Rostedt <rostedt@goodmis.org>

From: Steven Rostedt <rostedt@goodmis.org>

The rcu_nmi_enter() function was marked NOKPROBE() by commit
c13324a505c77 ("x86/kprobes: Prohibit probing on functions before
kprobe_int3_handler()") because the do_int3() call kprobe code must
not be invoked before kprobe_int3_handler() is called.  It turns out
that ist_enter() (in do_int3()) calls rcu_nmi_enter(), hence the
marking NOKPROBE() being added to rcu_nmi_enter().

This commit therefore adds a comment documenting this line of
reasoning.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/rcu/tree.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -842,6 +842,14 @@ void rcu_nmi_enter(void)
 {
 	rcu_nmi_enter_common(false);
 }
+/*
+ * All functions called in the breakpoint trap handler (e.g. do_int3()
+ * on x86), must not allow kprobes until the kprobe breakpoint handler
+ * is called, otherwise it can cause an infinite recursion.
+ * On some archs, rcu_nmi_enter() is called in the breakpoint handler
+ * before the kprobe breakpoint handler is called, thus it must be
+ * marked as NOKPROBE.
+ */
 NOKPROBE_SYMBOL(rcu_nmi_enter);
 
 /**
