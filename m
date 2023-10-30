Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CC47DBAD6
	for <lists+linux-arch@lfdr.de>; Mon, 30 Oct 2023 14:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjJ3NdM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Oct 2023 09:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjJ3NdL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Oct 2023 09:33:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565C9E1
        for <linux-arch@vger.kernel.org>; Mon, 30 Oct 2023 06:33:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32db8924201so2819180f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 30 Oct 2023 06:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698672785; x=1699277585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg+2phEYGkxNvU/hCz5W3gC6On0lJ4QhzztTYgaxDUQ=;
        b=uuNNzHQoKgD5NwI1onlSZf3WTlI0fbh7854f+ntOj37FiJusZeuUMufEMf2YvWNngS
         hvvffsfO3j5+FSAUwtMmQYRTF9DMVR/bLqe/HpUXj/x+aHcUysIt/LPDyD7GjWK8/JRQ
         lObeGoZAk8EKI143cz0ltFbApfq82618xHxj7tUZfEYSC0DgwWfB1RWIU23jg5eqt8JI
         nPEe9QJ7Txe1F32QrpDPtb1eyyKPOsjkGNf+K5PhMNhSc11trYjL33rRkTm8J5NetVrR
         j9WT7EmJ7rvvTQwq31TJsR14nmKggfLT6Z0O/rV9/VjLgihPv21jaUxs0XNGCpYQYLvC
         y//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698672785; x=1699277585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg+2phEYGkxNvU/hCz5W3gC6On0lJ4QhzztTYgaxDUQ=;
        b=gLFdNjUsxCQAJFLV5CHJJNH+5pT4ZslFPr2gDnJFWV/8GajnLAWJxGUmyFq5Yd05hA
         PATGQI0MlArAWewOQvvtvgESge5f9XcDfqIa9LS/z4wLniyOQE3Buc6WwMgf+zgCsHSN
         6RGXOM88XovsG8ZCCIrTjIc3lcmssVLUUsDyfQWGlIbNtqzqNfmME5fGF9t4wEdP0CAp
         GmlkLF82X3L9/+L4GSMabskQL+Jnavxul5NfqK/bpTa70xglQAg1pr5BfK7HZdf27ICN
         8SBDHcig/x4UfiKh+457ideDb4hSIDoITYXVz4afyBH2p6IUPoehMdk4UtPpzQYSdQU1
         ib+w==
X-Gm-Message-State: AOJu0YzRZJujTV4I1lCVwovjYma6RgcfJIo4/pVJRkjq2m1y/PU7CaoC
        kLY0LlT038+87jKyT3WSSS1e7w==
X-Google-Smtp-Source: AGHT+IFSVGIn3GkkCdVjrv9GJYab3GvRdyYNVKTc+rLB8DHUCDxVeEERoRHJ6rwLZ6Dt9ZCmv4emsA==
X-Received: by 2002:adf:d1ca:0:b0:32f:7967:aa4d with SMTP id b10-20020adfd1ca000000b0032f7967aa4dmr5491624wrd.68.1698672784653;
        Mon, 30 Oct 2023 06:33:04 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id d25-20020adfa419000000b0032f79e55eb8sm6061601wra.16.2023.10.30.06.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:33:04 -0700 (PDT)
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
        Samuel Holland <samuel.holland@sifive.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 2/4] riscv: Improve flush_tlb_range() for hugetlb pages
Date:   Mon, 30 Oct 2023 14:30:26 +0100
Message-Id: <20231030133027.19542-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030133027.19542-1-alexghiti@rivosinc.com>
References: <20231030133027.19542-1-alexghiti@rivosinc.com>
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

flush_tlb_range() uses a fixed stride of PAGE_SIZE and in its current form,
when a hugetlb mapping needs to be flushed, flush_tlb_range() flushes the
whole tlb: so set a stride of the size of the hugetlb mapping in order to
only flush the hugetlb mapping. However, if the hugepage is a NAPOT region,
all PTEs that constitute this mapping must be invalidated, so the stride
size must actually be the size of the PTE.

Note that THPs are directly handled by flush_pmd_tlb_range().

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # On RZ/Five SMARC
---
 arch/riscv/mm/tlbflush.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index fa03289853d8..b6d712a82306 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -3,6 +3,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
+#include <linux/hugetlb.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
@@ -147,7 +148,33 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	__flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
+	unsigned long stride_size;
+
+	if (!is_vm_hugetlb_page(vma)) {
+		stride_size = PAGE_SIZE;
+	} else {
+		stride_size = huge_page_size(hstate_vma(vma));
+
+		/*
+		 * As stated in the privileged specification, every PTE in a
+		 * NAPOT region must be invalidated, so reset the stride in that
+		 * case.
+		 */
+		if (has_svnapot()) {
+			if (stride_size >= PGDIR_SIZE)
+				stride_size = PGDIR_SIZE;
+			else if (stride_size >= P4D_SIZE)
+				stride_size = P4D_SIZE;
+			else if (stride_size >= PUD_SIZE)
+				stride_size = PUD_SIZE;
+			else if (stride_size >= PMD_SIZE)
+				stride_size = PMD_SIZE;
+			else
+				stride_size = PAGE_SIZE;
+		}
+	}
+
+	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
 }
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
-- 
2.39.2

