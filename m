Return-Path: <linux-arch+bounces-9630-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E24A05390
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 07:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149DD16603B
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 06:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FAF1A9B5C;
	Wed,  8 Jan 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lkjsf6mt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EFF1A9B3B
	for <linux-arch@vger.kernel.org>; Wed,  8 Jan 2025 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319589; cv=none; b=KUBm9DFp9ro+iqFp6cR5939BUuV2eaQaF40DJN+n1YHRjdDyEfchBflY6qPlXqhU9JVFvqm3Lm71v4N0LCmwSHcpIXpL/5aHhP5HnzYaYQoCKtb3u9v1dq2mIq023015flSUIZbILdG8ml1XwJJUV5kAXHSrrI3atadcqPZVZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319589; c=relaxed/simple;
	bh=ma5h64nM92pGVw8WsUJDDYGPNfXZFgLftucZEsbzZpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jYOXlyMFgcIiU+eoRHtU4nBb/Nqt0QNP+kL7RdC5vjQmnfp8zuKL+Ry0WliAHEYg34Zsl4OJ5dz+PcjUwAEt4lJPm2FjXnx5gcROpWBI0bg6Z0as8sr1qDIj9Wfrxq9uR+k4zTQB2EqEn5ue7wW80kav+uiIR9zFN72T4e3EqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lkjsf6mt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2167141dfa1so9476785ad.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Jan 2025 22:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319586; x=1736924386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgpljFzcR37DW+k0izImY02NXJU+2N4CamZhPf6BMmU=;
        b=lkjsf6mtx7iieDBNQgHtDsNwfH81+Ahx5znscEAY+uMyGeqVwDbxKilg3fHzJFKf7m
         yyZZ7rtjWp0OBVs0551xO1oX49k2Oy9EQMjn5paprIo8V/l6Yy5iT6s9+oCibH4HIooX
         31HtOM0khddPN9cF0IM7JQ96jiBOW7NVDLoFWud+rNan94G1yv//xmjhloxmIF8XRxhm
         AEouloJS4x6ju49vfHa+FORb2R7BT80AgfdZjVlEvUA4SMjvzUUAK93CguXuZ6a55P1A
         ZALeoJVB36ib9+/NtHSGuMIWrm0PG9Xjbzz1sB9Ynbww8v5X85/P8EQZcFSLqhbymKos
         VSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319586; x=1736924386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgpljFzcR37DW+k0izImY02NXJU+2N4CamZhPf6BMmU=;
        b=HLzSGn13uMOAXYEvtX9OFVDLmD6tJg1riqejlbJlDuvZ6LnRbLeERW4qzAYVL5nX47
         2P7AxP/bVrbi4hC5GyH58NyceTU6bNxyCZnIQ73mHDs57kww8D8QGFTPAMlqKNYOXFj5
         Sk867VOjXIx1dEgIPVWwyPAWmaTPgdI+7ZfIueiqRHTEWBVKzX45YFnAo0pd7xh5F1ty
         Y7nyNQIUieMQ7HiRyPvHpY6CUW8wMBdw1IbqpiYXWCQv7wgmYHJfBt2JX43EKh/x+dXC
         FElFdtTh36qSnGwVxtk0rtp9Sn3D3i9D8pMK3Q86F4V7EkmiBNNtuOJ8TARRLTwBL8MD
         CTrA==
X-Forwarded-Encrypted: i=1; AJvYcCXCnvcZjRz4veamW8TTYFC/6NrABMl0co1oWJ0K8dQnlFaNhkpKeTvGNlWHjWbpMlPTy9AA5wgyj/+X@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJbI11ga06oaOkU+t8uWsJgQoQ1NBGAjBdjfVMMZi4QAI/JTH
	+CRryAkZ0rzc49zP9sllAtIi8PG3GVolInK6Wcxc3ViQMUMXomdg1f0fQiKVpOo=
X-Gm-Gg: ASbGncsFahe9GFUIFwgk6jfbh5hih9CT6+BOd924LGzSbKsgQ5+tWxzlGi8CVJGYgJM
	ill86a2/wCLknYQsiu/oqUdqBBwphuI7EWdsjUmUzlqhpLBLVxKFqrc3rSGIVYIps27oZfl4vNO
	JJXHODZIdAafENSu82txTeBPzmEX+IbOWqUn2BnVFCc+7Meo/t+UIWR8gptRhMcMa28hwYKJk5z
	ld760/A1/fHc5VByPbfQmm/vkXzSrTFeFQlIxr4outCnIOZGFSguf7BWHlLYFm66fuOC/VHY8Kw
	BvNoB7CFUxaTWm65Fwn+SRU9mAI=
X-Google-Smtp-Source: AGHT+IEXmx6aGyXUatDDUSC3BIwwvJRBe2xxgGmNdG6bwRG2a4u7PgHO01+qr8GDOf9tBGHx3RRkKg==
X-Received: by 2002:a17:902:fc4d:b0:216:5db1:5dc1 with SMTP id d9443c01a7336-21a83bb9991mr32206305ad.1.1736319586298;
        Tue, 07 Jan 2025 22:59:46 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.22.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 22:59:45 -0800 (PST)
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
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 02/17] riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
Date: Wed,  8 Jan 2025 14:57:18 +0800
Message-Id: <93a1c6bddc0ded9f1a9f15658c1e4af5c93d1194.1736317725.git.zhengqi.arch@bytedance.com>
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

From: Kevin Brodsky <kevin.brodsky@arm.com>

{pmd,pud,p4d}_alloc_one() is never called if the corresponding page
table level is folded, as {pmd,pud,p4d}_alloc() already does the
required check. We can therefore remove the runtime page table level
checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
the generic version, so we remove it altogether.

This is consistent with the way arm64 and x86 handle this situation
(runtime check in p4d_free() only).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
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


