Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2BF7CFBE7
	for <lists+linux-arch@lfdr.de>; Thu, 19 Oct 2023 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjJSODI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Oct 2023 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjJSODH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Oct 2023 10:03:07 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A020C134
        for <linux-arch@vger.kernel.org>; Thu, 19 Oct 2023 07:03:05 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507a0907896so7843987e87.2
        for <linux-arch@vger.kernel.org>; Thu, 19 Oct 2023 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697724184; x=1698328984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd/FLevx18XhR5UIn9smwlv93JRL3lzcOo0hNfovrwU=;
        b=HJA5HuLtYTVxlQIRyWzG0OniQP7/8a/98VFXx8BMT6kiyddDWdcgpjUv8Hhhi9WJ/d
         vH5FtT476kx7pJgzASWxniUxPI8bFBWDvZqVaM/F5ghyDUN75bd6nZb3vqkwE4xBWNwR
         B/QmK/J6n8SfkpcQxtNMCsslSMm2LfHQsyLlB3+z/s3Kwx5D08zg+SaTEg4+4fbem7NU
         AY71ChGTOHp37IVr9qW5wrrglTpRKWlNsfg3fBiohFvr33t/uzJK1dNIFClKj3YuVxkO
         NBb4hoLa/G5do/qgGzMhswR32jvlL3So6wAo8h8hj0C4yTlA9wV3aZoQa3lORdGsY4OI
         zhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697724184; x=1698328984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd/FLevx18XhR5UIn9smwlv93JRL3lzcOo0hNfovrwU=;
        b=GExZHh8T3/G0s28oCq0ytrO9zluYgiaIm1QgZ7DEebgrmJ3hlRnlZdXtm5oIV+Lf6t
         VM3D+URxAawm37CN9SpN1VsHOolnHzyrqqw38r7XuJBqSk6VdnlHzLTuKl/qRZbsklEC
         NtKHke6SHkyxZZ/xVuSpMNOmJOa4OBksqnM70DsZZJCxSBLkJlDznO18bz/47AmlEfTq
         GgcQl05fCL++sv7b97ZbwamWG0G82vOY609S0JQlJf9OPeh0Dq0NB/WA+ANomooWSJTP
         XYrwQ/UApGNTWEbU011Jnd19WPjaORpC60UCZdZ8UIAxiVichqxCKGWZJkmuk9nHgDfs
         9Arw==
X-Gm-Message-State: AOJu0Yxjl7vOK2hToFQ7Law5g86FP42a97PkDrdM2bMfw33pK23oFdLA
        qMO2oVP2hWKD6cmSXClB87b06w==
X-Google-Smtp-Source: AGHT+IEreDwOMoW56yjrW09GCEE/pI+6cCamWfZVDmTeqTnMJ6ObGDZTCddBTRTbchZ8BncLsOt9fw==
X-Received: by 2002:ac2:5a04:0:b0:507:b993:bb86 with SMTP id q4-20020ac25a04000000b00507b993bb86mr1486713lfn.66.1697724183683;
        Thu, 19 Oct 2023 07:03:03 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600000c900b0032d8eecf901sm4567033wrx.3.2023.10.19.07.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:03:03 -0700 (PDT)
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
        Samuel Holland <samuel.holland@sifive.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 1/4] riscv: Improve tlb_flush()
Date:   Thu, 19 Oct 2023 16:01:48 +0200
Message-Id: <20231019140151.21629-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019140151.21629-1-alexghiti@rivosinc.com>
References: <20231019140151.21629-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For now, tlb_flush() simply calls flush_tlb_mm() which results in a
flush of the whole TLB. So let's use mmu_gather fields to provide a more
fine-grained flush of the TLB.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # On RZ/Five SMARC
---
 arch/riscv/include/asm/tlb.h      | 8 +++++++-
 arch/riscv/include/asm/tlbflush.h | 3 +++
 arch/riscv/mm/tlbflush.c          | 7 +++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index 120bcf2ed8a8..1eb5682b2af6 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -15,7 +15,13 @@ static void tlb_flush(struct mmu_gather *tlb);
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
-	flush_tlb_mm(tlb->mm);
+#ifdef CONFIG_MMU
+	if (tlb->fullmm || tlb->need_flush_all)
+		flush_tlb_mm(tlb->mm);
+	else
+		flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end,
+				   tlb_get_unmap_size(tlb));
+#endif
 }
 
 #endif /* _ASM_RISCV_TLB_H */
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index a09196f8de68..f5c4fb0ae642 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -32,6 +32,8 @@ static inline void local_flush_tlb_page(unsigned long addr)
 #if defined(CONFIG_SMP) && defined(CONFIG_MMU)
 void flush_tlb_all(void);
 void flush_tlb_mm(struct mm_struct *mm);
+void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
+			unsigned long end, unsigned int page_size);
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end);
@@ -52,6 +54,7 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 }
 
 #define flush_tlb_mm(mm) flush_tlb_all()
+#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
 #endif /* !CONFIG_SMP || !CONFIG_MMU */
 
 /* Flush a range of kernel pages */
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 77be59aadc73..fa03289853d8 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -132,6 +132,13 @@ void flush_tlb_mm(struct mm_struct *mm)
 	__flush_tlb_range(mm, 0, -1, PAGE_SIZE);
 }
 
+void flush_tlb_mm_range(struct mm_struct *mm,
+			unsigned long start, unsigned long end,
+			unsigned int page_size)
+{
+	__flush_tlb_range(mm, start, end - start, page_size);
+}
+
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
 	__flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
-- 
2.39.2

