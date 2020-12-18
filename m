Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935A22DE3AC
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 15:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgLROIs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 09:08:48 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:19929 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgLROIs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Dec 2020 09:08:48 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Cy9gL3Ck1z9txvg;
        Fri, 18 Dec 2020 15:07:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5Ndh04yO9aS3; Fri, 18 Dec 2020 15:07:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Cy9gL1tj2z9txvB;
        Fri, 18 Dec 2020 15:07:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B41FD8B783;
        Fri, 18 Dec 2020 15:07:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ynTuRuN7N3DG; Fri, 18 Dec 2020 15:07:59 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.204.43])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C2E88B75F;
        Fri, 18 Dec 2020 15:07:59 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F030266868; Fri, 18 Dec 2020 14:07:58 +0000 (UTC)
Message-Id: <320d7a9ed7b379a6e0edf16d539bc22447272e65.1608299993.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] mm: Remove arch_remap() and mm-arch-hooks.h
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Date:   Fri, 18 Dec 2020 14:07:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

powerpc was the last provider of arch_remap() and the last
user of mm-arch-hooks.h.

Since commit 526a9c4a7234 ("powerpc/vdso: Provide vdso_remap()"),
arch_remap() hence mm-arch-hooks.h are not used anymore.

Remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/um/include/asm/Kbuild          |  1 -
 include/asm-generic/Kbuild          |  1 -
 include/asm-generic/mm-arch-hooks.h | 16 ----------------
 include/linux/mm-arch-hooks.h       | 22 ----------------------
 mm/mremap.c                         |  3 ---
 5 files changed, 43 deletions(-)
 delete mode 100644 include/asm-generic/mm-arch-hooks.h
 delete mode 100644 include/linux/mm-arch-hooks.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 1c63b260ecc4..314979467db1 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -14,7 +14,6 @@ generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += mcs_spinlock.h
-generic-y += mm-arch-hooks.h
 generic-y += mmiowb.h
 generic-y += module.lds.h
 generic-y += param.h
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 4365b9aa3e3f..e867eb3058d5 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -34,7 +34,6 @@ mandatory-y += kmap_size.h
 mandatory-y += kprobes.h
 mandatory-y += linkage.h
 mandatory-y += local.h
-mandatory-y += mm-arch-hooks.h
 mandatory-y += mmiowb.h
 mandatory-y += mmu.h
 mandatory-y += mmu_context.h
diff --git a/include/asm-generic/mm-arch-hooks.h b/include/asm-generic/mm-arch-hooks.h
deleted file mode 100644
index 5ff0e5193f85..000000000000
--- a/include/asm-generic/mm-arch-hooks.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Architecture specific mm hooks
- */
-
-#ifndef _ASM_GENERIC_MM_ARCH_HOOKS_H
-#define _ASM_GENERIC_MM_ARCH_HOOKS_H
-
-/*
- * This file should be included through arch/../include/asm/Kbuild for
- * the architecture which doesn't need specific mm hooks.
- *
- * In that case, the generic hooks defined in include/linux/mm-arch-hooks.h
- * are used.
- */
-
-#endif /* _ASM_GENERIC_MM_ARCH_HOOKS_H */
diff --git a/include/linux/mm-arch-hooks.h b/include/linux/mm-arch-hooks.h
deleted file mode 100644
index 9c4bedc95504..000000000000
--- a/include/linux/mm-arch-hooks.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Generic mm no-op hooks.
- *
- * Copyright (C) 2015, IBM Corporation
- * Author: Laurent Dufour <ldufour@linux.vnet.ibm.com>
- */
-#ifndef _LINUX_MM_ARCH_HOOKS_H
-#define _LINUX_MM_ARCH_HOOKS_H
-
-#include <asm/mm-arch-hooks.h>
-
-#ifndef arch_remap
-static inline void arch_remap(struct mm_struct *mm,
-			      unsigned long old_start, unsigned long old_end,
-			      unsigned long new_start, unsigned long new_end)
-{
-}
-#define arch_remap arch_remap
-#endif
-
-#endif /* _LINUX_MM_ARCH_HOOKS_H */
diff --git a/mm/mremap.c b/mm/mremap.c
index c5590afe7165..e43696a91260 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -22,7 +22,6 @@
 #include <linux/syscalls.h>
 #include <linux/mmu_notifier.h>
 #include <linux/uaccess.h>
-#include <linux/mm-arch-hooks.h>
 #include <linux/userfaultfd_k.h>
 
 #include <asm/cacheflush.h>
@@ -560,8 +559,6 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		new_addr = err;
 	} else {
 		mremap_userfaultfd_prep(new_vma, uf);
-		arch_remap(mm, old_addr, old_addr + old_len,
-			   new_addr, new_addr + new_len);
 	}
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
-- 
2.25.0

