Return-Path: <linux-arch+bounces-9544-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C799FE491
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2024 10:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E32618822E9
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2024 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E0F1A2547;
	Mon, 30 Dec 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CbvM39v8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD61A76AC
	for <linux-arch@vger.kernel.org>; Mon, 30 Dec 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549873; cv=none; b=oZeWOJ5jg9wTsEe+QR6EhvO3OHktbyp93TYQhb+52NBoqZ7ix4pXWhTvRxSYfAEIVddJbCahr05fGKmu8Nvu0FlSrTAoZEz9tN6mrXxRguXBlXuaokKSQVHqk1Fha8ANjuZLu9OP++rjadiu510Lf0XF7CdljBn1zTeDCMDDg74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549873; c=relaxed/simple;
	bh=ySnIl2i3Fo/t1YN/rcwyhGqxWwlx1TNUJRz33ZWxlkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUV+XNVw1IL81IhnrtiemZe7c/f5qCdF+EsPq29fHYcexPNki0XyIowFMWsv3Nfrae+8mORWCI2oA15NUW+KB0vVnWFhnQpfxTr6/D3V1hZKgMYkiQfXaMca2TvOPWHzwCQ0/r36EYEl3fTpBia0gcC/+miylwW0LMK7C07S02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CbvM39v8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21675fd60feso153837625ad.2
        for <linux-arch@vger.kernel.org>; Mon, 30 Dec 2024 01:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549870; x=1736154670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyEzElX2/Cl2Hb0vACePBo9dDp7jwROhL3d0Mq9f7ig=;
        b=CbvM39v8DSxX3gTbaGPkNFXL2gTwNFbnSvW9hMdWzoZdSAtW4hbM7cGR3bLAME+DTg
         eLqPZxIF/CeaTOx8hjA0ITXh4+xGxzfJzxuRHVzPc5Ap2qf00l4doFQn5sAjWsiVzYuu
         gxk5PCTQ/K8GFKmxsi4rbVYXXE/QXdE1bbaZzuxLrh/Tgo1c3W5H0qNOca4nTF8TS4t5
         LkCaPMhQtv3BdNeDF9l6NsVnG/1Gz7Bcky/2IBBDRGbanH5Hqdn2K2xkBn44LLuhyTlV
         Z5d+lDOSE2Oq+ggPmtp7yE6VfDvavDoBoJfe7XHWBEWbvnm0PspH8WikEnP7tCpj5j0V
         6kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549870; x=1736154670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyEzElX2/Cl2Hb0vACePBo9dDp7jwROhL3d0Mq9f7ig=;
        b=px3KeQGoFHTHJVVOhPTfgDqincYkv1psqFLowJ14ASuzDF2IASle4kMHmaqNPM94ZV
         /7XHQhSWGBugyxlspNVWYJ1lonWfLewwtavmGyniinh2DlqZJ3ZHr2fOb/hZUbgtgePT
         xPG1fxl9kNgoB83n8t0g9+lkStcP5oXjzFOXn37HVykpTylJzHa3LrsqurxRBWAYG04F
         6alcYBv5t1fWTjmlUFk/adlBMutqXY1j8jWtWVCQocoLQ8iVGO9BnQ+eLDKBquvEvpHd
         kXrvBEkYWSX/MOt0wtTBgUqaF4A/q0cIcCfrVWuI/5Mx2RoNr3PeCl5nTDSUtsS3h6JD
         7org==
X-Forwarded-Encrypted: i=1; AJvYcCX7uSA0kYLGAL4hGbbDfIELLV5wrKxGzKgo8IWKhKhMt1IyWpEtW+LE46X1LnDrWavalvRs8QCL33or@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02bKsdtoBw1d++vVL6kLw0f5iCznMmAg8ouBGRKYr0nq9Uces
	skmg7xIZdQ8IrkEaDDdS9u0u5KdUJoXzw+lGpXoqPKVkX5X/pFX8pTCGqKJeT1w=
X-Gm-Gg: ASbGncv+LtJd4Xa6LRYSl8dpizWeiZPxBtNP4O0Bx6USW4D+gTjQDTWfebCCPr98oYj
	L4TRUFpyAiThoL+QMYT0ZPYxmCru1AunXQ/JiFEba+FiztJwKODjN4T83fWm8ts75CttK+jBeFz
	Cf0WHSeD+FB8a/QUPQG8ojnF0vGJx0XuKh+7GWh8pDNSunz51aV4As/NlmxsdT+k0TYU+ZfqwAT
	bu0ng/0RwrGK9hJ48Ldd9PCuuaTJ/TdUnSzhPRgwPXAUV0F/rU+kz+cRMz7eXC1VkEmFxuPrrKK
	NlnvXBd4KB57vhOIQx+Ijw==
X-Google-Smtp-Source: AGHT+IHPMMlkiFtH678yJhisFXpRpeLbEmYMWQPlXwvGfvt1NUv1TR7XGzXk5FcrgJpzIcDaQ0LX6w==
X-Received: by 2002:a05:6a20:7351:b0:1e0:cadd:f670 with SMTP id adf61e73a8af0-1e5e044c8ebmr53183808637.5.1735549869780;
        Mon, 30 Dec 2024 01:11:09 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:11:09 -0800 (PST)
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
Subject: [PATCH v4 12/15] s390: pgtable: also move pagetable_dtor() of PxD to __tlb_remove_table()
Date: Mon, 30 Dec 2024 17:07:47 +0800
Message-Id: <ad21b9392096336cf15aee46f68f9989a9cf877e.1735549103.git.zhengqi.arch@bytedance.com>
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

To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
PMD|PUD|P4D to __tlb_remove_table().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/tlb.h |  3 ---
 arch/s390/mm/pgalloc.c      | 14 ++++----------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 74b6fba4c2ee3..79df7c0932c56 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -102,7 +102,6 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 {
 	if (mm_pmd_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(pmd));
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
@@ -122,7 +121,6 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 {
 	if (mm_pud_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(pud));
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_p4ds = 1;
@@ -141,7 +139,6 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 {
 	if (mm_p4d_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(p4d));
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 569de24d33761..c73b89811a264 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -180,7 +180,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	return table;
 }
 
-static void pagetable_pte_dtor_free(struct ptdesc *ptdesc)
+static void pagetable_dtor_free(struct ptdesc *ptdesc)
 {
 	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
@@ -190,20 +190,14 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
 
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 void __tlb_remove_table(void *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
-	struct page *page = ptdesc_page(ptdesc);
 
-	if (compound_order(page) == CRST_ALLOC_ORDER) {
-		/* pmd, pud, or p4d */
-		pagetable_free(ptdesc);
-		return;
-	}
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -211,7 +205,7 @@ static void pte_free_now(struct rcu_head *head)
 {
 	struct ptdesc *ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
 
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
-- 
2.20.1


