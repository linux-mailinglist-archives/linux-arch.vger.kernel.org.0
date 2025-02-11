Return-Path: <linux-arch+bounces-10109-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 917B3A30C5E
	for <lists+linux-arch@lfdr.de>; Tue, 11 Feb 2025 14:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11DE188996E
	for <lists+linux-arch@lfdr.de>; Tue, 11 Feb 2025 13:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2D021E08B;
	Tue, 11 Feb 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkgLzWy5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532D1F428D
	for <linux-arch@vger.kernel.org>; Tue, 11 Feb 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739278837; cv=none; b=VMDxDXUQrArbUzjCm3FVq3oJpwkdnFsk8KL2vM2xbTO1Q4WBjV5sb+HKAF8xSscvK3IIo2K6LXQywuRwZ4ZcLC8Nd5tC9yA4g/o0ROyhullMTy3b93ZlfdzYpAn6EBGm+4vgGb2HB7ieEZEdOGub2VXjDILACiIjEl0Lq/uYdNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739278837; c=relaxed/simple;
	bh=/aMiQ3ZNfwhbBf5f1lgUUnJouB+XgZQzCmgT7j7ornw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uZMESKTHPJ+MqdWQYb0Cok56OsrblPz6asiS6ktmyOzCCZVVz/zj6THimCJZvGLB+LlGpXlVyZyyO3eTDFoMhCHUfky6D7tantvy38uFEdoZ0jvVstHBc+ON/RYRiJMM8WxX6fDl27GdhLbmDTSDxBRP3hB6kGgHfJmysbbVdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkgLzWy5; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so7146955e9.0
        for <linux-arch@vger.kernel.org>; Tue, 11 Feb 2025 05:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739278834; x=1739883634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W7gYg59+sDZQNRnefhKDnqvbzcvbYlsLc2LHTucHdDo=;
        b=KkgLzWy5VzzY6XvtG/G1kNjhK5KLd5g7nXrTzuylpuTTtvaH6uj7yTlGK26aMECEQX
         Rps8HrNWj6NSKBahtnv/uOSMMstiAESmSBXFRWXdw0K9f5VGIhTnMdkfdm08fLIvBBNV
         Pba6x8PWviEB/KWJWhhtM6XodICeqPjlLmSVU9SSgm5y74wD0OP4BaCtCkiUGhJAuS2u
         3DC0IGUmXAGKib0kMGaC2kOCU4KaBAQR7zbumR6igUoXGL4fWpvB/j/Yp1aT0wr0l38+
         SBwaTQ83msb+Dy/JeKGyIARkLw06V66epiSui6DK1/O2ogukF8SfSHXF4rloXIGp4dfI
         gRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739278834; x=1739883634;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7gYg59+sDZQNRnefhKDnqvbzcvbYlsLc2LHTucHdDo=;
        b=ecVQzKB0MNgnpO+m2zYPbsh2sT5PazLn2Ao9/MI+/eyCtmItlnrPBh8NwB5XLWnCVr
         RV/+ZzpLV9R9mIgulBm+bR+r8yo9L+u3udLfXGkG/srQre5m0ntiMp8HJdXd+4JPrcwf
         I37Wyg+L2r3emDYBNTjFrRPG5Mm4I0raToDgw2ezJPHjgCNj9wW66vW7jQ6Vxbas7ncY
         l4Yz9tRrvVZDjyPvMcZFOGLKgfJKE9kSSYnJRj2bKFjWkURzYmOBCg3lbWXel4thYI5t
         U5gz81JRrzOPIYNsY8sbtnilqABIT2Lb9hN02Rz2PUYov8shXovXf3wTJQQGqLbAslw/
         Zfdg==
X-Forwarded-Encrypted: i=1; AJvYcCViwziw6gKvAKzd0/4i+nR1XcSe8vh0HcUqeVKe5ns6tQMOPqK+m4IYMwHY/AHYXtdbm649k/OM8UJl@vger.kernel.org
X-Gm-Message-State: AOJu0YxxY4kTOKMIoGUPSL9skxBmbJlavquoHhAJ0RxdGDKI9i3COOXn
	zvt2D4GnlwJDi/rf8VybYCvE8ObbopVTxDF/Kw9svZtaAx+K+EOCfdVLRqtKQLcvqcZDZ6RV0Rg
	IU4kxomc/2A==
X-Google-Smtp-Source: AGHT+IHwr3r+Gl9rsjjNjLPgMI6GwOLR7Cj0VDO2gN5+9hWA4l0IXZ1OmyM9sLdTtfqcOymt28f8pEh85VJfxw==
X-Received: from wmsp2.prod.google.com ([2002:a05:600c:1d82:b0:439:4a82:6746])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f09:b0:439:4d37:7f49 with SMTP id 5b1f17b1804b1-4394d37819emr25173465e9.28.1739278834302;
 Tue, 11 Feb 2025 05:00:34 -0800 (PST)
Date: Tue, 11 Feb 2025 13:00:23 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOdJq2cC/x3MQQqAIBBA0avErBPUEqKrRAuZJp2FGmoRRHdPW
 r7F/w8UykwF5u6BTBcXTrFB9R2gt9GR4K0ZtNRGaqVECKez1VMWmEKgWMWA1uyjmqQhhNYdmXa +/+eyvu8H7kVt+GMAAAA=
X-Change-Id: 20250211-mmugather-comment-3ca5f41805ec
X-Mailer: b4 0.15-dev
Message-ID: <20250211-mmugather-comment-v1-1-1ac1e0c765d2@google.com>
Subject: [PATCH] mm/mmu_gather: Update comment on RCU freeing
From: Brendan Jackman <jackmanb@google.com>
To: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Some recent discussion on LMKL [0] brought up some interesting and
useful additional context on RCU-freeing for pagetables.

Note down some extra info in here, in particular a) be concrete about
the reason why an arch might not have an IPI and b) add the interesting
paravirt details.

[0] https://lore.kernel.org/linux-kernel/20250206044346.3810242-2-riel@surriel.com/

---
Note the Lore link in here is referring to the base of the thread. The
mail I wanted to actually refer to is not yet on Lore as it's not
currently updating.

Here's what I have in my mailbox:

On Tue, 11 Feb 2025 at 12:07, Peter Zijlstra <peterz@infradead.org> wrote:
> > It would be nice to update the CONFIG_MMU_GATHER_RCU_TABLE_FREE
> > comment in mm/mmu_gather.c to mention INVLPG alongside "Architectures
> > that do not have this (PPC)"
>
> Why? This is just one more architecture that does broadcast.

Hmm yeah, I didn't really make the leap from "doesn't do an IPI" to
"that just means it uses broadcast TLB flush". In that light I can see
how it's "just another architecture".

I do think it would make sense to be more explicit about that, even
though it seems obvious now you point it out. But it's not really
relevant to this patchset.

> - and while that's being updated it would
> > also be useful to note down the paravirt thing you explained above,
> > IMO it's pretty helpful to have more examples of the concrete usecases
> > for this logic.
>
> Look at kvm_flush_tlb_multi() if you're interested. The notable detail
> is that is avoids flushing TLB for vCPUs that are preempted, and instead
> lets the vCPU resume code do the invalidate.

Oh that actually looks like a slightly different case from what Rik mentioned?

> some paravirt TLB flush implementations
> handle the TLB flush in the hypervisor, and will do the flush
> even when the target CPU has interrupts disabled.

Do we have

a) Systems where the flush gets completely pushed into the hypervisor
- xen_flush_tlb_multi()?

b) Systems where the guest coordinates with the hypervisor to avoid
IPI-ing preempted vCPUs?

Maybe I can send a separate patch to note this in the commentary, it's
interesting and useful to know.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/mmu_gather.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 7aa6f18c500b2d292621ec308f575ed4ddbdcd3e..db7ba4a725d6ad445eb7f35f0b34e0d4364eb693 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -246,8 +246,16 @@ static void __tlb_remove_table_free(struct mmu_table_batch *batch)
  * IRQs delays the completion of the TLB flush we can never observe an already
  * freed page.
  *
- * Architectures that do not have this (PPC) need to delay the freeing by some
- * other means, this is that means.
+ * Not all systems IPI every CPU for this purpose:
+ *
+ * - Some architectures have HW support for cross-CPU synchronisation of TLB
+ *   flushes, so there's no IPI at all.
+ *
+ * - Paravirt guests can do this TLB flushing in the hypervisor, or coordinate
+ *   with the hypervisor to defer flushing on preempted vCPUs.
+ *
+ * Such systems need to delay the freeing by some other means, this is that
+ * means.
  *
  * What we do is batch the freed directory pages (tables) and RCU free them.
  * We use the sched RCU variant, as that guarantees that IRQ/preempt disabling

---
base-commit: 266a5a879d40554630c7e485cb5576227759c7a0
change-id: 20250211-mmugather-comment-3ca5f41805ec

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


