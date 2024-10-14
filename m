Return-Path: <linux-arch+bounces-8093-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4429699D179
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 17:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283EC28499A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2F11CDFBE;
	Mon, 14 Oct 2024 15:13:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E01ABEB4;
	Mon, 14 Oct 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918833; cv=none; b=loivlMQtuXTcxkJYO2nrqIP3kxZ2b0xwoQ3s4/TfyuWs5uZTDRjL9e5KFRvYLZcnu0D/uJj9L3+NN+Yroej+Vama+w6aQYCXlFo5OQJ5OhHUg380s4M3QB206+xAR2klrMMARsTyGXoP44oP+/wKbor7SDzoC70J3GTi1xUjkmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918833; c=relaxed/simple;
	bh=cckMB+qD2PVKSnam4JSXbKZgacfoJ6fciL5iBGDIqeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WdLqIzofaYVEImMvXu5ZW+cKUo4goWHgZjK5OsEMOCnxmYeOT9aaNFFoC6lqcpjircmKRpnAMooByPSWNN73ANHqXrZUGxhgDNPCNRLXBvMgFATcgRWTe9+/XviY5rD7eB/H28SPlNfpYWsohBv7wP9Mg89PJ2JcJGXF2MF80gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7E661007;
	Mon, 14 Oct 2024 08:14:20 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F4793F51B;
	Mon, 14 Oct 2024 08:13:49 -0700 (PDT)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v5 3/3] s390: Remove remaining _PAGE_* macros
Date: Mon, 14 Oct 2024 16:13:40 +0100
Message-Id: <20241014151340.1639555-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014151340.1639555-1-vincenzo.frascino@arm.com>
References: <20241014151340.1639555-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The introduction of vdso/page.h made redundant the definition of
_PAGE_SHIFT, _PAGE_SIZE, _PAGE_MASK.

Refactor the code to remove the macros.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410112106.mvc2U2p0-lkp@intel.com/
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/s390/include/asm/page.h    | 3 ---
 arch/s390/include/asm/pgtable.h | 2 +-
 arch/s390/mm/fault.c            | 2 +-
 arch/s390/mm/gmap.c             | 6 +++---
 arch/s390/mm/pgalloc.c          | 4 ++--
 5 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index dbc25dc5fa0a..b7ba87f89761 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -13,9 +13,6 @@
 
 #include <vdso/page.h>
 
-#define _PAGE_SHIFT	PAGE_SHIFT
-#define _PAGE_SIZE	PAGE_SIZE
-#define _PAGE_MASK	PAGE_MASK
 #define PAGE_DEFAULT_ACC	_AC(0, UL)
 /* storage-protection override */
 #define PAGE_SPO_ACC		9
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 0ffbaf741955..8b67036edb69 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -338,7 +338,7 @@ static inline int is_module_addr(void *addr)
 #define _REGION2_INDEX	(0x7ffUL << _REGION2_SHIFT)
 #define _REGION3_INDEX	(0x7ffUL << _REGION3_SHIFT)
 #define _SEGMENT_INDEX	(0x7ffUL << _SEGMENT_SHIFT)
-#define _PAGE_INDEX	(0xffUL  << _PAGE_SHIFT)
+#define _PAGE_INDEX	(0xffUL  << PAGE_SHIFT)
 
 #define _REGION1_SIZE	(1UL << _REGION1_SHIFT)
 #define _REGION2_SIZE	(1UL << _REGION2_SHIFT)
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index ad8b0d6b77ea..12e10269dfcd 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -147,7 +147,7 @@ static void dump_pagetable(unsigned long asce, unsigned long address)
 			goto out;
 		table = __va(entry & _SEGMENT_ENTRY_ORIGIN);
 	}
-	table += (address & _PAGE_INDEX) >> _PAGE_SHIFT;
+	table += (address & _PAGE_INDEX) >> PAGE_SHIFT;
 	if (get_kernel_nofault(entry, table))
 		goto bad;
 	pr_cont("P:%016lx ", entry);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index eb0b51a36be0..346ec059c8bd 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -851,7 +851,7 @@ static inline unsigned long *gmap_table_walk(struct gmap *gmap,
 		if (*table & _REGION_ENTRY_INVALID)
 			return NULL;
 		table = __va(*table & _SEGMENT_ENTRY_ORIGIN);
-		table += (gaddr & _PAGE_INDEX) >> _PAGE_SHIFT;
+		table += (gaddr & _PAGE_INDEX) >> PAGE_SHIFT;
 	}
 	return table;
 }
@@ -1317,7 +1317,7 @@ static void gmap_unshadow_page(struct gmap *sg, unsigned long raddr)
 	table = gmap_table_walk(sg, raddr, 0); /* get page table pointer */
 	if (!table || *table & _PAGE_INVALID)
 		return;
-	gmap_call_notifier(sg, raddr, raddr + _PAGE_SIZE - 1);
+	gmap_call_notifier(sg, raddr, raddr + PAGE_SIZE - 1);
 	ptep_unshadow_pte(sg->mm, raddr, (pte_t *) table);
 }
 
@@ -1335,7 +1335,7 @@ static void __gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr,
 	int i;
 
 	BUG_ON(!gmap_is_shadow(sg));
-	for (i = 0; i < _PAGE_ENTRIES; i++, raddr += _PAGE_SIZE)
+	for (i = 0; i < _PAGE_ENTRIES; i++, raddr += PAGE_SIZE)
 		pgt[i] = _PAGE_INVALID;
 }
 
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index f691e0fb66a2..58696a0c4e4a 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -278,7 +278,7 @@ static inline unsigned long base_##NAME##_addr_end(unsigned long addr,	\
 	return (next - 1) < (end - 1) ? next : end;			\
 }
 
-BASE_ADDR_END_FUNC(page,    _PAGE_SIZE)
+BASE_ADDR_END_FUNC(page,    PAGE_SIZE)
 BASE_ADDR_END_FUNC(segment, _SEGMENT_SIZE)
 BASE_ADDR_END_FUNC(region3, _REGION3_SIZE)
 BASE_ADDR_END_FUNC(region2, _REGION2_SIZE)
@@ -302,7 +302,7 @@ static int base_page_walk(unsigned long *origin, unsigned long addr,
 	if (!alloc)
 		return 0;
 	pte = origin;
-	pte += (addr & _PAGE_INDEX) >> _PAGE_SHIFT;
+	pte += (addr & _PAGE_INDEX) >> PAGE_SHIFT;
 	do {
 		next = base_page_addr_end(addr, end);
 		*pte = base_lra(addr);
-- 
2.34.1


