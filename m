Return-Path: <linux-arch+bounces-5386-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808A8930431
	for <lists+linux-arch@lfdr.de>; Sat, 13 Jul 2024 09:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC04283A6A
	for <lists+linux-arch@lfdr.de>; Sat, 13 Jul 2024 07:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E394E2E3FE;
	Sat, 13 Jul 2024 07:09:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3129428;
	Sat, 13 Jul 2024 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720854552; cv=none; b=nQdh/ZUqx2DAHFytJg6EFSIfLK+b1P9vtSHaoPgXVZ+3pFxUjh/+YKNM7PAqMqEWtlmpMxh3Fp/vmDswSLABwij7yrAYEo26uYrmeyUeK5meraDQO+bHHFmVgdfj9IBXRFDQrhayLOZUdPGdpDjQYGog6ajd70qaBBx5JCf0Q+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720854552; c=relaxed/simple;
	bh=RQbVBWOxUSgTrrtTd+PLaiyfFRNFBzohHDDwKNmlF88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUzHBv5NLuGxVq6YUecDLyAp30VNkqUSspiRPu+MqteadiUwzuEDuzSq742rhxpHoecZa58kBjuPKlRGUE8LhEa2ahPTxvwzv9XKhSTb9tEmFc9hGaWbubmbKEPUf2mCM+CerG9AmacKGJfF2wlx3tM+/Uf35RTAI9RF0uCDc7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WLfhX1pTzz9sSW;
	Sat, 13 Jul 2024 09:09:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QGR30cHzyt9i; Sat, 13 Jul 2024 09:09:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WLfhW68VNz9sSS;
	Sat, 13 Jul 2024 09:08:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C0DA28B76C;
	Sat, 13 Jul 2024 09:08:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Is4Ot-2G3sfo; Sat, 13 Jul 2024 09:08:59 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.195])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CA20E8B764;
	Sat, 13 Jul 2024 09:08:58 +0200 (CEST)
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
Subject: [PATCH v3 3/5] LoongArch: Do not define pud_leaf() when there is no PMD
Date: Sat, 13 Jul 2024 09:08:25 +0200
Message-ID: <732f3bdff0eed9cadfd35c698fd625e6e6cd6a04.1720854135.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <c81566e5df160587de50f9095d0ec377114fdba8.1720854135.git.christophe.leroy@csgroup.eu>
References: <c81566e5df160587de50f9095d0ec377114fdba8.1720854135.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720854504; l=1137; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=RQbVBWOxUSgTrrtTd+PLaiyfFRNFBzohHDDwKNmlF88=; b=kyeTq4tTk01pp+vPiGqPZ3xAI/bTN/2nOUDzVVH38OHwoM7j5I4X1quNwT1FsruuJa0FOTAwZ rE5KJnkCyhRC1DTqMd1fiL38cWn3qM95rUdVmXFoo9KKFZEIFgqwdKA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

pud_leaf() is already provided by asm-generic/pgtable-nopmd.h

Do not add a macro that hides and overrides the static inline
definition in asm-generic/pgtable-nopmd.h.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/loongarch/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 161dd6e10479..da91b2d8bc6f 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -207,6 +207,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 
 #define pud_phys(pud)		PHYSADDR(pud_val(pud))
 #define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
+#define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
 
 #endif
 
@@ -611,7 +612,6 @@ static inline long pmd_protnone(pmd_t pmd)
 #endif /* CONFIG_NUMA_BALANCING */
 
 #define pmd_leaf(pmd)		((pmd_val(pmd) & _PAGE_HUGE) != 0)
-#define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
 
 /*
  * We provide our own get_unmapped area to cope with the virtual aliasing
-- 
2.44.0


