Return-Path: <linux-arch+bounces-15802-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA9D258E7
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 17:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B2D5300C36A
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5A53A0E9B;
	Thu, 15 Jan 2026 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SAU8KHrX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7723ACA62
	for <linux-arch@vger.kernel.org>; Thu, 15 Jan 2026 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492789; cv=none; b=cUblwTuVPb1LpesjPqBHGgfKMZP0F0LA1xeHk3xjxDqsV44IfP0mLABFJgmE+JjtPcP68h1iYligRJEaHvFSks0oP27+Rn1r2m2QhnxjZlKcU0mhSkIexLQKnM+ORYaNzZhHvfSdMF/TMohZ9DZjGJ0wWOQUk555VDQp35f2rIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492789; c=relaxed/simple;
	bh=MySSqFXdh27Jhv9YxGPLb6HM3EfP+c6lUr2OoQQpZyg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sRMItPdQYgfRNq3AN9mJ0WXnuawrh6lTj0fgCbDyBkl04GsYjOKXO1uRPs2gd04XMB/nN0cJVZth021tFJK3CsZmnAw61n3I4U/XZDU6wKcdQFMU/k+pPOZ8S+ZmkxoiF7A6u7e3zil9WrWJDEw54eEmtybm76YhAYfU5ds/7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SAU8KHrX; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b871403f69eso161623366b.2
        for <linux-arch@vger.kernel.org>; Thu, 15 Jan 2026 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768492786; x=1769097586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xKA8uBixCnuXT4RDzr3ztc4JDRb2Op3qzpX/zr1IjZQ=;
        b=SAU8KHrXzHvESeTxewwS1aPWpLfLl35GRRBoI2KU/eE+4+EZcSmWtuxhxFHVVVS0Zg
         s2ogK4mbR3XYjFihM7jA/zp5CQC/M5gGK7T/Zl5g3oavIrPU2kHCIiqusizmvs/El5sq
         1i3os2z4Du1ptEtIk+Fn8pZ2ba9ZPCxmbj+gawbfJEY/pMSYl2lpeQyzVspAstmVoQ70
         pB50N4i40VImLAkZlgLVAOi7/XsFYDBPwruYMIdOx6YF4zj41WSc/N08Re1WBs28fyh8
         njpNXZbN5z9u8hCRc6jjCyZ7FdJr30Etp+BG3tmCyluelLi/RVTE+zlE1AfUfuyNlwma
         S47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768492786; x=1769097586;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKA8uBixCnuXT4RDzr3ztc4JDRb2Op3qzpX/zr1IjZQ=;
        b=b17hJd59HFC/TebuAVj6aoP+lS9IYAhVGINaAfm2wIXT3btzwxAH3S/3Ygf9+n5gIL
         jFYh/Ndv4dkqv5AmMOJmY04/atqRnVMV98ZGHPjai9pzUdxEyJVqobG0zb0cA6fTPDxZ
         gB1VduV3CB5WHcgsFsNquU7WrNWT+OHB3oPXp8Fe3r1AkA/5OTRArDIFuYoFHPt4Y3He
         ay/dIOuM8CAbR7jeNyWg5IYsCOklEZjenZ6yOhMwrPZflKtCtGb4cB/yWUmnd+q/RPPU
         sY8Xa+3JfOmYLw6z/v4Y3GXhFI0Sp5A4+2Wd+r5B6TlNN6mKPiGpc85xNtpc1agNQFsu
         6YcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU7f8DuJUL+f167gNLOMpsNi4aPEZKKKA8TTOFmId6hkO+jBmfYv8zCv1cJpi3vPp+qJb8Eo2FtoxP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1iM1lOCUS/pFw+2VXsoI+0Y1mYEmGR1VxpHJs6OEqlmgVIZ1p
	TdpIzwGg1GomEJHiNnKL0EMkMmNyd9FIWItny+LHj3Cb8dcFtJvph+xxOsDoANKial0aunVFi0E
	j+8LMIA==
X-Received: from ejds8.prod.google.com ([2002:a17:906:1688:b0:b87:2428:c785])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:80c:b0:b80:3447:e0c0
 with SMTP id a640c23a62f3a-b87932b8d3amr4447066b.62.1768492786413; Thu, 15
 Jan 2026 07:59:46 -0800 (PST)
Date: Thu, 15 Jan 2026 15:59:39 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115155942.482137-1-lrizzo@google.com>
Subject: [PATCH-v4 0/3] Global Software Interrupt Moderation (GSIM)
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

In all cases, with adaptive moderatrion, latency up to p95 is unaffected
at low/moderate load, even if compared with no moderation at all.

Changes in v4:
- added irqdesc and irqdata flags as suggested by maintainer
- parameters are only configured via independent procfs entries.
  No module parameters anymore.
- merged control and interrupt functions back into a single header/C files
- applied various annotations (lockdep, data_race())
- formatting and various renaming as suggested by maintainer.
- added performance measurements with adaptive moderation.
- removed the mechanism to conditionally enable moderation at interrupt
  creation. This can be done in userspace and suitable udev extensions
  will be handled separately.

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
  genirq: Add flags for software interrupt moderation.
  genirq: Fixed-delay Global Software Interrupt Moderation (GSIM)
  genirq: Adaptive Global Software Interrupt Moderation (GSIM).

 include/linux/irq.h         |   6 +-
 include/linux/irqdesc.h     |  12 +
 kernel/irq/Kconfig          |  11 +
 kernel/irq/Makefile         |   1 +
 kernel/irq/chip.c           |  15 +
 kernel/irq/internals.h      |  10 +
 kernel/irq/irq_moderation.c | 693 ++++++++++++++++++++++++++++++++++++
 kernel/irq/irq_moderation.h | 161 +++++++++
 kernel/irq/irqdesc.c        |   1 +
 kernel/irq/proc.c           |   2 +
 kernel/irq/settings.h       |   7 +
 11 files changed, 918 insertions(+), 1 deletion(-)
 create mode 100644 kernel/irq/irq_moderation.c
 create mode 100644 kernel/irq/irq_moderation.h

-- 
2.52.0.457.g6b5491de43-goog


