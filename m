Return-Path: <linux-arch+bounces-14803-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E861C61A99
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 19:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20CEA359998
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 18:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED76330ACEB;
	Sun, 16 Nov 2025 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7QIvzQs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C11E1DE9
	for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317742; cv=none; b=QS1bPSdzSRxvuL4Pm+BfCsGaICNfoap/881cVbreqrd4v+/ELJ1su5wEqpq1J7stT6vpY8G3cVbAtk85PLIE1spDIqiXBJdiZs8l0a7PjGT5rl/G2wCNmRQMsUtB+ADXFusJPmajO+VBvz4dBdiOVGWFKGGY4Hq4Y5QlGGigWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317742; c=relaxed/simple;
	bh=e/NDLE4lm4XXXtJXlQ/Je8fKG2yqbtPtFZRrqBZVGwc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fYVqZAjjOezBqCh5Ghg2kLQLsYk0WSmYBtaIQ+NN+6YFuL/sUBchxeSlqsDBMG3jRADt1VQUlQCAtaTxXW5m13XmZM5proGAbFEGRczd8PLMfSdofRqPIFTb+4lAoc/Ln0PnzAebkP1Mw4d9NQnR6+KSX57d35NJL1E+xJQDjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b7QIvzQs; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-640c4609713so5470583a12.2
        for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 10:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763317739; x=1763922539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YvMXCYQqNl8eAP7ZjX3xekdoemphyR6uyVcKDD1Aa7E=;
        b=b7QIvzQsK+yEW9i2/ZtQjXcb5MoNgTldm3HoRdDnzo4Mpt4+5GSq2LjYbr4Itpo28Y
         P5G8TsQAad5BZB6BUUaiiIpEQ3rnMUvOWX9TpJlNoO7l/dcBwgI1Vy7bmiX+P6+01+oK
         hkaBkFkAWGhmoEolwTRvK3W0tJ7P8ZGFxaU48BIT3JYrWW7H9rcUP0XCoJeghviZAvSS
         9OSTXPRFZqckxo0fwCdrvv23TCrz502slrDoFio02fflaMytRy62eW+KeealtlWE4WFv
         RM0/zOUA7tXb6q9737syLF/5BcY3rLuI4pv0zFRw/oVaNCWOioQFlI/Qe/XmRH7uoBFQ
         e+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763317739; x=1763922539;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YvMXCYQqNl8eAP7ZjX3xekdoemphyR6uyVcKDD1Aa7E=;
        b=g8xLPTa07c1Xad6I1tRlPnVFKo2jukDMhn5qHScapE0n7j+V6dsEIOoJh21rwEI3aE
         UQzkJs7hWaw0rfS52j7HZg98MzQkqUwuEj+1Kh6gT/XKN9GhJgzEmhdnQoEEc2VSZFyo
         ev0lKAYeI1fETskF293jhjSFS3hhQKtQeY0kvygPEzZ0SxsWgnMxnrgNR4deO/Fxcpgn
         Amgy6SlsGbqqEqpS5xPmUR76MFtIEcpa28qyzXU1zPotqJtvSN9FtbAH0eYLa54er8aW
         fQyjKBr1wmsvIKV1jJFwmF+7b/uH4g6jYXTJ0Z8DXQZPjGa4N1k8RM2Ahhcm8m8rDFZO
         hTtw==
X-Forwarded-Encrypted: i=1; AJvYcCUp7WBubpQEf/fJcQD5t81y0edRroiWWlmzRo60v+vOqj2nQ6Tt2Yloco1qey0tQ34I7Mqls847s2ce@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJrw2nQiridOleWblxF6KpXxfAFtbPgiM2hOAaG1FAaP9HQDk
	isOfK2BQJfF/Uw/wrXXOGCrOaLROL40Yn7TnSpJrGe5jFH655Mphxyd+cRRZz0feoM14+LLHjOy
	T35Yxmg==
X-Google-Smtp-Source: AGHT+IFZxzNW1lAKiVO0/bT6yQ99fGAEmH1vKQNLme+7ph3cZ6mJqm2lGDFwMn0QaGHKPEcfXSQ9OK4+59U=
X-Received: from edt9.prod.google.com ([2002:a05:6402:4549:b0:640:b66f:1e73])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4609:b0:633:d0b7:d6d2
 with SMTP id 4fb4d7f45d1cf-64350e89a32mr8046248a12.18.1763317739372; Sun, 16
 Nov 2025 10:28:59 -0800 (PST)
Date: Sun, 16 Nov 2025 18:28:31 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116182839.939139-1-lrizzo@google.com>
Subject: [PATCH v2 0/8] platform wide software interrupt moderation
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Platform wide software interrupt moderation specifically addresses a
limitation of platforms, from many vendors, whose I/O performance drops
significantly when the total rate of MSI-X interrupts is too high (e.g
1-3M intr/s depending on the platform).

Conventional interrupt moderation operates separately on each source,
hence the configuration should target the worst case. On large servers
with hundreds of interrupt sources, keeping the total rate bounded would
require delays of 100-200us; and adaptive moderation would have to reach
those delays with as little as 10K intr/s per source. These values are
unacceptable for RPC or transactional workloads.

To address this problem, this code measures efficiently the total and
per-CPU interrupt rates, so that individual moderation delays can be
adjusted based on actual global and local load. This way, the system
controls both global interrupt rates and individual CPU load, and
tunes delays so they are normally 0 or very small except during actual
local/global overload.

Configuration is easy and robust. System administrators specify the
maximum targets (moderation delay; interrupt rate; and fraction of time
spent in hardirq), and per-CPU control loops adjust actual delays to try
and keep metrics within the bounds.

There is no need for exact targets, because the system is adaptive.
Values like delay_us=100, target_irq_rate=1000000, hardirq_percent=70
are good almost everywhere.

The system does not rely on any special hardware feature except from
devices recording pending interrupts.

Boot defaults are set via module parameters (/sys/module/irq_moderation
and /sys/module/${DRIVER}) or at runtime via /proc/irq/moderation, which
is also used to export statistics.  Moderation on individual irq can be
turned on/off via /proc/irq/NN/moderation .

PERFORMANCE BENEFITS:
Below are some experimental results under high load (before/after rates
are measured with conventional moderation or with this change):

- 100Gbps NIC, 32 queues: rx goes from 50-60Gbps to 92.8 Gbps (line rate).
- 200Gbps NIC, 10 VMs (total 160 queues): rx goes from 30 Gbps to 190 Gbps (line rate).
- 12 SSD, 96 queues: 4K random read goes from 6M to 20.5 MIOPS (device max).

In all cases, latency up to p95 is unaffected at low/moderate load,
even if compared with no moderation at all.

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


Luigi Rizzo (8):
  genirq: platform wide interrupt moderation: Documentation, Kconfig,
    irq_desc
  genirq: soft_moderation: add base files, procfs
  genirq: soft_moderation: implement fixed moderation
  genirq: soft_moderation: implement adaptive moderation
  x86/irq: soft_moderation: add support for posted_msi (intel)
  genirq: soft_moderation: helpers for per-driver defaults
  nvme-pci: add module parameter for default moderation mode
  vfio-pci: add module parameter for default moderation mode

 Documentation/core-api/irq/index.rst          |   1 +
 Documentation/core-api/irq/irq-moderation.rst | 154 +++++
 arch/x86/kernel/Makefile                      |   2 +-
 arch/x86/kernel/irq.c                         |  13 +
 drivers/nvme/host/pci.c                       |   3 +
 drivers/vfio/pci/vfio_pci_intrs.c             |   3 +
 include/linux/interrupt.h                     |  19 +
 include/linux/irqdesc.h                       |  18 +
 kernel/irq/Kconfig                            |  12 +
 kernel/irq/Makefile                           |   1 +
 kernel/irq/handle.c                           |   3 +
 kernel/irq/irq_moderation.c                   | 606 ++++++++++++++++++
 kernel/irq/irq_moderation.h                   | 330 ++++++++++
 kernel/irq/irqdesc.c                          |   1 +
 kernel/irq/proc.c                             |   3 +
 15 files changed, 1168 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/core-api/irq/irq-moderation.rst
 create mode 100644 kernel/irq/irq_moderation.c
 create mode 100644 kernel/irq/irq_moderation.h

-- 
2.52.0.rc1.455.g30608eb744-goog


