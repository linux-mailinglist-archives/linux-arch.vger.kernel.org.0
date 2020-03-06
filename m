Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06C5517C4EF
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 18:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCFRzF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 12:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgCFRzF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 12:55:05 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 223DF206E2;
        Fri,  6 Mar 2020 17:55:02 +0000 (UTC)
Date:   Fri, 6 Mar 2020 12:55:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        dan carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Message-ID: <20200306125500.6aa75c0d@gandalf.local.home>
In-Reply-To: <1896740806.20220.1583510668164.JavaMail.zimbra@efficios.com>
References: <20200221133416.777099322@infradead.org>
        <20200221134216.051596115@infradead.org>
        <20200306104335.GF3348@worktop.programming.kicks-ass.net>
        <20200306113135.GA8787@worktop.programming.kicks-ass.net>
        <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com>
        <1896740806.20220.1583510668164.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 6 Mar 2020 11:04:28 -0500 (EST)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> If we care about not adding those extra branches on the fast-path, there is
> an alternative way to do things: BPF could provide two distinct probe callbacks,
> one meant for rcuidle tracepoints (which would have the trace_rcu_enter/exit), and
> the other for the for 99% of the other callsites which have RCU watching.
> 
> I would recommend performing benchmarks justifying the choice of one approach over
> the other though.

I just whipped this up (haven't even tried to compile it), but this should
satisfy everyone. Those that register a callback that needs RCU protection
simply registers with one of the _rcu versions, and all will be done. And
since DO_TRACE is a macro, and rcuidle is a constant, the rcu protection
code will be compiled out for locations that it is not needed.

With this, perf doesn't even need to do anything extra but register with
the "_rcu" version.

-- Steve

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index b29950a19205..582dece30170 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -25,6 +25,7 @@ struct tracepoint_func {
 	void *func;
 	void *data;
 	int prio;
+	int requires_rcu;
 };
 
 struct tracepoint {
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 1fb11daa5c53..5f4de82ffa0f 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -179,25 +179,28 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		 * For rcuidle callers, use srcu since sched-rcu	\
 		 * doesn't work from the idle path.			\
 		 */							\
-		if (rcuidle) {						\
+		if (rcuidle)						\
 			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
-			rcu_irq_enter_irqson();				\
-		}							\
 									\
 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
 									\
 		if (it_func_ptr) {					\
 			do {						\
+				int rcu_flags;				\
 				it_func = (it_func_ptr)->func;		\
+				if (rcuidle &&				\
+				    (it_func_ptr)->requires_rcu)	\
+					rcu_flags = trace_rcu_enter();	\
 				__data = (it_func_ptr)->data;		\
 				((void(*)(proto))(it_func))(args);	\
+				if (rcuidle &&				\
+				    (it_func_ptr)->requires_rcu)	\
+					trace_rcu_exit(rcu_flags);	\
 			} while ((++it_func_ptr)->func);		\
 		}							\
 									\
-		if (rcuidle) {						\
+		if (rcuidle)						\
 			rcu_irq_exit_irqson();				\
-			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
-		}							\
 									\
 		preempt_enable_notrace();				\
 	} while (0)
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 73956eaff8a9..1797e20fd471 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -295,6 +295,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
  * @probe: probe handler
  * @data: tracepoint data
  * @prio: priority of this function over other registered functions
+ * @rcu: set to non zero if the callback requires RCU protection
  *
  * Returns 0 if ok, error value on error.
  * Note: if @tp is within a module, the caller is responsible for
@@ -302,8 +303,8 @@ static int tracepoint_remove_func(struct tracepoint *tp,
  * performed either with a tracepoint module going notifier, or from
  * within module exit functions.
  */
-int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
-				   void *data, int prio)
+int tracepoint_probe_register_prio_rcu(struct tracepoint *tp, void *probe,
+				       void *data, int prio, int rcu)
 {
 	struct tracepoint_func tp_func;
 	int ret;
@@ -312,12 +313,52 @@ int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
 	tp_func.func = probe;
 	tp_func.data = data;
 	tp_func.prio = prio;
+	tp_func.requires_rcu = rcu;
 	ret = tracepoint_add_func(tp, &tp_func, prio);
 	mutex_unlock(&tracepoints_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio_rcu);
+
+/**
+ * tracepoint_probe_register_prio -  Connect a probe to a tracepoint with priority
+ * @tp: tracepoint
+ * @probe: probe handler
+ * @data: tracepoint data
+ * @prio: priority of this function over other registered functions
+ *
+ * Returns 0 if ok, error value on error.
+ * Note: if @tp is within a module, the caller is responsible for
+ * unregistering the probe before the module is gone. This can be
+ * performed either with a tracepoint module going notifier, or from
+ * within module exit functions.
+ */
+int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
+				   void *data, int prio)
+{
+	return tracepoint_probe_register_prio_rcu(tp, probe, data, prio, 0);
+}
 EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio);
 
+/**
+ * tracepoint_probe_register_rcu -  Connect a probe to a tracepoint
+ * @tp: tracepoint
+ * @probe: probe handler
+ * @data: tracepoint data
+ *
+ * Returns 0 if ok, error value on error.
+ * Note: if @tp is within a module, the caller is responsible for
+ * unregistering the probe before the module is gone. This can be
+ * performed either with a tracepoint module going notifier, or from
+ * within module exit functions.
+ */
+int tracepoint_probe_register_rcu(struct tracepoint *tp, void *probe, void *data)
+{
+	return tracepoint_probe_register_prio_rcu(tp, probe, data,
+						  TRACEPOINT_DEFAULT_PRIO, 1);
+}
+EXPORT_SYMBOL_GPL(tracepoint_probe_register_rcu);
+
 /**
  * tracepoint_probe_register -  Connect a probe to a tracepoint
  * @tp: tracepoint
@@ -332,7 +373,8 @@ EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio);
  */
 int tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data)
 {
-	return tracepoint_probe_register_prio(tp, probe, data, TRACEPOINT_DEFAULT_PRIO);
+	return tracepoint_probe_register_prio_rcu(tp, probe, data,
+						  TRACEPOINT_DEFAULT_PRIO, 0);
 }
 EXPORT_SYMBOL_GPL(tracepoint_probe_register);
 
