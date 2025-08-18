Return-Path: <linux-arch+bounces-13188-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7512EB29E65
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 11:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0BD37B3CD5
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C146930FF24;
	Mon, 18 Aug 2025 09:50:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ED830F81E;
	Mon, 18 Aug 2025 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510649; cv=none; b=ucHeGWu9FKjxCekR6RHf1EYG0yv52pLsTgK476HduO9zpNSmbFHlwQnGTfM+ffc94APifhNTR/CEjxZwZuxwItnOx6VHzh+rEMxRc39J2QptFBWS8PpOD5dd1wZdGdh9x8gjW+CEomcl4zR5WjuPOWduSlwjpm3PHXnxnMpgaSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510649; c=relaxed/simple;
	bh=LTBJbGAaZnZ9xdSyMCrWcKItZ2m45x3r8zAe1HyRjkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsNOCeaVfZZDeNx5N1dEo7TwnCd06OZwqnSCFx7K6RvOI2px38UwYnwk6102EcFqzrRTfWkZhAeV8aelRi5oRWncu6OTBGrrrWi29H+q/fBmXlbfFoeaVFURQQl9l18Uh8Zq+Bm203XoGFlPIWmV5rlIpyF9DyulM1mnVbVZpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c56yW6MFjz9sRs;
	Mon, 18 Aug 2025 11:35:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S4lQMV8lRn9d; Mon, 18 Aug 2025 11:35:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c56yW5CjDz9sRk;
	Mon, 18 Aug 2025 11:35:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9EFE08B764;
	Mon, 18 Aug 2025 11:35:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id A_F0l_xYSBua; Mon, 18 Aug 2025 11:35:31 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6855F8B763;
	Mon, 18 Aug 2025 11:35:31 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2] asm-generic: Remove pud_user() from pgtable-nopmd.h
Date: Mon, 18 Aug 2025 11:35:29 +0200
Message-ID: <c2c9fc69871a7caaa205e237ff73557f19f5e176.1755509286.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755509730; l=2790; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=LTBJbGAaZnZ9xdSyMCrWcKItZ2m45x3r8zAe1HyRjkA=; b=8qUOHdMYJYyqO833zMLZ/GYzKalR9OMtGfcspZDpf14JjHMbxR02lStqhYZM25fsAVWilTr0q wzzsorRSqjLBdi9uE2wvgfjKDvqiPoLqP1ZmxaRS+NLBOlTSuLY3Wry
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
issues") added pud_user() in include/asm-generic/pgtable-nopmd.h

But pud_user() only exists on ARM64 and RISCV and is not expected
by any part of MM.

Add the missing definition in arch/riscv/include/asm/pgtable-32.h
and remove it from asm-generic/pgtable-nopmd.h

A stub pud_user() is also required for ARM64 after
commit ed928a3402d8 ("arm64/mm: fix page table check compile
error for CONFIG_PGTABLE_LEVELS=2")

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
Not sure whether this goes via asm-generic or mm as it touches the earth of mm allthough the files are in asm-generic

v2: Change ARM64 pud_user macro to pud_user(pud)
---
 arch/arm64/include/asm/pgtable.h    | 1 +
 arch/riscv/include/asm/pgtable-32.h | 5 +++++
 include/asm-generic/pgtable-nopmd.h | 1 -
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index abd2dee416b3..d812ed1c96b4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -955,6 +955,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 
 #define pud_valid(pud)		false
 #define pud_page_paddr(pud)	({ BUILD_BUG(); 0; })
+#define pud_user(pud)		false /* Always 0 with folding */
 #define pud_user_exec(pud)	pud_user(pud) /* Always 0 with folding */
 
 /* Match pmd_offset folding in <asm/generic/pgtable-nopmd.h> */
diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index 00f3369570a8..37878ef37466 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -36,4 +36,9 @@
 static const __maybe_unused int pgtable_l4_enabled;
 static const __maybe_unused int pgtable_l5_enabled;
 
+static inline int pud_user(pud_t pud)
+{
+	return 0;
+}
+
 #endif /* _ASM_RISCV_PGTABLE_32_H */
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 8ffd64e7a24c..b01349a312fa 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -30,7 +30,6 @@ typedef struct { pud_t pud; } pmd_t;
 static inline int pud_none(pud_t pud)		{ return 0; }
 static inline int pud_bad(pud_t pud)		{ return 0; }
 static inline int pud_present(pud_t pud)	{ return 1; }
-static inline int pud_user(pud_t pud)		{ return 0; }
 static inline int pud_leaf(pud_t pud)		{ return 0; }
 static inline void pud_clear(pud_t *pud)	{ }
 #define pmd_ERROR(pmd)				(pud_ERROR((pmd).pud))
-- 
2.49.0


