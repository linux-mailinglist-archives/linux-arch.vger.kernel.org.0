Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D70D708261
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjERNOB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjERNNh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3388F172E;
        Thu, 18 May 2023 06:12:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE7E64F44;
        Thu, 18 May 2023 13:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790E8C433A7;
        Thu, 18 May 2023 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415575;
        bh=gcDd0R4XsxsPBucDmYK1iap8GL8ZX5NOiXczxwUZldM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uu7DJ5RUzqXpTaSuArwglr0rWJYmKTwNtwf/L5azEkL3TnZGpmnZn3fJXUSHUmWpZ
         dJVivDkIzOHwZOSDa13HbwD6EBl2CPnbpPqmOKR666K2piHTT4NtNULOC3f32AASrE
         IL7+haD4mgaXB9yLIiarp0uMJAmejmJYqyIEfNMIJgLsVblo4fwUNFeiEu5O1OOvFI
         OQ4KfeHqtKP5n99HlbyH3fGyXKQJw1mYJbnoFSIXe4fGIsBdqj5OzyqYlrbPjBTpYk
         /Rv9fPyUwOKT/FJbwRM9rtywAfkUqR3vXa6cu6tZ9IYe6pQ/ThCT2LtfDtqAGmv0ZV
         E+dV50MoDYR8Q==
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
Subject: [RFC PATCH 11/22] riscv: s64ilp32: Add ebpf jit support
Date:   Thu, 18 May 2023 09:10:02 -0400
Message-Id: <20230518131013.3366406-12-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230518131013.3366406-1-guoren@kernel.org>
References: <20230518131013.3366406-1-guoren@kernel.org>
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

The s64ilp32 uses the rv64 ISA instruction set, not the rv32 ISA. So
bpf_jit_comp32.c can't be used for s64ilp32, and we use bpf_jit_comp64.c
instead. This patch makes s64ilp32 ebpf jit correct and improves the
performance because bpf_jit_comp32.c has significant gaps in mapping
ebpf 64-bit ISA.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/extable.h |  2 +-
 arch/riscv/net/Makefile          |  6 +++---
 arch/riscv/net/bpf_jit_comp64.c  | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/extable.h b/arch/riscv/include/asm/extable.h
index 512012d193dc..3ad79a7989e2 100644
--- a/arch/riscv/include/asm/extable.h
+++ b/arch/riscv/include/asm/extable.h
@@ -34,7 +34,7 @@ do {							\
 
 bool fixup_exception(struct pt_regs *regs);
 
-#if defined(CONFIG_BPF_JIT) && defined(CONFIG_ARCH_RV64I)
+#if defined(CONFIG_BPF_JIT) && !defined(CONFIG_ARCH_RV32I)
 bool ex_handler_bpf(const struct exception_table_entry *ex, struct pt_regs *regs);
 #else
 static inline bool
diff --git a/arch/riscv/net/Makefile b/arch/riscv/net/Makefile
index 9a1e5f0a94e5..907edce21acc 100644
--- a/arch/riscv/net/Makefile
+++ b/arch/riscv/net/Makefile
@@ -2,8 +2,8 @@
 
 obj-$(CONFIG_BPF_JIT) += bpf_jit_core.o
 
-ifeq ($(CONFIG_ARCH_RV64I),y)
-	obj-$(CONFIG_BPF_JIT) += bpf_jit_comp64.o
-else
+ifeq ($(CONFIG_ARCH_RV32I),y)
 	obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
+else
+	obj-$(CONFIG_BPF_JIT) += bpf_jit_comp64.o
 endif
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index f5a668736c79..5a65cd01c73c 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -125,7 +125,7 @@ static u8 rv_tail_call_reg(struct rv_jit_context *ctx)
 
 static bool is_32b_int(s64 val)
 {
-	return -(1L << 31) <= val && val < (1L << 31);
+	return -(1LL << 31) <= val && val < (1LL << 31);
 }
 
 static bool in_auipc_jalr_range(s64 val)
@@ -134,15 +134,15 @@ static bool in_auipc_jalr_range(s64 val)
 	 * auipc+jalr can reach any signed PC-relative offset in the range
 	 * [-2^31 - 2^11, 2^31 - 2^11).
 	 */
-	return (-(1L << 31) - (1L << 11)) <= val &&
-		val < ((1L << 31) - (1L << 11));
+	return (-(1LL << 31) - (1LL << 11)) <= val &&
+		val < ((1LL << 31) - (1LL << 11));
 }
 
 /* Emit fixed-length instructions for address */
 static int emit_addr(u8 rd, u64 addr, bool extra_pass, struct rv_jit_context *ctx)
 {
-	u64 ip = (u64)(ctx->insns + ctx->ninsns);
-	s64 off = addr - ip;
+	ulong ip  = (ulong)(ctx->insns + ctx->ninsns);
+	s64 off   = (ulong)addr - ip;
 	s64 upper = (off + (1 << 11)) >> 12;
 	s64 lower = off & 0xfff;
 
-- 
2.36.1

