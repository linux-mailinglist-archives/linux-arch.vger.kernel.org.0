Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777295A55CA
	for <lists+linux-arch@lfdr.de>; Mon, 29 Aug 2022 22:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiH2Uw1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Aug 2022 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH2Uw0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2022 16:52:26 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B017E03B
        for <linux-arch@vger.kernel.org>; Mon, 29 Aug 2022 13:52:25 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id x10so9261766ljq.4
        for <linux-arch@vger.kernel.org>; Mon, 29 Aug 2022 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=E7RreK0635SHJ4nmMLctoUcNBnNqGDxfeSoly44DNHQ=;
        b=aeDmLdf7MSg2oBqyyVI0+vId7I5nAyLGJ9Rp5cXLslDGKgiz1P+NAQ9HWv63SqkYwB
         P5kQIOojfWwj1ZHZ1fRBWNazK6NTVL10X3mpYKtQrR4UrD2X2WZq92utRa+ZooT2qg+c
         dK3wZ7nffKzxLNJh6lhH9cQQYaq45Hqgu373LgcuFJN0N5PaQ6Fd1PNGoWEtr5y/lwLE
         RUjJyxkxn207NMEAEdFuNxCdhRM/aY0GOyfZVhO8jMmTnYUHNaMVpb0opEFef+mqelQA
         mE/HT3ivwtC/ilWAkRHmijoBKqaPIrkLHoJ8Uz0WIFmWsNaiJXXH/jF6uxiQHxIPuChE
         BSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=E7RreK0635SHJ4nmMLctoUcNBnNqGDxfeSoly44DNHQ=;
        b=KMhFqPr8rXV+ZL0AMLORJHYyCJR7gNO++4ZJh7y3iF32DCXNBzBI16DmTiNV01Sg0X
         DQPE3L1L/1q1FhmYfKrKecKaJO55pLN2qNsQ0GlNKOL8fxKpcUq6xq/Yb9+WCrVkwFZA
         y/3K45c9Xl2Q3QLq3XpBlopDKlNfwnN6fIOCbQZUN2vry7okxT4pKt/6tWeJj6ezGzKJ
         C8jycMCaFA8DNmmIvgCdz7ET0b+5gbSFFHafXrVCi20lWwsIFDINVlRoQYLauY5UhFDV
         MdFlUh9DM1SuHni/i8piRStarvkodUT5sPc60xKOmdABVnfrclu5XnPSi4uLYslE4qmh
         ZOnA==
X-Gm-Message-State: ACgBeo087HzJ+1k/pegXBD5HB2yuvMJAvhjroJhGQQMC+efIshGRx2vJ
        s27tijXZujwhYbsByF+d3bbCYizca/sHlw==
X-Google-Smtp-Source: AA6agR7wHVgKd7Li6v5oebyF5gSGkdZ+Kd0lFiHYmA3bWYcD1GL/dv7I6MkyU9DnT8y1PX62JIr3mQ==
X-Received: by 2002:a2e:3c13:0:b0:263:63d3:b498 with SMTP id j19-20020a2e3c13000000b0026363d3b498mr3278169lja.487.1661806343584;
        Mon, 29 Aug 2022 13:52:23 -0700 (PDT)
Received: from localhost.localdomain ([5.188.167.245])
        by smtp.googlemail.com with ESMTPSA id v20-20020a056512349400b0048b05882c28sm1378874lfr.271.2022.08.29.13.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 13:52:23 -0700 (PDT)
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Subject: [RFC PATCH 1/1] riscv: mm: notify remote harts about mmu cache updates
Date:   Mon, 29 Aug 2022 23:52:19 +0300
Message-Id: <20220829205219.283543-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sergey Matyukevich <sergey.matyukevich@syntacore.com>

Current implementation of update_mmu_cache function performs local TLB
flush. It does not take into account ASID information. Besides, it does
not take into account other harts currently running the same mm context
or possible migration of the running context to other harts. Meanwhile
TLB flush is not performed for every context switch if ASID support
is enabled.

Patch [1] proposed to add ASID support to update_mmu_cache to avoid
flushing local TLB entirely. This patch takes into account other
harts currently running the same mm context as well as possible
migration of this context to other harts.

For this purpose the approach from flush_icache_mm is reused. Remote
harts currently running the same mm context are informed via SBI calls
that they need to flush their local TLBs. All the other harts are marked
as needing a deferred TLB flush when this mm context runs on them.

[1] https://lore.kernel.org/linux-riscv/20220821013926.8968-1-tjytimi@163.com/

Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
---
 arch/riscv/include/asm/mmu.h      |  2 ++
 arch/riscv/include/asm/pgtable.h  |  2 +-
 arch/riscv/include/asm/tlbflush.h | 18 ++++++++++++++++++
 arch/riscv/mm/context.c           | 10 ++++++++++
 arch/riscv/mm/tlbflush.c          | 28 +++++++++++-----------------
 5 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index cedcf8ea3c76..86670a1b4ffd 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -20,6 +20,8 @@ typedef struct {
 #ifdef CONFIG_SMP
 	/* A local icache flush is needed before user execution can resume. */
 	cpumask_t icache_stale_mask;
+	/* A local tlb flush is needed before user execution can resume. */
+	cpumask_t tlb_stale_mask;
 #endif
 } mm_context_t;
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7ec936910a96..330f75fe1278 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -415,7 +415,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 	 * Relying on flush_tlb_fix_spurious_fault would suffice, but
 	 * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
 	 */
-	local_flush_tlb_page(address);
+	flush_tlb_page(vma, address);
 }
 
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 801019381dea..907b9efd39a8 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -22,6 +22,24 @@ static inline void local_flush_tlb_page(unsigned long addr)
 {
 	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
 }
+
+static inline void local_flush_tlb_all_asid(unsigned long asid)
+{
+	__asm__ __volatile__ ("sfence.vma x0, %0"
+			:
+			: "r" (asid)
+			: "memory");
+}
+
+static inline void local_flush_tlb_page_asid(unsigned long addr,
+		unsigned long asid)
+{
+	__asm__ __volatile__ ("sfence.vma %0, %1"
+			:
+			: "r" (addr), "r" (asid)
+			: "memory");
+}
+
 #else /* CONFIG_MMU */
 #define local_flush_tlb_all()			do { } while (0)
 #define local_flush_tlb_page(addr)		do { } while (0)
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 7acbfbd14557..80ce9caba8d2 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -196,6 +196,16 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 
 	if (need_flush_tlb)
 		local_flush_tlb_all();
+#ifdef CONFIG_SMP
+	else {
+		cpumask_t *mask = &mm->context.tlb_stale_mask;
+
+		if (cpumask_test_cpu(cpu, mask)) {
+			cpumask_clear_cpu(cpu, mask);
+			local_flush_tlb_all_asid(cntx & asid_mask);
+		}
+	}
+#endif
 }
 
 static void set_mm_noasid(struct mm_struct *mm)
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 37ed760d007c..ce7dfc81bb3f 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -5,23 +5,7 @@
 #include <linux/sched.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
-
-static inline void local_flush_tlb_all_asid(unsigned long asid)
-{
-	__asm__ __volatile__ ("sfence.vma x0, %0"
-			:
-			: "r" (asid)
-			: "memory");
-}
-
-static inline void local_flush_tlb_page_asid(unsigned long addr,
-		unsigned long asid)
-{
-	__asm__ __volatile__ ("sfence.vma %0, %1"
-			:
-			: "r" (addr), "r" (asid)
-			: "memory");
-}
+#include <asm/tlbflush.h>
 
 void flush_tlb_all(void)
 {
@@ -31,6 +15,7 @@ void flush_tlb_all(void)
 static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
 				  unsigned long size, unsigned long stride)
 {
+	struct cpumask *pmask = &mm->context.tlb_stale_mask;
 	struct cpumask *cmask = mm_cpumask(mm);
 	unsigned int cpuid;
 	bool broadcast;
@@ -44,6 +29,15 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
 	if (static_branch_unlikely(&use_asid_allocator)) {
 		unsigned long asid = atomic_long_read(&mm->context.id);
 
+		/*
+		 * TLB will be immediately flushed on harts concurrently
+		 * executing this MM context. TLB flush on other harts
+		 * is deferred until this MM context migrates there.
+		 */
+		cpumask_setall(pmask);
+		cpumask_clear_cpu(cpuid, pmask);
+		cpumask_andnot(pmask, pmask, cmask);
+
 		if (broadcast) {
 			sbi_remote_sfence_vma_asid(cmask, start, size, asid);
 		} else if (size <= stride) {
-- 
2.37.1

