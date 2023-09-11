Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DE579B711
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 02:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjIKVFj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbjIKNNe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 09:13:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB1FE9
        for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2023 06:13:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso47216705e9.2
        for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2023 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694438008; x=1695042808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJvQhuwass6T7QyQKJFHTMKHPeCPiB8wQ+ZaCt6WMq4=;
        b=HMVF18wQjc6DGqjgcRT56k/Qc7TQBLsEFQr/u/7CslBI5TL9VDmxEfG21MuDQ1mqQ0
         MzzAuSioeSPUXqwoxRJSWH/BHJL2cRO0R1D1W2iq7cXpubvpnbHetCIYce4Yrs1DzNDc
         6ujewR7F2CvE/Xtpqo7IPTDtcQRSwjN400/wWye8QRxGlCK9EG9b6TjWRCHzw1PWssl2
         6VjNe2sf5H4VXL0JbUP3ejfCorRb2KPuoovBtaenVugdLiPQO2xR4CMDeiZAIAhe54T/
         P0BdYZIgJ/ruTOzDVnPLj/GWPs/2MLgFVd2acSFqE9udG3d1kPuxhoLt6FTncTdedCuZ
         qbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438008; x=1695042808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJvQhuwass6T7QyQKJFHTMKHPeCPiB8wQ+ZaCt6WMq4=;
        b=YV9NK/hQfwGItyWHudp91gEwxfvcL3JBFODlIom0aa9ujwzTkprbohc1oB7VNf0i6Y
         me27NnBl3LmMUwNGGje0SaG/kA5oaQSXOxfJHXcLMQLcuy8yX2K6YBxIRsj0PZT22FYn
         pt6UMXbJf/SoyuV5t0k5r4y83A/cYhFK48U85OBTMkq0iYn5MxtTzDAfSObksvMXpbsP
         J17roEVJqXf1fAvr121VWTKHR5Uk6fzmHxd2fh3JnOI90O9y1/wDBs1bvgf7F7QBhbo4
         5U/MtIaMQhVMCdHdgUnaA0Ic+npjK3uSn9HQ7uD1327aX2ETP08n7Pu4bjXyaAGkVgQu
         dx1Q==
X-Gm-Message-State: AOJu0Yymx+7C/kjaN0SrWyMqJGpzNWCqleu5e5Ml82eKKy+SGob30RMt
        gyVQ03BXUgKVpxenzFfdteHATw==
X-Google-Smtp-Source: AGHT+IHDNb5CqLim35ose2q7WmJ+9tXpgSAwI6QOLAumXk8SMHKSu15qIwBWXUEtVo37x5UyrTFz2g==
X-Received: by 2002:a05:6000:118f:b0:317:6d9d:1250 with SMTP id g15-20020a056000118f00b003176d9d1250mr7674314wrx.61.1694438008262;
        Mon, 11 Sep 2023 06:13:28 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id b14-20020a5d550e000000b0031f34a395e7sm10072174wrv.45.2023.09.11.06.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:13:27 -0700 (PDT)
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
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 1/4] riscv: Improve flush_tlb()
Date:   Mon, 11 Sep 2023 15:12:21 +0200
Message-Id: <20230911131224.61924-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911131224.61924-1-alexghiti@rivosinc.com>
References: <20230911131224.61924-1-alexghiti@rivosinc.com>
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

For now, flush_tlb() simply calls flush_tlb_mm() which results in a
flush of the whole TLB. So let's use mmu_gather fields to provide a more
fine-grained flush of the TLB.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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

