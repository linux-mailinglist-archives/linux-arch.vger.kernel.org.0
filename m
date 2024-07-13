Return-Path: <linux-arch+bounces-5388-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF61930438
	for <lists+linux-arch@lfdr.de>; Sat, 13 Jul 2024 09:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180AFB2304D
	for <lists+linux-arch@lfdr.de>; Sat, 13 Jul 2024 07:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C9339FC1;
	Sat, 13 Jul 2024 07:09:20 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32395200A3;
	Sat, 13 Jul 2024 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720854560; cv=none; b=r11oombKy61tVMg25iur3xgXoa6YZw+oacf9uwa09rz4DHgYnmenTVggJPlaohsSiOdMOJ4ETV2GAa/9HwxAmq/1LT7sDwykLQjCMR+5Y/wp0+4o0yIycEq4OzGtJpfSo2F5u95TAgcnJwujY+FRJi6Gj4R3ELbNoT7Lb58y2Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720854560; c=relaxed/simple;
	bh=9cGeujZtX2c/zEf05hq/l7o1WBt5GJFv+9LPfky90p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIfjdTGACYuvOmFTBla0rJwhQuw8Ytj/bkmEbmysMpKGdPQQ27wtb++61dlaC88eDCnQ8LZe7Bw3oEgUMESSny47x04id4e/+wELSNFN2pn+OteBrIgXzaV2dGf0lZ/MvuPOJJUq430/MWVU9ni9wz6HrUSM9A2R5iNZVxwq73o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WLfhZ1Ccnz9sSb;
	Sat, 13 Jul 2024 09:09:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rBAPNnN2erdv; Sat, 13 Jul 2024 09:09:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WLfhY68WVz9sSS;
	Sat, 13 Jul 2024 09:09:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BCB5C8B764;
	Sat, 13 Jul 2024 09:09:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id U1NlTXZ3sw-T; Sat, 13 Jul 2024 09:09:01 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.195])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B6F798B76C;
	Sat, 13 Jul 2024 09:09:00 +0200 (CEST)
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
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 5/5] mm: Add p{g/4}d_leaf() in asm-generic/pgtable-nop{4/u}d.h
Date: Sat, 13 Jul 2024 09:08:27 +0200
Message-ID: <7b6f39f3cc9823e0a058b27f50ad4f47b2e10979.1720854135.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <c81566e5df160587de50f9095d0ec377114fdba8.1720854135.git.christophe.leroy@csgroup.eu>
References: <c81566e5df160587de50f9095d0ec377114fdba8.1720854135.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720854504; l=2504; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=9cGeujZtX2c/zEf05hq/l7o1WBt5GJFv+9LPfky90p8=; b=MN2/woF7LqGhnWnq57H61zGqJsMcmtZviZwr/m6VoCoVv5XepEx+34tqeLFna5lL+rtgkoHC6 84JnWQ04MY8AFTasVOBH1guX6oXN81IRpiabqc6NIYejAVLsU1O2E4y
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
issues") added pud_leaf() in include/asm-generic/pgtable-nopmd.h

Do the same for p4d_leaf() and pgd_leaf() to avoid getting them
erroneously defined by architectures that do not implement the
related page level.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
v2: Added pXd_leaf macro as well in asm-generic/pgtable-nopXd.h to cohabit with the fallback
---
 include/asm-generic/pgtable-nop4d.h | 2 ++
 include/asm-generic/pgtable-nopmd.h | 1 +
 include/asm-generic/pgtable-nopud.h | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 03b7dae47dd4..ed7ba008469f 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -21,6 +21,8 @@ typedef struct { pgd_t pgd; } p4d_t;
 static inline int pgd_none(pgd_t pgd)		{ return 0; }
 static inline int pgd_bad(pgd_t pgd)		{ return 0; }
 static inline int pgd_present(pgd_t pgd)	{ return 1; }
+static inline int pgd_leaf(pgd_t pgd)		{ return 0; }
+#define pgd_leaf pgd_leaf
 static inline void pgd_clear(pgd_t *pgd)	{ }
 #define p4d_ERROR(p4d)				(pgd_ERROR((p4d).pgd))
 
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index b01349a312fa..e178ace2e23e 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -31,6 +31,7 @@ static inline int pud_none(pud_t pud)		{ return 0; }
 static inline int pud_bad(pud_t pud)		{ return 0; }
 static inline int pud_present(pud_t pud)	{ return 1; }
 static inline int pud_leaf(pud_t pud)		{ return 0; }
+#define pud_leaf pud_leaf
 static inline void pud_clear(pud_t *pud)	{ }
 #define pmd_ERROR(pmd)				(pud_ERROR((pmd).pud))
 
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index eb70c6d7ceff..655dfebea91c 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -28,6 +28,8 @@ typedef struct { p4d_t p4d; } pud_t;
 static inline int p4d_none(p4d_t p4d)		{ return 0; }
 static inline int p4d_bad(p4d_t p4d)		{ return 0; }
 static inline int p4d_present(p4d_t p4d)	{ return 1; }
+static inline int p4d_leaf(p4d_t p4d)		{ return 0; }
+#define p4d_leaf p4d_leaf
 static inline void p4d_clear(p4d_t *p4d)	{ }
 #define pud_ERROR(pud)				(p4d_ERROR((pud).p4d))
 
-- 
2.44.0


