Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5E476AB7C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Aug 2023 10:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjHAI4w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Aug 2023 04:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjHAI4v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Aug 2023 04:56:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C761BC6
        for <linux-arch@vger.kernel.org>; Tue,  1 Aug 2023 01:56:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso60082145e9.0
        for <linux-arch@vger.kernel.org>; Tue, 01 Aug 2023 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690880168; x=1691484968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdYxZtsdohXkJiEqvE1Q59ExwQkgmM2r74atDceIuW4=;
        b=P1QobXoccsE3+9czY0EpajvoT8IDASIi5MHnVOCPkE2PMZjb4NqJkp3pvl6huP8YRq
         inBiQsncpHkOkganYv8SrZAOd3CtSTRw0CEuM5zl62vwXj74EYJEKz1rWmjPNAGUwXcZ
         0T//g3rQxb50UzHNokVzEi/3Xp6BVR9XQED7mluE4W1zuOqwh31OFZ6aHgZa9eXfLMxk
         Ybdk6zmtonm5+VeE6xBp3pLoAkOzJzfiBcOkz9WrXEMNt9py7w/QriiUEhWdVim5+GYl
         oNYLzRRYgjWZYYev+98Hpz+c7VOxxXWdwErfKirkGLaiOfoY7c7Toqiek1j1aM9FuYjR
         xmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880168; x=1691484968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdYxZtsdohXkJiEqvE1Q59ExwQkgmM2r74atDceIuW4=;
        b=BAGKngesoOadOJjiUWJuLq6h7g7vw84KJMrihK0gnJb0imNGfkG9wjWANr/Xl2ARP6
         SIf1w8WXkf7oe8V2kT6ZXKYdBqvqYUbq8tX/qAINexaztKwhcHfcK80nKyyipHBJChkp
         CTNvDIFm+dHtt0sRH4yEaQ/uj3PHSX81KYXptCZ88a8LG5Qar9Rqn94q5TkouiDtR2HK
         mnObSz1q1tzXcDnju3R9oEZ7ZD0+pmwQTSGTBcpfg3jP9XbhGbfnu3izD3GQHBEUGA2L
         Vvrzwf7p8yNRi+drvblcMG4Zc0kQ5dum5/3TDRa+DaBYkCpLOsatRTcRYdIy5hZGYexC
         zTbg==
X-Gm-Message-State: ABy/qLZuYzRopcJajs4Nh3tfOqeLena5valRh7ni2FXQhll3VUoSPYLJ
        NqpRMud1Js99p80wk7+m1RBlcQ==
X-Google-Smtp-Source: APBJJlG/YdSyO9mZdobMpVoP2KrhKuvsBSBkyDxEF7tvWdeyE2ucJPc2rpUQPp8XKp43TrymC0aSMA==
X-Received: by 2002:a7b:c4c5:0:b0:3fe:f99:1ba with SMTP id g5-20020a7bc4c5000000b003fe0f9901bamr1969783wmk.2.1690880168420;
        Tue, 01 Aug 2023 01:56:08 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l12-20020a7bc44c000000b003fe215e4492sm4763826wmi.4.2023.08.01.01.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 01:56:08 -0700 (PDT)
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
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 2/4] riscv: Improve flush_tlb_range() for hugetlb pages
Date:   Tue,  1 Aug 2023 10:54:00 +0200
Message-Id: <20230801085402.1168351-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801085402.1168351-1-alexghiti@rivosinc.com>
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/mm/tlbflush.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index fa03289853d8..d883df0dee4a 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -3,6 +3,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
+#include <linux/hugetlb.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
@@ -147,7 +148,13 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	__flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
+	unsigned long stride_size;
+
+	stride_size = is_vm_hugetlb_page(vma) ?
+				huge_page_size(hstate_vma(vma)) :
+				PAGE_SIZE;
+
+	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
 }
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
-- 
2.39.2

