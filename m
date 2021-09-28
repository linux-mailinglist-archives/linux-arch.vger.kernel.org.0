Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBD441A97D
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 09:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbhI1HRs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 03:17:48 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:57751 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239245AbhI1HRr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Sep 2021 03:17:47 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HJW4z0rbjz9sY3;
        Tue, 28 Sep 2021 09:16:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NzRtLB4124gI; Tue, 28 Sep 2021 09:16:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HJW4w14HDz9sY1;
        Tue, 28 Sep 2021 09:16:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B9B48B774;
        Tue, 28 Sep 2021 09:16:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BewMGGJ0kGtE; Tue, 28 Sep 2021 09:15:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.48])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A5BD48B770;
        Tue, 28 Sep 2021 09:15:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18S7Fnqa1452313
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 09:15:49 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18S7Fn3u1452312;
        Tue, 28 Sep 2021 09:15:49 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrew Morton <akpm@linux-foundation.org>, arnd@arndb.de
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH v2 2/4] mm: Make generic arch_is_kernel_initmem_freed() do what it says
Date:   Tue, 28 Sep 2021 09:15:35 +0200
Message-Id: <ec69cc95a98548c862c22b742936244fdb0c7984.1632813331.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <ffa99e8e91e756b081427b27e408f275b7d43df7.1632813331.git.christophe.leroy@csgroup.eu>
References: <ffa99e8e91e756b081427b27e408f275b7d43df7.1632813331.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 7a5da02de8d6 ("locking/lockdep: check for freed initmem in
static_obj()") added arch_is_kernel_initmem_freed() which is supposed
to report whether an object is part of already freed init memory.

For the time being, the generic version of arch_is_kernel_initmem_freed()
always reports 'false', allthough free_initmem() is generically called
on all architectures.

Therefore, change the generic version of arch_is_kernel_initmem_freed()
to check whether free_initmem() has been called. If so, then check
if a given address falls into init memory.

In order to use function init_section_contains(), the fonction is
moved at the end of asm-generic/section.h

Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Change to using the new SYSTEM_FREEING_INITMEM state
---
 include/asm-generic/sections.h | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d16302d3eb59..13f301239007 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -80,20 +80,6 @@ static inline int arch_is_kernel_data(unsigned long addr)
 }
 #endif
 
-/*
- * Check if an address is part of freed initmem. This is needed on architectures
- * with virt == phys kernel mapping, for code that wants to check if an address
- * is part of a static object within [_stext, _end]. After initmem is freed,
- * memory can be allocated from it, and such allocations would then have
- * addresses within the range [_stext, _end].
- */
-#ifndef arch_is_kernel_initmem_freed
-static inline int arch_is_kernel_initmem_freed(unsigned long addr)
-{
-	return 0;
-}
-#endif
-
 /**
  * memory_contains - checks if an object is contained within a memory region
  * @begin: virtual address of the beginning of the memory region
@@ -172,4 +158,21 @@ static inline bool is_kernel_rodata(unsigned long addr)
 	       addr < (unsigned long)__end_rodata;
 }
 
+/*
+ * Check if an address is part of freed initmem. This is needed on architectures
+ * with virt == phys kernel mapping, for code that wants to check if an address
+ * is part of a static object within [_stext, _end]. After initmem is freed,
+ * memory can be allocated from it, and such allocations would then have
+ * addresses within the range [_stext, _end].
+ */
+#ifndef arch_is_kernel_initmem_freed
+static inline int arch_is_kernel_initmem_freed(unsigned long addr)
+{
+	if (system_state < SYSTEM_FREEING_INITMEM)
+		return 0;
+
+	return init_section_contains((void *)addr, 1);
+}
+#endif
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
-- 
2.31.1

