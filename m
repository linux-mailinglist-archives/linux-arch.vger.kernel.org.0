Return-Path: <linux-arch+bounces-9462-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E9C9FAC2F
	for <lists+linux-arch@lfdr.de>; Mon, 23 Dec 2024 10:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D1F166D33
	for <lists+linux-arch@lfdr.de>; Mon, 23 Dec 2024 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031C194A45;
	Mon, 23 Dec 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ikFqkr6B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256A19342E
	for <linux-arch@vger.kernel.org>; Mon, 23 Dec 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947011; cv=none; b=b5df+LnDXllw0zUzUqNdI50Gp4HBkcm1T8coWqY8PkzC0+XAnWCiXuFBOJZbrgtKvV3g5pSFXat324m73F3Ikqpk8JtNt7rvNCS7vYF7jFURJJFqnvV8QgtKCaStCGf301SdsjIDyKjcS1AFFTyYC62xdO7z3Nn7eQA+h6TXJ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947011; c=relaxed/simple;
	bh=ju5DuzkKGwFmMyIwrlT1Lgl5SSQbM6pKt1IYE0Qmp1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HVsj82AGPKqy7CH+4m/uXs0zlMbylwMUD/q0ztIdRQH3psldfcnceg0Ykb0AgpFI+WvIQ6eQm3jqO2+a7DnOjrHhxKZbxhovtmLoDVXDz6GmQv6t42cw1uDbzwhwLru+dQOHBzja//o498xWGOleBZOV99+ycHmpAifxAN7J+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ikFqkr6B; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7292a83264eso3434480b3a.0
        for <linux-arch@vger.kernel.org>; Mon, 23 Dec 2024 01:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947009; x=1735551809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/tJ15+vmer/NbqXoUznjybhQp/MgC6GOdT/GuQUXpM=;
        b=ikFqkr6B0/3PS1wO+3Ey7F7j57aIAc5gjLbqDwTohFJrbACx++AluUPiHxN9uHBSQC
         IVPuuF6KnKEYEiKr/yQHxcdloQB5DmS29AvyvLbqeNU3NHLyX3a9I+gZbR15sRRD11He
         3WwSXngasVjY/nlqAjPJjwQfmR0c2XGTXEKlcXALQ5kf8ED99PA2Ayoi/O3MhrlmfPNn
         3D8gWkdGG66Ol9dqQ0sbt4gH8vLMHxGLBKAh+ZQlp5ldZC91qPk058gI+7dKBfDn/WE0
         E73kQOlr4lyiks0g4/4kKzB3pYIYnBkZGpw6tt/3pr2uNYDQk51eeBQEn8dRlp1a5OqM
         YufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947009; x=1735551809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/tJ15+vmer/NbqXoUznjybhQp/MgC6GOdT/GuQUXpM=;
        b=Zb++zkeISMLAG1SySNFWLA2bUUBQM+cU6PoLYDzD6+r/Jfq3Z+Jm32ePcjFJqnoUhk
         wGqwCMbZB9LYR+hCq3j7ug3zYtWyUg+Ep6rmSzpSlpA+opFXVpkGaNZCG9UDDxWjm2Tb
         EnSFRae/N+F1Oq/8hJwQ9lexJOekCGhdzTldqPU/K/p38c0j6nJ/zF3Gvy3ORIAfnG0m
         5ciELFBEvq/Y1tMUSMd9JzB4nrMx9rUUfCrSXA+uXUHO+oJ4DS+xSJU6Q8AprqV628qz
         NXC/Fidfk23A361UyPFb2hnuf7Yl1PK7kETtn4weeZG+eMN//l2k3V33tqr4hS244s0+
         YiAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgrwBAM/VgiKh1re6BmDGqtNy4X1gKW9Xi6WFablRnZ831kkpSFn1bZaYBjtBxGbdiGi2W7prHoXIk@vger.kernel.org
X-Gm-Message-State: AOJu0YxpGiWX03FTz2EZalFAVvPOssYDjr3yvfagW3JZK88mFiAMvZTb
	ZrfoHlohbBcewFppWqTJWyu3lXamNjUEMenUiOW5/GLH9DbFvQnysGQwD1VxkKc=
X-Gm-Gg: ASbGncs6afhh86lWzdJctp/u/MNVtXo6K9QIsKa8ye3xEW9cQeZ6lfJbs1hKniq45v8
	CS50U6l7E63UVjRlBmffvtrBX+ttyK/xdtb59pgUqnKWPFUm/ZynNeAx1NLLWkbtwahdyl25E3R
	H06PMOrz6vcfb8kllnZOpuy44aEWYJGibohVFNEfxX8IhfX0zCU41+oXwNMZayFM5txx5l0RNM4
	3S4Zt4xlS3GQKG8EuhjXcawiqOrkyNmmj898hiwls8Z6hEFacZt8Rdm0EEEXhUxwBmsTxpazZR4
	bcjiYMOQjvXaHpUJl0kW2Q==
X-Google-Smtp-Source: AGHT+IGn0WgNlH4n6jFU+xV15Lu8l6dnMV2FFWuW4zvXTMVJTCCaTT+ZxewqFKpQcJgKvmYU0RJrVw==
X-Received: by 2002:a05:6a00:35ca:b0:724:f86e:e3d9 with SMTP id d2e1a72fcca58-72abdecbdb4mr16058641b3a.14.1734947008718;
        Mon, 23 Dec 2024 01:43:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:43:28 -0800 (PST)
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
Subject: [PATCH v3 02/17] riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
Date: Mon, 23 Dec 2024 17:40:48 +0800
Message-Id: <84ddf857508b98a195a790bc6ff6ab8849b44633.1734945104.git.zhengqi.arch@bytedance.com>
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

From: Kevin Brodsky <kevin.brodsky@arm.com>

{pmd,pud,p4d}_alloc_one() is never called if the corresponding page
table level is folded, as {pmd,pud,p4d}_alloc() already does the
required check. We can therefore remove the runtime page table level
checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
the generic version, so we remove it altogether.

This is consistent with the way arm64 and x86 handle this situation
(runtime check in p4d_free() only).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index f52264304f772..8ad0bbe838a24 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -12,7 +12,6 @@
 #include <asm/tlb.h>
 
 #ifdef CONFIG_MMU
-#define __HAVE_ARCH_PUD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
@@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
 	}
 }
 
-#define pud_alloc_one pud_alloc_one
-static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	if (pgtable_l4_enabled)
-		return __pud_alloc_one(mm, addr);
-
-	return NULL;
-}
-
 #define pud_free pud_free
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
@@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 #define p4d_alloc_one p4d_alloc_one
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	if (pgtable_l5_enabled) {
-		gfp_t gfp = GFP_PGTABLE_USER;
-
-		if (mm == &init_mm)
-			gfp = GFP_PGTABLE_KERNEL;
-		return (p4d_t *)get_zeroed_page(gfp);
-	}
+	gfp_t gfp = GFP_PGTABLE_USER;
 
-	return NULL;
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	return (p4d_t *)get_zeroed_page(gfp);
 }
 
 static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
-- 
2.20.1


