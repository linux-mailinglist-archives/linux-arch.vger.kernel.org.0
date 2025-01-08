Return-Path: <linux-arch+bounces-9640-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E2FA0540D
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 08:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DED3A5508
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 07:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2B21E0B96;
	Wed,  8 Jan 2025 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TbTLzel2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B11ABEA1
	for <linux-arch@vger.kernel.org>; Wed,  8 Jan 2025 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319745; cv=none; b=ONXe/rP3nFlWTV7UL8b85fmY5F825FP8SiYUBez/b7QGxuYnRO8Q6X0bEXZDXSGWeP6+dt/TK95e/RxpjVgs9MzYuvaK0WkFWbGMl3LZzxzpRynCSPmnzTJY10T4ruNg5YGwpPIwCvFvw034Got4rSMRGGk1aJOTfA6lPLsG8gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319745; c=relaxed/simple;
	bh=mRvQQIHi+4LQZG1SlLZU2M6iRiMg420TF1JW/rjWMH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c2Y2zcLDr0c2GWXA03LPLZBmJCNqDL9ABYL2jgHAMjuUwN/c2kVGKgZ/K3pDwW+t4ds6/XgKBLkPC1uwODEqugzwBO5kquXhKWleFr6coSiabc8GpKJeL1CWkaaPa/nwzxZ+LE5o5+qy372Wmi82Z37kWxD3nOlY6DMXAeRUNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TbTLzel2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso833501a91.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Jan 2025 23:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319742; x=1736924542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRkfj+TNyCYVuLoiDWLKznOk7pFXzbzTll42IhJYX5s=;
        b=TbTLzel2ez/j6B2xHXZtXIzj5+Ccj4K+825gfLGpFCgBQYFHgC1dfLx+V1JaXUz29H
         5aQRDq6Bo07uJOg2g0jG4PnWMcFwqq1xe63rPDEfLzrQJVBp1qab07GwOVFJYlUbTw0O
         MaQsnN9R7d/6h1/Fss1ltLZjwV+ujZGU07MyOx1EkfEUV0FlG7ShL08Uurx01Bto7lo0
         zfFpDsOMF4XSOrTySbUrUdudYbxreEfsyL9y+eNVMA0AvZ+9Ay50LqrcHa2zgJiNgyiw
         6sUAIeSzb/fGiqcE6/9jfEGiK4S/ZPsacJ07L7oXE15M470Foecqv0JPvRDryS27WQQO
         ko3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319742; x=1736924542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRkfj+TNyCYVuLoiDWLKznOk7pFXzbzTll42IhJYX5s=;
        b=YuQqlNeMJaU548qb+5NLqMTtxCh+3C4MY33voUO5wkSEou8t+dHOSdHD/HOl3qFVsl
         P98aelD/x3VtrRQXkijUfZT8BpXqiZl/XFNW3svSrX5hZKkc3VLaKckHWe7U/fjeU2VN
         aV/aUxC/ys24FrzKrA1Bc2niLp8LgBHAw+OTGOHk+j9o9f2sQJdU3SgvgxgoIyQ0hvGB
         IsMcUHvHOsRby3IYIgEfo1mw4WMi1lHI15y4Iueur9Ou6swvgCbGTwPl+o+qwrlxkjyO
         FXpKfa+ulFynZsWCxu1RJ7AhYExVAplNHkaCsqp2nmpuvdSDF2rm4PBmn1SUFGemV47X
         DsIw==
X-Forwarded-Encrypted: i=1; AJvYcCVasANhXtTpF294omSxMQIWQhxeajLS8gh8n8kMWmcCMpzSZ1WBbm61QF1IimtcSWPMGNzhE9JzfCV+@vger.kernel.org
X-Gm-Message-State: AOJu0YyThnEGu3rEv4eIxpOgSKi0FXKSDsiqnK13oKYbYwxt666gBqr7
	uEC9LO4mQvpPvKDv++nxjRx0uGX33ARfZuYWh7wjDpWKUgvvsH9e2wYB+QdUBl4=
X-Gm-Gg: ASbGncva1Y+2JKnBYwzzkTY+/KsfqN6hebLm1vscTFP0HxbuWXHznGH1lQxEF6YIjC3
	+ToXrdk2PHHmstkaelIRFG7nDwnqQCTlZnLGPBw46benOLfeS0vwAyNUSDeTiWVNzcJi4J1zFvs
	9g2UdOkBuAVMThlqzNH2ASr9NXtRcgdf+I5ll2Iy6vbQkfzjXsRkadvdE/b3t9+aZF28YkG2Anu
	G6dAf5WBe6TKgz3LNrmUerSJWJnV/TBCJwA1NK/kDTKNdT18+pfUW5aSCZvBsKD5vAgPukTPro9
	ddqtmWHQmXKE8ZnrLqWcPHvRN0c=
X-Google-Smtp-Source: AGHT+IEyar1kSnzqQimnz8qjA8akoGYyLgYubsk1qekCNbk2Sp0If2dwICCDFtvO4jCrehuyEyMuwg==
X-Received: by 2002:a17:90a:dfc4:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-2f548602842mr3182102a91.8.1736319741885;
        Tue, 07 Jan 2025 23:02:21 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:02:21 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	alex@ghiti.fr,
	andreas@gaisler.com,
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
Subject: [PATCH v5 12/17] x86: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Wed,  8 Jan 2025 14:57:28 +0800
Message-Id: <27b3cdc8786bebd4f748380bf82f796482718504.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: x86@kernel.org
---
 arch/x86/include/asm/tlb.h |  1 +
 arch/x86/kernel/paravirt.c |  1 +
 arch/x86/mm/pgtable.c      | 16 ++++------------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 680ec3d47915a..f64730be5ad67 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -33,6 +33,7 @@ static inline void __tlb_remove_table(void *table)
 {
 	struct ptdesc *ptdesc = (struct ptdesc *)table;
 
+	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index dc1ab9301d2c6..1ccaa3397a670 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -64,6 +64,7 @@ static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
 	struct ptdesc *ptdesc = (struct ptdesc *)table;
 
+	pagetable_dtor(ptdesc);
 	tlb_remove_page(tlb, ptdesc_page(ptdesc));
 }
 #else
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f9516024cbe5d..c02aa0427a6a5 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -25,6 +25,7 @@ void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
 	struct ptdesc *ptdesc = (struct ptdesc *)table;
 
+	pagetable_dtor(ptdesc);
 	tlb_remove_page(tlb, ptdesc_page(ptdesc));
 }
 #else
@@ -62,7 +63,6 @@ early_param("userpte", setup_userpte);
 
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
-	pagetable_dtor(page_ptdesc(pte));
 	paravirt_release_pte(page_to_pfn(pte));
 	paravirt_tlb_remove_table(tlb, page_ptdesc(pte));
 }
@@ -70,7 +70,6 @@ void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 #if CONFIG_PGTABLE_LEVELS > 2
 void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 	paravirt_release_pmd(__pa(pmd) >> PAGE_SHIFT);
 	/*
 	 * NOTE! For PAE, any changes to the top page-directory-pointer-table
@@ -79,28 +78,21 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
-	pagetable_dtor(ptdesc);
-	paravirt_tlb_remove_table(tlb, ptdesc);
+	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pmd));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
-
-	pagetable_dtor(ptdesc);
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
-	paravirt_tlb_remove_table(tlb, ptdesc);
+	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pud));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
-
-	pagetable_dtor(ptdesc);
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
-	paravirt_tlb_remove_table(tlb, ptdesc);
+	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(p4d));
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
 #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
-- 
2.20.1


