Return-Path: <linux-arch+bounces-14808-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C14C61AB7
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 19:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 711CD4E3CD6
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 18:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610EF311976;
	Sun, 16 Nov 2025 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMK3RkXZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3611A311597
	for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317752; cv=none; b=HJuX9hC4/gKZoF305zlaU1s0dqsZ8FTwpCuQrL+/QOYZzwP9myn2S+LMl/8aIuzQGBQeb1CxsXR7sJ1onGmRpvaXmofUR+gNhkb4fyWihBDyYbGJDDhnksTUIbG6odzdRiQXqsfrQu1EG+DFmlPxcSjadB3PHiDA9dQOLSZpJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317752; c=relaxed/simple;
	bh=TJL2KgBEcq4rTiytbw83vY0ThDV3QLXu+8zyjuIc5ik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QEQmtArEOP3i6ZGmpGL8Fb+5WP1DG44lABpPiUuMRidpB70xyPQ3/Nrv3YXWnBWd7oidgvqeyZVSDIG/IRlGhwMC+KVWW4JefwxlLeph+187tX0SV5x/2jRpOb+1tp/TxOwJTmJ/LQ3QSQedISjam7NBXhwCw4ZHGqFMDEQHrcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMK3RkXZ; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6409c803b1aso4260628a12.3
        for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 10:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763317748; x=1763922548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XXQUInU7bO+wjRcN7SHdJ4OA0vdulnVKg5jqBeyGDA=;
        b=OMK3RkXZqOYZX2OD2LabHIP41jkp8gqPiXXvcxNjMf7FWyKW7DUeatoFfLOwxX5RAW
         eA8nNhlLnd35rh5MOo7g9Hfh3UVSh/a2neXwRKjxsLunrODX6FWSbRGAw0UmmP4Bgw7B
         oX0v18dX1liQ0bvJagEXl7I3pi/8JOY0Wlv925RZbwrAA+LA81rX3/yYcPTNQ+v4uopD
         VoeZJWLQxNadwVKejQZWWe8qfERMqYdlAFR/YJkNeXKHa7HhTf6xl4wogcVQF4FAyy6U
         p/XfeIBKYfzuqrC/aifbLeTvmVJoIbYkiBaz8I9hbQmSwLf5gyNAmyu5BJHWboa4p8DA
         Wsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763317748; x=1763922548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XXQUInU7bO+wjRcN7SHdJ4OA0vdulnVKg5jqBeyGDA=;
        b=hckI2SZq62iUM3jXo2Hpi+Y/4th56lUSdgsrqjRNx5BoS/V2RbJvdOhHbHliPQ6NBO
         +ccxgHrOdRiVv7UqJk//0PayX/sakhznWzKHOLfxsO5NpForZsLupr8BBQmJ524b+SSH
         J8/eRmqi17hC87xKQgWR7qPBe7zsQdx0h1wZuTh3SJ2chKZV6ObJViLOtyjKio0zlPNp
         Mi1wHnvd4VF2TpxKsVeD72rNkCe/pvwhDAl5BNfDome+vtLV0ZE12g/DV2d/hhUSLjSD
         nDPiQ1yNVQJiP6cmkOQzO90cBP6hxkqPt501hMuLH08dTcQkek+x9+1JsydNduTuxI8e
         sK7A==
X-Forwarded-Encrypted: i=1; AJvYcCUgsVYy/dJaRkgVfswDqiBgFELC6tSp1f1WTDznX4ZOP2d26244x4YxK97uKBZCsX69JqbCx0qtiAGS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1hG+xHzHO1iBmH0ASn9FdgtaTTLanJLfpaJPuc22vkJ9thsJ3
	EXUpAUlq+oZPE6IWbce/I5dOC4/0bQJRoHrBIcx3thSiQOc0Ctyi4IP/UVnY13LZYPyA7u4ynvh
	PFY7tBQ==
X-Google-Smtp-Source: AGHT+IHJ8mtoRSyGEGrDBFTug13XTDzH8rOwxD9MoD9yV6y8zsmq9vDHzXXHpZ6uoHAOqOaHWrn3WjXK5mc=
X-Received: from edh20.prod.google.com ([2002:a05:6402:5054:b0:640:6b4f:f86b])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:13cd:b0:63b:f1aa:11c8
 with SMTP id 4fb4d7f45d1cf-64350e0511bmr9517342a12.10.1763317748692; Sun, 16
 Nov 2025 10:29:08 -0800 (PST)
Date: Sun, 16 Nov 2025 18:28:36 +0000
In-Reply-To: <20251116182839.939139-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116182839.939139-6-lrizzo@google.com>
Subject: [PATCH v2 5/8] x86/irq: soft_moderation: add support for posted_msi (intel)
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

On recent Intel CPUs, kernels compiled with CONFIG_X86_POSTED_MSI=y,
and the boot option "intremap=posted_msi", all MSI interrupts
that hit a CPU issue a single POSTED_MSI interrupt processed by
sysvec_posted_msi_notification() instead of having separate interrupts.

This change adds soft moderation hooks to the above handler.
Soft moderation on posted_msi does not require per-source enable,
irq_moderation.delay_us > 0 suffices.

To test it, run a kernel with the above options and enable moderation by
setting delay_us > 0.  The column "from_msi" in /proc/irq/soft_moderation
will show a non-zero value.

Change-Id: I07b83b428de6f6541e3903b553c1b837c68a0b7d
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 arch/x86/kernel/Makefile    |  2 +-
 arch/x86/kernel/irq.c       | 13 +++++++
 kernel/irq/irq_moderation.c | 38 ++++++++++++++++++-
 kernel/irq/irq_moderation.h | 73 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index bc184dd38d993..530f5b5342eaa 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -46,7 +46,7 @@ KCOV_INSTRUMENT_unwind_guess.o				:= n
 
 CFLAGS_head32.o := -fno-stack-protector
 CFLAGS_head64.o := -fno-stack-protector
-CFLAGS_irq.o := -I $(src)/../include/asm/trace
+CFLAGS_irq.o := -I $(src)/../include/asm/trace -I $(srctree)/kernel/irq
 
 obj-y			+= head_$(BITS).o
 obj-y			+= head$(BITS).o
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 10721a1252269..1abdd21fa5c52 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -13,6 +13,8 @@
 #include <linux/export.h>
 #include <linux/irq.h>
 
+#include <irq_moderation.h>
+
 #include <asm/irq_stack.h>
 #include <asm/apic.h>
 #include <asm/io_apic.h>
@@ -448,6 +450,13 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 	inc_irq_stat(posted_msi_notification_count);
 	irq_enter();
 
+	if (posted_msi_moderation_enabled()) {
+		if (posted_msi_should_rearm(handle_pending_pir(pid->pir, regs)))
+			goto rearm;
+		else
+			goto common_end;
+	}
+
 	/*
 	 * Max coalescing count includes the extra round of handle_pending_pir
 	 * after clearing the outstanding notification bit. Hence, at most
@@ -458,6 +467,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 			break;
 	}
 
+rearm:
 	/*
 	 * Clear outstanding notification bit to allow new IRQ notifications,
 	 * do this last to maximize the window of interrupt coalescing.
@@ -471,6 +481,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 	 */
 	handle_pending_pir(pid->pir, regs);
 
+common_end:
+	posted_msi_moderation_epilogue();
+
 	apic_eoi();
 	irq_exit();
 	set_irq_regs(old_regs);
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
index 72be9e88c3890..2d01e4cd4638b 100644
--- a/kernel/irq/irq_moderation.c
+++ b/kernel/irq/irq_moderation.c
@@ -11,6 +11,13 @@
 #include "internals.h"
 #include "irq_moderation.h"
 
+#ifdef CONFIG_X86
+#include <asm/apic.h>
+#include <asm/irq_remapping.h>
+#else
+static inline bool posted_msi_supported(void) { return false; }
+#endif
+
 /*
  * Platform-wide software interrupt moderation.
  *
@@ -32,6 +39,10 @@
  *   moderation on that CPU/irq. If so, calls disable_irq_nosync() and starts
  *   an hrtimer with appropriate delay.
  *
+ * - Intel only: using "intremap=posted_msi", all the above is done in
+ *   sysvec_posted_msi_notification(). In this case all host device interrupts
+ *   are subject to moderation.
+ *
  * - the timer callback calls enable_irq() for all disabled interrupts on that
  *   CPU. That in turn will generate interrupts if there are pending events.
  *
@@ -230,6 +241,17 @@ static enum hrtimer_restart timer_cb(struct hrtimer *timer)
 
 	ms->rounds_left--;
 
+#ifdef CONFIG_X86_POSTED_MSI
+	if (ms->kick_posted_msi) {
+		if (ms->rounds_left == 0)
+			ms->kick_posted_msi = false;
+		/* Next call will be from timer, count it conditionally. */
+		ms->dont_count = !irq_mod_info.count_timer_calls;
+		ms->timer_calls++;
+		apic->send_IPI_self(POSTED_MSI_NOTIFICATION_VECTOR);
+	}
+#endif
+
 	if (ms->rounds_left > 0) {
 		/* Timer still alive, just call the handlers. */
 		list_for_each_entry_safe(desc, next, &ms->descs, mod.ms_node) {
@@ -332,7 +354,7 @@ static int moderation_show(struct seq_file *p, void *v)
 	}
 
 	seq_printf(p, "\n"
-		   "enabled              %s\n"
+		   "enabled              %s%s\n"
 		   "delay_us             %u\n"
 		   "timer_rounds         %u\n"
 		   "target_irq_rate      %u\n"
@@ -344,6 +366,7 @@ static int moderation_show(struct seq_file *p, void *v)
 		   "decay_factor         %u\n"
 		   "grow_factor          %u\n",
 		   str_yes_no(delay_us > 0),
+		   posted_msi_supported() ? " (also on posted_msi)" : "",
 		   delay_us, irq_mod_info.timer_rounds,
 		   irq_mod_info.target_irq_rate, irq_mod_info.hardirq_percent,
 		   irq_mod_info.update_ms, irq_mod_info.scale_cpus,
@@ -389,6 +412,7 @@ static struct param_names param_names[] = {
 	{},
 	{ "scale_cpus", &irq_mod_info.scale_cpus, 50, 1000 },
 	{ "count_timer_calls", &irq_mod_info.count_timer_calls, 0, 1 },
+	{ "count_msi_calls", &irq_mod_info.count_msi_calls, 0, 1 },
 	{ "decay_factor", &irq_mod_info.decay_factor, 8, 64 },
 	{ "grow_factor", &irq_mod_info.grow_factor, 8, 64 },
 };
@@ -476,6 +500,18 @@ static ssize_t mode_write(struct file *f, const char __user *buf, size_t count,
 	ret = kstrtobool(cmd, &enable);
 	if (!ret)
 		ret = set_moderation_mode(desc, enable);
+	if (ret) {
+		/* extra helpers for prodkernel */
+		if (cmd[count - 1] == '\n')
+			cmd[count - 1] = '\0';
+		ret = 0;
+		if (!strcmp(cmd, "managed"))
+			irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
+		else if (!strcmp(cmd, "unmanaged"))
+			irqd_clear(&desc->irq_data, IRQD_AFFINITY_MANAGED);
+		else
+			ret = -EINVAL;
+	}
 	return ret ? : count;
 }
 
diff --git a/kernel/irq/irq_moderation.h b/kernel/irq/irq_moderation.h
index 3543e8e8b6e2d..69bbbb7b2ec80 100644
--- a/kernel/irq/irq_moderation.h
+++ b/kernel/irq/irq_moderation.h
@@ -145,7 +145,8 @@ static inline void irq_moderation_adjust_delay(struct irq_mod_state *ms)
 {
 	u64 now, delta_time;
 
-	ms->irq_count++;
+	/* dont_count can only be set in timer calls from posted_msi */
+	ms->irq_count += !ms->dont_count;
 	/* ktime_get_ns() is expensive, don't do too often */
 	if (ms->irq_count & 0xf)
 		return;
@@ -196,6 +197,15 @@ static inline void irq_moderation_hook(struct irq_desc *desc)
 	if (!static_branch_unlikely(&irq_moderation_enabled_key))
 		return;
 
+#ifdef CONFIG_X86_POSTED_MSI
+	if (ms->in_posted_msi) {
+		/* these calls are not moderated */
+		ms->from_posted_msi++;
+		ms->irq_count += irq_mod_info.count_msi_calls;
+		return;
+	}
+#endif
+
 	if (!READ_ONCE(desc->mod.enable))
 		return;
 
@@ -243,6 +253,61 @@ static inline void irq_moderation_epilogue(const struct irq_desc *desc)
 		irq_moderation_start_timer(ms);
 }
 
+#ifdef CONFIG_X86_POSTED_MSI
+/*
+ * Helpers for to sysvec_posted_msi_notification(), use as follows
+ *
+ *	if (posted_msi_moderation_enabled()) {
+ *		if (posted_msi_should_rearm(handle_pending_pir(pid->pir, regs)))
+ *			goto rearm;
+ *		else
+ *			goto common_end;
+ *	}
+ *	...
+ *  common_end:
+ *	posted_msi_moderation_epilogue();
+ */
+static inline bool posted_msi_moderation_enabled(void)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	if (!static_branch_unlikely(&irq_moderation_enabled_key))
+		return false;
+	irq_moderation_adjust_delay(ms);
+	/* Tell handlers to not throttle next calls. */
+	ms->in_posted_msi = true;
+	return true;
+}
+
+/* Decide whether or not to rearm posted_msi. */
+static inline bool posted_msi_should_rearm(bool work_done)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	/* No rearm if there is a timer pending. */
+	if (ms->rounds_left > 0)
+		return false;
+	/* No work done, can rearm. */
+	if (!work_done)
+		return true;
+	if (!irq_moderation_needed(ms))
+		return true;
+	/* Start the timer, inform the handler, and do not rearm. */
+	ms->kick_posted_msi = true;
+	irq_moderation_start_timer(ms);
+	return false;
+}
+
+/* Cleanup state set in posted_msi_moderation_enabled() */
+static inline void posted_msi_moderation_epilogue(void)
+{
+	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
+
+	ms->in_posted_msi = false;
+	ms->dont_count = false;
+}
+#endif
+
 void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode);
 void irq_moderation_procfs_remove(struct irq_desc *desc);
 
@@ -251,6 +316,12 @@ void irq_moderation_procfs_remove(struct irq_desc *desc);
 static inline void irq_moderation_hook(struct irq_desc *desc) {}
 static inline void irq_moderation_epilogue(const struct irq_desc *desc) {}
 
+#ifdef CONFIG_X86_POSTED_MSI
+static inline bool posted_msi_moderation_enabled(void) { return false; }
+static inline bool posted_msi_should_rearm(bool work_done) { return false; }
+static inline void posted_msi_moderation_epilogue(void) {}
+#endif
+
 static inline void irq_moderation_procfs_add(struct irq_desc *desc, umode_t umode) {}
 static inline void irq_moderation_procfs_remove(struct irq_desc *desc) {}
 
-- 
2.52.0.rc1.455.g30608eb744-goog


