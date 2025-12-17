Return-Path: <linux-arch+bounces-15483-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E268DCC7557
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 12:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C558B303EB94
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097C12E9ED8;
	Wed, 17 Dec 2025 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="01m/zrrB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDDE30BF4E
	for <linux-arch@vger.kernel.org>; Wed, 17 Dec 2025 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970501; cv=none; b=qRowu6Ljauou5p0q7mdc8ep/nxI0HNkWewEQYVt6H+kM3LiEBifswjBJ5L3cBhVilVBirRVWVXfmB9PgICBDFeJ6FEGdMODXLt0OcWW95y0cisWY9VaaUSdVbANHshpQvRPa4uEJeThikeJ6wpoODWb7pB38bLXvle1wYX3p6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970501; c=relaxed/simple;
	bh=s4YjybFP9Xj3uoLW60mHUMPlzFMN8/tC2aXfwhiwTc4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XozAUU8glzPE9SoJESYTLglTb5i8ocAIW0Z57+5evGAWO6GN/Yn6+/gAYqQJo5aebiUHsURbv87ESQKpLqR8SRrcpyf+GLLM7Z7/6NKPZ0B2V6LTxA2H/Qee3uq44XIEohqJh2TDez4amlEkS3GDadTtJrOFWOEEYEN4KhCg/nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=01m/zrrB; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-64b40c8df90so883757a12.1
        for <linux-arch@vger.kernel.org>; Wed, 17 Dec 2025 03:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765970498; x=1766575298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ac17T8EqLXvXToh3COlAyPaJsSQUWcS3OiJ1C0xLIYc=;
        b=01m/zrrBISThpzIJbNfALcjTLWMFJ48/q6Yi813ViJ3eEAWnck8Tzpe+yv2HVx2Q3N
         te7ptDVcCIa2mV/arrgHEv8LAVrDzr7ZnnHEGEldN5BW29WdHtW8v/ZX8aVgOcRoEshS
         RptvYqwq2siDK6Z0UomL7eTGITKjG8eAoN7EJrpnf3TUi6ghLCowtUs7+Wld4K1JNwwa
         sHnPsYXHGQrLQSYLLKpsisVPEpgiPBIivGvyB484h1DfqhNX9DwOul6Srxdj6PQS+YCJ
         eo7jbZmfc8rLC9ElbL1pIA231N4MTU9B3UIhpj7h9O0BKzWHN+CE3tV0AJgsu46cpk+4
         +shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970498; x=1766575298;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ac17T8EqLXvXToh3COlAyPaJsSQUWcS3OiJ1C0xLIYc=;
        b=PRBkDPtFgzBm+CtC6kF4TkvrQxhYOq3CJx8W8bUPtNqpl3gjFi2tMGsAPLKQoF3xxF
         7HA9NDZLaokXfjXj47yLK98j6fSspShrihjsKP8WqKLRMdi3ruJ7O5bUKCmLFIjAiY/V
         PGuYVXBvpoqr6xTptvcvPKXKfQwMpVM2fk1ZXSXXfO4HPIu9SUp+AVgOMVDeg+FVJl2l
         SZ1osdNKepYydGexqULYQdoaZaUm+aeWxY3iS68tSoTYb788B3sx5T98aAKoxQbIDtyD
         2o+HNY+x+otUBFJeDgv5FrrgyA/R2xO7Qz5ebVFL3NBSrcpljpjnP6Wa05hUfE4wERVp
         anjg==
X-Forwarded-Encrypted: i=1; AJvYcCVqoR/wa2foKrqYJSrJcewLqbM+UBV7uC/jprWHXelvhneTqetgURIlL2VtI4MXri/vz92DSLJbDc8n@vger.kernel.org
X-Gm-Message-State: AOJu0Yytn0DeuhBRcpaSNWJM0VrOUt7FbCZ9LLnCfNOUbuJPhOZYp/ud
	bX2FyYmZiyPc9cfubQ34mdtpEFYava0Fp/5DWMkZCH6vjU1S4fCwfUM/x+xPaIsBxj5l/mL1BCP
	kBPQ7yA==
X-Google-Smtp-Source: AGHT+IHDCclkkG8PMu1yT8HsTKvMfimkjHZol8s755J0PAGFl60kS8B57uOYU5bSsgVB8nCJ9HYD2kgbcA0=
X-Received: from edqx13.prod.google.com ([2002:aa7:d38d:0:b0:649:1567:4ef5])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:a245:20b0:641:6872:8857
 with SMTP id 4fb4d7f45d1cf-6499b33ec5fmr13762906a12.34.1765970498308; Wed, 17
 Dec 2025 03:21:38 -0800 (PST)
Date: Wed, 17 Dec 2025 11:21:25 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.305.g3fc767764a-goog
Message-ID: <20251217112128.1401896-1-lrizzo@google.com>
Subject: [PATCH-v3 0/3] Global Software Interrupt Moderation (GSIM)
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Global Software Interrupt Moderation (GSIM) specifically addresses a
limitation of platforms, from many vendors, whose I/O performance drops
significantly when the total rate of MSI-X interrupts is too high (e.g
1-3M intr/s depending on the platform).

Conventional interrupt moderation, typically implemented in hardware
by NICs or storage devices, operates separately on each source (e.g. a
completion queue). Large servers can have hundreds of sources, and without
knowledge of global activity, keeping the total rate bounded would require
moderation delays of 100-200us, and adaptive moderation would have to
reach those delays with as little as 10K intr/s per source. These values
are unacceptable for RPC or transactional workloads.

To address this problem, GSIM measures efficiently the total and
per-CPU interrupt rates, so that individual moderation delays can be
dynamically adjusted based on actual global and local load. This way,
delays are normally 0 or very small except during actual
local/global overload.

As an additional benefit, GSIM also monitors the percentage of time
spent by each CPU in hardirq, and can use moderation to reserve some
time for other, lower priority, tasks.

Configuration is easy and robust. System administrators specify the
maximum targets (moderation delay; interrupt rate; and percentage of time
spent in hardirq), and which interrupt sources should be moderated (can be
done per-interrupt, per device, or globally). Independent per-CPU control
loops adjust actual delays to try and keep metrics within the targets.

The system is adaptive, and moderation does not affect throughput but
only latency and only in high load scenarios. Hence, targets don't need
to match precisely the platform limits, and one can make conservative
and robust choices. Values like delay_us=100, target_irq_rate=1000000,
hardirq_percent=70 are a very good starting point.

GSIM does not rely on any special hardware feature.

Defaults are set at boot via module parameters

    irq_moderation.${NAME}=${VALUE}

and can be changed runtime with

    echo ${NAME}=${VALUE} /proc/irq/soft_moderation

/proc/irq/soft_moderation is also used to export statistics.

Moderation on individual interrupts can be turned on/off at runtime with

    echo 1 > /proc/irq/NN/moderation  # use 0 to disable

PERFORMANCE BENEFITS:
Below are some experimental results under high load comparing conventional
moderation with GSIM:

- 100Gbps NIC, 32 queues: rx goes from 50 Gbps to 92.8 Gbps (line rate).
- 200Gbps NIC, 10 VMs (total 160 queues): rx goes from 30 Gbps to 190 Gbps (line rate).
- 12 SSD, 96 queues: 4K random read goes from 6M to 20.5M IOPS (device max).

In all cases, latency up to p95 is unaffected at low/moderate load,
even if compared with no moderation at all.

Changes in v3:
- clearly documented architecture in kernel/irq/irq_moderation.c
  including how to handle enable/disable/mask, interrupt migration,
  hotplug and suspend.
- split implementation in 4 files irq_moderation.[ch] and
  irq_moderation_hook.[ch] for better separation of control plane and
  "dataplane" (functions ran on each interrupt)
- limited scope to handle_edge_irq() and handle_fasteoi_irq() which
  have been tested on actual hardware.
- tested on Intel (also with intremap=posted_msi), AMD, ARM, with NIC,
  nvme, vfio

Changes in v2:
- many style fixes (mostly on comments) based on reviewers' comments on v1
- removed background from Documentation/core-api/irq/irq-moderation.rst
- split procfs handlers
- moved internal details to kernel/irq/irq_moderation.h
- use cpu hotplug for per-CPU setup, removed unnecessary arch-specific changes
- select suitable irqs based on !irqd_is_level_type(irqd) && irqd_is_single_target(irqd)
- use a static_key to enable/disable the feature

There are two open comments from v1 for which I would like maintainer's
clarifications

- handle_irq_event() calls irq_moderation_hook() after releasing the lock,
  so it can call disable_irq_nosync(). It may be possible to move the
  call before releasing the lock and use __disable_irq(). I am not sure
  if there is any benefit in making the change.

- the timer callback calls handle_irq_event_percpu(desc) on moderated
  irqdesc (which have irqd_irq_disabled(irqd) == 1) without changing
  IRQD_IRQ_INPROGRESS. I am not sure if this should be protected with
  the following, and especially where it would make a difference
  (specifically because that the desc is disabled during this sequence).

     raw_spin_lock(&desc->lock);
     irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
     raw_spin_unlock(&desc->lock)

     handle_irq_event_percpu(desc); // <--

     raw_spin_lock(&desc->lock);
     irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
     raw_spin_unlock(&desc->lock)


Luigi Rizzo (3):
  genirq: Fixed Global Software Interrupt Moderation (GSIM)
  genirq: Adaptive Global Software Interrupt Moderation (GSIM)
  genirq: Configurable default mode for GSIM

 include/linux/irqdesc.h          |  28 ++
 kernel/irq/Kconfig               |  12 +
 kernel/irq/Makefile              |   1 +
 kernel/irq/chip.c                |  16 +-
 kernel/irq/irq_moderation.c      | 613 +++++++++++++++++++++++++++++++
 kernel/irq/irq_moderation.h      | 135 +++++++
 kernel/irq/irq_moderation_hook.c | 157 ++++++++
 kernel/irq/irq_moderation_hook.h | 102 +++++
 kernel/irq/irqdesc.c             |   1 +
 kernel/irq/manage.c              |   4 +
 kernel/irq/proc.c                |   3 +
 11 files changed, 1071 insertions(+), 1 deletion(-)
 create mode 100644 kernel/irq/irq_moderation.c
 create mode 100644 kernel/irq/irq_moderation.h
 create mode 100644 kernel/irq/irq_moderation_hook.c
 create mode 100644 kernel/irq/irq_moderation_hook.h

-- 
2.52.0.305.g3fc767764a-goog


