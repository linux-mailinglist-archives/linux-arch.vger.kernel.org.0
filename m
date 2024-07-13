Return-Path: <linux-arch+bounces-5387-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ADD930435
	for <lists+linux-arch@lfdr.de>; Sat, 13 Jul 2024 09:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A07B283A94
	for <lists+linux-arch@lfdr.de>; Sat, 13 Jul 2024 07:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADBE39AC3;
	Sat, 13 Jul 2024 07:09:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC844C7B;
	Sat, 13 Jul 2024 07:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720854556; cv=none; b=ASlBf/OfygTjOc47uK6P4/p3ZMGb/V4u0GN7JdT878W2a5kRODB2KP5p7aCy/xqNY7LE8Y8PbmGnSQjmGDV3PgQUmp+m3k7p1sDF9eLQo3MKhfrf3A/y6oNuL326Kr6M5wxMWsZFvoEhPzr8xbLONbRhlL0IgOMyl4kU9yD6vBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720854556; c=relaxed/simple;
	bh=+hQ+cxc/Ik0JwvL+Bfnn1kxrsZliqHaKk8FlBgA+6Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyyQIKogDCYdiqOepMel+2O2mvYa701rm+x2/FjdrXCZ8lpuwiOFCjxC2S9/ESJvJNtDEKMF/rYroJk64VtKcB+LRR7USNPgi7INadP0YT++4yRP3jXifh0JOIzX8jR96tB1qFi2UJpXAAEcw/jAV2dNjr/3owUyxp9uCOG1rC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WLfhY1Ky4z9sSY;
	Sat, 13 Jul 2024 09:09:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A-AU9RRVGJNq; Sat, 13 Jul 2024 09:09:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WLfhX5qbsz9sSS;
	Sat, 13 Jul 2024 09:09:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B4D378B764;
	Sat, 13 Jul 2024 09:09:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id g1jIk9GeChEz; Sat, 13 Jul 2024 09:09:00 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.195])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C2AE78B77B;
	Sat, 13 Jul 2024 09:08:59 +0200 (CEST)
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
	linux-mips@vger.kernel.org
Subject: [PATCH v3 4/5] mips: Do not define pud_leaf() when there is no PMD
Date: Sat, 13 Jul 2024 09:08:26 +0200
Message-ID: <1cb28532d832b48b0a41f169615fec40546a5398.1720854135.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <c81566e5df160587de50f9095d0ec377114fdba8.1720854135.git.christophe.leroy@csgroup.eu>
References: <c81566e5df160587de50f9095d0ec377114fdba8.1720854135.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720854504; l=1388; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=+hQ+cxc/Ik0JwvL+Bfnn1kxrsZliqHaKk8FlBgA+6Fo=; b=PLrrIe9d7K8ajU9r5dWm0pYSfP8m3PYAmv4ou0R1F/fHVq5h7MJVKy8XI87mc+oO63w30Q/0N 999CdgHyAKNBeKPL3EK6axF0jxci7jZZYgenwddYCjhEEnjixrFTwoj
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

pud_leaf() is already provided by asm-generic/pgtable-nopmd.h

Do not add a macro that hides and overrides the static inline
definition in asm-generic/pgtable-nopmd.h.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/mips/include/asm/pgtable-64.h | 4 ++++
 arch/mips/include/asm/pgtable.h    | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 401c1d9e4409..d2de4e2800be 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -294,6 +294,10 @@ static inline void pud_clear(pud_t *pudp)
 {
 	pud_val(*pudp) = ((unsigned long) invalid_pmd_table);
 }
+
+#ifdef _PAGE_HUGE
+#define pud_leaf(pud)	((pud_val(pud) & _PAGE_HUGE) != 0)
+#endif
 #endif
 
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index c29a551eb0ca..28233025f884 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -755,7 +755,6 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 
 #ifdef _PAGE_HUGE
 #define pmd_leaf(pmd)	((pmd_val(pmd) & _PAGE_HUGE) != 0)
-#define pud_leaf(pud)	((pud_val(pud) & _PAGE_HUGE) != 0)
 #endif
 
 #define gup_fast_permitted(start, end)	(!cpu_has_dc_aliases)
-- 
2.44.0


