Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAAD316FC33
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 11:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBZK2p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 05:28:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52134 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgBZK2p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 05:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z5GY7g1U6cVcKtwHwAk/qKvo2bn7XaDsOcP6dqXXZLM=; b=E/396K5ODdirrE16mjokbXWYIF
        cZZyfCqIW+2SQNUJ5XdFp7cU6wyrt4Vm3/tKhD4ey1SkmaDwZwdBJPMu1RlZ0/EzvSMVzpznI+wAK
        rNNrpKv2tbgr3bn92f2xWXxdwyeGWNAqb4KbrP/Z4A/mcJXzbWNfmbi3oj/BjFsii2mxZezKoN84e
        3000eL83qvwk0mcJ/XY/aPkk+DIIt8obnwunrEvSlCXmrZBi7AKJA0O/5G485pbfSMZHLMrdTayvv
        XOTMJmBKMroUg2FbpZPqGD6VMBm69ZV4HmS8ZPOaYe81OCz1zUgINYIqrDL7prQfqEhoneb4h8QT7
        PEBKaYPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6tv6-0001ZC-Nk; Wed, 26 Feb 2020 10:28:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D1DA300130;
        Wed, 26 Feb 2020 11:26:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E21E20160BF2; Wed, 26 Feb 2020 11:27:58 +0100 (CET)
Date:   Wed, 26 Feb 2020 11:27:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 05/27] x86: Replace ist_enter() with nmi_enter()
Message-ID: <20200226102758.GV18400@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.328642621@infradead.org>
 <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
 <20200221202246.GA14897@hirez.programming.kicks-ass.net>
 <20200224104346.GJ14946@hirez.programming.kicks-ass.net>
 <20200224112708.4f307ba3@gandalf.local.home>
 <20200224163409.GJ18400@hirez.programming.kicks-ass.net>
 <20200224114754.0fb798c1@gandalf.local.home>
 <20200224213139.GO11457@worktop.programming.kicks-ass.net>
 <20200224170231.3807931d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224170231.3807931d@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 24, 2020 at 05:02:31PM -0500, Steven Rostedt wrote:

> The other is for the hwlat detector that measures the time it was in an
> NMI, as NMIs appear as a hardware latency too.

Yeah,.. I hate that one. But I ended up with this patch.

And yes, I know some of those notrace annotations are strictly
unnessecary due to Makefile crap, but having them is _SO_ much easier.

---
Subject: x86,tracing: Robustify ftrace_nmi_enter()
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Feb 24 23:40:29 CET 2020

  ftrace_nmi_enter()
     trace_hwlat_callback()
       trace_clock_local()
         sched_clock()
           paravirt_sched_clock()
           native_sched_clock()

All must not be traced or kprobed, it will be called from do_debug()
before the kprobe handler.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h |    2 +-
 arch/x86/kernel/tsc.c           |    7 +++++--
 include/linux/ftrace_irq.h      |    4 ++--
 kernel/trace/trace_clock.c      |    2 ++
 kernel/trace/trace_hwlat.c      |    4 +++-
 5 files changed, 13 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -17,7 +17,7 @@
 #include <linux/cpumask.h>
 #include <asm/frame.h>
 
-static inline unsigned long long paravirt_sched_clock(void)
+static __always_inline unsigned long long paravirt_sched_clock(void)
 {
 	return PVOP_CALL0(unsigned long long, time.sched_clock);
 }
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -14,6 +14,7 @@
 #include <linux/percpu.h>
 #include <linux/timex.h>
 #include <linux/static_key.h>
+#include <linux/kprobes.h>
 
 #include <asm/hpet.h>
 #include <asm/timer.h>
@@ -207,7 +208,7 @@ static void __init cyc2ns_init_secondary
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
-u64 native_sched_clock(void)
+notrace u64 native_sched_clock(void)
 {
 	if (static_branch_likely(&__use_tsc)) {
 		u64 tsc_now = rdtsc();
@@ -228,6 +229,7 @@ u64 native_sched_clock(void)
 	/* No locking but a rare wrong value is not a big deal: */
 	return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);
 }
+NOKPROBE_SYMBOL(native_sched_clock);
 
 /*
  * Generate a sched_clock if you already have a TSC value.
@@ -240,10 +242,11 @@ u64 native_sched_clock_from_tsc(u64 tsc)
 /* We need to define a real function for sched_clock, to override the
    weak default version */
 #ifdef CONFIG_PARAVIRT
-unsigned long long sched_clock(void)
+notrace unsigned long long sched_clock(void)
 {
 	return paravirt_sched_clock();
 }
+NOKPROBE_SYMBOL(sched_clock);
 
 bool using_native_sched_clock(void)
 {
--- a/include/linux/ftrace_irq.h
+++ b/include/linux/ftrace_irq.h
@@ -7,7 +7,7 @@ extern bool trace_hwlat_callback_enabled
 extern void trace_hwlat_callback(bool enter);
 #endif
 
-static inline void ftrace_nmi_enter(void)
+static __always_inline void ftrace_nmi_enter(void)
 {
 #ifdef CONFIG_HWLAT_TRACER
 	if (trace_hwlat_callback_enabled)
@@ -15,7 +15,7 @@ static inline void ftrace_nmi_enter(void
 #endif
 }
 
-static inline void ftrace_nmi_exit(void)
+static __always_inline void ftrace_nmi_exit(void)
 {
 #ifdef CONFIG_HWLAT_TRACER
 	if (trace_hwlat_callback_enabled)
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -22,6 +22,7 @@
 #include <linux/sched/clock.h>
 #include <linux/ktime.h>
 #include <linux/trace_clock.h>
+#include <linux/kprobes.h>
 
 /*
  * trace_clock_local(): the simplest and least coherent tracing clock.
@@ -44,6 +45,7 @@ u64 notrace trace_clock_local(void)
 
 	return clock;
 }
+NOKPROBE_SYMBOL(trace_clock_local);
 EXPORT_SYMBOL_GPL(trace_clock_local);
 
 /*
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -43,6 +43,7 @@
 #include <linux/cpumask.h>
 #include <linux/delay.h>
 #include <linux/sched/clock.h>
+#include <linux/kprobes.h>
 #include "trace.h"
 
 static struct trace_array	*hwlat_trace;
@@ -137,7 +138,7 @@ static void trace_hwlat_sample(struct hw
 #define init_time(a, b)	(a = b)
 #define time_u64(a)	a
 
-void trace_hwlat_callback(bool enter)
+notrace void trace_hwlat_callback(bool enter)
 {
 	if (smp_processor_id() != nmi_cpu)
 		return;
@@ -156,6 +157,7 @@ void trace_hwlat_callback(bool enter)
 	if (enter)
 		nmi_count++;
 }
+NOKPROBE_SYMBOL(trace_hwlat_callback);
 
 /**
  * get_sample - sample the CPU TSC and look for likely hardware latencies
