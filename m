Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD64C74E86F
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 09:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGKH4o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 03:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjGKH4m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 03:56:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DFA1A4
        for <linux-arch@vger.kernel.org>; Tue, 11 Jul 2023 00:56:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so59652655e9.3
        for <linux-arch@vger.kernel.org>; Tue, 11 Jul 2023 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689062199; x=1691654199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FofimiyN+7gyzGEdPyrBP2skR/4a1H3RZbKcHwnJwCU=;
        b=Qf1MDi4IQVSgi+mVmNSDLBvvWhfd8ba6Ayo48Gj0+fuhQZ4V9G61dBcMO//cFS1/fC
         eMTYYy06UvyotO+oVGCBq6zI9sY1LeYU01nJRoZJ+JLckfsVKJMM97nPklKyDZRE3HOu
         TVkWiZ1s6BeKrYLS2wuPUnzE9wyBrK5LdHaTtNHXVs67A6vQfZbIP4oSE43hkg/e5u/I
         R82FjYAOaShi8TnwHOG++346KF4aekyWodyFCqKGj8HPeSDtbX8x88W80pqGP3MBU7wD
         2AUgLCJEZ6IWj8TTYNHFpXz8+pCuX+wIU15tPfBynjH9x67d68/tJq305rfx6T581tDJ
         NCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689062199; x=1691654199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FofimiyN+7gyzGEdPyrBP2skR/4a1H3RZbKcHwnJwCU=;
        b=MLRKtI7MbTHr4ulC8QqaNQmRpIrtl1MuGs2+y4ZGhFlaf0d2Z/c0D5wysm3wgOYHQj
         m/P41JcY9oDqLmEo4OVVjO2SAPSby6lb8RmF+71cf+KmKWkOQ8o2AChgK24yh6ei2DcH
         CRibr7z1S1zQ0tNBrBEsIm6U9FGpyibYiEQtNJtHM7dXQlI2W1cXc3SBWPpnS9gRnwZ/
         1fmEe21NQnP7z1RHfL7BCDtlVLz+diOk/mV197ZQ7KY62+VI54XZtgHJCcqtpRgGKUVr
         2r2TalzCvJn0Nee8b9l6IMaWpZU1jArVr4LlTEKw9vDJSxXnYcnoGibdQzDNcsVg1XJ+
         CkKA==
X-Gm-Message-State: ABy/qLZ/oXZW3umRNxawot8/tU+CNNZGG2CAWAkv8i6dRvydrxZ456bU
        VkSnglvx5ERukQ8E54X/wwAuww==
X-Google-Smtp-Source: APBJJlFgOrHK/zRfOp0MLvbYM0U1zfW7SDksh40rSfKhwgzyv7cSwo1z6lrEN1sxG+rtuvh+ttt+lA==
X-Received: by 2002:adf:f052:0:b0:30a:a15d:eb2f with SMTP id t18-20020adff052000000b0030aa15deb2fmr16274589wro.3.1689062199178;
        Tue, 11 Jul 2023 00:56:39 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p8-20020adfe608000000b003141f3843e6sm1489099wrm.90.2023.07.11.00.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 00:56:39 -0700 (PDT)
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
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 2/4] riscv: Improve flush_tlb_range() for hugetlb pages
Date:   Tue, 11 Jul 2023 09:54:32 +0200
Message-Id: <20230711075434.10936-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711075434.10936-1-alexghiti@rivosinc.com>
References: <20230711075434.10936-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

flush_tlb_range() uses a fixed stride of PAGE_SIZE and in its current form,
when a hugetlb mapping needs to be flushed, flush_tlb_range() flushes the
whole tlb: so set a stride of the size of the hugetlb mapping in order to
only flush the hugetlb mapping.

Note that THPs are directly handled by flush_pmd_tlb_range().

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/tlbflush.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index fa03289853d8..3e4acef1f6bc 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -3,6 +3,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
+#include <linux/hugetlb.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
@@ -147,7 +148,14 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	__flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
+	unsigned long stride_shift;
+
+	stride_shift = is_vm_hugetlb_page(vma) ?
+				huge_page_shift(hstate_vma(vma)) :
+				PAGE_SHIFT;
+
+	__flush_tlb_range(vma->vm_mm,
+			  start, end - start, 1 << stride_shift);
 }
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
-- 
2.39.2

