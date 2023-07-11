Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20A74E872
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 09:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjGKH5p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 03:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjGKH5o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 03:57:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B180F1A4
        for <linux-arch@vger.kernel.org>; Tue, 11 Jul 2023 00:57:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3143ccb0f75so6272811f8f.0
        for <linux-arch@vger.kernel.org>; Tue, 11 Jul 2023 00:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689062260; x=1691654260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GXjLhe5TXUta+EXxk7AgfyYmiNiXB9g5OSSIlBPGEA=;
        b=jpjsGIvHWDXwtmenwjPw+yleh84wYF4Gde1Y36TPhdybnF0jpwSLd/aOo7CFMtSuDK
         ScyvlYS80l2vcQ9apidNHokPdNcKdGvUFOz16EWh6HyNXWzuR/QaMrKyDRVuWrs51yKx
         skZgZTUZjD6cFKSOYgb53UN64gLFvysjjqU8dLz9nE2+HJHAHGf48tinF7oqdJtBI4pc
         Et4wuuECz5m6cPYyXZRudVvVIj9AKfqmjpYZWVzHlfwOhzfYW2aebgP/Fu+HS+8C0bcV
         XDhilVqCMXb407/A4iXWplI1yIn5lQwUah0v2s5df1KU/cDtaR7kCadJjP9Y4QwOQKtB
         s4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689062260; x=1691654260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GXjLhe5TXUta+EXxk7AgfyYmiNiXB9g5OSSIlBPGEA=;
        b=CLW0TKHt97dXj4TmL1S0w64pTTmQuMvsbU8chBtK8/gk1vARpFdk1S2dTWAw1pfV5p
         BRO8ClLgVjip0y0cwJl8UVSjD26a1u4Vw9+Jkokz6cWI5HAdfe/yK/Mwa/SZldkgRo2T
         TWRKJT8LIPjB0EvkivXvxXVFUmwwzc/ZpujPm4j1XQoaZhjjNoTBvqVT245iOUnuzC0C
         P+nmsSsaRDWTwR8fsNS+idjz38Yr2d8+bBIV+A/ym4wUyI1ypj/7Ozq1apg0sdf1oYm/
         aBBLqNH+qvvp3zCBJlyTDGhSUy8HRrhWPDzk5cslvtFzVtdBjmiGoqYCFw20j2lEbjq9
         u9Fg==
X-Gm-Message-State: ABy/qLb6XdQU7zlWe5QVCZwO0GE4S2aswTPVcfpQ7DZNUmXOVdhUsyMm
        Gh+PgrHe86vV47hlqsqTEkpNLg==
X-Google-Smtp-Source: APBJJlFF+JXKqksjRHwPA1L44xQAHuT0wraSNDH0ZMzzf07N8OaPZzuThlMge3mXhbU6gGV1bjdvMg==
X-Received: by 2002:a5d:4404:0:b0:314:46cb:880a with SMTP id z4-20020a5d4404000000b0031446cb880amr18276011wrq.28.1689062260118;
        Tue, 11 Jul 2023 00:57:40 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d49d0000000b003143bb5ecd5sm1499978wrs.69.2023.07.11.00.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 00:57:39 -0700 (PDT)
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
Subject: [PATCH 3/4] riscv: Make __flush_tlb_range() loop over pte instead of flushing the whole tlb
Date:   Tue, 11 Jul 2023 09:54:33 +0200
Message-Id: <20230711075434.10936-4-alexghiti@rivosinc.com>
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

Currently, when the range to flush covers more than one page (a 4K page or
a hugepage), __flush_tlb_range() flushes the whole tlb. Flushing the whole
tlb comes with a greater cost than flushing a single entry so we should
flush single entries up to a certain threshold so that:
threshold * cost of flushing a single entry < cost of flushing the whole
tlb.

This threshold is microarchitecture dependent and can/should be
overwritten by vendors.

Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/tlbflush.c | 41 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 3e4acef1f6bc..de61ecaa218a 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -24,13 +24,48 @@ static inline void local_flush_tlb_page_asid(unsigned long addr,
 			: "memory");
 }
 
+/*
+ * Flush entire TLB if number of entries to be flushed is greater
+ * than the threshold below. Platforms may override the threshold
+ * value based on marchid, mvendorid, and mimpid.
+ */
+unsigned long tlb_flush_all_threshold __read_mostly = 64;
+
+static void local_flush_tlb_range_threshold_asid(unsigned long start,
+						 unsigned long size,
+						 unsigned long stride,
+						 unsigned long asid)
+{
+	u16 nr_ptes_in_range = DIV_ROUND_UP(size, stride);
+	int i;
+
+	if (nr_ptes_in_range > tlb_flush_all_threshold) {
+		if (asid != -1)
+			local_flush_tlb_all_asid(asid);
+		else
+			local_flush_tlb_all();
+		return;
+	}
+
+	for (i = 0; i < nr_ptes_in_range; ++i) {
+		if (asid != -1)
+			local_flush_tlb_page_asid(start, asid);
+		else
+			local_flush_tlb_page(start);
+		start += stride;
+	}
+}
+
 static inline void local_flush_tlb_range(unsigned long start,
 		unsigned long size, unsigned long stride)
 {
 	if (size <= stride)
 		local_flush_tlb_page(start);
-	else
+	else if (size == (unsigned long)-1)
 		local_flush_tlb_all();
+	else
+		local_flush_tlb_range_threshold_asid(start, size, stride, -1);
+
 }
 
 static inline void local_flush_tlb_range_asid(unsigned long start,
@@ -38,8 +73,10 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
 {
 	if (size <= stride)
 		local_flush_tlb_page_asid(start, asid);
-	else
+	else if (size == (unsigned long)-1)
 		local_flush_tlb_all_asid(asid);
+	else
+		local_flush_tlb_range_threshold_asid(start, size, stride, asid);
 }
 
 static void __ipi_flush_tlb_all(void *info)
-- 
2.39.2

