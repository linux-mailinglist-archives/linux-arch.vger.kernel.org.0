Return-Path: <linux-arch+bounces-14678-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA29C542BB
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 20:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DB5E4E4993
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 19:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216B5350A07;
	Wed, 12 Nov 2025 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wR96Uzqw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC534F495
	for <linux-arch@vger.kernel.org>; Wed, 12 Nov 2025 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975470; cv=none; b=Hr4t9DLXqCz7Bf3HfSrSiNZ4x2VGyex9kDxKugPxiKh3UxurSXYKOBqQjA4J+w5C8uC7l6QFoSW/+C8vSx7vUMm/Q5Wlr9iaG4czOLd4qW5btxBXFMNCVOqr0A0Z/zsnLgig3mqkUIhswdl5dxdtyc3LOxqBP4xjBNUtisJV6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975470; c=relaxed/simple;
	bh=JboPOrrlrY4Ko6LJbn94SzHonmcSfVDYwJHknxK4H3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nUsFFYg/m54Q/quo7idF+yRr11g6H/UG0s+uoJ7/M7bXyOZ+mRYOAOr3RIMyvfouP6T3dT1yNDyi7rhap3/mXz1gU7FqXI9S98MyYtyWz0lU2UnMEHv9eOMwnbBJA0LOV5xi1uMUgKLATjJINo4ZxSJVvIYfmj6WtDBYtSQ7bek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wR96Uzqw; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b72de28c849so148355166b.1
        for <linux-arch@vger.kernel.org>; Wed, 12 Nov 2025 11:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975466; x=1763580266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B24mQnSZMVRgdG5U9hRXkGt9TnaPoRUEHUCFM9E7GFE=;
        b=wR96UzqwAPrKEfTJIjFEVuwe0xevl/xEFkWYQ04EmhA0Pko+qnZym6fQbCoU8qywgI
         9nQqadI0HKcqQv95b6MzoQ4LWozWP1p/7S3fagw92TRI0hleW/OggPd+8yhv8L77xX3c
         /TNfetYUp+6WjoLoBxXkGTxR/eLtCdfr1255T+1m1IOzgEK/KXx34zm98Emuck2GhmVi
         h18zaGQvNIfI3sROC2RMWjk8Sir0Ium06Q0NDpamZWjUdq/tAIkA/hqZ6oLwAwWaSVho
         qt0+1lfbjSyDX3CPX5Vyk7sAeQoqNJjEfhM2Sm4Lrn3RwGzToLE70MyrOZE3dh/Mgq4w
         xPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975466; x=1763580266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B24mQnSZMVRgdG5U9hRXkGt9TnaPoRUEHUCFM9E7GFE=;
        b=JzT4UzhNPVicLgGoa1LOmbQR7EStDRp79ICqtX4ZiLkVLV+kgnCM/nUJV+L6q6c4Nv
         kFREL7NwSX5PAepe0pMUQEAPXvATIt/Bh0ub0A+xYV0Qr+RC5ITz84ZSRe3HnKoILUMZ
         mMrRQ7PuHVq3+LmQCInBFMd+hp9hgC8Wg7QGTRmF81MvhrXbaM+2C4eLvmsgQUAdjamB
         nIQHH62hCyhBVud6L4J10C8adEVA6zUOhvflkpkOe9RzoXavl9U0Hv2vUzKV3eGmh6c6
         mLvCn/4PbKoosUPDSvYxV+gjMMaBZHgvaNh6HKL9uKP5PXXLP3dYQDPDZazZ1rTtJ7ri
         dONg==
X-Forwarded-Encrypted: i=1; AJvYcCVxTkLa7ddvUdp5C9t+tWPzps5pjVFfj2eKJwadiukAaeq9/wGEPft/Z7StLuOtOk+iSa8yIEVbay9B@vger.kernel.org
X-Gm-Message-State: AOJu0YywJ4UJxvsICqftZDkujn9Hxom/ltiVoaMkQCZ3GQ5NL28O6/1J
	gLtcc04EuDr18p2kP16NfmQarPZZpqlfiv2ERK8phb0UAoBdZi7I+sQUiHpiOsYNgyop7JGSkFP
	C1m5nnA==
X-Google-Smtp-Source: AGHT+IHRbH0+L2jlw8eibE1pxIXW03f0w5TdjuwI8vS9PEphIgcgFYF8p42VznymTU0p0+Uaeai1DRIrV5Y=
X-Received: from ejczi12.prod.google.com ([2002:a17:907:e98c:b0:b6d:7901:e54f])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:1c25:b0:b72:7cd3:d55b
 with SMTP id a640c23a62f3a-b733195f534mr450314366b.12.1762975465792; Wed, 12
 Nov 2025 11:24:25 -0800 (PST)
Date: Wed, 12 Nov 2025 19:24:04 +0000
In-Reply-To: <20251112192408.3646835-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112192408.3646835-3-lrizzo@google.com>
Subject: [PATCH 2/6] genirq: soft_moderation: add base files, procfs hooks
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the main core files that implement soft_moderation, limited to static
moderation, plus related small changes to include/linux/interrupt.h,
kernel/irq/Makefile, and kernel/irq/proc.c

- include/linux/irq_moderation.h has the two main struct, prototypes
  and inline hooks

- kernel/irq/irq_moderation.c has the procfs handlers

The code is not yet hooked to the interrupt handler, so
the feature is disabled but we can see the module parameters
/sys/module/irq_moderation/parameters and read/write the procfs entries
/proc/irq/soft_moderation and /proc/irq/NN/soft_moderation.

Examples:
cat /proc/irq/soft_moderation
echo "delay_us=345" > /proc/irq/soft_moderation
echo 1 | tee /proc/irq/*/nvme*/../soft_moderation

Change-Id: I472d9b5b31770aa2787f062f7fe5d411882be60e
---
 include/linux/irq_moderation.h | 196 ++++++++++++++++++++
 kernel/irq/Makefile            |   1 +
 kernel/irq/irq_moderation.c    | 315 +++++++++++++++++++++++++++++++++
 kernel/irq/proc.c              |   2 +
 4 files changed, 514 insertions(+)
 create mode 100644 include/linux/irq_moderation.h
 create mode 100644 kernel/irq/irq_moderation.c

diff --git a/include/linux/irq_moderation.h b/include/linux/irq_moderation.h
new file mode 100644
index 0000000000000..4d90d7c4ca26b
--- /dev/null
+++ b/include/linux/irq_moderation.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+
+#ifndef _LINUX_IRQ_MODERATION_H
+#define _LINUX_IRQ_MODERATION_H
+
+/*
+ * Platform wide software interrupt moderation, see
+ * Documentation/core-api/irq/irq-moderation.rst
+ */
+
+#include <linux/kernel.h>
+#include <linux/hrtimer.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+
+#ifdef CONFIG_IRQ_SOFT_MODERATION
+
+/* Global configuration parameters and state */
+struct irq_mod_info {
+	/* These fields are written to by all CPUs */
+	____cacheline_aligned
+	atomic_long_t total_intrs; /* running count updated every update_ms */
+	atomic_long_t total_cpus; /* as above, active CPUs in this interval */
+
+	/* These are mostly read (frequently), so use a different cacheline */
+	____cacheline_aligned
+	u64 procfs_write_ns;	/* last write to /proc/irq/soft_moderation */
+	uint delay_us;		/* fixed delay, or maximum for adaptive */
+	uint target_irq_rate;	/* target interrupt rate */
+	uint hardirq_percent;	/* target maximum hardirq percentage */
+	uint timer_rounds;	/* how many timer polls once moderation fires */
+	uint update_ms;		/* how often to update delay/rate/fraction */
+	uint scale_cpus;	/* (percent) scale factor to estimate active CPUs */
+	uint count_timer_calls;	/* count timer calls for irq limits */
+	uint count_msi_calls;	/* count calls from posted_msi for irq limits */
+	uint decay_factor;	/* keep it at 16 */
+	uint grow_factor;	/* keep it at 8 */
+	int pad[] ____cacheline_aligned;
+};
+
+extern struct irq_mod_info irq_mod_info;
+
+/* Per-CPU moderation state */
+struct irq_mod_state {
+	struct hrtimer timer;	/* moderation timer */
+	struct list_head descs;	/* moderated irq_desc on this CPU */
+
+	/* Counters on last time we updated moderation delay */
+	u64 last_ns;		/* time of last update */
+	u64 last_irqtime;	/* from cpustat[CPUTIME_IRQ] */
+	u64 last_total_irqs;
+	u64 last_total_cpus;
+
+	bool in_posted_msi;	/* don't suppress handle_irq, set in posted_msi handler */
+	bool kick_posted_msi;	/* kick posted_msi from the timer callback */
+
+	u32 cycles;		/* calls since last ktime_get_ns() */
+	s32 irq_count;		/* irqs in the last cycle, signed as we also decrement */
+	u32 delay_ns;		/* fetched from irq_mod_info */
+	u32 mod_ns;		/* recomputed every update_ms */
+	u32 sleep_ns;		/* accumulated time for actual delay */
+	s32 rounds_left;	/* how many rounds left for moderation */
+
+	/* Statistics */
+	u32 irq_rate;		/* smoothed global irq rate */;
+	u32 my_irq_rate;	/* smoothed irq rate for this CPU */;
+	u32 cpu_count;		/* smoothed CPU count (scaled) */;
+	u32 src_count;		/* smoothed irq sources count (scaled) */;
+	u32 irq_high;		/* how many times above each threshold */
+	u32 my_irq_high;
+	u32 hardirq_high;
+	u32 timer_set;		/* counters for various events */
+	u32 timer_fire;
+	u32 disable_irq;
+	u32 enable_irq;
+	u32 timer_calls;
+	u32 from_posted_msi;
+	u32 stray_irq;
+	int pad[] ____cacheline_aligned;
+};
+
+DECLARE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
+
+static inline void irq_moderation_start_timer(struct irq_mod_state *ms)
+{
+	ms->timer_set++;
+	ms->rounds_left = clamp(READ_ONCE(irq_mod_info.timer_rounds), 0u, 20u) + 1;
+	hrtimer_start_range_ns(&ms->timer, ns_to_ktime(ms->sleep_ns),
+			       /*range*/2000, HRTIMER_MODE_REL_PINNED_HARD);
+}
+
+static inline bool irq_moderation_enabled(void)
+{
+	return READ_ONCE(irq_mod_info.delay_us);
+}
+
+static inline uint irq_moderation_get_update_ms(void)
+{
+	return clamp(READ_ONCE(irq_mod_info.update_ms), 1u, 100u);
+}
+
+/* Called on each interrupt for adaptive moderation delay adjustment */
+static inline void irq_moderation_adjust_delay(struct irq_mod_state *ms)
+{
+	u64 now, delta_time, update_ns;
+
+	ms->irq_count++;
+	if (ms->cycles++ < 16)	/* ktime_get_ns() is expensive, don't do too often */
+		return;
+	ms->cycles = 0;
+	now = ktime_get_ns();
+	delta_time = now - ms->last_ns;
+	update_ns = irq_moderation_get_update_ms() * NSEC_PER_MSEC;
+
+	/* Run approximately every update_ns, a little bit early is ok */
+	if (delta_time < update_ns - 5000)
+		return;
+
+	/* Fetch important state */
+	ms->delay_ns = clamp(irq_mod_info.delay_us, 1u, 500u) * NSEC_PER_USEC;
+
+	ms->last_ns = now;
+	ms->mod_ns = ms->delay_ns;
+}
+
+/* Return true if timer is active or delay is large enough to require moderation */
+static inline bool irq_moderation_needed(struct irq_mod_state *ms)
+{
+	if (!hrtimer_is_queued(&ms->timer)) {
+		ms->sleep_ns += ms->mod_ns;     /* accumulate sleep time */
+		if (ms->sleep_ns < 10000)       /* no moderation if too small */
+			return false;
+	}
+	return true;
+}
+
+void disable_irq_nosync(unsigned int irq);
+
+/*
+ * Use in handle_irq_event() before calling the handler. Decide whether this
+ * desc should be moderated, and in case disable the irq and add the desc to
+ * the list for this CPU.
+ */
+static inline void irq_moderation_hook(struct irq_desc *desc)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	if (!irq_moderation_enabled())
+		return;
+
+	if (!READ_ONCE(desc->moderation_mode))
+		return;
+
+	irq_moderation_adjust_delay(ms);
+
+	if (!list_empty(&desc->ms_node)) {
+		/*
+		 * Very unlikely, stray interrupt while the desc is moderated.
+		 * Unfortunately we cannot ignore it, just count it.
+		 */
+		ms->stray_irq++;
+		return;
+	}
+
+	if (!irq_moderation_needed(ms))
+		return;
+
+	list_add(&desc->ms_node, &ms->descs); /* Add to list of moderated desc */
+	/*
+	 * disable the irq. This will also cause irq_can_handle() return false
+	 * (through irq_can_handle_actions()), and that will prevent a handler
+	 * instance to be run again while the descriptor is being moderated.
+	 *
+	 * irq_moderation_epilogue() will then start the timer if needed.
+	 */
+	ms->disable_irq++;
+	disable_irq_nosync(desc->irq_data.irq); /* desc must be unlocked */
+}
+
+/* After the handler, if desc is moderated, make sure the timer is active. */
+static inline void irq_moderation_epilogue(const struct irq_desc *desc)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	if (!list_empty(&desc->ms_node) && !hrtimer_is_queued(&ms->timer))
+		irq_moderation_start_timer(ms);
+}
+
+#else	/* empty stubs to avoid conditional compilation */
+
+static inline void irq_moderation_hook(struct irq_desc *desc) {}
+static inline void irq_moderation_epilogue(const struct irq_desc *desc) {}
+
+#endif /* CONFIG_IRQ_SOFT_MODERATION */
+
+#endif /* _LINUX_IRQ_MODERATION_H */
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
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
new file mode 100644
index 0000000000000..a9d2bdcf4d8c7
--- /dev/null
+++ b/kernel/irq/irq_moderation.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+
+#include <linux/irq_moderation.h>
+#include <linux/kernel_stat.h>	/* interrupt.h, kcpustat_this_cpu */
+#include "internals.h"
+
+/*
+ * Platform-wide software interrupt moderation.
+ *
+ * see Documentation/core-api/irq/irq-moderation.rst
+ *
+ * === MOTIVATION AND OPERATION ===
+ *
+ * Some platforms show reduced I/O performance when the total device interrupt
+ * rate across the entire platform becomes too high. This code implements
+ * per-CPU adaptive moderation based on the total interrupt rate, as opposed
+ * to conventional moderation that operates separately on each source.
+ *
+ * It computes the total interrupt rate and number of sources, and uses the
+ * information to adaptively disable individual interrupts for small amounts
+ * of time using per-CPU hrtimers and MSI-X Pending Bit Array. Specifically:
+ *
+ * - a hook in handle_irq_event(), which applies only on sources configured
+ *   to use moderation, updates statistics and check whether we need
+ *   moderation on that CPU/irq. If so, calls disable_irq_nosync() and starts
+ *   an hrtimer with appropriate delay.
+ *
+ * - the timer callback calls enable_irq() for all disabled interrupts on that
+ *   CPU. That in turn will generate interrupts if there are pending events.
+ *
+ * === CONFIGURATION ===
+ *
+ * The following can be controlled at boot time via module parameters
+ *
+ *     irq_moderation.${NAME}=${VALUE}
+ *
+ * or at runtime by writing
+ *
+ *     echo "${NAME}=${VALUE}" > /proc/irq/soft_moderation
+ *
+ *   delay_us (default 50, range 10..500, 0 DISABLES MODERATION)
+ *     Fixed or maximum moderation delay.  A reasonable range is 20..100, higher
+ *     values can be useful if the hardirq handler is performing a significant
+ *     amount of work.
+ *
+ *     FIXED MODERATION mode requires target_irq_rate=0, hardirq_percent=0
+ *
+ *   target_irq_rate (default 1M, 0 off, range 0..50M)
+ *     the total irq rate above which moderation kicks in.
+ *     Not particularly critical, a value in the 500K-1M range is usually ok
+ *
+ *   hardirq_percent (default 70, 0 off, range 10..100)
+ *     the hardirq percentage above which moderation kicks in.
+ *     50-90 is a reasonable range.
+ *
+ *   timer_rounds (default 0, max 20)
+ *     once moderation triggers, periodically run handler zero or more
+ *     times using a timer rather than interrupts. This is similar to
+ *     napi_defer_hard_irqs on NICs.
+ *     A small value may help control load in interrupt-challenged platforms.
+ *
+ *   update_ms (default 1, range 1...100)
+ *     how often the load is measured and moderation delay updated.
+ *
+ * Moderation can be enabled/disabled for individual interrupts with
+ *
+ *    echo "on" > /proc/irq/NN/soft_moderation # use "off" to disable
+ *
+ * === MONITORING ===
+ *
+ * cat /proc/irq/soft_moderation shows per-CPU and global statistics.
+ *
+ */
+
+static_assert(offsetof(struct irq_mod_info, procfs_write_ns) == 64);
+
+struct irq_mod_info irq_mod_info ____cacheline_aligned = {
+	.delay_us = 100,
+	.update_ms = 1,
+	.count_timer_calls = true,
+};
+
+module_param_named(delay_us, irq_mod_info.delay_us, uint, 0444);
+MODULE_PARM_DESC(delay_us, "Max moderation delay us, 0 = moderation off, range 10..500.");
+
+module_param_named(timer_rounds, irq_mod_info.timer_rounds, uint, 0444);
+MODULE_PARM_DESC(timer_rounds, "How many extra timer polls once moderation triggered.");
+
+DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
+
+static void smooth_avg(u32 *dst, u32 val, u32 steps)
+{
+	*dst = ((64 - steps) * *dst + steps * val) / 64;
+}
+
+/* moderation timer handler, called in hardintr context */
+static enum hrtimer_restart moderation_timer_cb(struct hrtimer *timer)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+	struct irq_desc *desc, *next;
+	uint srcs = 0;
+
+	ms->timer_fire++;
+	WARN_ONCE(ms->timer_set != ms->timer_fire,
+		  "CPU %d timer set %d fire %d (lost events?)\n",
+		  smp_processor_id(), ms->timer_set, ms->timer_fire);
+
+	ms->rounds_left--;
+
+	if (ms->rounds_left > 0) {
+		/* Timer still alive. Just call the handlers */
+		list_for_each_entry_safe(desc, next, &ms->descs, ms_node) {
+			ms->irq_count += irq_mod_info.count_timer_calls;
+			ms->timer_calls++;
+			handle_irq_event_percpu(desc);
+		}
+		ms->timer_set++;
+		hrtimer_forward_now(&ms->timer, ms->sleep_ns);
+		return HRTIMER_RESTART;
+	}
+
+	/* Last round, remove from list and enable_irq() */
+	list_for_each_entry_safe(desc, next, &ms->descs, ms_node) {
+		list_del(&desc->ms_node);
+		INIT_LIST_HEAD(&desc->ms_node);
+		srcs++;
+		ms->enable_irq++;
+		enable_irq(desc->irq_data.irq);	/* ok if the sync_lock/unlock are NULL */
+	}
+	smooth_avg(&ms->src_count, srcs * 256, 1);
+
+	ms->sleep_ns = 0;	/* prepare to accumulate next moderation delay */
+
+	WARN_ONCE(ms->disable_irq != ms->enable_irq,
+		  "CPU %d irq disable %d enable %d (%s)\n",
+		  smp_processor_id(), ms->disable_irq, ms->enable_irq,
+		     "bookkeeping error, some irq qill be stuck");
+
+	return HRTIMER_NORESTART;
+}
+
+/* Initialize moderation state in desc_set_defaults() */
+void irq_moderation_init_fields(struct irq_desc *desc)
+{
+	INIT_LIST_HEAD(&desc->ms_node);
+	desc->moderation_mode = 0;
+}
+
+/* Per-CPU state initialization */
+void irq_moderation_percpu_init(void)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	hrtimer_setup(&ms->timer, moderation_timer_cb, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
+	INIT_LIST_HEAD(&ms->descs);
+}
+
+static void set_moderation_mode(struct irq_desc *desc, bool mode)
+{
+	if (desc) {
+		struct irq_chip *chip = desc->irq_data.chip;
+
+		/* Make sure this is msi and we can run enable_irq from irq context */
+		mode &= desc->handle_irq == handle_edge_irq && chip && chip->irq_bus_lock == NULL &&
+				chip->irq_bus_sync_unlock == NULL;
+		if (mode != desc->moderation_mode)
+			desc->moderation_mode = mode;
+	}
+}
+
+#pragma clang diagnostic error "-Wformat"
+/* Print statistics */
+static int moderation_show(struct seq_file *p, void *v)
+{
+	ulong irq_rate = 0, irq_high = 0, my_irq_high = 0, hardirq_high = 0;
+	uint delay_us = irq_mod_info.delay_us;
+	struct irq_mod_state *ms;
+	u64 now = ktime_get_ns();
+	int j, active_cpus = 0;
+	struct irq_desc *desc = p->private;
+
+	if (desc) {
+		seq_printf(p, "%s\n", desc->moderation_mode ? "on" : "off");
+		return 0;
+	}
+
+	seq_puts(p, "# CPU     irq/s  my_irq/s  cpus  srcs  delay_ns       irq_hi     my_irq_hi"
+		 "   hardirq_hi    timer_set  disable_irq    from_msi  timer_calls  stray_irq\n");
+	for_each_online_cpu(j) {
+		ms = per_cpu_ptr(&irq_mod_state, j);
+		if (now - ms->last_ns > NSEC_PER_SEC) {
+			ms->my_irq_rate = 0;
+			ms->irq_rate = 0;
+			ms->cpu_count = 0;
+		} else {	/* average irq_rate over active CPUs */
+			active_cpus++;
+			irq_rate += ms->irq_rate;
+		}
+		/* compute totals */
+		irq_high += ms->irq_high;
+		my_irq_high += ms->my_irq_high;
+		hardirq_high += ms->hardirq_high;
+
+		seq_printf(p, "%5u  %8u  %8u  %4u  %4u  %8u  %11u  %11u  %11u  %11u  %11u  %11u  %11u  %9u\n",
+			   j, ms->irq_rate, ms->my_irq_rate, (ms->cpu_count + 128) / 256,
+			   (ms->src_count + 128) / 256, ms->mod_ns, ms->irq_high, ms->my_irq_high,
+			   ms->hardirq_high, ms->timer_set, ms->disable_irq,
+			   ms->from_posted_msi, ms->timer_calls, ms->stray_irq);
+	}
+
+	seq_printf(p, "\n"
+		   "enabled              %s\n"
+		   "delay_us             %u\n"
+		   "timer_rounds         %u\n"
+		   "count_timer_calls    %s\n",
+		   str_yes_no(delay_us),
+		   delay_us,
+		   irq_mod_info.timer_rounds,
+		   str_yes_no(irq_mod_info.count_timer_calls));
+
+	return 0;
+}
+
+static int moderation_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, moderation_show, pde_data(inode));
+}
+
+/* helpers to set values */
+struct var_names {
+	const char *name;
+	uint *val;
+	int min;
+	int max;
+} var_names[] = {
+	{ "delay_us", &irq_mod_info.delay_us, 0, 500 },
+	{ "timer_rounds", &irq_mod_info.timer_rounds, 0, 50 },
+	{ "count_timer_calls", &irq_mod_info.count_timer_calls, 0, 1 },
+	{}
+};
+
+static int set_parameter(const char *buf, int len)
+{
+	struct var_names *n;
+	int l, val;
+
+	for (n = var_names; n->name; n++) {
+		l = strlen(n->name);
+		if (len >= l + 2 && !strncmp(buf, n->name, l) && buf[l] == '=')
+			break;
+	}
+	if (!n->name || !n->val)
+		return -EINVAL;
+	if (kstrtouint(buf + l + 1, 0, &val))
+		return -EINVAL;
+	WRITE_ONCE(*(n->val), clamp(val, n->min, n->max));
+	irq_mod_info.procfs_write_ns = ktime_get_ns();
+	return len;
+}
+
+static ssize_t moderation_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
+{
+	char val[40];	/* bounded string size */
+	struct irq_desc *desc = (struct irq_desc *)pde_data(file_inode(f));
+
+	if (count == 0 || count + 1 > sizeof(val))
+		return -EINVAL;
+	if (copy_from_user(val, buf, count))
+		return -EFAULT;
+	val[count] = '\0';
+	if (val[count - 1] == '\n')
+		val[count - 1] = '\0';
+	if (!desc)
+		return set_parameter(val, count);
+
+	if (!strcmp(val, "off") || !strcmp(val, "0"))
+		set_moderation_mode(desc, false);
+	else if (!strcmp(val, "on") || !strcmp(val, "1"))
+		set_moderation_mode(desc, true);
+	else
+		return -EINVAL;
+	return count;	/* consume all */
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
+void irq_moderation_procfs_entry(struct irq_desc *desc, umode_t umode)
+{
+	if (umode)
+		proc_create_data("soft_moderation", umode, desc->dir, &proc_ops, desc);
+	else
+		remove_proc_entry("soft_moderation", desc->dir);
+}
+
+static int __init init_irq_moderation(void)
+{
+	proc_create_data("irq/soft_moderation", 0644, NULL, &proc_ops, (void *)0);
+	return 0;
+}
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_VERSION("1.0");
+MODULE_AUTHOR("Luigi Rizzo <lrizzo@google.com>");
+MODULE_DESCRIPTION("Platform wide software interrupt moderation");
+module_init(init_irq_moderation);
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 29c2404e743be..3d2b583b9443e 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -374,6 +374,7 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 	proc_create_single_data("effective_affinity_list", 0444, desc->dir,
 				irq_effective_aff_list_proc_show, irqp);
 # endif
+	irq_moderation_procfs_entry(desc, 0644);
 #endif
 	proc_create_single_data("spurious", 0444, desc->dir,
 				irq_spurious_proc_show, (void *)(long)irq);
@@ -395,6 +396,7 @@ void unregister_irq_proc(unsigned int irq, struct irq_desc *desc)
 	remove_proc_entry("effective_affinity", desc->dir);
 	remove_proc_entry("effective_affinity_list", desc->dir);
 # endif
+	irq_moderation_procfs_entry(desc, 0);	/* remove */
 #endif
 	remove_proc_entry("spurious", desc->dir);
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


