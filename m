Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B94A41762C
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhIXNuv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 09:50:51 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:41017 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231510AbhIXNuv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Sep 2021 09:50:51 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HGD0X5vB8z9sVt;
        Fri, 24 Sep 2021 15:49:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j5VNJ9feyuFZ; Fri, 24 Sep 2021 15:49:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HGD0X4sfyz9sVq;
        Fri, 24 Sep 2021 15:49:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A49E8B781;
        Fri, 24 Sep 2021 15:49:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id D0X0hp1BLVGj; Fri, 24 Sep 2021 15:49:16 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.215])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 49A808B763;
        Fri, 24 Sep 2021 15:49:16 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18ODn6DW1293064
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 15:49:06 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18ODn6eg1293063;
        Fri, 24 Sep 2021 15:49:06 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrew Morton <akpm@linux-foundation.org>, arnd@arndb.de
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH 3/3] s390: Use generic version of arch_is_kernel_initmem_freed()
Date:   Fri, 24 Sep 2021 15:48:47 +0200
Message-Id: <8e7f31b51ce62c9c495f71845f29a6d825d6e852.1632491308.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <0b55650058a5bf64f7d74781871a1ada2298c8b4.1632491308.git.christophe.leroy@csgroup.eu>
References: <0b55650058a5bf64f7d74781871a1ada2298c8b4.1632491308.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Generic version of arch_is_kernel_initmem_freed() now does the same
as s390 version.

Remove the s390 version.

Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/s390/include/asm/sections.h | 12 ------------
 arch/s390/mm/init.c              |  3 ---
 2 files changed, 15 deletions(-)

diff --git a/arch/s390/include/asm/sections.h b/arch/s390/include/asm/sections.h
index 85881dd48022..3fecaa4e8b74 100644
--- a/arch/s390/include/asm/sections.h
+++ b/arch/s390/include/asm/sections.h
@@ -2,20 +2,8 @@
 #ifndef _S390_SECTIONS_H
 #define _S390_SECTIONS_H
 
-#define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
-
 #include <asm-generic/sections.h>
 
-extern bool initmem_freed;
-
-static inline int arch_is_kernel_initmem_freed(unsigned long addr)
-{
-	if (!initmem_freed)
-		return 0;
-	return addr >= (unsigned long)__init_begin &&
-	       addr < (unsigned long)__init_end;
-}
-
 /*
  * .boot.data section contains variables "shared" between the decompressor and
  * the decompressed kernel. The decompressor will store values in them, and
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index a04faf49001a..8c6f258a6183 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -58,8 +58,6 @@ unsigned long empty_zero_page, zero_page_mask;
 EXPORT_SYMBOL(empty_zero_page);
 EXPORT_SYMBOL(zero_page_mask);
 
-bool initmem_freed;
-
 static void __init setup_zero_pages(void)
 {
 	unsigned int order;
@@ -214,7 +212,6 @@ void __init mem_init(void)
 
 void free_initmem(void)
 {
-	initmem_freed = true;
 	__set_memory((unsigned long)_sinittext,
 		     (unsigned long)(_einittext - _sinittext) >> PAGE_SHIFT,
 		     SET_MEMORY_RW | SET_MEMORY_NX);
-- 
2.31.1

