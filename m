Return-Path: <linux-arch+bounces-9538-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 559459FE451
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2024 10:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AF41882965
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2024 09:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5407115B984;
	Mon, 30 Dec 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZdDBIIoe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A91A23BE
	for <linux-arch@vger.kernel.org>; Mon, 30 Dec 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549799; cv=none; b=g0mrB8uchU+DHVnl4TgY8e2GlOPLe5l15yFrlfwNJJM1ccYB+VfF71cIbSKUfHKKx8oqDQryxCHJA4HRbKd9m9GFw++2kQHg/QzwAnpGgTFYasgy3tM0bsQzU937Ff93qEbxJoure+OGxXNNoUKyM9iyVEztwkHiH7n5isqfWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549799; c=relaxed/simple;
	bh=gsn2MxaDHMIkVDeNJoAZ1GXzg4UbDMQdMp9AlgDJXWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jgclOSWxR+nY7UY+jbGbr3Pi/jvbAztJDfeHkEqTg8O64uDTtAhjlxSqsSx9K+3t8NXyS7MckM3UEnwSVMLIyb4xK+HzARm1+VJNvntFt32DyPw6hQhfK+4GPtKsz4osTxvjMqhm3LQSg/1JIjCj9EJWrJwCoK3WTpi769TzJqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZdDBIIoe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166022c5caso101201485ad.2
        for <linux-arch@vger.kernel.org>; Mon, 30 Dec 2024 01:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549795; x=1736154595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY41yoAggnrpKZDOvMIy0+FhpPRF9QFn+bDK7HKPzWw=;
        b=ZdDBIIoelCJjmLBiAvvITNIgs9m6LIoCNsC5x8RDr8WBQ/EfIiCbfp7WwIxMKjwY13
         m9Tu8tZuobXFHMie0svrZpxYb810XVGhwhsiiFS8xegb+19Z0mkzzb6zr1p06EpCB00q
         ASZJz5wujN5irKhpTpcdgLubw2t3o2KQodRClOS/h3Ch9DQG7pEEEnWG3WtPDFMqw8rC
         nNxn6lZW81uNhA+v5NPe4AAUVn5YS88g8RFWQfjtOk6+dQE5QtB7LKV33ORmBrFTGqvO
         8qJ/Ug6fXbwNi5F9KypqIzGrAMB6Bip/zuS4djeXVdQoQSpnGTP6oQghkUwh/iEST0vl
         KI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549795; x=1736154595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY41yoAggnrpKZDOvMIy0+FhpPRF9QFn+bDK7HKPzWw=;
        b=aLpZOaZgza9LT1+Vhc94+iHFOG5c5Xx82v9yfz32V99qY09p7GwxNhXD0EUQVsQbTh
         s4cbHMyemoEbxYo4obJB+MzaI6kRoZszonFnhKwYyVnbpEvyADeit/+2qoQa07L7+aWs
         N/lBTmKTYxNTfw0MU/JM/K/6JBK6sdO0WmkLrQkOIK6eXA5sEuB/9frAtZ0DbxyZbVPq
         xacI4E8Xf/nAEuV63Th8NWWvBf1cgdh9h9qz/oy7HhMfTJwcfq+N9NQ5A9YUvdWReUnJ
         G324jBDnWMI7VAelGbo98gvKOk6E5NWSsvTRVlG9wpad0NFto/j/UwSYvFAC/rGmDZmP
         ZsZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkAmPmbBGO0sg8+rbThCpdXB1wKKDzppdMXosog1nTbQswPLLkhwHg5EGvH0FOIcpJBvu9EYy9OdhR@vger.kernel.org
X-Gm-Message-State: AOJu0YyfHAPAH035Lde31BsH9leNCKSMDBzguOYrpsFsngBh/c1a6svv
	qoz41BjKLgvaZ8w6XfOz5zL22h/a4micgDLkXwZVSnhLCBKrUWJVJ/iLZaZ5Jwg=
X-Gm-Gg: ASbGncsGcHEUWxzn+VEXrCrxBnwyJlpgl+Ba3Hs2vG6K1k9wU/7WoUmtm4J/+tK1Fej
	8QxYLOqgwhqCJJE/s1ejdjgLndgAqRBwVkIHaTHxP8VJo8SHxu7nkFSMYfkCXLGh6jeLEHxRokK
	Cz6ScnQnJjODtDe02tEz0UgN89E1t+3gpfqSRvIVc7qxNO2MoNp/vyQ5mRubJop0InbXvOUcmUE
	rhr/0xoSDAKc87gqA0OeAnL1Wc1vPJwpLu5dGSOuEjjLqU5epv1v3W/7c7Gf+y9ccbtg2A4Aprd
	ML8hPeJ9YhCiCiWkuGsJJg==
X-Google-Smtp-Source: AGHT+IGnRshrEAoIvJb/W9ouyd0xHkDgdKkbYKOXyUcaItniQPw/Z8/M3j6tdqefIia4rt8bUMG2kg==
X-Received: by 2002:a05:6a21:328d:b0:1db:f68a:d943 with SMTP id adf61e73a8af0-1e5e0461b11mr51051580637.17.1735549795427;
        Mon, 30 Dec 2024 01:09:55 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:09:54 -0800 (PST)
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
Subject: [PATCH v4 06/15] s390: pgtable: add statistics for PUD and P4D level page table
Date: Mon, 30 Dec 2024 17:07:41 +0800
Message-Id: <35be22a2b1666df729a9fc108c2da5cce266e4be.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like PMD and PTE level page table, also add statistics for PUD and P4D
page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/pgalloc.h | 29 +++++++++++++++++++-------
 arch/s390/include/asm/tlb.h     | 37 +++++++++++++++++----------------
 2 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 7b84ef6dc4b6d..a0c1ca5d8423c 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -53,29 +53,42 @@ static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	unsigned long *table = crst_table_alloc(mm);
 
-	if (table)
-		crst_table_init(table, _REGION2_ENTRY_EMPTY);
+	if (!table)
+		return NULL;
+	crst_table_init(table, _REGION2_ENTRY_EMPTY);
+	pagetable_p4d_ctor(virt_to_ptdesc(table));
+
 	return (p4d_t *) table;
 }
 
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
-	if (!mm_p4d_folded(mm))
-		crst_table_free(mm, (unsigned long *) p4d);
+	if (mm_p4d_folded(mm))
+		return;
+
+	pagetable_p4d_dtor(virt_to_ptdesc(p4d));
+	crst_table_free(mm, (unsigned long *) p4d);
 }
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	unsigned long *table = crst_table_alloc(mm);
-	if (table)
-		crst_table_init(table, _REGION3_ENTRY_EMPTY);
+
+	if (!table)
+		return NULL;
+	crst_table_init(table, _REGION3_ENTRY_EMPTY);
+	pagetable_pud_ctor(virt_to_ptdesc(table));
+
 	return (pud_t *) table;
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
-	if (!mm_pud_folded(mm))
-		crst_table_free(mm, (unsigned long *) pud);
+	if (mm_pud_folded(mm))
+		return;
+
+	pagetable_pud_dtor(virt_to_ptdesc(pud));
+	crst_table_free(mm, (unsigned long *) pud);
 }
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index e95b2c8081eb8..b946964afce8e 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -110,24 +110,6 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 	tlb_remove_ptdesc(tlb, pmd);
 }
 
-/*
- * p4d_free_tlb frees a pud table and clears the CRSTE for the
- * region second table entry from the tlb.
- * If the mm uses a four level page table the single p4d is freed
- * as the pgd. p4d_free_tlb checks the asce_limit against 8PB
- * to avoid the double free of the p4d in this case.
- */
-static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
-				unsigned long address)
-{
-	if (mm_p4d_folded(tlb->mm))
-		return;
-	__tlb_adjust_range(tlb, address, PAGE_SIZE);
-	tlb->mm->context.flush_mm = 1;
-	tlb->freed_tables = 1;
-	tlb_remove_ptdesc(tlb, p4d);
-}
-
 /*
  * pud_free_tlb frees a pud table and clears the CRSTE for the
  * region third table entry from the tlb.
@@ -140,11 +122,30 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 {
 	if (mm_pud_folded(tlb->mm))
 		return;
+	pagetable_pud_dtor(virt_to_ptdesc(pud));
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_p4ds = 1;
 	tlb_remove_ptdesc(tlb, pud);
 }
 
+/*
+ * p4d_free_tlb frees a p4d table and clears the CRSTE for the
+ * region second table entry from the tlb.
+ * If the mm uses a four level page table the single p4d is freed
+ * as the pgd. p4d_free_tlb checks the asce_limit against 8PB
+ * to avoid the double free of the p4d in this case.
+ */
+static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
+				unsigned long address)
+{
+	if (mm_p4d_folded(tlb->mm))
+		return;
+	pagetable_p4d_dtor(virt_to_ptdesc(p4d));
+	__tlb_adjust_range(tlb, address, PAGE_SIZE);
+	tlb->mm->context.flush_mm = 1;
+	tlb->freed_tables = 1;
+	tlb_remove_ptdesc(tlb, p4d);
+}
 
 #endif /* _S390_TLB_H */
-- 
2.20.1


