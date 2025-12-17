Return-Path: <linux-arch+bounces-15485-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A31CCCC7566
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 12:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C9E230C3357
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 11:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAF4324714;
	Wed, 17 Dec 2025 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbh7XPNI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0B03090C5
	for <linux-arch@vger.kernel.org>; Wed, 17 Dec 2025 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970508; cv=none; b=vEmA11hACUoPkV/+yRmHJ+ScfqKnA5Bh2GtrIr4h65aE4uey+Ch/pSTPwhUyGGwvFXb4xtWponvLub9O5lOTE2b6nz24THwploEVUohKFuBY7Af9J5I6JVzdmpadaoh1GBzwsCKL0MbFDqLJzPgCQS6jY3wC9NNhozcP6ehA2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970508; c=relaxed/simple;
	bh=PbT5sZfmDr+/nxVY4pWWN+h6fehfMdGovGMLtwFj30I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UrDToBPdcmumACFTvPrqz3OE1FeSJhfUAB2/OX5cS88nXdDirTjE6sUKyOjVZdtN0W9hTNKf8qc3+CO9YJay3h/jYe2TzmvyTMwLCFJzOyyUcV9vIIv2Dp7q0mGeHEH9k3ejGhXcMGja5PSuvrl2jnVv8RED415Tt1V2og5FZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dbh7XPNI; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-64969d8d4f2so7821602a12.1
        for <linux-arch@vger.kernel.org>; Wed, 17 Dec 2025 03:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765970505; x=1766575305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ttwkH5J3h4njr7aVXheWd9p5UAgulJqqOnMFy47kAAI=;
        b=dbh7XPNIBwltX4D8LD7Nv26S1V9vXWyk/d3/pxvFFpZLSL6adpVNEHDAVtYPLYGQ+u
         /Nczr/2HPw6SeZxGa/EyMU+mUKuKU/jYDUtfw6XwlrdYQIxfL4aWJ2itzIrnJGKBI+wp
         mNkljGhXkRDXfjyCA56mYSe8EqlYrpDA/pHkMH84+y2ilX3cN+HPJrLSKmClZBrkX7N6
         xK8i5MavN9Et20Sb+CKmFYhXoTN6DsLcTYBCT4a4z1/x4rqlStAAhnlDB4MX++aOfeIF
         1pXErjrx7kRLMHlddBE1q9NvLBCUsEhkgw3EJtjg/puHYf11mce2N4b9rrDUT7J8lkEU
         tNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970505; x=1766575305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttwkH5J3h4njr7aVXheWd9p5UAgulJqqOnMFy47kAAI=;
        b=iSjbKsnODtobulhdLxHAf0lbRvqCTWUgxkzdMqtWzvzU2co1KViarjsDCmz6/MwdJI
         FEtbItk5KwWsKxwRKiQqjLhIlhOgYeftGH+MWqyYBs6Zy2XZIP0npD7UzveA31K9F+zI
         v6gDm31JRbHHuygRl+uJELOoL4zmH7/Zkd3bpeOIxKCxTMmd5ZEPpLfmWp773zHkJRQm
         JWFIt+AX1UvKYR7d093YIrlcyCYZMdXPL2ZguYhe4xXJcARnUQm1fGF3biQRwtiohkaz
         k4FZp/ph9V0B7xx/uP/UQR+yM4a30h0hAdIH6T84cf+rtfpff2WJSk1b5M1s8u/61+ZX
         /F7w==
X-Forwarded-Encrypted: i=1; AJvYcCVgBDB9xb0WnkvxLnMC7/sV87M2V0Sg0FBTHZc71Bg588Wfvm/j5OehMQKssjLltXHKWAF45cz3SOkV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlj+4ZHaa+eLNCxrwoi4i3pQAV6zfomGcadlf63APqak7VLGQ9
	VpoCEYP5ZxHueB3LT2w9sOl3fvC3dJRmgE2D2wQBBy5tb+GT2YzFD1lBxitPIqIgw7VGa4X9ShJ
	DlPX0NA==
X-Google-Smtp-Source: AGHT+IFDfOsMOee0hfiQvTUpX1IE1LLzHt3SPKjbuu0LgAk88CvrnY2u6emV5Ojh7/e0nVpY6PDW9rUud6s=
X-Received: from edbco9.prod.google.com ([2002:a05:6402:c09:b0:641:a64d:bead])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5209:b0:649:9251:1115
 with SMTP id 4fb4d7f45d1cf-6499b1f369bmr15648762a12.29.1765970504895; Wed, 17
 Dec 2025 03:21:44 -0800 (PST)
Date: Wed, 17 Dec 2025 11:21:27 +0000
In-Reply-To: <20251217112128.1401896-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251217112128.1401896-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.305.g3fc767764a-goog
Message-ID: <20251217112128.1401896-3-lrizzo@google.com>
Subject: [PATCH-v3 2/3] genirq: Adaptive Global Software Interrupt Moderation (GSIM)
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Make GSIM adaptive by measuring total and per-CPU interrupt rates, as
well as time spent in hardirq on each CPU. The metrics are compared to
configurable targets, and each CPU adjusts the moderation delay up
or down depending on the result, using multiplicative increase/decrease.

Configuration is done at boot time via module parameters

    irq_moderation.${NAME}=${VALUE}

or at runtime via /proc/irq/soft_moderation

    echo ${NAME}=${VALUE} > /proc/irq/soft_moderation

Parameters are:

  delay_us (0 off, range 0-500)
      Maximum moderation delay in microseconds.

  target_intr_rate (0 off, range 0-50000000)
      Total rate above which moderation should trigger.

  hardirq_percent (0 off,range 0-100)
      Percentage of time spent in hardirq above which moderation should
      trigger.

  update_ms (range 1-100)
      How often the metrics should be computed and moderation delay
      updated.

When target_intr_rate and hardirq_percent are both 0, GSIM uses a fixed
moderation delay equal to delay_us. Otherwise, the delay is dynamically
adjusted up or down, independently on each CPU, based on how the total
and per-CPU metrics compare with the targets.

Provided that delay_us suffices to bring the metrics within the target,
the control loop will dynamically converge to the minimum actual
moderation delay to stay within the target.

Change-Id: I19b15d98e214a90fadee1c6e5bce6c8aac7a709a
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 kernel/irq/Makefile              |   2 +-
 kernel/irq/irq_moderation.c      |  94 ++++++++++++++++--
 kernel/irq/irq_moderation.h      |  46 ++++++++-
 kernel/irq/irq_moderation_hook.c | 157 +++++++++++++++++++++++++++++++
 kernel/irq/irq_moderation_hook.h |  12 +--
 5 files changed, 291 insertions(+), 20 deletions(-)
 create mode 100644 kernel/irq/irq_moderation_hook.c

diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index c06da43d644f2..d41cca6a5da76 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_GENERIC_IRQ_CHIP) += generic-chip.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_IRQ_DOMAIN) += irqdomain.o
 obj-$(CONFIG_IRQ_SIM) += irq_sim.o
-obj-$(CONFIG_IRQ_SOFT_MODERATION) += irq_moderation.o
+obj-$(CONFIG_IRQ_SOFT_MODERATION) += irq_moderation.o irq_moderation_hook.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
 obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
index 2a7401bc51da2..be7d10404a24a 100644
--- a/kernel/irq/irq_moderation.c
+++ b/kernel/irq/irq_moderation.c
@@ -19,8 +19,9 @@
  *
  * Some platforms show reduced I/O performance when the total device interrupt
  * rate across the entire platform becomes too high. To address the problem,
- * GSIM uses a hook after running the handler to implement software interrupt
- * moderation with programmable delay.
+ * GSIM uses a hook after running the handler to measure global and per-CPU
+ * interrupt rates, compare them with configurable targets, and implements
+ * independent, per-CPU software moderation delays.
  *
  * Configuration is controlled at boot time via module parameters
  *
@@ -36,6 +37,19 @@
  *       Maximum moderation delay. A reasonable range is 20-100. Higher values
  *       can be useful if the hardirq handler has long runtimes.
  *
+ *   target_intr_rate (default 0, suggested 1000000, 0 off, range 0-50000000)
+ *       The total interrupt rate above which moderation kicks in.
+ *       Not particularly critical, a value in the 500K-1M range is usually ok.
+ *
+ *   hardirq_percent (default 0, suggested 70, 0 off, range 0-100)
+ *       The hardirq percentage above which moderation kicks in.
+ *       50-90 is a reasonable range.
+ *
+ *       FIXED MODERATION mode requires target_intr_rate=0, hardirq_percent=0
+ *
+ *   update_ms (default 5, range 1-100)
+ *       How often the load is measured and moderation delay updated.
+ *
  * Moderation can be enabled/disabled dynamically for individual interrupts with
  *
  *     echo 1 > /proc/irq/NN/soft_moderation # use 0 to disable
@@ -101,11 +115,22 @@
 /* Recommended values. */
 struct irq_mod_info irq_mod_info ____cacheline_aligned = {
 	.update_ms		= 5,
+	.increase_factor	= MIN_SCALING_FACTOR,
+	.scale_cpus		= 200,
 };
 
 module_param_named(delay_us, irq_mod_info.delay_us, uint, 0444);
 MODULE_PARM_DESC(delay_us, "Max moderation delay us, 0 = moderation off, range 0-500.");
 
+module_param_named(hardirq_percent, irq_mod_info.hardirq_percent, uint, 0444);
+MODULE_PARM_DESC(hardirq_percent, "Target max hardirq percentage, 0 off, range 0-100.");
+
+module_param_named(target_intr_rate, irq_mod_info.target_intr_rate, uint, 0444);
+MODULE_PARM_DESC(target_intr_rate, "Target max interrupt rate, 0 off, range 0-50000000.");
+
+module_param_named(update_ms, irq_mod_info.update_ms, uint, 0444);
+MODULE_PARM_DESC(update_ms, "Update interval in milliseconds, range 1-100");
+
 DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
 
 DEFINE_STATIC_KEY_FALSE(irq_moderation_enabled_key);
@@ -142,27 +167,72 @@ static int set_mode(struct irq_desc *desc, bool enable)
 /* Print statistics */
 static int moderation_show(struct seq_file *p, void *v)
 {
+	ulong intr_rate = 0, irq_high = 0, my_irq_high = 0, hardirq_high = 0;
 	uint delay_us = irq_mod_info.delay_us;
-	int j;
+	u64 now = ktime_get_ns();
+	int j, active_cpus = 0;
 
-#define HEAD_FMT "%5s  %8s  %11s  %11s  %9s\n"
-#define BODY_FMT "%5u  %8u  %11u  %11u  %9u\n"
+#define HEAD_FMT "%5s  %8s  %8s  %4s  %8s  %11s  %11s  %11s  %11s  %11s  %9s\n"
+#define BODY_FMT "%5u  %8u  %8u  %4u  %8u  %11u  %11u  %11u  %11u  %11u  %9u\n"
 
 	seq_printf(p, HEAD_FMT,
-		   "# CPU", "delay_ns", "timer_set", "enqueue", "stray_irq");
+		   "# CPU", "irq/s", "my_irq/s", "cpus", "delay_ns",
+		   "irq_hi", "my_irq_hi", "hardirq_hi", "timer_set",
+		   "enqueue", "stray_irq");
 
 	for_each_possible_cpu(j) {
 		struct irq_mod_state *ms = per_cpu_ptr(&irq_mod_state, j);
+		/* Watch out, epoch start_ns is 64 bits. */
+		u64 epoch_start_ns = atomic64_read((atomic64_t *)&ms->epoch_start_ns);
+		s64 age_ms = min((now - epoch_start_ns) / NSEC_PER_MSEC, (u64)999999);
+
+		if (age_ms < 10000) {
+			/* Average intr_rate over recently active CPUs. */
+			active_cpus++;
+			intr_rate += ms->intr_rate;
+		} else {
+			age_ms = -1;
+			ms->intr_rate = 0;
+			ms->my_intr_rate = 0;
+			ms->scaled_cpu_count = 0;
+			ms->mod_ns = 0;
+		}
+
+		irq_high += ms->irq_high;
+		my_irq_high += ms->my_irq_high;
+		hardirq_high += ms->hardirq_high;
 
 		seq_printf(p, BODY_FMT,
-			   j, ms->mod_ns, ms->timer_set, ms->enqueue, ms->stray_irq);
+			   j, ms->intr_rate, ms->my_intr_rate,
+			   (ms->scaled_cpu_count + 128) / 256,
+			   ms->mod_ns, ms->irq_high, ms->my_irq_high,
+			   ms->hardirq_high, ms->timer_set, ms->enqueue,
+			   ms->stray_irq);
 	}
 
 	seq_printf(p, "\n"
 		   "enabled              %s\n"
-		   "delay_us             %u\n",
+		   "delay_us             %u\n"
+		   "target_intr_rate     %u\n"
+		   "hardirq_percent      %u\n"
+		   "update_ms            %u\n"
+		   "scale_cpus           %u\n",
 		   str_yes_no(delay_us > 0),
-		   delay_us);
+		   delay_us,
+		   irq_mod_info.target_intr_rate, irq_mod_info.hardirq_percent,
+		   irq_mod_info.update_ms, irq_mod_info.scale_cpus);
+
+	seq_printf(p,
+		   "intr_rate            %lu\n"
+		   "irq_high             %lu\n"
+		   "my_irq_high          %lu\n"
+		   "hardirq_percent_high %lu\n"
+		   "total_interrupts     %u\n"
+		   "total_cpus           %u\n",
+		   active_cpus ? intr_rate / active_cpus : 0,
+		   irq_high, my_irq_high, hardirq_high,
+		   READ_ONCE(*((u32 *)&irq_mod_info.total_intrs)),
+		   READ_ONCE(*((u32 *)&irq_mod_info.total_cpus)));
 
 	return 0;
 }
@@ -182,8 +252,12 @@ struct param_names {
 
 static struct param_names param_names[] = {
 	{ "delay_us", &irq_mod_info.delay_us, 0, 500 },
+	{ "target_intr_rate", &irq_mod_info.target_intr_rate, 0, 50000000 },
+	{ "hardirq_percent", &irq_mod_info.hardirq_percent, 0, 100 },
+	{ "update_ms", &irq_mod_info.update_ms, 1, 100 },
 	/* Entries with no name cannot be set at runtime. */
-	{ "", &irq_mod_info.update_ms, 1, 100 },
+	{ "", &irq_mod_info.increase_factor, MIN_SCALING_FACTOR, 128 },
+	{ "", &irq_mod_info.scale_cpus, 50, 1000 },
 };
 
 static void update_enable_key(void)
diff --git a/kernel/irq/irq_moderation.h b/kernel/irq/irq_moderation.h
index 8fe1cf30bdf91..bd8edb9524613 100644
--- a/kernel/irq/irq_moderation.h
+++ b/kernel/irq/irq_moderation.h
@@ -14,14 +14,32 @@
 
 /**
  * struct irq_mod_info - global configuration parameters and state
+ * @total_intrs:	running count of total interrupts
+ * @total_cpus:		running count of total active CPUs
+ *			totals are updated every update_ms ("epoch")
  * @version:		increment on writes to /proc/irq/soft_moderation
- * @delay_us:		maximum delay
- * @update_ms:		how often to update delay (epoch duration)
+ * @delay_us:		fixed delay, or maximum for adaptive
+ * @target_intr_rate:	target maximum interrupt rate
+ * @hardirq_percent:	target maximum hardirq percentage
+ * @update_ms:		how often to update delay/rate/fraction (epoch duration)
+ * @increase_factor:	constant for exponential increase/decrease of delay
+ * @scale_cpus:		(percent) scale factor to estimate active CPUs
  */
 struct irq_mod_info {
+	/* These fields are written to by all CPUs every epoch. */
+	____cacheline_aligned
+	atomic_t	total_intrs;
+	atomic_t	total_cpus;
+
+	/* These are mostly read (frequently), so use a different cacheline. */
+	____cacheline_aligned
 	u32		version;
 	u32		delay_us;
+	u32		target_intr_rate;
+	u32		hardirq_percent;
 	u32		update_ms;
+	u32		increase_factor;
+	u32		scale_cpus;
 	u32		pad[];
 };
 
@@ -48,9 +66,20 @@ extern struct irq_mod_info irq_mod_info;
  *
  * Used once per epoch:
  * @version:		version fetched from irq_mod_info
+ * @delay_ns:		fetched from irq_mod_info
+ * @epoch_ns:		duration of last epoch
+ * @last_total_intrs:	from irq_mod_info
+ * @last_total_cpus:	from irq_mod_info
+ * @last_irqtime:	from cpustat[CPUTIME_IRQ]
  *
  * Statistics
+ * @intr_rate:		smoothed global interrupt rate
+ * @my_intr_rate:	smoothed interrupt rate for this CPU
  * @timer_set:		how many timer_set calls
+ * @scaled_cpu_count:	smoothed CPU count (scaled)
+ * @irq_high:		how many times global irq above threshold
+ * @my_irq_high:	how many times local irq above threshold
+ * @hardirq_high:	how many times local hardirq_percent above threshold
  */
 struct irq_mod_state {
 	/* Used on every interrupt. */
@@ -71,13 +100,26 @@ struct irq_mod_state {
 
 	/* Used once per epoch. */
 	u32			version;
+	u32			delay_ns;
+	u32			epoch_ns;
+	u32			last_total_intrs;
+	u32			last_total_cpus;
+	u64			last_irqtime;
 
 	/* Statistics */
+	u32			intr_rate;
+	u32			my_intr_rate;
 	u32			timer_set;
+	u32			timer_fire;
+	u32			scaled_cpu_count;
+	u32			irq_high;
+	u32			my_irq_high;
+	u32			hardirq_high;
 };
 
 DECLARE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
 
+#define MIN_SCALING_FACTOR 8u
 extern struct static_key_false irq_moderation_enabled_key;
 
 void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode);
diff --git a/kernel/irq/irq_moderation_hook.c b/kernel/irq/irq_moderation_hook.c
new file mode 100644
index 0000000000000..f04ed25a482a0
--- /dev/null
+++ b/kernel/irq/irq_moderation_hook.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/kernel_stat.h>
+
+#include "internals.h"
+#include "irq_moderation_hook.h"
+
+/* Slow path functions for interrupt moderation. */
+
+static inline u32 smooth_avg(u32 old, u32 cur, u32 steps)
+{
+	const u32 smooth_factor = 64;
+
+	steps = min(steps, smooth_factor - 1);
+	return ((smooth_factor - steps) * old + steps * cur) / smooth_factor;
+}
+
+/* Measure and assess time spent in hardirq. */
+static inline bool hardirq_high(struct irq_mod_state *ms, u32 hardirq_percent)
+{
+	bool above_threshold = false;
+
+	if (IS_ENABLED(CONFIG_IRQ_TIME_ACCOUNTING)) {
+		u64 irqtime, cur = kcpustat_this_cpu->cpustat[CPUTIME_IRQ];
+
+		irqtime = cur - ms->last_irqtime;
+		ms->last_irqtime = cur;
+
+		above_threshold = irqtime * 100 > (u64)ms->epoch_ns * hardirq_percent;
+		ms->hardirq_high += above_threshold;
+	}
+	return above_threshold;
+}
+
+/* Measure and assess total and per-CPU interrupt rates. */
+static inline bool irqrate_high(struct irq_mod_state *ms, u32 target_rate, u32 steps)
+{
+	u32 intr_rate, my_intr_rate, delta_intrs, active_cpus, tmp;
+	bool my_rate_high, global_rate_high;
+
+	my_intr_rate = ((u64)ms->intr_count * NSEC_PER_SEC) / ms->epoch_ns;
+
+	/* Accumulate global counter and compute global interrupt rate. */
+	tmp = atomic_add_return(ms->intr_count, &irq_mod_info.total_intrs);
+	ms->intr_count = 1;
+	delta_intrs = tmp - ms->last_total_intrs;
+	ms->last_total_intrs = tmp;
+	intr_rate = ((u64)delta_intrs * NSEC_PER_SEC) / ms->epoch_ns;
+
+	/*
+	 * Count how many CPUs handled interrupts in the last epoch, needed
+	 * to determine the per-CPU target (target_rate / active_cpus).
+	 * Each active CPU increments the global counter approximately every
+	 * update_ns. Scale the value by (update_ns / ms->epoch_ns) to get the
+	 * correct value. Also apply rounding and make sure active_cpus > 0.
+	 */
+	tmp = atomic_add_return(1, &irq_mod_info.total_cpus);
+	active_cpus = tmp - ms->last_total_cpus;
+	ms->last_total_cpus = tmp;
+	active_cpus = (active_cpus * ms->update_ns + ms->epoch_ns / 2) / ms->epoch_ns;
+	if (active_cpus < 1)
+		active_cpus = 1;
+
+	/* Compare with global and per-CPU targets. */
+	global_rate_high = intr_rate > target_rate;
+
+	/*
+	 * Short epochs may lead to underestimate the number of active CPUs.
+	 * Apply a scaling factor to compensate. This may make the controller
+	 * a bit more aggressive but does not harm system throughput.
+	 */
+	my_rate_high = my_intr_rate * active_cpus * irq_mod_info.scale_cpus > target_rate * 100;
+
+	/* Statistics. */
+	ms->intr_rate = smooth_avg(ms->intr_rate, intr_rate, steps);
+	ms->my_intr_rate = smooth_avg(ms->my_intr_rate, my_intr_rate, steps);
+	ms->scaled_cpu_count = smooth_avg(ms->scaled_cpu_count, active_cpus * 256, steps);
+	ms->my_irq_high += my_rate_high;
+	ms->irq_high += global_rate_high;
+
+	/* Moderate on this CPU only if both global and local rates are high. */
+	return global_rate_high && my_rate_high;
+}
+
+/* Periodic adjustment, called once per epoch. */
+void irq_moderation_update_epoch(struct irq_mod_state *ms)
+{
+	const u32 hardirq_percent = READ_ONCE(irq_mod_info.hardirq_percent);
+	const u32 target_rate = READ_ONCE(irq_mod_info.target_intr_rate);
+	const u32 min_delay_ns = 500;
+	bool above_target = false;
+	u32 version;
+	u32 steps;
+
+	/* Fetch updated parameters. */
+	while ((version = READ_ONCE(irq_mod_info.version)) != ms->version) {
+		ms->update_ns = READ_ONCE(irq_mod_info.update_ms) * NSEC_PER_MSEC;
+		ms->mod_ns = READ_ONCE(irq_mod_info.delay_us) * NSEC_PER_USEC;
+		ms->delay_ns = ms->mod_ns;
+		ms->version = version;
+	}
+
+	if (target_rate == 0 && hardirq_percent == 0) {
+		/* Use fixed moderation delay. */
+		ms->mod_ns = ms->delay_ns;
+		ms->intr_rate = 0;
+		ms->my_intr_rate = 0;
+		ms->scaled_cpu_count = 0;
+		return;
+	}
+
+	/*
+	 * To scale values X by a factor (1 +/- 1/F) every "update_ns" we do
+	 * 	X := X * (1 +/- 1/F)
+	 * If the interval is N times longer, applying the formula N times gives
+	 * 	X := X * ((1 +/- 1/F) ** N)
+	 * We don't want to deal floating point or exponentials, and we cap N
+	 * to some small value < F . This leads to an approximated formula
+	 * 	X := X * (1 +/- N/F)
+	 * The variable steps below is the number N of steps.
+	 */
+	steps = clamp(ms->epoch_ns / ms->update_ns, 1u, MIN_SCALING_FACTOR - 1u);
+
+	if (target_rate > 0 && irqrate_high(ms, target_rate, steps))
+		above_target = true;
+
+	if (hardirq_percent > 0 && hardirq_high(ms, hardirq_percent))
+		above_target = true;
+
+	/*
+	 * Controller: adjust delay with exponential increase or decrease.
+	 *
+	 * Note the different constants: we increase fast (smaller factor)
+	 * to aggressively slow down when the interrupt rate goes up,
+	 * but decrease slowly (larger factor) because reducing the delay can
+	 * drive up the interrupt rate and we don't want to create load spikes.
+	 */
+	if (above_target) {
+		const u32 increase_factor = READ_ONCE(irq_mod_info.increase_factor);
+
+		/* Make sure the value is large enough for the exponential to grow. */
+		if (ms->mod_ns < min_delay_ns)
+			ms->mod_ns = min_delay_ns;
+		ms->mod_ns += ms->mod_ns * steps / increase_factor;
+		if (ms->mod_ns > ms->delay_ns)
+			ms->mod_ns = ms->delay_ns;
+	} else {
+		const u32 decrease_factor = 2 * READ_ONCE(irq_mod_info.increase_factor);
+
+		ms->mod_ns -= ms->mod_ns * steps / decrease_factor;
+		/* Round down to 0 values that are too small to bother. */
+		if (ms->mod_ns < min_delay_ns)
+			ms->mod_ns = 0;
+	}
+}
diff --git a/kernel/irq/irq_moderation_hook.h b/kernel/irq/irq_moderation_hook.h
index f9ac3005f69f4..e96127923a04b 100644
--- a/kernel/irq/irq_moderation_hook.h
+++ b/kernel/irq/irq_moderation_hook.h
@@ -14,22 +14,20 @@
 
 #ifdef CONFIG_IRQ_SOFT_MODERATION
 
+void irq_moderation_update_epoch(struct irq_mod_state *ms);
+
 static inline void __maybe_new_epoch(struct irq_mod_state *ms)
 {
 	const u64 now = ktime_get_ns(), epoch_ns = now - ms->epoch_start_ns;
 	const u32 slack_ns = 5000;
-	u32 version;
 
 	/* Run approximately every update_ns, a little bit early is ok. */
 	if (epoch_ns < ms->update_ns - slack_ns)
 		return;
+	ms->epoch_ns = min(epoch_ns, (u64)U32_MAX);
 	ms->epoch_start_ns = now;
-	/* Fetch updated parameters. */
-        while ((version = READ_ONCE(irq_mod_info.version)) != ms->version) {
-		ms->update_ns = READ_ONCE(irq_mod_info.update_ms) * NSEC_PER_MSEC;
-		ms->mod_ns = READ_ONCE(irq_mod_info.delay_us) * NSEC_PER_USEC;
-		ms->version = version;
-        }
+	/* Do the expensive processing */
+	irq_moderation_update_epoch(ms);
 }
 
 static inline bool irq_moderation_needed(struct irq_desc *desc, struct irq_mod_state *ms)
-- 
2.52.0.305.g3fc767764a-goog


