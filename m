Return-Path: <linux-arch+bounces-14413-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10024C1C681
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 18:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B03704E5F23
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18992F260C;
	Wed, 29 Oct 2025 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCctPaF/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C5B1B87C0;
	Wed, 29 Oct 2025 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758122; cv=none; b=fJtQeyhjyIVlHwi/fUr8/SshEyRQ4cjXZ78XsM2noR001FSNxl8LMQ3/CMhlvtO11SEv3EUxVGtO/oWYbneKYMBR6idwYB+jzH0aIYVeULGA1vga8EoNLJNlT8vChqPqNeRA4qoVAaCC3pEJKuv5f1QTnbqeqdlTZtE2g/fXAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758122; c=relaxed/simple;
	bh=t3ByI2ggpnXN7fpU/j1XfFuDuzjdaTgYJk3bPpbYU5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSTHt7M/OMJKwY8zPtKKbK2qI68zIFYw0bKBN3OfeZOFQlPk22CYLdQ/sa3gTaja+D7zex/CJ9biySCLv+6yCu5GpD6eRxJkH5wkleXacan9vPGpG7x5AxKUzLjd0UDWTgwQete12zTsYHrv6XQ1uI61OoHU5UjK9CkaYFYK0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCctPaF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E0DC4CEF7;
	Wed, 29 Oct 2025 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761758120;
	bh=t3ByI2ggpnXN7fpU/j1XfFuDuzjdaTgYJk3bPpbYU5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCctPaF/s4Ej/qaUy9NBWjZ4tFp0QCR0mZ6Q58I4iogldTOoS12UFHS0vHbG0DSph
	 227Cm4eZbmJrh0L/NPvh44Kt43N6IyuWC/KldVbmCoiLr50mqPOn4lsXsfukXT9u+K
	 SBwatwsBkUUf9NSOFWQllmDLp942vZS35JrPpXugYhl3MQY2Z3swCE0Lc1cVMzrOLm
	 q+hyKGuAJkkwhVPyyL8Zd0mjnzZC9T1HST0yNNQxlFzyBGHCKafdtiPPmxzYYRh5+I
	 K8ivV6rg0eGcNpXKcdo4UXxI0eBtAIghhVlnwJJpy2Ww7H0rESJJHmDQURxNbt0Hv7
	 4WzSv5OBoFaLQ==
Date: Wed, 29 Oct 2025 18:15:17 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rcu@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
Message-ID: <aQJLpSYz3jdazzdb@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aQDuY3rgOK-L8D04@localhost.localdomain>
 <xhsmhzf9aov51.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhzf9aov51.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Wed, Oct 29, 2025 at 11:32:58AM +0100, Valentin Schneider a écrit :
> I need to have a think about that one; one pain point I see is the context
> tracking work has to be NMI safe since e.g. an NMI can take us out of
> userspace. Another is that NOHZ-full CPUs need to be special cased in the
> stop machine queueing / completion.
> 
> /me goes fetch a new notebook

Something like the below (untested) ?

diff --git a/arch/x86/include/asm/context_tracking_work.h b/arch/x86/include/asm/context_tracking_work.h
index 485b32881fde..2940e28ecea6 100644
--- a/arch/x86/include/asm/context_tracking_work.h
+++ b/arch/x86/include/asm/context_tracking_work.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_CONTEXT_TRACKING_WORK_H
 
 #include <asm/sync_core.h>
+#include <linux/stop_machine.h>
 
 static __always_inline void arch_context_tracking_work(enum ct_work work)
 {
@@ -10,6 +11,9 @@ static __always_inline void arch_context_tracking_work(enum ct_work work)
 	case CT_WORK_SYNC:
 		sync_core();
 		break;
+	case CT_WORK_STOP_MACHINE:
+		stop_machine_poll_wait();
+		break;
 	case CT_WORK_MAX:
 		WARN_ON_ONCE(true);
 	}
diff --git a/include/linux/context_tracking_work.h b/include/linux/context_tracking_work.h
index 2facc621be06..b63200bd73d6 100644
--- a/include/linux/context_tracking_work.h
+++ b/include/linux/context_tracking_work.h
@@ -6,12 +6,14 @@
 
 enum {
 	CT_WORK_SYNC_OFFSET,
+	CT_WORK_STOP_MACHINE_OFFSET,
 	CT_WORK_MAX_OFFSET
 };
 
 enum ct_work {
-	CT_WORK_SYNC     = BIT(CT_WORK_SYNC_OFFSET),
-	CT_WORK_MAX      = BIT(CT_WORK_MAX_OFFSET)
+	CT_WORK_SYNC         = BIT(CT_WORK_SYNC_OFFSET),
+	CT_WORK_STOP_MACHINE = BIT(CT_WORK_STOP_MACHINE_OFFSET),
+	CT_WORK_MAX          = BIT(CT_WORK_MAX_OFFSET)
 };
 
 #include <asm/context_tracking_work.h>
diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 72820503514c..0efe88e84b8a 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -36,6 +36,7 @@ bool stop_one_cpu_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
 void stop_machine_park(int cpu);
 void stop_machine_unpark(int cpu);
 void stop_machine_yield(const struct cpumask *cpumask);
+void stop_machine_poll_wait(void);
 
 extern void print_stop_info(const char *log_lvl, struct task_struct *task);
 
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 3fe6b0c99f3d..8f0281b0db64 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -22,6 +22,7 @@
 #include <linux/atomic.h>
 #include <linux/nmi.h>
 #include <linux/sched/wake_q.h>
+#include <linux/sched/isolation.h>
 
 /*
  * Structure to determine completion condition and record errors.  May
@@ -176,6 +177,68 @@ struct multi_stop_data {
 	atomic_t		thread_ack;
 };
 
+static DEFINE_PER_CPU(int, stop_machine_poll);
+
+void stop_machine_poll_wait(void)
+{
+	int *poll = this_cpu_ptr(&stop_machine_poll);
+
+	while (*poll)
+		cpu_relax();
+	/* Enforce the work in stop machine to be visible */
+	smp_mb();
+}
+
+static void stop_machine_poll_start(struct multi_stop_data *msdata)
+{
+	int cpu;
+
+	if (housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
+		return;
+
+	/* Random target can't be known in advance */
+	if (!msdata->active_cpus)
+		return;
+		
+	for_each_cpu_andnot(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)) {
+		int *poll = per_cpu_ptr(&stop_machine_poll, cpu);
+
+		if (cpumask_test_cpu(cpu, msdata->active_cpus))
+			continue;
+
+		*poll = 1;
+
+		/*
+		 * Act as a full barrier so that if the work is queued, polling is
+		 * visible.
+		 */
+		if (ct_set_cpu_work(cpu, CT_WORK_STOP_MACHINE))
+			msdata->num_threads--;
+		else
+			*poll = 0;
+	}
+}
+
+static void stop_machine_poll_complete(struct multi_stop_data *msdata)
+{
+	int cpu;
+
+	if (housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
+		return;
+
+	for_each_cpu_andnot(cpu, cpu_online_mask, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)) {
+		int *poll = per_cpu_ptr(&stop_machine_poll, cpu);
+
+		if (cpumask_test_cpu(cpu, msdata->active_cpus))
+			continue;
+		/*
+		 * The RmW in ack_state() fully orders the work performed in stop_machine()
+		 * with polling.
+		 */
+		*poll = 0;
+	}
+}
+
 static void set_state(struct multi_stop_data *msdata,
 		      enum multi_stop_state newstate)
 {
@@ -186,10 +249,13 @@ static void set_state(struct multi_stop_data *msdata,
 }
 
 /* Last one to ack a state moves to the next state. */
-static void ack_state(struct multi_stop_data *msdata)
+static bool ack_state(struct multi_stop_data *msdata)
 {
-	if (atomic_dec_and_test(&msdata->thread_ack))
+	if (atomic_dec_and_test(&msdata->thread_ack)) {
 		set_state(msdata, msdata->state + 1);
+		return true;
+	}
+	return false;
 }
 
 notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
@@ -240,7 +306,8 @@ static int multi_cpu_stop(void *data)
 			default:
 				break;
 			}
-			ack_state(msdata);
+			if (ack_state(msdata) && msdata->state == MULTI_STOP_EXIT)
+				stop_machine_poll_complete(msdata);
 		} else if (curstate > MULTI_STOP_PREPARE) {
 			/*
 			 * At this stage all other CPUs we depend on must spin
@@ -615,6 +682,8 @@ int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data,
 		return ret;
 	}
 
+	stop_machine_poll_start(&msdata);
+
 	/* Set the initial state and stop all online cpus. */
 	set_state(&msdata, MULTI_STOP_PREPARE);
 	return stop_cpus(cpu_online_mask, multi_cpu_stop, &msdata);

