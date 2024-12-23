Return-Path: <linux-arch+bounces-9468-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F319FAC78
	for <lists+linux-arch@lfdr.de>; Mon, 23 Dec 2024 10:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4161166ED7
	for <lists+linux-arch@lfdr.de>; Mon, 23 Dec 2024 09:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0781A3AB9;
	Mon, 23 Dec 2024 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WQBEl3A+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9301A4F21
	for <linux-arch@vger.kernel.org>; Mon, 23 Dec 2024 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947088; cv=none; b=DWFEO67/5VkvsTj8E80dFVztmD6cRwIFWI2JaEAUkOK5y41BhezjQ1nT1xLLANj2PervpLrILcU9a3UTey8D9SFjSlESxuNge5DaRkDfLziT0IquDNZfvAu7PxA+wVy9H0hoZV5FMEb/NhkvhnDjYJwX55GHpvaMM63tASP69hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947088; c=relaxed/simple;
	bh=H/x1u07M3HXF9oVd+o3reuerQgd2pca8MMjlY49GFUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nIZ5W54iIzOb9ktLFnwrmJQub7NrTJi++dAAMjiAUZKs9zfOw7AGtHOWjOKloWPOL2epqYzPTBmwFmOPEtYW9lEDVTJz5WQ1ixQraUtixztFtCZZDL/BjOQRoPczNy+YA8VGuJIttIx/LXCCVFSbe8bbMDrZJkXIHPQ5N6KskXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WQBEl3A+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728e729562fso3163935b3a.0
        for <linux-arch@vger.kernel.org>; Mon, 23 Dec 2024 01:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947085; x=1735551885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA0mhWnXo6upWemI3POPEc6VJyAkyxFJggkOB6WNq2k=;
        b=WQBEl3A+mEOA3b5ceCxp8meUWkNWxaDq19onO6zzpsw8B6C1H7Mv2ClbIVM+aXCijy
         8OdVyNWPGfWsgQBZ3xX19CbOpxwNzVFXM1mZmPUCeJtUtlONy5pB0Tis1opn9oEk6a1r
         LyGcy0HD41FxpYv1jLY82v3cmHLPWej9P9aUI++2iOOLA3zpR5pzBf8t6XlrD3ay3qCO
         VxtSuWlhTz+SqOOdzMiIR046vfUShNoCt9H7Bgxdtps5fHUvcbGkXoY+LflF8sk2gvio
         6UhUH25G6Fb4mB2mTaOMD+F5eDM8prZVqjQ7uojLmx6dIG/mjzSEck4qD3ZQWVKIBaOz
         jt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947085; x=1735551885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA0mhWnXo6upWemI3POPEc6VJyAkyxFJggkOB6WNq2k=;
        b=OQstNwHCMZTbdePkv5D2R2UQqNmjx3YYdOG7mbxq4mkFa2VFZe8uierwxgKHgFtI4o
         beMVOXd2YaOz3dz/c/wCBOhPkyOwtiFeRw0HdYfuYCnJ1hIyZFigWTTuGc0C6x72QOUV
         TzttKohU1uRgXDc/h936wghLArYQBdM4JPO0RhwZQuc+b4pNfOrqKfqNTzQHt4I8iy2f
         uoAcj07477zHnz5ux6C5G0OehpWyHpMLF+qMHnEP194zY2VpelLJidB3esUZ+w0T2t8t
         EKyEZlDglvyMFW6SxnkrF3WI6At6OAvrflepdQzjyC4X87KsuW+MqpTEPdxOi4Rk5sqs
         zaSA==
X-Forwarded-Encrypted: i=1; AJvYcCX7auNOPSVoBHJ/j2OsKvAULsanp6kp+yUGpTdKxLADP5w+YFvM4uaB7kQDfHjAxIaC7hslm+pitlGI@vger.kernel.org
X-Gm-Message-State: AOJu0YxBPmsXpwySpE1KHOtPIks5yWhAKlePrp4hlfkI9YtM92cGcYW3
	xJciNk3zninkKr0QUjKAkrYa5nHPoMkcYXFXHBSHbNZ2iXDrUExqLbayC0FtwNE=
X-Gm-Gg: ASbGncvR+m9e9svNRpvMSMh0QrA4rDBX3T7+VaRqORhAEGr5UD/5065Rwjwt8dr5Cal
	cEf6HqMWX84ec4XcHaI55/XjW9jgaVcoankMffh0DHvOsa5S9CCZJxM1DFXCPUNwcLguEwma8Qb
	9xrQ+prKTQNP9K3FOcD0QcLUYDqGoqTYY1CEOAVdpfMjLX7jOUg3jCjGGHw5IVB0C3zUpORIAZn
	mtoo9JjnVKi2YaZrmeV4YOHhDTnfYDcvPU7XI+3lvfJSwwGxpRgSYELkCo38HnTDNSu5+cN6oWE
	3AXcusAfEabC0oebYOhYcw==
X-Google-Smtp-Source: AGHT+IEwnxNRxjpY566VNLJW6lRIrSoOOApqv/9DKS3yUbVNE+/391+nOnqyFIwO+T3gR5XgQach6A==
X-Received: by 2002:a05:6a00:330b:b0:728:e382:5f14 with SMTP id d2e1a72fcca58-72abdd7bae3mr14443469b3a.9.1734947085429;
        Mon, 23 Dec 2024 01:44:45 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:44:45 -0800 (PST)
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
Subject: [PATCH v3 08/17] arm: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 23 Dec 2024 17:40:54 +0800
Message-Id: <955162bfbbcd9fbb3b074e1fe2aef4f64b61d6f9.1734945104.git.zhengqi.arch@bytedance.com>
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

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/tlb.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index ef79bf1e8563f..264ab635e807a 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -26,12 +26,14 @@
 
 #else /* !CONFIG_MMU */
 
-#include <linux/swap.h>
 #include <asm/tlbflush.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #include <asm-generic/tlb.h>
@@ -41,8 +43,6 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
-
 #ifndef CONFIG_ARM_LPAE
 	/*
 	 * With the classic ARM MMU, a pte page has two corresponding pmd
@@ -61,7 +61,6 @@ __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
 #ifdef CONFIG_ARM_LPAE
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 #endif
 }
-- 
2.20.1


