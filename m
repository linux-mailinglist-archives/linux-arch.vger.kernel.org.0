Return-Path: <linux-arch+bounces-14807-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36401C61AB1
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 19:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17A5135A34B
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 18:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7C6311942;
	Sun, 16 Nov 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8XkE27n"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC3310784
	for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317750; cv=none; b=l3wvYd/Z+aw0eKv5aaN7X+py0UVNSHaimT1Eqs0au6JFslYeAqD/ftn8BH3kqYkDriN0bj276FrlGdStXYY+6dA6KOtO0r508wnL4mzo7SP+NmbvkMhYU9QvAZoI7TTirZV4ufOeQ5GkCgs5jAfZ4eTyL9FlFO0//Ftffe6KdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317750; c=relaxed/simple;
	bh=E6M5AxnC9JjydbvzVv2hQNyNAWu9ZWFLWuOxU/6vY/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c6na6t7d7RsWoi/12t6ITM8bHTEfbAhxdno5TTZF0PJjiMJHhYwqbkIdyWrhIhCsPpCzKSKg7gi+lym3HUOssVe5YpJ9YQ1lugJ54bZkRyiImkHDrgmsSAS8yZ4X6cJ9wsP+k1DFW+B6XTf5T4Os5PWvvP+SR3UQryLKu2bj8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8XkE27n; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b739f418149so14507466b.1
        for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 10:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763317747; x=1763922547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=buYRm9QBjC0d1zsJkJx24A/GdARTgy2dtx57bpPid6A=;
        b=B8XkE27nf6+jPlDkj7NxksVKAGfjRIKfLf8mCsWz70vjdrEb/ZDWDae+iWI8d/3lSK
         Eza+GUaADNBum3+oAL72aV/F7ObSi1HL+XXBj7c8t+KVsVGUg7g/J8bD4ghOoeFj5pYX
         KmPgLHZaCtr5Rl8GnWT8+Ybqn7P9dvrH34N347SjM6hbE83WeUa8m3MLdkoqqOQQHi4o
         TbzYlrBYJYDHC9PgMLM7i19LfbjOEDIGOOkFeENfJhtvtu3Ma/HF8QOvr+YZUmQ8fcv/
         oRYBOyclf7VRVRTOz2A4IfXbgyuhDnOdG4Mwu93h/l8XIfpTe/SuxlXSthjgt6no22Pe
         R54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763317747; x=1763922547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buYRm9QBjC0d1zsJkJx24A/GdARTgy2dtx57bpPid6A=;
        b=MXprw/Sa5trVmqghcTRZ/TNBLdxlZk4GJmg7lnSPY0br/W/NsZrqDtnAtDEE/8wATj
         NVNYip+jZLH5Wr6cpAFkFyvpsYBELmdnNrtBtFpjEY7PCdscHT5/Ngd53y1UHJLkqUR4
         ahb/OBHQQmbDfjMZdCEJ/NHdA4RKvFeEJ527UqP87o4P1B0UroSnUMLvCoT/ZiXBkBro
         +bh8G6/uxeaCVLlpoWZmmwIVmxYN9GP19/a1AN7W1OLylDyypp1gTaHVTYTwkYqAHapR
         7zRQhkg73k6eYz5QwxBcb8+p0RX+NZzLigwqiE4EHMInPIHWpscoU/cCuqbtR1U3UDTc
         KQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtwhmmDu/+RX+vqmlEfPSBqd/TgeGrvWSTutJBorQJiIBm7gUd/FNfi8mBB7aazrlyWU1OyjSRzDL1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/200BTD73oyZ4hsP1Uqx7d1JC5DpLbnKLEo3xXBLHfArSqYnv
	tij6T5pIHZMcxJnThPqhtWRLYxKFdY7nVyVQu4HtkNGsaymG5pEATt1J5JdyT+4DomQXfITJX0Z
	AF1rdFQ==
X-Google-Smtp-Source: AGHT+IFKPV3amKOS04Qi+2cJE+5aypdtWzch0N/2msaSdloN3TRrmhoOzJjEORYxaMpwT9481qSMh2c2HMQ=
X-Received: from ejclk13.prod.google.com ([2002:a17:907:178d:b0:b6d:56f5:440b])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:3913:b0:b73:709b:c754
 with SMTP id a640c23a62f3a-b73709bd3dbmr666681566b.35.1763317747091; Sun, 16
 Nov 2025 10:29:07 -0800 (PST)
Date: Sun, 16 Nov 2025 18:28:35 +0000
In-Reply-To: <20251116182839.939139-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116182839.939139-5-lrizzo@google.com>
Subject: [PATCH v2 4/8] genirq: soft_moderation: implement adaptive moderation
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Add two control parameters (target_irq_rate and hardirq_percent)
to indicate the desired maximum values for these two metrics.

Every update_ms the hook in handle_irq_event() recomputes the total and
local interrupt rate and the amount of time spent in hardirq, compares
the values with the targets, and adjusts the moderation delay up or down.

The interrupt rate is computed in a scalable way by counting interrupts
per-CPU, and aggregating the value in a global variable only every
update_ms. Only CPUs that actively process interrupts are actually
accessing the shared variable, so the system scales well even on very
large servers.

EXAMPLE TESTING

Exceeding the thresholds requires suitably heavy workloads, such as
network or SSD traffic. Lower thresholds (e.g. target_irq_rate=50000,
hardirq_frac=10) can make it easier to reach those values.

  # configure maximum delay (which is also the fixed moderation delay)
  echo "delay_us=400" > /proc/irq/soft_moderation

  # enable on network interrupts (change name as appropriate)
  echo on | tee /proc/irq/*/*eth*/../soft_moderation

  # ping times should reflect the 400us
  ping -n -f -q -c 1000 ${some_nearby_host}
  # show actual per-cpu delays and statistics
  less /proc/irq/soft_moderation

  # configure adaptive bounds. The control loop will adjust values
  # based on actual load
  echo "target_irq_rate=1000000" > /proc/irq/soft_moderation
  echo "hardirq_percent=70" > /proc/irq/soft_moderation

  # ping times now should be much lower
  ping -n -f -q -c 1000 ${some_nearby_host}

  # show actual per-cpu delays and statistics
  less /proc/irq/soft_moderation

By generating high interrupt or hardirq loads, one can also test
the effectiveness of the control scheme and the sensitivity to
control parameters.

NEW PARAMETERS

target_irq_rate   0 off, 0-50000000, default 0
    The total maximum acceptable interrupt rate.

hardirq_percent   0 off,  0-100, default 0
    The maximum acceptable percentage of time spent in hardirq.

update_ms         1-100, default 5
    How often the control loop will readjust the delay.

Change-Id: Iccd762a61c4389eb15f06d4a35c5dab2821e5fd1
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 kernel/irq/irq_moderation.c | 177 +++++++++++++++++++++++++++++++++++-
 kernel/irq/irq_moderation.h |  10 +-
 2 files changed, 182 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
index 688c8e8c49392..72be9e88c3890 100644
--- a/kernel/irq/irq_moderation.c
+++ b/kernel/irq/irq_moderation.c
@@ -56,9 +56,18 @@
  *     napi_defer_hard_irqs on NICs.
  *     A small value may help control load in interrupt-challenged platforms.
  *
+ *     FIXED MODERATION mode requires target_irq_rate=0, hardirq_percent=0
+ *
+ *   target_irq_rate (default 0, suggested 1000000, 0 off, range 0..50M)
+ *     The total irq rate above which moderation kicks in.
+ *     Not particularly critical, a value in the 500K-1M range is usually ok.
+ *
+ *   hardirq_percent (default 0, suggested 70, 0 off, range 10..100)
+ *     The hardirq percentage above which moderation kicks in.
+ *     50-90 is a reasonable range.
  *
  *   update_ms (default 5, range 1...100)
- *     How often moderation delay is updated.
+ *     How often the load is measured and moderation delay updated.
  *
  * Moderation can be enabled/disabled for individual interrupts with
  *
@@ -73,6 +82,9 @@
 /* Recommended values for the control loop. */
 struct irq_mod_info irq_mod_info ____cacheline_aligned = {
 	.update_ms		= 5,
+	.scale_cpus		= 200,
+	.decay_factor		= 16,
+	.grow_factor		= 8,
 };
 
 /* Boot time value, copled to irq_mod_info.delay_us after init. */
@@ -83,6 +95,12 @@ MODULE_PARM_DESC(delay_us, "Max moderation delay us, 0 = moderation off, range 0
 module_param_named(timer_rounds, irq_mod_info.timer_rounds, uint, 0444);
 MODULE_PARM_DESC(timer_rounds, "How many timer polls once moderation triggers, range 0-20.");
 
+module_param_named(hardirq_percent, irq_mod_info.hardirq_percent, uint, 0444);
+MODULE_PARM_DESC(hardirq_percent, "Target max hardirq percentage, 0 off, range 0-100.");
+
+module_param_named(target_irq_rate, irq_mod_info.target_irq_rate, uint, 0444);
+MODULE_PARM_DESC(target_irq_rate, "Target max interrupt rate, 0 off, range 0-50000000.");
+
 module_param_named(update_ms, irq_mod_info.update_ms, uint, 0444);
 MODULE_PARM_DESC(update_ms, "Update interval in milliseconds, range 1-100");
 
@@ -96,6 +114,108 @@ static inline void smooth_avg(u32 *dst, u32 val, u32 steps)
 	*dst = ((64 - steps) * *dst + steps * val) / 64;
 }
 
+/* Measure and assess time spent in hardirq. */
+static inline bool hardirq_high(struct irq_mod_state *ms, u64 delta_time, u32 hardirq_percent)
+{
+	bool above_threshold = false;
+
+	if (IS_ENABLED(CONFIG_IRQ_TIME_ACCOUNTING)) {
+		u64 irqtime, cur = kcpustat_this_cpu->cpustat[CPUTIME_IRQ];
+
+		irqtime = cur - ms->last_irqtime;
+		ms->last_irqtime = cur;
+
+		above_threshold = irqtime * 100 > delta_time * hardirq_percent;
+		ms->hardirq_high += above_threshold;
+	}
+	return above_threshold;
+}
+
+/* Measure and assess total and per-CPU interrupt rates. */
+static inline bool irqrate_high(struct irq_mod_state *ms, u64 delta_time,
+				u32 target_rate, u32 steps)
+{
+	u64 irq_rate, my_irq_rate, tmp, delta_irqs, active_cpus;
+	bool my_rate_high, global_rate_high;
+
+	my_irq_rate = (ms->irq_count * NSEC_PER_SEC) / delta_time;
+	/* Accumulate global counter and compute global irq rate. */
+	tmp = atomic_long_add_return(ms->irq_count, &irq_mod_info.total_intrs);
+	ms->irq_count = 1;
+	delta_irqs = tmp - ms->last_total_irqs;
+	ms->last_total_irqs = tmp;
+	irq_rate = (delta_irqs * NSEC_PER_SEC) / delta_time;
+
+	/*
+	 * Count how many CPUs handled interrupts in the last interval, needed
+	 * to determine the per-CPU target (target_rate / active_cpus).
+	 * Each active CPU increments the global counter approximately every
+	 * update_ns. Scale the value by (update_ns / delta_time) to get the
+	 * correct value. Also apply rounding and make sure active_cpus > 0.
+	 */
+	tmp = atomic_long_add_return(1, &irq_mod_info.total_cpus);
+	active_cpus = tmp - ms->last_total_cpus;
+	ms->last_total_cpus = tmp;
+	active_cpus = (active_cpus * ms->update_ns + delta_time / 2) / delta_time;
+	if (active_cpus < 1)
+		active_cpus = 1;
+
+	/* Compare with global and per-CPU targets. */
+	global_rate_high = irq_rate > target_rate;
+	my_rate_high = my_irq_rate * active_cpus * irq_mod_info.scale_cpus > target_rate * 100;
+
+	/* Statistics. */
+	smooth_avg(&ms->irq_rate, irq_rate, steps);
+	smooth_avg(&ms->my_irq_rate, my_irq_rate, steps);
+	smooth_avg(&ms->scaled_cpu_count, active_cpus * 256, steps);
+	ms->my_irq_high += my_rate_high;
+	ms->irq_high += global_rate_high;
+
+	/* Moderate on this CPU only if both global and local rates are high. */
+	return global_rate_high && my_rate_high;
+}
+
+/* Adjust the moderation delay, called at most every update_ns. */
+void __irq_moderation_adjust_delay(struct irq_mod_state *ms, u64 delta_time)
+{
+	u32 hardirq_percent = READ_ONCE(irq_mod_info.hardirq_percent);
+	u32 target_rate = READ_ONCE(irq_mod_info.target_irq_rate);
+	bool below_target = true;
+	u32 steps;
+
+	if (target_rate == 0 && hardirq_percent == 0) {
+		/* Use fixed moderation delay. */
+		ms->mod_ns = ms->delay_ns;
+		ms->irq_rate = 0;
+		ms->my_irq_rate = 0;
+		ms->scaled_cpu_count = 0;
+		return;
+	}
+
+	/* Compute decay steps based on elapsed time, bound to a reasonable value. */
+	steps = delta_time > 10 * ms->update_ns ? 10 : 1 + (delta_time / ms->update_ns);
+
+	if (target_rate > 0 && irqrate_high(ms, delta_time, target_rate, steps))
+		below_target = false;
+
+	if (hardirq_percent > 0 && hardirq_high(ms, delta_time, hardirq_percent))
+		below_target = false;
+
+	/* Controller: adjust delay with exponential decay/grow. */
+	if (below_target) {
+		ms->mod_ns -= ms->mod_ns * steps / (steps + irq_mod_info.decay_factor);
+		if (ms->mod_ns < 100)
+			ms->mod_ns = 0;
+	} else {
+		/* Exponential grow does not restart if value is too small. */
+		if (ms->mod_ns < 500)
+			ms->mod_ns = 500;
+		ms->mod_ns += ms->mod_ns * steps / (steps + irq_mod_info.grow_factor);
+		if (ms->mod_ns > ms->delay_ns)
+			ms->mod_ns = ms->delay_ns;
+	}
+}
+
 /* Moderation timer handler. */
 static enum hrtimer_restart timer_cb(struct hrtimer *timer)
 {
@@ -169,8 +289,10 @@ static inline int set_moderation_mode(struct irq_desc *desc, bool enable)
 /* Print statistics */
 static int moderation_show(struct seq_file *p, void *v)
 {
+	ulong irq_rate = 0, irq_high = 0, my_irq_high = 0, hardirq_high = 0;
 	uint delay_us = irq_mod_info.delay_us;
-	int j;
+	u64 now = ktime_get_ns();
+	int j, active_cpus = 0;
 
 #define HEAD_FMT "%5s  %8s  %8s  %4s  %4s  %8s  %11s  %11s  %11s  %11s  %11s  %11s  %11s  %9s\n"
 #define BODY_FMT "%5u  %8u  %8u  %4u  %4u  %8u  %11u  %11u  %11u  %11u  %11u  %11u  %11u  %9u\n"
@@ -182,6 +304,23 @@ static int moderation_show(struct seq_file *p, void *v)
 
 	for_each_possible_cpu(j) {
 		struct irq_mod_state *ms = per_cpu_ptr(&irq_mod_state, j);
+		u64 age_ms = min((now - ms->last_ns) / NSEC_PER_MSEC, (u64)999999);
+
+		if (age_ms < 10000) {
+			/* Average irq_rate over recently active CPUs. */
+			active_cpus++;
+			irq_rate += ms->irq_rate;
+		} else {
+			ms->irq_rate = 0;
+			ms->my_irq_rate = 0;
+			ms->scaled_cpu_count = 64;
+			ms->scaled_src_count = 64;
+			ms->mod_ns = 0;
+		}
+
+		irq_high += ms->irq_high;
+		my_irq_high += ms->my_irq_high;
+		hardirq_high += ms->hardirq_high;
 
 		seq_printf(p, BODY_FMT,
 			   j, ms->irq_rate, ms->my_irq_rate,
@@ -195,9 +334,34 @@ static int moderation_show(struct seq_file *p, void *v)
 	seq_printf(p, "\n"
 		   "enabled              %s\n"
 		   "delay_us             %u\n"
-		   "timer_rounds         %u\n",
+		   "timer_rounds         %u\n"
+		   "target_irq_rate      %u\n"
+		   "hardirq_percent      %u\n"
+		   "update_ms            %u\n"
+		   "scale_cpus           %u\n"
+		   "count_timer_calls    %s\n"
+		   "count_msi_calls      %s\n"
+		   "decay_factor         %u\n"
+		   "grow_factor          %u\n",
 		   str_yes_no(delay_us > 0),
-		   delay_us, irq_mod_info.timer_rounds);
+		   delay_us, irq_mod_info.timer_rounds,
+		   irq_mod_info.target_irq_rate, irq_mod_info.hardirq_percent,
+		   irq_mod_info.update_ms, irq_mod_info.scale_cpus,
+		   str_yes_no(irq_mod_info.count_timer_calls),
+		   str_yes_no(irq_mod_info.count_msi_calls),
+		   irq_mod_info.decay_factor, irq_mod_info.grow_factor);
+
+	seq_printf(p,
+		   "irq_rate             %lu\n"
+		   "irq_high             %lu\n"
+		   "my_irq_high          %lu\n"
+		   "hardirq_percent_high %lu\n"
+		   "total_interrupts     %lu\n"
+		   "total_cpus           %lu\n",
+		   active_cpus ? irq_rate / active_cpus : 0,
+		   irq_high, my_irq_high, hardirq_high,
+		   READ_ONCE(*((ulong *)&irq_mod_info.total_intrs)),
+		   READ_ONCE(*((ulong *)&irq_mod_info.total_cpus)));
 
 	return 0;
 }
@@ -218,10 +382,15 @@ struct param_names {
 static struct param_names param_names[] = {
 	{ "delay_us", &irq_mod_info.delay_us, 0, 500 },
 	{ "timer_rounds", &irq_mod_info.timer_rounds, 0, 20 },
+	{ "target_irq_rate", &irq_mod_info.target_irq_rate, 0, 50000000 },
+	{ "hardirq_percent", &irq_mod_info.hardirq_percent, 0, 100 },
 	{ "update_ms", &irq_mod_info.update_ms, 1, 100 },
 	/* Empty entry indicates the following are not settable from procfs. */
 	{},
+	{ "scale_cpus", &irq_mod_info.scale_cpus, 50, 1000 },
 	{ "count_timer_calls", &irq_mod_info.count_timer_calls, 0, 1 },
+	{ "decay_factor", &irq_mod_info.decay_factor, 8, 64 },
+	{ "grow_factor", &irq_mod_info.grow_factor, 8, 64 },
 };
 
 static void update_enable_key(void)
diff --git a/kernel/irq/irq_moderation.h b/kernel/irq/irq_moderation.h
index d9bc672ffd6f1..3543e8e8b6e2d 100644
--- a/kernel/irq/irq_moderation.h
+++ b/kernel/irq/irq_moderation.h
@@ -138,6 +138,8 @@ DECLARE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
 
 extern struct static_key_false irq_moderation_enabled_key;
 
+void __irq_moderation_adjust_delay(struct irq_mod_state *ms, u64 delta_time);
+
 /* Called on each interrupt for adaptive moderation delay adjustment. */
 static inline void irq_moderation_adjust_delay(struct irq_mod_state *ms)
 {
@@ -157,7 +159,13 @@ static inline void irq_moderation_adjust_delay(struct irq_mod_state *ms)
 	ms->update_ns = READ_ONCE(irq_mod_info.update_ms) * NSEC_PER_MSEC;
 	ms->delay_ns = READ_ONCE(irq_mod_info.delay_us) * NSEC_PER_USEC;
 
-	ms->mod_ns = ms->delay_ns;
+	/* If config changed, restart from the highest delay. */
+	if (ktime_compare(irq_mod_info.procfs_write_ns, ms->last_ns) > 0)
+		ms->mod_ns = ms->delay_ns;
+
+	ms->last_ns = now;
+	/* Do the expensive processing */
+	__irq_moderation_adjust_delay(ms, delta_time);
 }
 
 /* Return true if timer is active or delay is large enough to require moderation */
-- 
2.52.0.rc1.455.g30608eb744-goog


