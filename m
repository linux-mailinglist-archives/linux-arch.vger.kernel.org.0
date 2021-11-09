Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0962444A5A3
	for <lists+linux-arch@lfdr.de>; Tue,  9 Nov 2021 05:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhKIEOO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Nov 2021 23:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbhKIEON (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Nov 2021 23:14:13 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68963C061764;
        Mon,  8 Nov 2021 20:11:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id q17so6478331plr.11;
        Mon, 08 Nov 2021 20:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWf+4vpjI63IfEWJIwFv/TcCQdIY6ThOZqM9mQL4Tqw=;
        b=btRaMQ2euXTUxldbQKN5q2eVaVQvSdjaaWV6GHN8vp+MyYyBjYjokLcFHTrw3xzDPf
         RcF87ShSFj4X4XEjcM7qWXpCosb1TI36LHureb+2KE9PfTWJgRZJYw+o+0Rwc3fp7O+i
         NxFzhqXjAmXphsjhkzCv7zWKvkXp3JCa9MqqBeXDsZ3vih7xkYxkJJl5zx6Fygir42r3
         mo2Ht5le7PHxW90Re76WocWyBmYCfbjjGN0/kuiaV9pon1bmmYC6jPgPQ0/7JcmgnCdz
         d+Lq/qdUAkS7j5alOj7wvnTyRgVjfUPbZ5P238EM82PVKl8sg3AJEDXRGa4GoErAtEMV
         zQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWf+4vpjI63IfEWJIwFv/TcCQdIY6ThOZqM9mQL4Tqw=;
        b=q3Brg6oQBsACTQyIoy2BzrAN10MSHdH8qWkLxlCnixn95p4n30O+CSHjz50qWeLQDx
         0ujhK9mPf4K1s0SIuCah1rwSgkmIL5UB6+xjZ0z3WD1ClGQMd8nDGQ9tuaVDTtvXWFNV
         TQ7WOIr9qGtxL1sk2c4KuyDwfjOpKnJgJ7aMCcnf/+uQuZk8J7Rjj7MY/OVLnAQrG0v+
         WXQzEmsMunoXU7dG6+0HvqtwZNN+hgdtYMHZQG52ahwfi1hlrQlJNUlXJiodQGnGOg/X
         8k3S/dYBVDrSvPUg+lgiXrwAok0QF28kjGlqi+KSzVIBFnvATTa7QzHNkugtAsFCePTg
         a45w==
X-Gm-Message-State: AOAM530qtXKDTyuooH5eM0lUJ1mp0GM3A4dxCby1G/HeoyEiE3PTlRVd
        xFsVYJo5Gv7YZtgzNN02I+Rg3/siNlg=
X-Google-Smtp-Source: ABdhPJw7KmJE+JgNaACYg61LiuSpQutSiLoP+i59GyP/VmW6RGfabTNzDl7BLHP+jIuxyLD+CAjYiA==
X-Received: by 2002:a17:90a:aa0e:: with SMTP id k14mr3984913pjq.88.1636431087956;
        Mon, 08 Nov 2021 20:11:27 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-241-46-56.tpgi.com.au. [60.241.46.56])
        by smtp.gmail.com with ESMTPSA id o19sm18278063pfu.56.2021.11.08.20.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 20:11:27 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 0/4] shoot lazy tlbs
Date:   Tue,  9 Nov 2021 14:11:15 +1000
Message-Id: <20211109041119.1972927-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since v4, this fixes a kthread_use_mm refcounting bug and adds some
comments in code and changelogs around the kthread_use_mm change in
patch 1 (due to akpm's comment -- thanks).

It also adds and improves comments in code, changelogs, and Kconfig
options. The overall design is unchanged though. Please merge.

This series has suffered some issues getting agreement, so I would
like to address a few sticking points or misconceptions up front,
which hopefully can result in constructive disagreement and actual
actionable feedback.

* That the lazy mm scheme is complicated or bug prone.

  This is not true, the concept is trivial and core code is extremely
  simple and basically unchanged since Linus' active_mm email 20 years
  ago in 2.3 days.

  This series leaves the lazy tlb switching and ->active_mm semantics
  entirely unchanged. It does change the refcounting, but the effects
  are hidden under wrappers. It does not add anything new for code
  outside those few places to think about except that they must specify
  _lazy_mm when refcounting this particular type of reference. This
  is not much of a problem since lazy mm references never "escape"
  from specific switching sequences and become hard to track. Refs
  that go into the wider world are always normal ones (i.e., created
  by explicit mmgrab or kthread_use_mm).

* That membarrier code is complicated

  This is true. My series changes exactly nothing to do with
  membarriers. My series is entirely about lazy mm, which has been
  virtually unchanged for many years before membarrier.
  membarrier code takes advantage of memory ordering in scheduler
  switch code that lazy mm refcounting was providing, so this series
  adds one commented smp_mb() ifdef there to replace the refcount op
  being removed. That does not affect the ability to change membarrier
  code in future because the refcounted path has to be accounted for
  here anyway.

  In other words, any changes to membarrier code which deal with the
  refcounted lazy mm path that exists today, then dealing with the non
  refcounted option is trivial.

* That active_mm should be removed from core code.

  I don't know how to address this other than it's not a good or well
  thought out idea. This is not happening and is certainly not related
  to my series which does not change ->active_mm semantics at all.

* That this series provides an option for archs to enable which result
  in stale ->active_mm pointers, whereby it is up to the arch to
  ensure nothing dereferences those pointers.

  This is FUD. It has always been false. Archs that enable
  MMU_LAZY_TLB_SHOOTDOWN never ever have stale ->active_mm pointers,
  ever. If active_mm is non-NULL, then that gives exactly the same
  guarantees as you have today.

* That performance of IPIs or other things is a problem.

  I posted actual numbers showing this was not a concern, and listed
  some options that could reduce them further if needed. No numbers
  were ever posted to support the other side of the argument.

* That the series is a powerpc specific thing.

  Untrue. I have trivial sparc and alpha conversions as the first two
  things I looked at which I have SMP qemu environments for.

* That this series somehow prevents future changes or improvements.

  It doesn't.

* That the series is very complex, code is bad or has problems.

  Look at the patches. They seem pretty small and simple to me. I am
  happy to address specific issues that are pointed out though, and
  have done so.

* That x86 is relevant here.

  This patch does not touch or affect x86 in any way. x86 has gone off
  and done its own horrendously complicated and under-documented thing
  with active_mm and the lazy mm concept. But that has been entirely
  hidden from core code by the arch context switching hooks. Core code
  continues to operate on the concept of ->mm and ->active_mm, and this
  series does not change that at all. x86 is no more or less divorced
  from that after the series.

  Nothing the series does constrains x86 or changes to it in future. The
  option can not be used immediately by x86, but there is no reason x86
  could not be adapted to use it, or change their scheme to something
  else entirely. Where code can be adapted to be shared or made usable by
  x86, I have no problem with doing that.

If I've missed something or I've got anything wrong with the above,
I'm happy to hear it.

Thanks,
Nick

Nicholas Piggin (4):
  lazy tlb: introduce lazy mm refcount helper functions
  lazy tlb: allow lazy tlb mm refcounting to be configurable
  lazy tlb: shoot lazies, a non-refcounting lazy tlb option
  powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN

 Documentation/vm/active_mm.rst       |  6 ++++
 arch/Kconfig                         | 32 +++++++++++++++++
 arch/arm/mach-rpc/ecard.c            |  2 +-
 arch/powerpc/Kconfig                 |  1 +
 arch/powerpc/kernel/smp.c            |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c |  4 +--
 fs/exec.c                            |  2 +-
 include/linux/sched/mm.h             | 20 +++++++++++
 kernel/cpu.c                         |  2 +-
 kernel/exit.c                        |  2 +-
 kernel/fork.c                        | 51 ++++++++++++++++++++++++++++
 kernel/kthread.c                     | 21 +++++++-----
 kernel/sched/core.c                  | 35 +++++++++++++------
 kernel/sched/sched.h                 |  4 ++-
 14 files changed, 158 insertions(+), 26 deletions(-)

-- 
2.23.0

