Return-Path: <linux-arch+bounces-5385-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B34E93042F
	for <lists+linux-arch@lfdr.de>; Sat, 13 Jul 2024 09:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EE7283907
	for <lists+linux-arch@lfdr.de>; Sat, 13 Jul 2024 07:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B7A20309;
	Sat, 13 Jul 2024 07:09:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD51BDCF;
	Sat, 13 Jul 2024 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720854547; cv=none; b=BWeHuW9xPLbeDxUkWnLNJNz/+nLScOiIWusOFI2Sg4g6w1NPbP32nfzt71jkWXSQDlsob2MlrXArAd0sSZbjMwVlO3wBrXlnIAAfw3cnDkCIiW4tjU57MXbJqxQCG+cs2yZIRqO8psN5HIQfT5v5ADhSIAFtt7FIWTuK2IC8gNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720854547; c=relaxed/simple;
	bh=iBVqoMJazAvRQUo1vTp2Zd43IQ2OKhUaCoVnbqsBTJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rG7V2KWT21rPqAJz+xBFmfFIlLCVp8GmO06WG1PNvez71M0TIpmBpmRzaT8/ejNsYgCbH/KFEiZq00rkRw7vputiC775bMAt54OQfeyR7bWeLAVJ1Zl5msOE6FAxRKGgGeRN3mwlZyK/TSybmcHOdLvCvGkRYvEQR77w96k31b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WLfhW0n1Bz9sSV;
	Sat, 13 Jul 2024 09:08:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NT0I5H53SC1G; Sat, 13 Jul 2024 09:08:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WLfhV6fGyz9sSS;
	Sat, 13 Jul 2024 09:08:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D26E98B76C;
	Sat, 13 Jul 2024 09:08:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 0WXuODkIT-v3; Sat, 13 Jul 2024 09:08:58 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.195])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C367B8B77B;
	Sat, 13 Jul 2024 09:08:57 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 2/5] mm: Remove pud_user() from asm-generic/pgtable-nopmd.h
Date: Sat, 13 Jul 2024 09:08:24 +0200
Message-ID: <a2e995063b48377b048d84fc97b5fb6b54fef62c.1720854135.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <c81566e5df160587de50f9095d0ec377114fdba8.1720854135.git.christophe.leroy@csgroup.eu>
References: <c81566e5df160587de50f9095d0ec377114fdba8.1720854135.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720854504; l=2533; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=iBVqoMJazAvRQUo1vTp2Zd43IQ2OKhUaCoVnbqsBTJ0=; b=jJMk8U4y7cgZ/vp8633dMxDk0wPNiAX4F6OCHO9eyw5ASH4oMHt8ifjkUfcz5Xn4tKjD9A2nJ JWThXhe1dp2BhqiFdgOfAEseuosECaD6ssSvIM65cfPqwfXUql7AiTb
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
---
v3: Added pud_user() for arm64
---
 arch/arm64/include/asm/pgtable.h    | 1 +
 arch/riscv/include/asm/pgtable-32.h | 5 +++++
 include/asm-generic/pgtable-nopmd.h | 1 -
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f8efbc128446..c818b3328704 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -812,6 +812,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 
 #define pud_valid(pud)		false
 #define pud_page_paddr(pud)	({ BUILD_BUG(); 0; })
+#define pud_user		false /* Always 0 with folding */
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
2.44.0


