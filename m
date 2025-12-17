Return-Path: <linux-arch+bounces-15484-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A28DCC7560
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 12:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 240F53111CB2
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1581632573A;
	Wed, 17 Dec 2025 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJpyjTcV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF763168E7
	for <linux-arch@vger.kernel.org>; Wed, 17 Dec 2025 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970508; cv=none; b=ZXUD+osZjdiSHUJ5/NYGF51mhcKCyau+E5AuTZ4+KXkotnmxGu82BG7mCDcoNzFXdJzBF20U1Sos0+M3tgFY2em8iN6TuwdL4Fl3+iH+87bgGR0DF2oymfzyWYt0WKuSB/dWJ4+RB/Ql83RA58NxngYxbb7G57CpabHNHE8G3xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970508; c=relaxed/simple;
	bh=LNHhM2s0FNoFuYALUvYHahtwRolnny8egm21AsJ1tag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OxwYMw5eqIRcKinTaTQLJ+i1OLXsC7avXE1BSp9PrRXKems+z1Tv6vEnVQpeus76kGcZGQDnMU+NcmG0jg6OExPZx9JRc30WpPVz4EaFbJ+GEbniPAkO9NT4kLNqDbk/3UipwBrk/8PWHxxt8p8oNnKx/H4dIvGlQcQa1xjgyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJpyjTcV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso38969745e9.2
        for <linux-arch@vger.kernel.org>; Wed, 17 Dec 2025 03:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765970503; x=1766575303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmCBnSY5i2PWNS+mgQi0gxQxxA/UKBXwwvGRJL++VOE=;
        b=DJpyjTcVdv5CEB5VqjJim6EFKmIkHOJjMHegnNA4MPHzWMdVfeGE2vtwBfV9sSkhh1
         6Kv/ZhlRQ53gUsqNZ4TCoeur1FES5OqoG3hMsjHnv1daS/PQf3+GfTU8kM5tUfllk+4u
         A/cUxO7wr5uw1tpp+RYzt60LsRD4zVNd61qNiVkw2nWutHtnXyufaS4qmPwJ7EjXh26Q
         x9MdczYupgl2d7+Nn+mLNTIGMJGnWH1D61IzKxQOMXXooLfwhPnw8ZRmYdhN5V00H96S
         asx6xVPVarzFhX/LvoCA8h2VLZCmiHJ5OsC5EweLgkigR4tDhf23dR6SWZNO5icv70SJ
         HVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970503; x=1766575303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmCBnSY5i2PWNS+mgQi0gxQxxA/UKBXwwvGRJL++VOE=;
        b=fEAht1kER5r6CnOkPbGPRLdgzoBAXWVwp04EAVmqU2LbO/MXpatlcaXxQWLIRDirpa
         eAP75TonUTktqSKhD50RG+tlZZRSxp/b7S2cF9Y/AlR8J/Cw1Vux0NN7LM2GHmoVBwEH
         VKWdFtr/6NTrw3eFRrChI9wYbJeuAxGbTP3CTVElCnD2T+h+X7jA7+PtoD/joCNb25Ew
         9mqcX36pGKZSFsaGXcMfg9uPU6+d/BrU0nASoijziMoARJgmw1bLy9skhh5hBN00FjAQ
         pXQEGXH/kCskFemYOYs3zgGR9aM1Ph15efwQ4VGbSUAWrfMajBfz122RxQCtpdLcsf4Z
         7N/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPVrqmntbz/x4I8nh4ST0CHBAllK1C4SBgo2/VAHtdDPMjTpK6FVLKU971m5v/vkFimyYgFcc3DZ+4@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4xCeOZ2KxdJkkd/1u2H3yCmTUC84dDkcihZyrm8KiizACtVE
	wmcGiGKLwjd7SUeUu9iqeTCma9uFuq1jNuBZ29Owq1dAftXARuAElN8aNbZcZiGmCGXBwfrfquU
	U+eaq5A==
X-Google-Smtp-Source: AGHT+IFeDH71QaXLwk/WRNgz5Fe1tzmbIXg7oPH7+C+a/ggvJu3bPkrJ3dJKywl1FzvNPOpIdCaQ1G3J5pg=
X-Received: from wmby5.prod.google.com ([2002:a05:600c:c045:b0:477:a0a1:eae8])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:699a:b0:479:2651:3f9c
 with SMTP id 5b1f17b1804b1-47bda6e58d4mr40141695e9.14.1765970502991; Wed, 17
 Dec 2025 03:21:42 -0800 (PST)
Date: Wed, 17 Dec 2025 11:21:26 +0000
In-Reply-To: <20251217112128.1401896-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251217112128.1401896-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.305.g3fc767764a-goog
Message-ID: <20251217112128.1401896-2-lrizzo@google.com>
Subject: [PATCH-v3 1/3] genirq: Fixed Global Software Interrupt Moderation (GSIM)
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Some platforms show reduced I/O performance when the total device
interrupt rate across the entire platform becomes too high.

Interrupt moderation can be used to rate-limit individual interrupts,
and as a consequence also the total rate. Not all devices implement
moderation in hardware, or they may have impractically coarse granularity
(e.g. NVME specifies 100us).

GSIM implements interrupt moderation in software, allowing control of
interrupt rates even without hardware support. It als provides a building
block for more sophisticated, adaptive mechanisms.

Moderation is enabled/disabled per interrupt source with

    echo 1 > /proc/irq/NN/soft_moderation # use 0 to disable

In this version the delay is fixed, and equal for all interrupts with
moderation enabled. It is set at boot via module parameter

    irq_moderation.delay_us=XX  # range 0-500, 0 means disabled

and can be updated at runtime with

    echo delay_us=XX > /proc/irq/soft_moderation

Per CPU statistics on how often moderation is used are available via

    cat /proc/irq/soft_moderation

GSIM is limited to edge interrupts using handle_edge_irq() or
handle_fasteoi_irq(). It has been tested on Intel (including with
intremap=posted_msi), AMD, ARM with NIC, NVME and VFIO.

PERFORMANCE BENEFITS:
Below are some experimental results under high load (before/after rates
are measured with conventional moderation or with this change):

- 100Gbps NIC, 32 queues: rx goes from 50 Gbps to 92.8 Gbps (line rate).
- 200Gbps NIC, 10 VMs (total 160 queues): rx goes from 30 Gbps to 190 Gbps (line rate).
- 12 SSD, 96 queues: 4K random read goes from 6M to 20.5M IOPS (device max).

In all cases, latency up to p95 is unaffected at low/moderate load,
even if compared with no moderation at all

On Intel, intremap=posted_msi requires the fix in
https://lore.kernel.org/lkml/20251125214631.044440658@linutronix.de/

Change-Id: I7c321ef5d295cad6ab4a87f2fa79ce8c85c7bf9a
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/irqdesc.h          |  23 ++
 kernel/irq/Kconfig               |  12 +
 kernel/irq/Makefile              |   1 +
 kernel/irq/chip.c                |  16 +-
 kernel/irq/irq_moderation.c      | 414 +++++++++++++++++++++++++++++++
 kernel/irq/irq_moderation.h      |  93 +++++++
 kernel/irq/irq_moderation_hook.h | 104 ++++++++
 kernel/irq/irqdesc.c             |   1 +
 kernel/irq/proc.c                |   3 +
 9 files changed, 666 insertions(+), 1 deletion(-)
 create mode 100644 kernel/irq/irq_moderation.c
 create mode 100644 kernel/irq/irq_moderation.h
 create mode 100644 kernel/irq/irq_moderation_hook.h

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 17902861de76d..d42ce57ff5406 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -17,6 +17,27 @@ struct irq_desc;
 struct irq_domain;
 struct pt_regs;
 
+#ifdef CONFIG_IRQ_SOFT_MODERATION
+
+/**
+ * struct irq_desc_mod - interrupt moderation information
+ * @ms_node:		per-CPU list of moderated irq_desc
+ * @enable:		enable moderation on this descriptor
+ */
+struct irq_desc_mod {
+	struct list_head	ms_node;
+	bool			enable;
+};
+
+void irq_moderation_init_fields(struct irq_desc_mod *mod);
+
+#else
+
+struct irq_desc_mod {};
+static inline void irq_moderation_init_fields(struct irq_desc_mod *mod) {}
+
+#endif
+
 /**
  * struct irqstat - interrupt statistics
  * @cnt:	real-time interrupt count
@@ -46,6 +67,7 @@ struct irqstat {
  * @threads_handled:	stats field for deferred spurious detection of threaded handlers
  * @threads_handled_last: comparator field for deferred spurious detection of threaded handlers
  * @lock:		locking for SMP
+ * @mod:		moderation state
  * @affinity_hint:	hint to user space for preferred irq affinity
  * @affinity_notify:	context for notification of affinity changes
  * @pending_mask:	pending rebalanced interrupts
@@ -81,6 +103,7 @@ struct irq_desc {
 	atomic_t		threads_handled;
 	int			threads_handled_last;
 	raw_spinlock_t		lock;
+	struct irq_desc_mod	mod;
 	struct cpumask		*percpu_enabled;
 #ifdef CONFIG_SMP
 	const struct cpumask	*affinity_hint;
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 1b4254d19a73e..c258973b63459 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -155,6 +155,18 @@ config IRQ_KUNIT_TEST
 
 endmenu
 
+# Support platform wide software interrupt moderation
+config IRQ_SOFT_MODERATION
+	bool "Enable platform wide software interrupt moderation"
+	depends on PROC_FS=y
+	help
+	  Enable platform wide software interrupt moderation.
+	  Uses a local timer to delay interrupts in configurable ways
+	  and depending on various global system load indicators
+	  and targets.
+
+	  If you don't know what to do here, say N.
+
 config GENERIC_IRQ_MULTI_HANDLER
 	bool
 	help
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index 6ab3a40556670..c06da43d644f2 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_GENERIC_IRQ_CHIP) += generic-chip.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_IRQ_DOMAIN) += irqdomain.o
 obj-$(CONFIG_IRQ_SIM) += irq_sim.o
+obj-$(CONFIG_IRQ_SOFT_MODERATION) += irq_moderation.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
 obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 678f094d261a7..56faa5260b858 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -18,6 +18,7 @@
 #include <trace/events/irq.h>
 
 #include "internals.h"
+#include "irq_moderation_hook.h"
 
 static irqreturn_t bad_chained_irq(int irq, void *dev_id)
 {
@@ -739,6 +740,13 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 
 	guard(raw_spinlock)(&desc->lock);
 
+	if (irq_moderation_skip_moderated(desc)) {
+		mask_irq(desc);
+		desc->istate |= IRQS_PENDING;
+		cond_eoi_irq(chip, &desc->irq_data);
+		return;
+	}
+
 	/*
 	 * When an affinity change races with IRQ handling, the next interrupt
 	 * can arrive on the new CPU before the original CPU has completed
@@ -765,6 +773,9 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 
 	cond_unmask_eoi_irq(desc, chip);
 
+	if (irq_moderation_hook(desc))
+		return;
+
 	/*
 	 * When the race described above happens this will resend the interrupt.
 	 */
@@ -824,7 +835,7 @@ void handle_edge_irq(struct irq_desc *desc)
 {
 	guard(raw_spinlock)(&desc->lock);
 
-	if (!irq_can_handle(desc)) {
+	if (irq_moderation_skip_moderated(desc) || !irq_can_handle(desc)) {
 		desc->istate |= IRQS_PENDING;
 		mask_ack_irq(desc);
 		return;
@@ -854,6 +865,9 @@ void handle_edge_irq(struct irq_desc *desc)
 
 		handle_irq_event(desc);
 
+		if (irq_moderation_hook(desc))
+			break;
+
 	} while ((desc->istate & IRQS_PENDING) && !irqd_irq_disabled(&desc->irq_data));
 }
 EXPORT_SYMBOL(handle_edge_irq);
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
new file mode 100644
index 0000000000000..2a7401bc51da2
--- /dev/null
+++ b/kernel/irq/irq_moderation.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+
+#include <linux/cpuhotplug.h>
+#include <linux/glob.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/kallsyms.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/proc_fs.h>
+#include <linux/suspend.h>
+#include <linux/seq_file.h>
+
+#include "internals.h"
+#include "irq_moderation.h"
+
+/*
+ * Management code for Global Software Interrupt Moderation (GSIM)
+ *
+ * Some platforms show reduced I/O performance when the total device interrupt
+ * rate across the entire platform becomes too high. To address the problem,
+ * GSIM uses a hook after running the handler to implement software interrupt
+ * moderation with programmable delay.
+ *
+ * Configuration is controlled at boot time via module parameters
+ *
+ *     irq_moderation.${NAME}=${VALUE}
+ *
+ * or at runtime via /proc/irq/soft_moderation
+ *
+ *     echo "${NAME}=${VALUE}" > /proc/irq/soft_moderation
+ *
+ * Supported parameters:
+ *
+ *   delay_us (default 0, suggested 100, 0 off, range 0-500)
+ *       Maximum moderation delay. A reasonable range is 20-100. Higher values
+ *       can be useful if the hardirq handler has long runtimes.
+ *
+ * Moderation can be enabled/disabled dynamically for individual interrupts with
+ *
+ *     echo 1 > /proc/irq/NN/soft_moderation # use 0 to disable
+ *
+ * === MONITORING ===
+ *
+ * cat /proc/irq/soft_moderation shows configuration and per-CPU/global statistics.
+ *
+ * === ARCHITECTURE ===
+ *
+ * INTERRUPT HANDLING:
+ * - irq_moderation_hook() runs under desc->lock right after the interrupt handler.
+ *   If the interrupt must be moderated, it sets IRQD_IRQ_INPROGRESS, calls
+ *   __disable_irq() adds the irq_desc to a per-CPU list of moderated interrupts,
+ *   and starts a moderation timer if not yet active.
+ * - desc->handler is modified so that when called on a moderated irq_desc it
+ *   calls mask_irq(), sets IRQS_PENDING and returns immediately.
+ * - the timer callback drains the moderation list: on each irq_desc it acquires
+ *   desc->lock, and if desc->action != NULL calls __enable_irq(), possibly calling
+ *   the handler if IRQS_PENDING is set.
+ *
+ * INTERRUPT TEARDOWN
+ * is protected by IRQD_IRQ_INPROGRESS and checking desc->action != NULL.
+ * This works because free_irq() runs in two steps:
+ * - first clear desc->action (under lock),
+ * - then call synchronize_irq(), which blocks on IRQD_IRQ_INPROGRESS
+ *   before freeing resources.
+ * When the moderation timer races with free_irq() we can have two cases:
+ * 1. timer runs before clearing desc->action. In this case __enable_irq()
+ *    is valid and the subsequent free_irq() will complete as intended
+ * 2. desc->action is cleared before the timer runs. In this case synchronize_irq()
+ *    will block until the timer expires (remember moderation delays are very short,
+ *    comparable to C-state exit times), __enable_irq() will not be run,
+ *    and free_irq() will complete successfully.
+ *
+ * INTERRUPT MIGRATION
+ * is protected by IRQD_IRQ_INPROGRESS that prevents running the handler on the
+ * new CPU while an interrupt is moderated.
+ *
+ * HOTPLUG
+ * During CPU shutdown, the kernel moves timers and reassigns interrupt affinity
+ * to a new CPU. The easiest way and most robust way to guarantee that pending
+ * events are handled correctly is to use a per-CPU "moderation_on" flag and
+ * hotplug callbacks on CPUHP_AP_ONLINE_DYN:
+ * - on setup, set the flag. That will allow interrupts to be moderated.
+ * - on shutdown, with interrupts disabled, 1. clear the flag thus preventing
+ *   more interrupts to be moderated on that CPU, 2. flush the list of moderated
+ *   interrupts (as if the timer had fired), and 3. cancel the timer.
+ * This avoids depending with the internals of the up/down sequence.
+ *
+ * SUSPEND
+ * Register a PM notifier to handle PM_SUSPEND_PREPARE and PM_POST_RESTORE as
+ * hotplug shutdown and setup events. The hotplug callbacks are also invoked
+ * during suspend to/resume from disk.
+ *
+ * BOOT PROCESSOR
+ * Hotplug callbacks are not invoked for the boot processor.
+ * However the boot processor is the last one to go, and since there is
+ * no other place to run the timer callbacks, they will be run where they
+ * are supposed to.
+ */
+
+/* Recommended values. */
+struct irq_mod_info irq_mod_info ____cacheline_aligned = {
+	.update_ms		= 5,
+};
+
+module_param_named(delay_us, irq_mod_info.delay_us, uint, 0444);
+MODULE_PARM_DESC(delay_us, "Max moderation delay us, 0 = moderation off, range 0-500.");
+
+DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
+
+DEFINE_STATIC_KEY_FALSE(irq_moderation_enabled_key);
+
+/* Initialize moderation state, used in desc_set_defaults() */
+void irq_moderation_init_fields(struct irq_desc_mod *mod)
+{
+	INIT_LIST_HEAD(&mod->ms_node);
+	mod->enable = false;
+}
+
+static int set_mode(struct irq_desc *desc, bool enable)
+{
+	lockdep_assert_held(&desc->lock);
+	if (enable) {
+		struct irq_data *irqd = &desc->irq_data;
+		struct irq_chip *chip = irqd->chip;
+
+		/* Moderation is only supported in specific cases. */
+		enable &= !irqd_is_level_type(irqd);
+		enable &= irqd_is_single_target(irqd);
+		enable &= !chip->irq_bus_lock && !chip->irq_bus_sync_unlock;
+		enable &= chip->irq_mask && chip->irq_unmask;
+		enable &= desc->handle_irq == handle_edge_irq ||
+				desc->handle_irq == handle_fasteoi_irq;
+		if (!enable)
+			return -EOPNOTSUPP;
+	}
+	desc->mod.enable = enable;
+	return 0;
+}
+
+#pragma clang diagnostic error "-Wformat"
+/* Print statistics */
+static int moderation_show(struct seq_file *p, void *v)
+{
+	uint delay_us = irq_mod_info.delay_us;
+	int j;
+
+#define HEAD_FMT "%5s  %8s  %11s  %11s  %9s\n"
+#define BODY_FMT "%5u  %8u  %11u  %11u  %9u\n"
+
+	seq_printf(p, HEAD_FMT,
+		   "# CPU", "delay_ns", "timer_set", "enqueue", "stray_irq");
+
+	for_each_possible_cpu(j) {
+		struct irq_mod_state *ms = per_cpu_ptr(&irq_mod_state, j);
+
+		seq_printf(p, BODY_FMT,
+			   j, ms->mod_ns, ms->timer_set, ms->enqueue, ms->stray_irq);
+	}
+
+	seq_printf(p, "\n"
+		   "enabled              %s\n"
+		   "delay_us             %u\n",
+		   str_yes_no(delay_us > 0),
+		   delay_us);
+
+	return 0;
+}
+
+static int moderation_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, moderation_show, pde_data(inode));
+}
+
+/* Helpers to set and clamp values from procfs or at init. */
+struct param_names {
+	const char *name;
+	uint *val;
+	uint min;
+	uint max;
+};
+
+static struct param_names param_names[] = {
+	{ "delay_us", &irq_mod_info.delay_us, 0, 500 },
+	/* Entries with no name cannot be set at runtime. */
+	{ "", &irq_mod_info.update_ms, 1, 100 },
+};
+
+static void update_enable_key(void)
+{
+	struct static_key_false *key = &irq_moderation_enabled_key;
+
+	if (irq_mod_info.delay_us != 0)
+		static_branch_enable(key);
+	else
+		static_branch_disable(key);
+}
+
+static ssize_t moderation_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
+{
+	uint i, val, copy_len, name_len;
+	struct param_names *n;
+	char cmd[40];
+
+	copy_len = min(sizeof(cmd) - 1, count);
+	if (count == 0)
+		return -EINVAL;
+	if (copy_from_user(cmd, buf, copy_len))
+		return -EFAULT;
+	cmd[copy_len] = '\0';
+	for (i = 0, n = param_names;  i < ARRAY_SIZE(param_names); i++, n++) {
+		name_len = strlen(n->name);
+		if (name_len < 1 || copy_len < name_len + 2 || strncmp(cmd, n->name, name_len) ||
+		    cmd[name_len] != '=')
+			continue;
+		if (kstrtouint(cmd + name_len + 1, 0, &val))
+			return -EINVAL;
+		WRITE_ONCE(*(n->val), clamp(val, n->min, n->max));
+		if (n->val == &irq_mod_info.delay_us)
+			update_enable_key();
+		/* Notify parameter update. */
+		irq_mod_info.version++;
+		return count;
+	}
+	return -EINVAL;
+}
+
+static const struct proc_ops proc_ops = {
+	.proc_open	= moderation_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+	.proc_write	= moderation_write,
+};
+
+/* Handlers for /proc/irq/NN/soft_moderation */
+static int mode_show(struct seq_file *p, void *v)
+{
+	struct irq_desc *desc = p->private;
+
+	if (!desc)
+		return -ENOENT;
+
+	seq_puts(p, desc->mod.enable ? "on\n" : "off\n");
+	return 0;
+}
+
+static ssize_t mode_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct irq_desc *desc = (struct irq_desc *)pde_data(file_inode(f));
+	char cmd[40];
+	bool enable;
+	int ret;
+
+	if (!desc)
+		return -ENOENT;
+	if (count == 0 || count + 1 > sizeof(cmd))
+		return -EINVAL;
+	if (copy_from_user(cmd, buf, count))
+		return -EFAULT;
+	cmd[count] = '\0';
+
+	ret = kstrtobool(cmd, &enable);
+	if (!ret) {
+		guard(raw_spinlock_irqsave)(&desc->lock);
+		ret = set_mode(desc, enable);
+	}
+	return ret ? : count;
+}
+
+static int mode_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mode_show, pde_data(inode));
+}
+
+static const struct proc_ops mode_ops = {
+	.proc_open	= mode_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+	.proc_write	= mode_write,
+};
+
+void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode)
+{
+	proc_create_data("soft_moderation", umode, desc->dir, &mode_ops, desc);
+}
+
+void irq_moderation_procfs_remove(struct irq_desc *desc)
+{
+	remove_proc_entry("soft_moderation", desc->dir);
+}
+
+/* Used on timer expiration or CPU shutdown. */
+static void drain_desc_list(struct irq_mod_state *ms)
+{
+	struct irq_desc *desc, *next;
+
+	/* Remove from list and enable interrupts back. */
+	list_for_each_entry_safe(desc, next, &ms->descs, mod.ms_node) {
+		guard(raw_spinlock)(&desc->lock);
+		list_del_init(&desc->mod.ms_node);
+		irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
+		/* Protect against competing free_irq(). */
+		if (desc->action)
+			__enable_irq(desc);
+	}
+}
+
+static enum hrtimer_restart timer_callback(struct hrtimer *timer)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	drain_desc_list(ms);
+	/* Prepare to accumulate next moderation delay. */
+	ms->sleep_ns = 0;
+	return HRTIMER_NORESTART;
+}
+
+/* Hotplug callback for setup. */
+static int cpu_setup_cb(uint cpu)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	if (ms->moderation_on)
+		return 0;
+	hrtimer_setup(&ms->timer, timer_callback,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
+	INIT_LIST_HEAD(&ms->descs);
+	smp_mb();
+	ms->moderation_on = true;
+	return 0;
+}
+
+/*
+ * Hotplug callback for shutdown.
+ * Mark the CPU as offline for moderation, and drain the list of masked
+ * interrupts. Any subsequent interrupt on this CPU will not be
+ * moderated, but they will be on the new target.
+ */
+static int cpu_remove_cb(uint cpu)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ms->moderation_on = false;
+	drain_desc_list(ms);
+	hrtimer_cancel(&ms->timer);
+	local_irq_restore(flags);
+	return 0;
+}
+
+static void(mod_pm_prepare_cb)(void *arg)
+{
+	cpu_remove_cb(smp_processor_id());
+}
+
+static void(mod_pm_resume_cb)(void *arg)
+{
+	cpu_setup_cb(smp_processor_id());
+}
+
+static int mod_pm_notifier_cb( struct notifier_block *nb, unsigned long event, void *unused)
+{
+	switch (event) {
+	case PM_SUSPEND_PREPARE:
+		on_each_cpu(mod_pm_prepare_cb, NULL, 1);
+		break;
+	case PM_POST_SUSPEND:
+		on_each_cpu(mod_pm_resume_cb, NULL, 1);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+struct notifier_block mod_nb = {
+	.notifier_call = mod_pm_notifier_cb,
+	.priority = 100,
+};
+
+static void clamp_parameter(uint *dst, uint val)
+{
+	struct param_names *n = param_names;
+
+	for (int i = 0; i < ARRAY_SIZE(param_names); i++, n++) {
+		if (dst == n->val) {
+			WRITE_ONCE(*dst, clamp(val, n->min, n->max));
+			return;
+		}
+	}
+}
+
+static int __init init_irq_moderation(void)
+{
+	/* Clamp all initial values to the allowed range, update version. */
+	for (uint *cur = &irq_mod_info.delay_us; cur < irq_mod_info.pad; cur++)
+		clamp_parameter(cur, *cur);
+	irq_mod_info.version++;
+
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "irq_moderation", cpu_setup_cb, cpu_remove_cb);
+	register_pm_notifier(&mod_nb);
+
+	update_enable_key();
+
+	proc_create_data("irq/soft_moderation", 0644, NULL, &proc_ops, NULL);
+	return 0;
+}
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_VERSION("1.0");
+MODULE_AUTHOR("Luigi Rizzo <lrizzo@google.com>");
+MODULE_DESCRIPTION("Global Software Interrupt Moderation");
+module_init(init_irq_moderation);
diff --git a/kernel/irq/irq_moderation.h b/kernel/irq/irq_moderation.h
new file mode 100644
index 0000000000000..8fe1cf30bdf91
--- /dev/null
+++ b/kernel/irq/irq_moderation.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+
+#ifndef _LINUX_IRQ_MODERATION_H
+#define _LINUX_IRQ_MODERATION_H
+
+/* Common data structures for Global Software Interrupt Moderation, GSIM */
+
+#include <linux/hrtimer.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/kernel.h>
+
+#ifdef CONFIG_IRQ_SOFT_MODERATION
+
+/**
+ * struct irq_mod_info - global configuration parameters and state
+ * @version:		increment on writes to /proc/irq/soft_moderation
+ * @delay_us:		maximum delay
+ * @update_ms:		how often to update delay (epoch duration)
+ */
+struct irq_mod_info {
+	u32		version;
+	u32		delay_us;
+	u32		update_ms;
+	u32		pad[];
+};
+
+extern struct irq_mod_info irq_mod_info;
+
+/**
+ * struct irq_mod_state - per-CPU moderation state
+ *
+ * Used on every interrupt:
+ * @timer:		moderation timer
+ * @moderation_on:	per-CPU enable, toggled during hotplug/suspend events
+ * @intr_count:		interrupts in the last epoch
+ * @sleep_ns:		accumulated time for actual delay
+ * @mod_ns:		nominal moderation delay, recomputed every epoch
+ *
+ * Used less frequently, every few interrupts:
+ * @epoch_start_ns:	start of current epoch
+ * @update_ns:		update_ms from irq_mod_info, converted to ns
+ * @stray_irq:		how many stray interrupts (almost never used)
+ *
+ * Used once per epoch per interrupt source:
+ * @descs:		list of	moderated irq_desc on this CPU
+ * @enqueue:		how many enqueue on the list
+ *
+ * Used once per epoch:
+ * @version:		version fetched from irq_mod_info
+ *
+ * Statistics
+ * @timer_set:		how many timer_set calls
+ */
+struct irq_mod_state {
+	/* Used on every interrupt. */
+	struct hrtimer		timer;
+	bool			moderation_on;
+	u32			intr_count;
+	u32			sleep_ns;
+	u32			mod_ns;
+
+	/* Used less frequently. */
+	u64			epoch_start_ns;
+	u32			update_ns;
+	u32			stray_irq;
+
+	/* Used once per epoch per source. */
+	struct list_head	descs;
+	u32			enqueue;
+
+	/* Used once per epoch. */
+	u32			version;
+
+	/* Statistics */
+	u32			timer_set;
+};
+
+DECLARE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
+
+extern struct static_key_false irq_moderation_enabled_key;
+
+void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode);
+void irq_moderation_procfs_remove(struct irq_desc *desc);
+
+#else /* CONFIG_IRQ_SOFT_MODERATION */
+
+static inline void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode) {}
+static inline void irq_moderation_procfs_remove(struct irq_desc *desc) {}
+
+#endif /* !CONFIG_IRQ_SOFT_MODERATION */
+
+#endif /* _LINUX_IRQ_MODERATION_H */
diff --git a/kernel/irq/irq_moderation_hook.h b/kernel/irq/irq_moderation_hook.h
new file mode 100644
index 0000000000000..f9ac3005f69f4
--- /dev/null
+++ b/kernel/irq/irq_moderation_hook.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+
+#ifndef _LINUX_IRQ_MODERATION_HOOK_H
+#define _LINUX_IRQ_MODERATION_HOOK_H
+
+/* Interrupt hooks for Global Software Interrupt Moderation, GSIM */
+
+#include <linux/hrtimer.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/kernel.h>
+
+#include "irq_moderation.h"
+
+#ifdef CONFIG_IRQ_SOFT_MODERATION
+
+static inline void __maybe_new_epoch(struct irq_mod_state *ms)
+{
+	const u64 now = ktime_get_ns(), epoch_ns = now - ms->epoch_start_ns;
+	const u32 slack_ns = 5000;
+	u32 version;
+
+	/* Run approximately every update_ns, a little bit early is ok. */
+	if (epoch_ns < ms->update_ns - slack_ns)
+		return;
+	ms->epoch_start_ns = now;
+	/* Fetch updated parameters. */
+        while ((version = READ_ONCE(irq_mod_info.version)) != ms->version) {
+		ms->update_ns = READ_ONCE(irq_mod_info.update_ms) * NSEC_PER_MSEC;
+		ms->mod_ns = READ_ONCE(irq_mod_info.delay_us) * NSEC_PER_USEC;
+		ms->version = version;
+        }
+}
+
+static inline bool irq_moderation_needed(struct irq_desc *desc, struct irq_mod_state *ms)
+{
+	if (!hrtimer_is_queued(&ms->timer)) {
+		const u32 min_delay_ns = 10000;
+		const u64 slack_ns = 2000;
+
+		/* Accumulate sleep time, no moderation if too small. */
+		ms->sleep_ns += ms->mod_ns;
+		if (ms->sleep_ns < min_delay_ns)
+			return false;
+		/* We need moderation, start the timer. */
+		ms->timer_set++;
+		hrtimer_start_range_ns(&ms->timer, ns_to_ktime(ms->sleep_ns),
+				       slack_ns, HRTIMER_MODE_REL_PINNED_HARD);
+	}
+
+	/*
+	 * Add to the timer list and __disable_irq() to prevent serving subsequent
+	 * interrupts.
+	 */
+	if (!list_empty(&desc->mod.ms_node)) {
+		/* Very unlikely, stray interrupt while moderated. */
+		ms->stray_irq++;
+	} else {
+		ms->enqueue++;
+		list_add(&desc->mod.ms_node, &ms->descs);
+		__disable_irq(desc);
+	}
+	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
+	return true;
+}
+
+/*
+ * Use after running the handler, with lock held. If this source should be
+ * moderated, disable it, add to the timer list for this CPU and return true.
+ */
+static inline bool irq_moderation_hook(struct irq_desc *desc)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	if (!static_branch_unlikely(&irq_moderation_enabled_key))
+		return false;
+	if (!desc->mod.enable)
+		return false;
+	if (!ms->moderation_on)
+		return false;
+
+	ms->intr_count++;
+
+	/* Is this a new epoch? ktime_get_ns() is expensive, don't check too often. */
+	if ((ms->intr_count & 0xf) == 0)
+		__maybe_new_epoch(ms);
+
+	return irq_moderation_needed(desc, ms);
+}
+
+/* On entry of desc->irq_handler() tell handler to skip moderated interrupts. */
+static inline bool irq_moderation_skip_moderated(struct irq_desc *desc)
+{
+	return !list_empty(&desc->mod.ms_node);
+}
+
+#else /* CONFIG_IRQ_SOFT_MODERATION */
+
+static inline bool irq_moderation_hook(struct irq_desc *desc) { return false; }
+static inline bool irq_moderation_skip_moderated(struct irq_desc *desc) { return false; }
+
+#endif /* !CONFIG_IRQ_SOFT_MODERATION */
+
+#endif /* _LINUX_IRQ_MODERATION_HOOK_H */
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index f8e4e13dbe339..bfc5802033383 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -134,6 +134,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->tot_count = 0;
 	desc->name = NULL;
 	desc->owner = owner;
+	irq_moderation_init_fields(&desc->mod);
 	for_each_possible_cpu(cpu)
 		*per_cpu_ptr(desc->kstat_irqs, cpu) = (struct irqstat) { };
 	desc_smp_init(desc, node, affinity);
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 77258eafbf632..462e63af5d4d1 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 
 #include "internals.h"
+#include "irq_moderation.h"
 
 /*
  * Access rules:
@@ -376,6 +377,7 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 	proc_create_single_data("effective_affinity_list", 0444, desc->dir,
 				irq_effective_aff_list_proc_show, irqp);
 # endif
+	irq_moderation_procfs_add(desc, 0644);
 #endif
 	proc_create_single_data("spurious", 0444, desc->dir,
 				irq_spurious_proc_show, (void *)(long)irq);
@@ -397,6 +399,7 @@ void unregister_irq_proc(unsigned int irq, struct irq_desc *desc)
 	remove_proc_entry("effective_affinity", desc->dir);
 	remove_proc_entry("effective_affinity_list", desc->dir);
 # endif
+	irq_moderation_procfs_remove(desc);
 #endif
 	remove_proc_entry("spurious", desc->dir);
 
-- 
2.52.0.305.g3fc767764a-goog


