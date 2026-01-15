Return-Path: <linux-arch+bounces-15805-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34028D25901
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 17:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D0103068761
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077FC3B8BC5;
	Thu, 15 Jan 2026 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4CDog9w"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD73B8BD3
	for <linux-arch@vger.kernel.org>; Thu, 15 Jan 2026 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492799; cv=none; b=gxjzIFpqwpL6mm/eytpUun4WtPiXPqZ0Cp6z6p7fteC27iWQacEB3fn8/seWneAwNH3RHBQqlpV2BlIDCHFd3YL0aG7UaRSLtGdyBaINp0JABAGdD3FvxVF80Z3m+PV6gugzoN5CorMt+ju3tZ32rmthLNsC1agwT3/er5vWVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492799; c=relaxed/simple;
	bh=jRm43U2AsnIO7xFmqZjHsWNWqyQ/L0IQkKZkoftjZj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mYOKKphtCZwIxH8YXu+jZ9KmbTP2nbCKZ/tFwXRGFsOZLciihgton9U/ym+LfNUN0cC1y5ltj68N9Bk9irhc39rQieZEGfzDtfcMCdiPCC1oXtlym3vof1a3cQ0yOtYyRKSjB1Dplp3DqfZgJLPhOhhuCRzDGjKoS72GGWbI2kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O4CDog9w; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-38305d006feso4505961fa.2
        for <linux-arch@vger.kernel.org>; Thu, 15 Jan 2026 07:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768492795; x=1769097595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZdLyvXEcNm2F3Dn8JAz82gdODXREWzN4kLA1i0te6Y=;
        b=O4CDog9wWNfBArp5Vjw+LFv+f24i84vyj01SdarAB0nFNABQ4tHzF1B3v/QBj5p2Up
         YK6M+SNbamIWipR+wIa9WfDmrucRzImZgmnofG4iGya8G5iAWaCidfLc7d8Irfqd6kph
         ItYo27ONZ/osQTGe5v8i14SxWBcF769uFQl5RJtVLhvcajUt+WDeu+CErMqrGr5oiMJf
         O5KAVwQssB2vSOI51zTaaPE4Ns0law6KAyiu8FJWPckCFykIZz9xDlJAOleZTfHMSZma
         3IBbHz0G3AnqdkpXWfUcRZcGpRh91sI3+jBXygOM2azI+PNi7e/Tkla4HP11yDmnAhvL
         9E0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768492795; x=1769097595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZdLyvXEcNm2F3Dn8JAz82gdODXREWzN4kLA1i0te6Y=;
        b=BJgnYaGgT9UUiJmefvvWonhLdUUhUo9k2fn5XjlDi2+Eqjle45o1QwfBugDtL900Om
         6fjCMvOZlnbQ+3kRj9OREyOboEtKjAUXNN5WlEC0fUOePN5QJR83N93hStUGaOffyioS
         qOeQ6o/haJTftL0gQ8oRBXDeNptgCNneH8/PiLWS4R3YMIpFXJQ9lFiBSWNLP72C3uKo
         SU8ypGS7KoRdvJf+8qqTo339lI6vLmoNfojq7uNa9ACZ6x8lUvbaM+cqiprsEM7DVkkw
         FhFymdpGUyV3F/e+JY86oWWpBYM+1mkp+FUr46MOcnNbhgaj4mVdZQ9I3DKdwg77Dbvj
         Lz8w==
X-Forwarded-Encrypted: i=1; AJvYcCUDVBtPGLHlTya7iesQcpMGRK0vYt3Hhbx+N8EnjGHaUqwE9okESCIfipdfAEZpw8HfUhgd8yCCxHqj@vger.kernel.org
X-Gm-Message-State: AOJu0YwF9EH2CoqIrSV593gbwxIFhUcy5BlSkANWxAIrOtjAna6P34d8
	4ZmqEfzxQZgClx0yYMGNE710iKTfUJFwJb5G0iKGVa2adBh9g37UawqMgH1Be5TXQH3W4FKcKPh
	lAgKgwQ==
X-Received: from ljhp21.prod.google.com ([2002:a2e:93d5:0:b0:37f:8d02:4f39])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a2e:a9a8:0:b0:37b:9b58:dd04
 with SMTP id 38308e7fff4ca-3838417575bmr764271fa.7.1768492794621; Thu, 15 Jan
 2026 07:59:54 -0800 (PST)
Date: Thu, 15 Jan 2026 15:59:42 +0000
In-Reply-To: <20260115155942.482137-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115155942.482137-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115155942.482137-4-lrizzo@google.com>
Subject: [PATCH v4 3/3] genirq: Adaptive Global Software Interrupt Moderation (GSIM).
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Interrupt moderation helps keeping system load (as defined later) under
control, but the use of a fixed moderation delay imposes unnecessary
latency when the system load is already low.

We focus on two types of system load related to interrupts:
- total device interrupt rates. Some platforms show severe I/O
  performance degradation with more than 1-2 Mintr/s across the entire
  system. This affects especially server-class hardware with hundreds of
  interrupt sources (NIC or SSD queues from many physical or virtualized
  devices).
- percentage of time spent in hardirq. This can become problematic in
  presence of large numbers of interrupt sources hitting individual CPUs
  (for instance, as a result of attempts to isolate application CPUs
  from interrupt load).

Make GSIM adaptive by measuring total and per-CPU interrupt rates, as
well as time spent in hardirq on each CPU. The metrics are compared to
configurable targets, and each CPU adjusts the moderation delay up
or down depending on the result, using multiplicative increase/decrease.

Configuration of moderation parameters is done via procfs

  echo ${VALUE} > /proc/irq/soft_moderation/${NAME}

Parameters are:

  delay_us (0 off, range 0-500)
      Maximum moderation delay in microseconds.

  target_intr_rate (0 off, range 0-50000000)
      Total rate above which moderation should trigger.

  hardirq_percent (0 off,range 0-100)
      Percentage of time spent in hardirq above which moderation should
      trigger.

  update_ms (range 1-100, default 5)
      How often the metrics should be computed and moderation delay
      updated.

When target_intr_rate and hardirq_percent are both 0, GSIM uses delay_us
as fixed moderation delay. Otherwise, the delay is dynamically adjusted
up or down, independently on each CPU, based on how the total and per-CPU
metrics compare with the targets.

Provided that delay_us suffices to bring the metrics within the target,
the control loop will dynamically converge to the minimum actual
moderation delay to stay within the target.

PERFORMANCE BENEFITS:

The tests below demonstrate how adaptive moderation allows improved
throughput at high load (same as fixed moderation) and low latency ad
moderate load (same as no moderation) without having to hand-tune the
system based on load.

We run experiments on one x86 platform with 8 SSD (64 queues) capable of
an aggregate of approximately 14M IOPS running fio with variable number
of SSD devices (1 or 8), threads per disk (1 or 200), and IODEPTH (from
1 to 128 per thread) the actual command is below:

${FIO} --name=read_IOPs_test ${DEVICES} --iodepth=${IODEPTH} --numjobs=${JOBS} \
    --bs=4K --rw=randread  --filesize=1000G --ioengine=libaio --direct=1 \
    --verify=0 --randrepeat=0 --time_based=1 --runtime=600s \
    --cpus-allowed=1-119 --cpus_allowed_policy=split --group_reporting=1

For each configuration we test three moderations settings:
- OFF:      delay_us=0
- FIXED:    delay_us=200 target_intr_rate=0 hardirq_percent=0
- ADAPTIVE: delay_us=200 target_intr_rate=1000000 hardirq_percent=70

The first set of measurements is for ONE DISK, ONE THREAD.
At low IODEPTH the throughput is latency bound, and moderation is not
necessary. A fixed moderation delay dominates the latency hence reducing
throughput; adaptive moderation avoids the problem.
As the IODEPTH increases, the system becomes I/O bound, and even the
fixed moderation delay does not harm.

Overall: adaptive moderation is better than fixed moderation and
at least as good as moderation off.

COMPLETION LATENCY PERCENTILES in us (p50, p90, p99)

         ------ OFF --------   ------ FIXED ------   ----- ADAPTIVE ----
IODEPTH  IOPS  p50  p90  p99   IOPS  p50  p90  p99   IOPS  p50  p90  p99
         -------------------   -------------------   -------------------
1:        12K   78   88   94 .   5K  208  210  215 .  12K   78   88   96
8:        94K   83   91  110 .  38K  210  212  221 .  94K   83   91  105
32:      423K   72   85  124 . 150K  210  219  235 . 424K   72   85  124
128:     698K  180  200  243 . 513K  251  306  347 . 718K  174  194  239

A second set of measurements is with one disk and 200 threads.
The system is I/O bound but without significant interrupt overhead.
All three scenarios are basically equivalent.

         --------- OFF --------   ------- FIXED -------   ------ ADAPTIVE -----
IODEPTH  IOPS    p50  p90   p99   IOPS    p50  p90  p99   IOPS    p50  p90  p99
         ----------------------   ---------------------   ---------------------
1:       1581K   110  174   281 .  933K   208  223  363 . 1556K   114  176  277
8:       1768K   889 1516  1926 . 1768K   848 1516 2147 . 1768K   889 1516 1942
32:      1768K  3589 5735  7701 . 1768K  3589 5735 7635 . 1768K  3589 5735 7504
128:     1768K  14ms 24ms  31ms . 1768K  14ms 24ms 29ms . 1768K  14ms 24ms 30ms

Finally, we have one set of measurements with 8 disks and 200 threads
per disk, all running on socket 0.  The system would be I/O bound (and
CPU/latency bound at low IODEPTH), but this platform is unable to cope with the
high global interrupt rate and so moderation is really necessary to hit
the disk limits.

As we see below, adaptive moderation gives more than 2X higher
throughput at meaningful iodepths, and even latency is much better.
The only case where we see a small regression is with iodepth=1, because
the high interrupt rate triggers the control loop to increase the
moderation delay.

         --------- OFF --------   -------- FIXED -------   ------ ADAPTIVE ------
IODEPTH  IOPS    p50  p90   p99   IOPS     p50  p90  p99   IOPS     p50  p90  p99
         ----------------------   ----------------------   ----------------------
1:       2304K    82   94   128 .  1030K   208  277  293 .  1842K    97  149  188
8:       5240K   128  938  1680 .  7500K   208  233  343 . 10000K   151  210  281
32:      5251K   206 3621  3949 . 12300K   184 1106 5407 . 12100K   184 1139 5407
128:     5330K  4228 12ms  17ms . 13800K  1123 4883 7373 . 13800K  1074 4883 7635

Finally, here are experiments indicating how throughput is affected by
the various parameters (with 8 disks and 200 threads).

IOPS vs delay_us (target_intr_rate = 0, hardirq_percent=0)

delay_us	0	50	100	150	200	250
IODEPTH 1	2300	1860	1580	1300	1034	1066
IODEPTH 8	5254	9936	9645	8818	7500	6150
IODEPTH 32	5250	11300	13800	13800	13800	13800
IODEPTH 128	5900	13600	13900	13900	13900	13900

IOPS vs target_intr_rate (delay_us = 200, hardirq_percent=0, iodepth 128)
value		250K	500K	750K	1000K	1250K	1500K	1750K	2000K
socket0		13900	13900	13900	13800	13800	12900	11000	8808
both sockets	13900	13900	13900	13800	8600	8000	6900	6400

hardirq_percent (delay_us = 200, target_intr_rate=0, iodepth 128)
hardirq%	1	10	20	30	40	50	60	70
KIOPS		13900	13800	13300	12100	10400	8600	7400	6500

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 kernel/irq/irq_moderation.c | 271 ++++++++++++++++++++++++++++++++++--
 kernel/irq/irq_moderation.h |  58 +++++++-
 2 files changed, 314 insertions(+), 15 deletions(-)

diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
index 07d1e740addcd..8221cb8d9fc79 100644
--- a/kernel/irq/irq_moderation.c
+++ b/kernel/irq/irq_moderation.c
@@ -18,8 +18,9 @@
  *
  * Some platforms show reduced I/O performance when the total device interrupt
  * rate across the entire platform becomes too high. To address the problem,
- * GSIM uses a hook after running the handler to implement software interrupt
- * moderation with programmable delay.
+ * GSIM uses a hook after running the handler to measure global and per-CPU
+ * interrupt rates, compare them with configurable targets, and implements
+ * independent, per-CPU software moderation delays.
  *
  * Configuration is done at runtime via procfs
  *   echo ${VALUE} > /proc/irq/soft_moderation/${NAME}
@@ -30,6 +31,26 @@
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
+ *   scale_cpus (default 150, range 50-1000)
+ *       Small update_ms may lead to underestimate the number of CPUs
+ *       simultaneously handling interrupts, and the opposite can happen
+ *       with very large values. This parameter may help correct the value,
+ *       though it is not recommended to modify the default unless there are
+ *       very strong reasons.
+ *
  * Moderation can be enabled/disabled dynamically for individual interrupts with
  *   echo 1 > /proc/irq/NN/soft_moderation # use 0 to disable
  *
@@ -93,6 +114,8 @@
 /* Recommended values. */
 struct irq_mod_info irq_mod_info ____cacheline_aligned = {
 	.update_ms		= 5,
+	.increase_factor	= MIN_SCALING_FACTOR,
+	.scale_cpus		= 150,
 };
 
 DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
@@ -107,6 +130,171 @@ static void update_enable_key(void)
 		static_branch_disable(&irq_moderation_enabled_key);
 }
 
+/* Functions called in handle_*_irq(). */
+
+/*
+ * Compute smoothed average between old and cur. 'steps' is used
+ * to approximate applying the smoothing multiple times.
+ */
+static inline u32 smooth_avg(u32 old, u32 cur, u32 steps)
+{
+	const u32 smooth_factor = 64;
+
+	steps = min(steps, smooth_factor - 1);
+	return ((smooth_factor - steps) * old + steps * cur) / smooth_factor;
+}
+
+/* Measure and assess time spent in hardirq. */
+static inline bool hardirq_high(struct irq_mod_state *m, u32 hardirq_percent)
+{
+	bool above_threshold;
+	u64 irqtime, cur;
+
+	if (!IS_ENABLED(CONFIG_IRQ_TIME_ACCOUNTING))
+		return false;
+
+	cur = kcpustat_this_cpu->cpustat[CPUTIME_IRQ];
+	irqtime = cur - m->last_irqtime;
+	m->last_irqtime = cur;
+
+	above_threshold = irqtime * 100 > (u64)m->epoch_ns * hardirq_percent;
+	m->hardirq_high += above_threshold;
+	return above_threshold;
+}
+
+/* Measure and assess total and per-CPU interrupt rates. */
+static inline bool irqrate_high(struct irq_mod_state *m, u32 target_rate, u32 steps)
+{
+	u32 global_intr_rate, local_intr_rate, delta_intrs, active_cpus, tmp;
+	bool local_rate_high, global_rate_high;
+
+	local_intr_rate = ((u64)m->intr_count * NSEC_PER_SEC) / m->epoch_ns;
+
+	/* Accumulate global counter and compute global interrupt rate. */
+	tmp = atomic_add_return(m->intr_count, &irq_mod_info.total_intrs);
+	m->intr_count = 1;
+	delta_intrs = tmp - m->last_total_intrs;
+	m->last_total_intrs = tmp;
+	global_intr_rate = ((u64)delta_intrs * NSEC_PER_SEC) / m->epoch_ns;
+
+	/*
+	 * Count how many CPUs handled interrupts in the last epoch, needed
+	 * to determine the per-CPU target (target_rate / active_cpus).
+	 * Each active CPU increments the global counter approximately every
+	 * update_ns. Scale the value by (update_ns / m->epoch_ns) to get the
+	 * correct value. Also apply rounding and make sure active_cpus > 0.
+	 */
+	tmp = atomic_add_return(1, &irq_mod_info.total_cpus);
+	active_cpus = tmp - m->last_total_cpus;
+	m->last_total_cpus = tmp;
+	active_cpus = (active_cpus * m->update_ns + m->epoch_ns / 2) / m->epoch_ns;
+	if (active_cpus < 1)
+		active_cpus = 1;
+
+	/* Compare with global and per-CPU targets. */
+	global_rate_high = global_intr_rate > target_rate;
+
+	/*
+	 * Short epochs may lead to underestimate the number of active CPUs.
+	 * Apply a scaling factor to compensate. This may make the controller
+	 * a bit more aggressive but does not harm system throughput.
+	 */
+	local_rate_high = local_intr_rate * active_cpus * irq_mod_info.scale_cpus > target_rate * 100;
+
+	/* Statistics. */
+	m->global_intr_rate = smooth_avg(m->global_intr_rate, global_intr_rate, steps);
+	m->local_intr_rate = smooth_avg(m->local_intr_rate, local_intr_rate, steps);
+	m->scaled_cpu_count = smooth_avg(m->scaled_cpu_count, active_cpus * 256, steps);
+	m->local_irq_high += local_rate_high;
+	m->global_irq_high += global_rate_high;
+
+	/* Moderate on this CPU only if both global and local rates are high. */
+	return global_rate_high && local_rate_high;
+}
+
+/* Periodic adjustment, called once per epoch. */
+void irq_moderation_update_epoch(struct irq_mod_state *m)
+{
+	const u32 hardirq_percent = READ_ONCE(irq_mod_info.hardirq_percent);
+	const u32 target_rate = READ_ONCE(irq_mod_info.target_intr_rate);
+	const u32 min_delay_ns = 500;
+	bool above_target = false;
+	u32 steps;
+
+	/*
+	 * If any of the configuration parameter changes, read the main ones
+	 * (delay_ns, update_ns), and set the adaptive delay, mod_ns, to the
+	 * maximum value to help converge.
+	 * Without that, the system might be already below target_intr_rate
+	 * because of saturation on the bus (the very problem GSIM is trying
+	 * to address) and that would block the control loop.
+	 * Setting mod_ns to the highest value (if chosen properly) can reduce
+	 * the interrupt rate below target_intr_rate and let the controller
+	 * gradually reach the target.
+	 */
+	if (raw_read_seqcount(&irq_mod_info.seq.seqcount) != m->seq) {
+		do {
+			m->seq = read_seqbegin(&irq_mod_info.seq);
+			m->update_ns = READ_ONCE(irq_mod_info.update_ms) * NSEC_PER_MSEC;
+			m->mod_ns = READ_ONCE(irq_mod_info.delay_us) * NSEC_PER_USEC;
+			m->delay_ns = m->mod_ns;
+		} while (read_seqretry(&irq_mod_info.seq, m->seq));
+	}
+
+	if (target_rate == 0 && hardirq_percent == 0) {
+		/* Use fixed moderation delay. */
+		m->mod_ns = m->delay_ns;
+		m->global_intr_rate = 0;
+		m->local_intr_rate = 0;
+		m->scaled_cpu_count = 0;
+		return;
+	}
+
+	/*
+	 * To scale values X by a factor (1 +/- 1/F) every "update_ns" we do
+	 *	X := X * (1 +/- 1/F)
+	 * If the interval is N times longer, applying the formula N times gives
+	 *	X := X * ((1 +/- 1/F) ** N)
+	 * We don't want to deal floating point or exponentials, and we cap N
+	 * to some small value < F . This leads to an approximated formula
+	 *	X := X * (1 +/- N/F)
+	 * The variable steps below is the number N of steps.
+	 */
+	steps = clamp(m->epoch_ns / m->update_ns, 1u, MIN_SCALING_FACTOR - 1u);
+
+	if (target_rate > 0 && irqrate_high(m, target_rate, steps))
+		above_target = true;
+
+	if (hardirq_percent > 0 && hardirq_high(m, hardirq_percent))
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
+		if (m->mod_ns < min_delay_ns)
+			m->mod_ns = min_delay_ns;
+		m->mod_ns += m->mod_ns * steps / increase_factor;
+		if (m->mod_ns > m->delay_ns)
+			m->mod_ns = m->delay_ns;
+	} else {
+		const u32 decrease_factor = 2 * READ_ONCE(irq_mod_info.increase_factor);
+
+		m->mod_ns -= m->mod_ns * steps / decrease_factor;
+		/* Round down to 0 values that are too small to bother. */
+		if (m->mod_ns < min_delay_ns)
+			m->mod_ns = 0;
+	}
+}
+
 /* Actually start moderation. */
 bool irq_moderation_do_start(struct irq_desc *desc, struct irq_mod_state *m)
 {
@@ -142,6 +330,8 @@ bool irq_moderation_do_start(struct irq_desc *desc, struct irq_mod_state *m)
 	return true;
 }
 
+/* Control functions. */
+
 /* Initialize moderation state, used in desc_set_defaults() */
 void irq_moderation_init_fields(struct irq_desc_mod *mod_state)
 {
@@ -189,7 +379,9 @@ static int swmod_wr_u32(struct swmod_param *n, const char __user *s, size_t coun
 	int ret = kstrtouint_from_user(s, count, 0, &res);
 
 	if (!ret) {
+		write_seqlock(&irq_mod_info.seq);
 		WRITE_ONCE(*(u32 *)(n->val), clamp(res, n->min, n->max));
+		write_sequnlock(&irq_mod_info.seq);
 		ret = count;
 	}
 	return ret;
@@ -211,34 +403,82 @@ static int swmod_wr_delay(struct swmod_param *n, const char __user *s, size_t co
 	return ret;
 }
 
-#define HEAD_FMT "%5s  %8s  %11s  %11s  %9s\n"
-#define BODY_FMT "%5u  %8u  %11u  %11u  %9u\n"
+#define HEAD_FMT "%5s  %8s  %10s  %4s  %8s  %11s  %11s  %11s  %11s  %11s  %9s\n"
+#define BODY_FMT "%5u  %8u  %10u  %4u  %8u  %11u  %11u  %11u  %11u  %11u  %9u\n"
 
 #pragma clang diagnostic error "-Wformat"
 
 /* Print statistics */
 static void rd_stats(struct seq_file *p)
 {
+	ulong global_intr_rate = 0, global_irq_high = 0;
+	ulong local_irq_high = 0, hardirq_high = 0;
 	uint delay_us = irq_mod_info.delay_us;
-	int cpu;
+	u64 now = ktime_get_ns();
+	int cpu, active_cpus = 0;
 
 	seq_printf(p, HEAD_FMT,
-		   "# CPU", "delay_ns", "timer_set", "enqueue", "stray_irq");
+		   "# CPU", "irq/s", "loc_irq/s", "cpus", "delay_ns",
+		   "irq_hi", "loc_irq_hi", "hardirq_hi", "timer_set",
+		   "enqueue", "stray_irq");
 
 	for_each_possible_cpu(cpu) {
-		struct irq_mod_state cur;
+		struct irq_mod_state cur, *m = per_cpu_ptr(&irq_mod_state, cpu);
+		u64 epoch_start_ns;
+		bool recent;
+
+		/* Accumulate and print only recent samples */
+		epoch_start_ns = atomic64_read(&m->epoch_start_ns);
+		recent = (now - epoch_start_ns) < 10 * NSEC_PER_SEC;
 
 		/* Copy statistics, will only use some 32bit values, races ok. */
 		data_race(cur = *per_cpu_ptr(&irq_mod_state, cpu));
+		if (recent) {
+			active_cpus++;
+			global_intr_rate += cur.global_intr_rate;
+		}
+
+		global_irq_high += cur.global_irq_high;
+		local_irq_high += cur.local_irq_high;
+		hardirq_high += cur.hardirq_high;
+
 		seq_printf(p, BODY_FMT,
-			   cpu, cur.mod_ns, cur.timer_set, cur.enqueue, cur.stray_irq);
+			   cpu,
+			   recent * cur.global_intr_rate,
+			   recent * cur.local_intr_rate,
+			   recent * (cur.scaled_cpu_count + 128) / 256,
+			   recent * cur.mod_ns,
+			   cur.global_irq_high,
+			   cur.local_irq_high,
+			   cur.hardirq_high,
+			   cur.timer_set,
+			   cur.enqueue,
+			   cur.stray_irq);
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
+		   active_cpus ? global_intr_rate / active_cpus : 0,
+		   global_irq_high, local_irq_high, hardirq_high,
+		   READ_ONCE(*((u32 *)&irq_mod_info.total_intrs)),
+		   READ_ONCE(*((u32 *)&irq_mod_info.total_cpus)));
 }
 
 static int moderation_show(struct seq_file *p, void *v)
@@ -258,6 +498,11 @@ static int moderation_open(struct inode *inode, struct file *file)
 
 static struct swmod_param param_names[] = {
 	{ "delay_us", swmod_wr_delay, swmod_rd_u32, &irq_mod_info.delay_us, 0, 500 },
+	{ "target_intr_rate", swmod_wr_u32, swmod_rd_u32, &irq_mod_info.target_intr_rate, 0, 50000000 },
+	{ "hardirq_percent", swmod_wr_u32, swmod_rd_u32, &irq_mod_info.hardirq_percent, 0, 100 },
+	{ "update_ms", swmod_wr_u32, swmod_rd_u32, &irq_mod_info.update_ms, 1, 100 },
+	{ "increase_factor", swmod_wr_u32, NULL, &irq_mod_info.increase_factor, MIN_SCALING_FACTOR, 128 },
+	{ "scale_cpus", swmod_wr_u32, swmod_rd_u32, &irq_mod_info.scale_cpus, 50, 1000 },
 	{ "stats", NULL, rd_stats},
 };
 
@@ -427,6 +672,7 @@ static int __init init_irq_moderation(void)
 	/* Clamp all initial values to the allowed range. */
 	for (uint *cur = &irq_mod_info.delay_us; cur < irq_mod_info.params_end; cur++)
 		clamp_parameter(cur, *cur);
+	seqlock_init(&irq_mod_info.seq);
 
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "irq_moderation", cpu_setup_cb, cpu_remove_cb);
 	register_pm_notifier(&mod_nb);
@@ -436,8 +682,11 @@ static int __init init_irq_moderation(void)
 	dir = proc_mkdir("irq/soft_moderation", NULL);
 	if (!dir)
 		return 0;
-	for (i = 0, n = param_names; i < ARRAY_SIZE(param_names); i++, n++)
+	for (i = 0, n = param_names; i < ARRAY_SIZE(param_names); i++, n++) {
+		if (!n->rd)
+			continue;
 		proc_create_data(n->name, n->wr ? 0644 : 0444, dir, &proc_ops, n);
+	}
 	return 0;
 }
 
diff --git a/kernel/irq/irq_moderation.h b/kernel/irq/irq_moderation.h
index 0d634f8e9225d..3a92306d1aee9 100644
--- a/kernel/irq/irq_moderation.h
+++ b/kernel/irq/irq_moderation.h
@@ -13,12 +13,32 @@
 
 /**
  * struct irq_mod_info - global configuration parameters and state
+ * @total_intrs:	running count of total interrupts
+ * @total_cpus:		running count of total active CPUs
+ *			totals are updated every update_ms ("epoch")
+ * @seq:		protects updates to parameters
  * @delay_us:		maximum delay
- * @update_ms:		how often to update delay (epoch duration)
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
+	seqlock_t	seq;
 	u32		delay_us;
+	u32		target_intr_rate;
+	u32		hardirq_percent;
 	u32		update_ms;
+	u32		increase_factor;
+	u32		scale_cpus;
 	u32		params_end[];
 };
 
@@ -43,8 +63,22 @@ extern struct irq_mod_info irq_mod_info;
  * @descs:		list of	moderated irq_desc on this CPU
  * @enqueue:		how many enqueue on the list
  *
+ * Used once per epoch:
+ * @seq:		latest seq from irq_mod_info
+ * @delay_ns:		fetched from irq_mod_info
+ * @epoch_ns:		duration of last epoch
+ * @last_total_intrs:	from irq_mod_info
+ * @last_total_cpus:	from irq_mod_info
+ * @last_irqtime:	from cpustat[CPUTIME_IRQ]
+ *
  * Statistics
+ * @global_intr_rate:	smoothed global interrupt rate
+ * @local_intr_rate:	smoothed interrupt rate for this CPU
  * @timer_set:		how many timer_set calls
+ * @scaled_cpu_count:	smoothed CPU count (scaled)
+ * @global_irq_high:	how many times global irq rate was above threshold
+ * @local_irq_high:	how many times local irq rate was above threshold
+ * @hardirq_high:	how many times local hardirq_percent was above threshold
  */
 struct irq_mod_state {
 	struct hrtimer		timer;
@@ -57,14 +91,29 @@ struct irq_mod_state {
 	u32			stray_irq;
 	struct list_head	descs;
 	u32			enqueue;
+	u32			seq;
+	u32			delay_ns;
+	u32			epoch_ns;
+	u32			last_total_intrs;
+	u32			last_total_cpus;
+	u64			last_irqtime;
+	u32			global_intr_rate;
+	u32			local_intr_rate;
 	u32			timer_set;
+	u32			scaled_cpu_count;
+	u32			global_irq_high;
+	u32			local_irq_high;
+	u32			hardirq_high;
 };
 
 DECLARE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
 
+#define MIN_SCALING_FACTOR 8u
+
 extern struct static_key_false irq_moderation_enabled_key;
 
 bool irq_moderation_do_start(struct irq_desc *desc, struct irq_mod_state *m);
+void irq_moderation_update_epoch(struct irq_mod_state *m);
 
 static inline void check_epoch(struct irq_mod_state *m)
 {
@@ -74,9 +123,10 @@ static inline void check_epoch(struct irq_mod_state *m)
 	/* Run approximately every update_ns, a little bit early is ok. */
 	if (epoch_ns < m->update_ns - slack_ns)
 		return;
-	/* Fetch updated parameters. */
-	m->update_ns = READ_ONCE(irq_mod_info.update_ms) * NSEC_PER_MSEC;
-	m->mod_ns = READ_ONCE(irq_mod_info.delay_us) * NSEC_PER_USEC;
+	m->epoch_ns = min(epoch_ns, (u64)U32_MAX);
+	atomic64_set(&m->epoch_start_ns, now);
+	/* Do the expensive processing */
+	irq_moderation_update_epoch(m);
 }
 
 /*
-- 
2.52.0.457.g6b5491de43-goog


