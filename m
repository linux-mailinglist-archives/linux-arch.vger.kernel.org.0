Return-Path: <linux-arch+bounces-9532-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525EF9FE418
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2024 10:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDFE161FAD
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2024 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70A01A23A8;
	Mon, 30 Dec 2024 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TsyjMRcE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D791A23A2
	for <linux-arch@vger.kernel.org>; Mon, 30 Dec 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549723; cv=none; b=dP5zd9HoYGmVVVvkAtiH9aKIbYKURfJQHdHOO6USEgdwF8FH1j0hBIBi2FX19jTMKrh33X1HoK5FOAByer9r/RtRKtbngfKw3j1G1SFehKR4smA4UfaC9ZC8dYUC/pfNlxoNVc5k5hDIQeIYq+2y4V0rOt180CDJpQERXMwYPfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549723; c=relaxed/simple;
	bh=obzuCkbthGjAmIl3Mi7AOVwJw8CRHlX3eo5rziGK7Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o26+bi1/PSI973hxTV47hKtrJF47ZQkvsE2R5gbeI9E+aQsfYtOHsiFP94U71uXzqfOBW8+iLTJkjnYc7NJhpimU54wiMLiTBvmn/hwamA6oveQDhFSFcGw3bBeF7vBQg4gvtHai21XMEu+znOep4aDaWa5pKe5U7sWJmjcvXvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TsyjMRcE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166f1e589cso140198865ad.3
        for <linux-arch@vger.kernel.org>; Mon, 30 Dec 2024 01:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549720; x=1736154520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCS148NFM6neePcbo7P2q7bn6Gnf3WOST+giN1oaVZ4=;
        b=TsyjMRcESMcOFb23epL+mnSLmxXybLJlbTkKYAFufRJtPvT2KdMra/oLmq2DhQh70p
         g02f2EPzg5ciDx3zTDMLoqvqRGjMjCv6ABbcQVXSbvxcv3dWrHpAK2TN0TwSt+hbOXwr
         XheDsYKNDC6Vx4av+V+8yYXHnS/GQ3Sx8vsYhBYeUIFCEbC/HqOU8leQWaOrEjmo61N0
         9KePyTW9H5Y0zAftYpfpyvfXJLF1N6UwzwQZQG1IJP9RbJffCJJJpRrg4NKvRdbQUem0
         cGRjBSaJSqdmVh4ocIHPhU9tgTWxWcacKtyh+MiLGOLs4pVR723gXgZcs8VIxj7tnvZn
         QBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549720; x=1736154520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCS148NFM6neePcbo7P2q7bn6Gnf3WOST+giN1oaVZ4=;
        b=ohUYHgvmzr0XnhzyGIveY5N25QxvnzexhsvyfzNAcIqATS0BwJqG/cj4gbWMwAxi6U
         6I5E5/FWWFK2/tR2IAT/VM4Yixv337xe5Px+SkWnpiR+E61D5iXOXJ7VwtCyeaLUONaz
         f8rcIpGCS8Uvgw2vh5eCZFlEGZXo7sGR9siJWJj5dvsvv1o2M/PYA3BkjNDLBVKuTql0
         Rn/ntXPwG/FozRalFiKbef217tCq4b1174ec6dZqHYXlwLsm5wmaWnvj8cC2ZUbEmhvb
         wC1vfQZeYXTS/H63aKf2AKns0JHBADQdJBiWD/T8KH1h2TWyzbzoKpc8wodfLmdo/IOO
         ik9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDXAbhcsOkolf1/2sMscSJvQwoOBE/zU4jIaACKUjcEr71K3Cn3COKMYitmLWQS+LtSLs7scbcJ/x5@vger.kernel.org
X-Gm-Message-State: AOJu0YzsR5CYRP2kBVkNOuO82YQn3PGSIWfP/xIA+/aCNO7R8hysQZN9
	xEn/KBp3AUo5AQvhwogVcuKtA5nERc4FAwKfr7w6OsS0taNVtmMPUZ5GPNutR54=
X-Gm-Gg: ASbGnct9DfvRXIxpej0LDaselBdcqBvjuR5sqi9kkXW+RW18yaWaefsxAnXJ4Vpv5P9
	WGZ47tA64uyT7q+XEqiBJc0bx5w+R8cFT/iZh8gnr06tExQLymeNPDayn56gxVh4HkGIsZqomrt
	lMwIlewpCEH0YFZVEs/AWxyHQwow72cqJ2DgwZtvOI/119Lbas4EpZ7lDrPJKP6UIKvrJ95Zhyz
	cQj86Qp9ZvFCAjEiN3yMnHFUQFBL+49vJy1LZcgQ0XUL+Y5m/NCJdM+HP9StcobYO4pxeBdjzHn
	xFpc4miYIdLao9aoxi3cpQ==
X-Google-Smtp-Source: AGHT+IHgLmMaWHwHgL0oRHIhYJ2vWpvY6ebuDt6AqrGAyIjEWzK95W7/7i/VdRxGUDUWQcC+IVrQ/g==
X-Received: by 2002:a05:6a00:e06:b0:725:9dc7:4f8b with SMTP id d2e1a72fcca58-72abde30cc7mr45836853b3a.15.1735549719834;
        Mon, 30 Dec 2024 01:08:39 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:08:39 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	palmer@dabbelt.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 00/15] move pagetable_*_dtor() to __tlb_remove_table()
Date: Mon, 30 Dec 2024 17:07:35 +0800
Message-Id: <cover.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
 - remove [PATCH v3 15/17] and [PATCH v3 16/17] (Mike Rapoport)
   (the tlb_remove_page_ptdesc() and tlb_remove_ptdesc() are intermediate
    products of the project: https://kernelnewbies.org/MatthewWilcox/Memdescs,
    so keep them)
 - collect Acked-by

Changes in v3:
 - take patch #5 and #6 from Kevin Brodsky's patch series below.
   Link: https://lore.kernel.org/lkml/20241219164425.2277022-1-kevin.brodsky@arm.com/
 - separate the statistics part from [PATCH v2 02/15] as [PATCH v3 04/17], and
   replace the rest part with Kevin Brodsky's patch #6
   (Alexander Gordeev and Kevin Brodsky)
 - change the commit message of [PATCH v2 10/15] and [PATCH v2 11/15]
   (Alexander Gordeev)
 - fix the bug introduced by [PATCH v2 11/15]
   (Peter Zijlstra)
 - rebase onto the next-20241220

Changes in v2:
 - add [PATCH v2 13|14|15/15] (suggested by Peter Zijlstra)
 - add Originally-bys and Suggested-bys
 - rebase onto the next-20241218

Hi all,

As proposed [1] by Peter Zijlstra below, this patch series aims to move
pagetable_*_dtor() into __tlb_remove_table(). This will cleanup pagetable_*_dtor()
a bit and more gracefully fix the UAF issue [2] reported by syzbot.

```
Notably:

 - s390 pud isn't calling the existing pagetable_pud_[cd]tor()
 - none of the p4d things have pagetable_p4d_[cd]tor() (x86,arm64,s390,riscv)
   and they have inconsistent accounting
 - while much of the _ctor calls are in generic code, many of the _dtor
   calls are in arch code for hysterial raisins, this could easily be
   fixed
 - if we fix ptlock_free() to handle NULL, then all the _dtor()
   functions can use it, and we can observe they're all identical
   and can be folded

after all that cleanup, you can move the _dtor from *_free_tlb() into
tlb_remove_table() -- which for the above case, would then have it
called from __tlb_remove_table_free().
```

And hi Andrew, I developed the code based on the latest linux-next, so I reverted
the "mm: pgtable: make ptlock be freed by RCU" first. Once the review of this
patch series is completed, the "mm: pgtable: make ptlock be freed by RCU" can be
dropped directly from mm tree, and this revert patch will not be needed.

This series is based on next-20241220. And I tested this patch series on x86 and
only cross-compiled it on arm, arm64, powerpc, riscv, s390 and sparc.

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/all/20241211133433.GC12500@noisy.programming.kicks-ass.net/
[2]. https://lore.kernel.org/all/67548279.050a0220.a30f1.015b.GAE@google.com/

Kevin Brodsky (2):
  riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
  asm-generic: pgalloc: Provide generic p4d_{alloc_one,free}

Qi Zheng (13):
  Revert "mm: pgtable: make ptlock be freed by RCU"
  mm: pgtable: add statistics for P4D level page table
  arm64: pgtable: use mmu gather to free p4d level page table
  s390: pgtable: add statistics for PUD and P4D level page table
  mm: pgtable: introduce pagetable_dtor()
  arm: pgtable: move pagetable_dtor() to __tlb_remove_table()
  arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
  riscv: pgtable: move pagetable_dtor() to __tlb_remove_table()
  x86: pgtable: move pagetable_dtor() to __tlb_remove_table()
  s390: pgtable: also move pagetable_dtor() of PxD to
    __tlb_remove_table()
  mm: pgtable: introduce generic __tlb_remove_table()
  mm: pgtable: move __tlb_remove_table_one() in x86 to generic file
  mm: pgtable: introduce generic pagetable_dtor_free()

 Documentation/mm/split_page_table_lock.rst |  4 +-
 arch/arm/include/asm/tlb.h                 | 10 ----
 arch/arm64/include/asm/pgalloc.h           | 18 ------
 arch/arm64/include/asm/tlb.h               | 21 ++++---
 arch/csky/include/asm/pgalloc.h            |  2 +-
 arch/hexagon/include/asm/pgalloc.h         |  2 +-
 arch/loongarch/include/asm/pgalloc.h       |  2 +-
 arch/m68k/include/asm/mcf_pgalloc.h        |  4 +-
 arch/m68k/include/asm/sun3_pgalloc.h       |  2 +-
 arch/m68k/mm/motorola.c                    |  2 +-
 arch/mips/include/asm/pgalloc.h            |  2 +-
 arch/nios2/include/asm/pgalloc.h           |  2 +-
 arch/openrisc/include/asm/pgalloc.h        |  2 +-
 arch/powerpc/include/asm/tlb.h             |  1 +
 arch/powerpc/mm/book3s64/mmu_context.c     |  2 +-
 arch/powerpc/mm/book3s64/pgtable.c         |  2 +-
 arch/powerpc/mm/pgtable-frag.c             |  4 +-
 arch/riscv/include/asm/pgalloc.h           | 69 +++++-----------------
 arch/riscv/include/asm/tlb.h               | 18 ------
 arch/riscv/mm/init.c                       |  4 +-
 arch/s390/include/asm/pgalloc.h            | 31 +++++++---
 arch/s390/include/asm/tlb.h                | 43 +++++++-------
 arch/s390/mm/pgalloc.c                     | 23 +-------
 arch/sh/include/asm/pgalloc.h              |  2 +-
 arch/sparc/include/asm/tlb_32.h            |  1 +
 arch/sparc/include/asm/tlb_64.h            |  1 +
 arch/sparc/mm/init_64.c                    |  2 +-
 arch/sparc/mm/srmmu.c                      |  2 +-
 arch/um/include/asm/pgalloc.h              |  6 +-
 arch/x86/include/asm/pgalloc.h             | 18 ------
 arch/x86/include/asm/tlb.h                 | 33 -----------
 arch/x86/kernel/paravirt.c                 |  1 +
 arch/x86/mm/pgtable.c                      | 13 ++--
 include/asm-generic/pgalloc.h              | 55 +++++++++++++++--
 include/asm-generic/tlb.h                  | 14 ++++-
 include/linux/mm.h                         | 50 ++++++----------
 include/linux/mm_types.h                   |  9 +--
 mm/memory.c                                | 23 +++-----
 mm/mmu_gather.c                            | 20 ++++++-
 39 files changed, 211 insertions(+), 309 deletions(-)

-- 
2.20.1


