Return-Path: <linux-arch+bounces-9637-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6B1A053F0
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 08:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FEF3A3A2E
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 07:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F431AAA15;
	Wed,  8 Jan 2025 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L8ZxJxdm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5EE1A23BF
	for <linux-arch@vger.kernel.org>; Wed,  8 Jan 2025 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319697; cv=none; b=BATPMuD6v6UufZq53sqR8Cdq9WLNsUEFp4gdsMcodZxTaWMHNr6rG3fqyb5uIKVPfhGSPor6JdDlWK/RXqnrXjZRAyn4efXZhqzWyp+HtaG28K7YVqK1GQqZ+3AmROzf0MZuxC1VU1iNj4VwZ0acsX4awe7Ve0dAl8ySo5TmR3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319697; c=relaxed/simple;
	bh=kKEIUjlBJNltvHAujR36Eou/m03YkuA8sY1cVhwRw1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNaOdHr0bxM1nWlOF+90uWvuW6E3M4zUDa+dvfJCp3AHACwtSuVIUdy/M8zepX6L5DbjLylSZYWGUxVRQsBUGNDdFeRHECd6DO2eIvdoHfx/eNMUw5bI6dCDHQ2nuggb4Ws9QMycdWuoPh7txRW6JhUVYvWg5JHxac5rUQEjcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L8ZxJxdm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21680814d42so205554835ad.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Jan 2025 23:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319695; x=1736924495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOmYFC5rDCHPndkDeYhMazAtFRSG5eQpr+EJP/iMn+M=;
        b=L8ZxJxdmY6LNQI27QQGrNiHhtgxy/3FYuT66k5rt7mBuNf3HimMV/K2x3UjXSqzB1F
         priRkl2qgbkp0jS1msuRSsPs81zcmwZH2DNPzltbq78j5MJfhGtInl7UEZn26SVu72KG
         oh8dvuGze25QJXFrKmhuxnH8zLIUvHVxDl0RZy2lrl3Qlv5eM2HoQTfxXi1UmVUiAbS9
         hUieP8dEztNcCY2yCtCRlyvQz+m9HOxLvv9EkZkKAEsX7VOZ5ebMF1bNf8sCPrc6xjmS
         5j6wPMG5cftqmF1FC1uCahcnrkx5dLyY7TpJdJhVqUBCJ4vsQNbZsmaC5S+YDYz8XfqT
         RE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319695; x=1736924495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOmYFC5rDCHPndkDeYhMazAtFRSG5eQpr+EJP/iMn+M=;
        b=PxyEINN8bt08qnext8J9dfTfTrK3rnxab8Tgx3t0t7O1m04bQi0/icZSwn3ff3aFII
         75MhLruJxWx3LZzRDddsfmmq+WFylKF3GMi1ZyluHe/q/HUSypiB6p6MFK5hLq828Qr+
         PUHWA6tfcUHX+O2mKopigx2X71UqHg50s0aDmt5aWOv71FtZNJCZpJrjfMLHJyHDpzlk
         d9XG8DD6DiuLiwDhOZO5UeqMJD7tmeGsPZRSpt2p44pAronKLXaVeRAjhkE9Zw36uoGb
         C/YeCyRv1DvxHalnqTU0MpWRuRTNyY2pLrvSkWQRKhSX9pF0+5JZWQMvw/uzAjQ43/NP
         tfGA==
X-Forwarded-Encrypted: i=1; AJvYcCUkwaEEbMxwrGyejN2nDRl4Ri2LCN2b+KI0RSJwegFwmPlFXL6L0KCAM3jZYWqKNSEf4NoUcv8JgJUL@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ7CK+zynIqFvdRVZSLrxjL5FrFg2zWV/oB87G4T50bWP4lh6O
	sS2tjvGFG9rH7jus3+bP+AQ/VKKnQLmcOlkQeOVRZnqfGBlDjgiMfxhRUcE+yZk=
X-Gm-Gg: ASbGncvK21vOD/yv/raXX2URyVqNPjm+D3JdnnfL5inVsUlmW7QOa4Aia/ROPhv2Lo3
	zs5ZPG0jn3K/YMX/UvQYwh4qHJu6GL8OEoNyuquQBkKz7cwG/chgGfyi45FVqMc03YkLV5KDViA
	kO0cEQgO09Yhqf7mejdPzIP5L+SRkLnyUdLl5EsOQlpCVnGjDbrD2ePsU3vmy/P9NE9p3X5ybi8
	Yxh9YYm0q0KfKVZGEhvq3d+hh83+t5r6vBg4/UltwXhXuVH2WP15B7ff20wSgBD1KNMQwxRlBc/
	ZCzW+/B1G8mTppyffycaCcHd6bg=
X-Google-Smtp-Source: AGHT+IG2O0LK8ylHfVSG3OwO7HgAN7h4l7Hu7AhiZODZJ2StNi5+XwyqKLd4EhZPQDdK0Gl46ps1VQ==
X-Received: by 2002:a17:902:d50d:b0:215:7421:27c with SMTP id d9443c01a7336-21a83f696a9mr29561025ad.29.1736319695027;
        Tue, 07 Jan 2025 23:01:35 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:01:34 -0800 (PST)
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
Subject: [PATCH v5 09/17] arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Wed,  8 Jan 2025 14:57:25 +0800
Message-Id: <cf4b847caf390f96a3e3d534dacb2c174e16c154.1736317725.git.zhengqi.arch@bytedance.com>
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

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/tlb.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 408d0f36a8a8f..93591a80b5bfb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -9,11 +9,13 @@
 #define __ASM_TLB_H
 
 #include <linux/pagemap.h>
-#include <linux/swap.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #define tlb_flush tlb_flush
@@ -82,7 +84,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 
@@ -92,7 +93,6 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -106,7 +106,6 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 	if (!pgtable_l4_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -120,7 +119,6 @@ static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
 	if (!pgtable_l5_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
-- 
2.20.1


