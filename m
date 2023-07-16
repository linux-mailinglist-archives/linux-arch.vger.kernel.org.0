Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D204754F5F
	for <lists+linux-arch@lfdr.de>; Sun, 16 Jul 2023 17:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjGPPUt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Jul 2023 11:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGPPUs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Jul 2023 11:20:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8090FE4E;
        Sun, 16 Jul 2023 08:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0857B60C61;
        Sun, 16 Jul 2023 15:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2D2C433C7;
        Sun, 16 Jul 2023 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689520846;
        bh=KuRdyUnvdhMI0IlJX5eClH8cwmGftUxt0A36mvY9HIo=;
        h=From:To:Cc:Subject:Date:From;
        b=ri48yWAptbDvfqa8raYqK0Qc1xMA0ks3kWOM4NUuo0b8ozl/Pc8U/qglksWNKcIuP
         +vto7asvYvtXHZCUksExNLZDPgkHtp6nxvIKycIguLGReF1B+4k3mVAoRSIKScJJx1
         SO5VL7v4wpz4YJ95lWZ2yoq3fY5zNsDLQcev9IpOAl/adKTR4w+4ApshXUixydSXvU
         g98GVv+4C2M8m+pir8crYc9qrybXkNIVOHEatJuiGPfuhljXbckSn7Efxu6qWfD8mk
         SH08O9qI5I5Mp87oicN/rNG1LHZxaCDjMcVDtyOV5g1DZ7EurVQX/anGucr7XxhCTI
         Mypmwvjdhle0Q==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        falcon@tinylab.org, bjorn@kernel.org, conor.dooley@microchip.com,
        alex@ghiti.fr
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: Add HAVE_IOREMAP_PROT support
Date:   Sun, 16 Jul 2023 11:20:33 -0400
Message-Id: <20230716152033.3713581-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add pte_pgprot macro, then riscv could have HAVE_IOREMAP_PROT,
which will enable generic_access_phys() code, it is useful for
debug, eg, gdb.

Because generic_access_phys() would call ioremap_prot()->
pgprot_nx() to disable excutable attribute, add definition
of pgprot_nx() for riscv.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 .../features/vm/ioremap_prot/arch-support.txt     |  2 +-
 arch/riscv/Kconfig                                |  1 +
 arch/riscv/include/asm/pgtable.h                  | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index a24149e59d73..ea8c8a361455 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -21,7 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: | TODO |
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4c07b9189c86..15900fa20797 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -117,6 +117,7 @@ config RISCV
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
+	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 75970ee2bda2..c9552a161f90 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -415,6 +415,11 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+static inline pgprot_t pte_pgprot(pte_t pte)
+{
+	return __pgprot(pte_val(pte) & ~_PAGE_PFN_MASK);
+}
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * See the comment in include/asm-generic/pgtable.h
@@ -573,6 +578,16 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	return ptep_test_and_clear_young(vma, address, ptep);
 }
 
+#define pgprot_nx pgprot_nx
+static inline pgprot_t pgprot_nx(pgprot_t _prot)
+{
+	unsigned long prot = pgprot_val(_prot);
+
+	prot &= ~_PAGE_EXEC;
+
+	return __pgprot(prot);
+}
+
 #define pgprot_noncached pgprot_noncached
 static inline pgprot_t pgprot_noncached(pgprot_t _prot)
 {
-- 
2.36.1

