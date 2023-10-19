Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C397CFC09
	for <lists+linux-arch@lfdr.de>; Thu, 19 Oct 2023 16:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346021AbjJSOGU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Oct 2023 10:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345906AbjJSOGS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Oct 2023 10:06:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D78130
        for <linux-arch@vger.kernel.org>; Thu, 19 Oct 2023 07:06:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32d9b507b00so5515208f8f.1
        for <linux-arch@vger.kernel.org>; Thu, 19 Oct 2023 07:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697724375; x=1698329175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwR/Ke20NAcUS81IhTmctZxyEuc+6gPtGwlWuG8Kglw=;
        b=cC1UDbLH7ixnvMUdBQ7wIbDKBxbypXS4GBX6klSsRfuokhgCNeU7qiwDNVzqCDjC99
         jt+A0QkyWWErARQdkwGxOAdCPR5sIjpIppUiRggDJgqRGZV1VDTYfpQ0RNVoZhtd4n4n
         PEmJkvmwWxppkbCLKFAXNhXN8AuXMn39KkVPvt6kfE4fFvMJRePv10rnvDP5C3iaXSMq
         sjj65LYF1AMEEHjLTCEtpTgyx3u16lV0PD1KIpUXPOJWOul7treYl3/SJLuRbwahnO1Q
         vGVbnYgxnqpk15spdroR3MBxp1MFe7jMugLdxFXoVCdVpEchdgFS1KHjo1hlzHsYMgWI
         PtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697724375; x=1698329175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwR/Ke20NAcUS81IhTmctZxyEuc+6gPtGwlWuG8Kglw=;
        b=tPxbRW27Sghg9oSpe+jssM43t+HniSIdP4CMsDLRl5zSF5eici9tBQPBt6ozMK4L8C
         BLmQ7kDNC/yrzm6ff22Aida5fzmMDg5JoNIHWbjuPtqTIK0kWH1/4WukVkxcGELVTQSE
         4mALbGWrjgaktLlknOoh9U339z9wYi+FbqvbCcQehsDo8ROYId80kqQfRapynMBPFi65
         GXfreB6oP2mA43F4FiMVeAYdht98bYfvSOuKHRCxSxK5nYfu3z3uE+4CiY2EStWAJDtO
         iB3hXTIeHOx/vHDtq8qctC00xNKTBh+N0Vzr23ET6iYJ8qD2yoiBvLD5hN/6hLlQmAhA
         TB2w==
X-Gm-Message-State: AOJu0YxZwtHflU6KBaO0jxU30WM5d2da2vtxN+BNZKYsIZdGFFA+SCPx
        /al372auvJ2tfDv84jpy0ZuJTg==
X-Google-Smtp-Source: AGHT+IEj56EYfD3VGGct58Hoxz0IsXjkWxjSdBpSEK26F7D/MeS2KrVfdBwf1rOZcSIiBfUvUcP6qg==
X-Received: by 2002:a5d:6e0b:0:b0:32d:8505:b9d7 with SMTP id h11-20020a5d6e0b000000b0032d8505b9d7mr1610093wrz.43.1697724374647;
        Thu, 19 Oct 2023 07:06:14 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d514b000000b0032db4825495sm4572197wrt.22.2023.10.19.07.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:06:14 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 4/4] riscv: Improve flush_tlb_kernel_range()
Date:   Thu, 19 Oct 2023 16:01:51 +0200
Message-Id: <20231019140151.21629-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019140151.21629-1-alexghiti@rivosinc.com>
References: <20231019140151.21629-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This function used to simply flush the whole tlb of all harts, be more
subtile and try to only flush the range.

The problem is that we can only use PAGE_SIZE as stride since we don't know
the size of the underlying mapping and then this function will be improved
only if the size of the region to flush is < threshold * PAGE_SIZE.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # On RZ/Five SMARC
---
 arch/riscv/include/asm/tlbflush.h | 11 ++++++-----
 arch/riscv/mm/tlbflush.c          | 33 ++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 170a49c531c6..8f3418c5f172 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -40,6 +40,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end);
+void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
@@ -56,15 +57,15 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 	local_flush_tlb_all();
 }
 
-#define flush_tlb_mm(mm) flush_tlb_all()
-#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
-#endif /* !CONFIG_SMP || !CONFIG_MMU */
-
 /* Flush a range of kernel pages */
 static inline void flush_tlb_kernel_range(unsigned long start,
 	unsigned long end)
 {
-	flush_tlb_all();
+	local_flush_tlb_all();
 }
 
+#define flush_tlb_mm(mm) flush_tlb_all()
+#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
+#endif /* !CONFIG_SMP || !CONFIG_MMU */
+
 #endif /* _ASM_RISCV_TLBFLUSH_H */
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index c27ba720e35f..7e182f2bc0ab 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -97,19 +97,27 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 			      unsigned long size, unsigned long stride)
 {
 	struct flush_tlb_range_data ftd;
-	struct cpumask *cmask = mm_cpumask(mm);
+	struct cpumask *cmask, full_cmask;
 	unsigned long asid = FLUSH_TLB_NO_ASID;
-	unsigned int cpuid;
 	bool broadcast;
 
-	if (cpumask_empty(cmask))
-		return;
+	if (mm) {
+		unsigned int cpuid;
+
+		cmask = mm_cpumask(mm);
+		if (cpumask_empty(cmask))
+			return;
 
-	cpuid = get_cpu();
-	/* check if the tlbflush needs to be sent to other CPUs */
-	broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
+		cpuid = get_cpu();
+		/* check if the tlbflush needs to be sent to other CPUs */
+		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
+	} else {
+		cpumask_setall(&full_cmask);
+		cmask = &full_cmask;
+		broadcast = true;
+	}
 
-	if (static_branch_unlikely(&use_asid_allocator))
+	if (static_branch_unlikely(&use_asid_allocator) && mm)
 		asid = atomic_long_read(&mm->context.id) & asid_mask;
 
 	if (broadcast) {
@@ -128,7 +136,8 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 		local_flush_tlb_range_asid(start, size, stride, asid);
 	}
 
-	put_cpu();
+	if (mm)
+		put_cpu();
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
@@ -181,6 +190,12 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
 }
+
+void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	__flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
-- 
2.39.2

