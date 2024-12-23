Return-Path: <linux-arch+bounces-9466-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B89FAC63
	for <lists+linux-arch@lfdr.de>; Mon, 23 Dec 2024 10:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BE3188367C
	for <lists+linux-arch@lfdr.de>; Mon, 23 Dec 2024 09:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C4718DF6E;
	Mon, 23 Dec 2024 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VqAbwFY+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A74194A6B
	for <linux-arch@vger.kernel.org>; Mon, 23 Dec 2024 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947062; cv=none; b=VlOZVwtffCgsx9JeogK8xCX1RJ4+RE1FBArPhOI4VdLilpQArERIyAooE6alw+srFhlGhPWRSzFaXng7cymgDUcswEfHIr43Z9eyWvJhtlmZDZf0Q8C73gIYrTKQ0omZprCarvI2MsL4gQvqBRm1S1X6Xh1RPY+H3j7Xx7fl8OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947062; c=relaxed/simple;
	bh=gsn2MxaDHMIkVDeNJoAZ1GXzg4UbDMQdMp9AlgDJXWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=avVYu+BvJbFxeaeW1iGZNdq/jiNwdTOPeqLU9B3Yy3ZA7xiWzKSMM4PrkqpNGNyFa1cZlfL/U0x+JGR2srwpKQWYv0OUMlrPgbak2BXWmSqeB+3LUjwsIWuD82NX4Pm//V9QpeWbAJRYNMVBCHS4QPJB3+x6xMsgdtCa+KzdkRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VqAbwFY+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fc88476a02so3087755a12.2
        for <linux-arch@vger.kernel.org>; Mon, 23 Dec 2024 01:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947060; x=1735551860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY41yoAggnrpKZDOvMIy0+FhpPRF9QFn+bDK7HKPzWw=;
        b=VqAbwFY+mxfHi24wSoLfeFH9u+D1/KxNf/fdg4uD/4bg61xhkNTGf4yKJXZo5XDk8v
         US3r5OvglLHzKlic2ukiek2bj0BKfKhwiq5abR1rjMk4h2sT7hxuH7kYIcGfvJN7hmIl
         NpU8ovDEiYsPvujSMsQdC+VSEnHHo6NzQ9P6VSmcpk1o7MKw4una5zLtHg4LcTLKAoVT
         sSLPHusPUK63ztodU6/MPaFHL/QX+dspXnSlTUtauT85SM/jfSP4YsWiMkOnJZZTmaU/
         W+f+S+roHE34myJIjQ+Nxd4+zc119g7+jpLtI5Yi6upYQnyGbh7XdXKG5mmSWX+n4F0a
         oA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947060; x=1735551860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY41yoAggnrpKZDOvMIy0+FhpPRF9QFn+bDK7HKPzWw=;
        b=oPCOKnXB7iTiVxwHdu23+a+qLZvoEFih1bzzpVw+WP48jARSdYl8h53k2kkQrSXTHU
         9oFBXIpWNrWEhacqjR9hmprodGLAJoYzbH4/4D5sn0BfgmZnciur4fdyD9VRhrH8kCjW
         CE6a75z0xHU0hI3F9705ESRqPQNiEwbZHejfwa1ELe05JwlH3Xlj9bkPWRby5LDAkGH0
         Kofiuv9x0cGOPE0Ylg/kad/xOfWZKgIQl/2iYbg+2TEeTsTrFmjLZMsVZbzcarYQgave
         9Ul+kTh3TGsjg5XBBBzhTL0S69J4zKpUXAH/bXCC0xOce4FTLWbnGCiOFQGLSqu4rFTc
         RPAw==
X-Forwarded-Encrypted: i=1; AJvYcCXw8rDsL3m51ATmQMqkorqWn7xygYMtCKAWATdyYo8vyj3C4NHuPs187xqi/hrD3dWS1VfdEJjIXKNb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6RoAHlqczQRcln5SUXEqWKt1S7KAmhjGSDdoEsE4WqhFY9kW2
	GPopSr7DzU2+yn6yxDqmikh/VbKgGsXqlVnq3cmSyz2lu9o8H5vinLfiW/mLCpw=
X-Gm-Gg: ASbGnct9bkX3TwqOV6FePS5CGZIhm3HB5V+vWSyyZ/mI9m02Qj0rlh7Zw3bkyW9PrnH
	PGHvCdjZdODsnRZFBxRhnEUZqi7PqipFQFbpk5jDIYF7JENDNlBO2h7PFDX2o86xKf9L5dSVEs2
	Rrn8/l/iqTfawvwvSzqzeOS3cATSVAShKJsTNBcJQ4DTxEhIo8nWZh3DIx6qtk6sX0d8dohfQAA
	4noFMQNDM+NX6IcsdJx64KjwMMbUlTzQUEPlYaqujYsb0OM/cz6uCQaGlymuuffsYuMGrWS3VoL
	grMvzV/QZKyvlTWLZ90uag==
X-Google-Smtp-Source: AGHT+IF7O/ZMCvOOtywTANPL1zwoTq06yXXDMhnBrPgrfov3E/r1DzhOhOYD8wImAojzeP7TdceoFw==
X-Received: by 2002:a05:6a21:3285:b0:1e1:aad7:d50d with SMTP id adf61e73a8af0-1e5e084b681mr22018514637.46.1734947059944;
        Mon, 23 Dec 2024 01:44:19 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:44:19 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
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
Subject: [PATCH v3 06/17] s390: pgtable: add statistics for PUD and P4D level page table
Date: Mon, 23 Dec 2024 17:40:52 +0800
Message-Id: <35be22a2b1666df729a9fc108c2da5cce266e4be.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
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


