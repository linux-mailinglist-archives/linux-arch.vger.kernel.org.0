Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEBA708259
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjERNNm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjERNNH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1582102;
        Thu, 18 May 2023 06:12:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79A1764F36;
        Thu, 18 May 2023 13:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F63AC4339E;
        Thu, 18 May 2023 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415563;
        bh=K6yzC4DxTrto6TIigKOf2HSRiKwOssJzxGPb5qsG5uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXJAwAIukQyUqKfJu7LCrvsuxh/2lr7uu5dOljJseAAxlywm7yBd0VVked85CNfjq
         IuuSjQ3DcQgJRFeh45p3dQgYfRpVz2tNQolXVKu9rK0sZ2MgE0882A/1QHYou7eh07
         4XNgn+8fsLlgrSHNcB3MocDEWrzhpRblVSC8K2jrSn0CbS7jrAdUasfwC32+By7tc0
         7f/1X9uwq+ZwYRbv8qHiTjboPIJEija8peqdWLq59oc44Q9Ca+TaUuK8KWZYNnf5Hd
         dl7nEC2nrfl05jQzwP2H1hXitACGVH5WlldFt/AFHIws3dqz6Xaxb08Lxc3x8D3btO
         j29hJzbTHERLA==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        paul.walmsley@sifive.com, catalin.marinas@arm.com, will@kernel.org,
        rppt@kernel.org, anup@brainfault.org, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, corbet@lwn.net, wuwei2016@iscas.ac.cn,
        jrtc27@jrtc27.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH 10/22] riscv: s64ilp32: Enable user space runtime environment
Date:   Thu, 18 May 2023 09:10:01 -0400
Message-Id: <20230518131013.3366406-11-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230518131013.3366406-1-guoren@kernel.org>
References: <20230518131013.3366406-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

RV64ILP32 uses the same setting from COMPAT mode for the user
space runtime environment. They all have the same 2GB TASK_SIZE.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/csr.h     | 2 --
 arch/riscv/include/asm/pgtable.h | 8 +++++++-
 arch/riscv/kernel/process.c      | 4 +++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index adc3c866d353..7558e0808af4 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -36,11 +36,9 @@
 #define SR_SD		_AC(0x8000000000000000, ULL) /* FS/XS dirty */
 #endif
 
-#if __riscv_xlen == 64
 #define SR_UXL		_AC(0x300000000, ULL) /* XLEN mask for U-mode */
 #define SR_UXL_32	_AC(0x100000000, ULL) /* XLEN = 32 for U-mode */
 #define SR_UXL_64	_AC(0x200000000, ULL) /* XLEN = 64 for U-mode */
-#endif
 
 /* SATP flags */
 #if __riscv_xlen == 32
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 3303fc03d724..d7b8eff0ade9 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -830,26 +830,32 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  * -     0x9fc00000 (~2.5GB) for RV32.
  * -   0x4000000000 ( 256GB) for RV64 using SV39 mmu
  * - 0x800000000000 ( 128TB) for RV64 using SV48 mmu
+ * -     0x80000000 (   2GB) for COMPAT and RV64ILP32
  *
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE since "RISC-V
  * Instruction Set Manual Volume II: Privileged Architecture" states that
  * "load and store effective addresses, which are 64bits, must have bits
  * 63–48 all equal to bit 47, or else a page-fault exception will occur."
  */
+#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
+
 #ifdef CONFIG_64BIT
 #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
 #define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
 
 #ifdef CONFIG_COMPAT
-#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
 #define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
 			 TASK_SIZE_32 : TASK_SIZE_64)
 #else
 #define TASK_SIZE	TASK_SIZE_64
 #endif
 
+#else
+#ifdef CONFIG_ARCH_RV64ILP32
+#define TASK_SIZE	TASK_SIZE_32
 #else
 #define TASK_SIZE	FIXADDR_START
+#endif
 #define TASK_SIZE_MIN	TASK_SIZE
 #endif
 
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index ab01b51a5bb9..e033dbe5b5eb 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -125,13 +125,15 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	regs->epc = pc;
 	regs->sp = sp;
 
-#ifdef CONFIG_64BIT
 	regs->status &= ~SR_UXL;
 
+#ifdef CONFIG_64BIT
 	if (is_compat_task())
 		regs->status |= SR_UXL_32;
 	else
 		regs->status |= SR_UXL_64;
+#else
+		regs->status |= SR_UXL_32;
 #endif
 }
 
-- 
2.36.1

