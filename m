Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E787396E9
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 07:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjFVFkc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 01:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjFVFkb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 01:40:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8180171C;
        Wed, 21 Jun 2023 22:40:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4271961764;
        Thu, 22 Jun 2023 05:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53F9C433C8;
        Thu, 22 Jun 2023 05:40:25 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        WANG Rui <wangrui@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Add guard for the larch_insn_gen_xxx functions
Date:   Thu, 22 Jun 2023 13:40:18 +0800
Message-Id: <20230622054018.414153-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: WANG Rui <wangrui@loongson.cn>

Add guard for the larch_insn_gen_xxx functions to verify whether the
immediate operand is within the acceptable range.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/inst.h   | 13 +++++++++++--
 arch/loongarch/include/asm/module.h |  2 +-
 arch/loongarch/kernel/inst.c        | 24 ++++++++++++++++++++++--
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index b09887ffcd15..1dc5b5802c15 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -5,6 +5,7 @@
 #ifndef _ASM_INST_H
 #define _ASM_INST_H
 
+#include <linux/bitops.h>
 #include <linux/types.h>
 #include <asm/asm.h>
 #include <asm/ptrace.h>
@@ -15,14 +16,22 @@
 #define ADDR_IMMMASK_LU52ID	0xFFF0000000000000
 #define ADDR_IMMMASK_LU32ID	0x000FFFFF00000000
 #define ADDR_IMMMASK_LU12IW	0x00000000FFFFF000
+#define ADDR_IMMMASK_ORI	0x0000000000000FFF
 #define ADDR_IMMMASK_ADDU16ID	0x00000000FFFF0000
 
 #define ADDR_IMMSHIFT_LU52ID	52
+#define ADDR_IMMSBIDX_LU52ID	11
 #define ADDR_IMMSHIFT_LU32ID	32
+#define ADDR_IMMSBIDX_LU32ID	19
 #define ADDR_IMMSHIFT_LU12IW	12
+#define ADDR_IMMSBIDX_LU12IW	19
+#define ADDR_IMMSHIFT_ORI	0
+#define ADDR_IMMSBIDX_ORI	63
 #define ADDR_IMMSHIFT_ADDU16ID	16
+#define ADDR_IMMSBIDX_ADDU16ID	15
 
-#define ADDR_IMM(addr, INSN)	((addr & ADDR_IMMMASK_##INSN) >> ADDR_IMMSHIFT_##INSN)
+#define ADDR_IMM(addr, INSN)	\
+	(sign_extend64(((addr & ADDR_IMMMASK_##INSN) >> ADDR_IMMSHIFT_##INSN), ADDR_IMMSBIDX_##INSN))
 
 enum reg0i15_op {
 	break_op	= 0x54,
@@ -449,7 +458,7 @@ u32 larch_insn_gen_move(enum loongarch_gpr rd, enum loongarch_gpr rj);
 u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
-u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
+u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 
 static inline bool signed_imm_check(long val, unsigned int bit)
 {
diff --git a/arch/loongarch/include/asm/module.h b/arch/loongarch/include/asm/module.h
index 12a0f1e66916..2ecd82bb64e1 100644
--- a/arch/loongarch/include/asm/module.h
+++ b/arch/loongarch/include/asm/module.h
@@ -55,7 +55,7 @@ static inline struct plt_entry emit_plt_entry(unsigned long val)
 	lu12iw = larch_insn_gen_lu12iw(LOONGARCH_GPR_T1, ADDR_IMM(val, LU12IW));
 	lu32id = larch_insn_gen_lu32id(LOONGARCH_GPR_T1, ADDR_IMM(val, LU32ID));
 	lu52id = larch_insn_gen_lu52id(LOONGARCH_GPR_T1, LOONGARCH_GPR_T1, ADDR_IMM(val, LU52ID));
-	jirl = larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, 0, (val & 0xfff));
+	jirl = larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, ADDR_IMM(val, ORI));
 
 	return (struct plt_entry) { lu12iw, lu32id, lu52id, jirl };
 }
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 258ef267cd30..ffe13c5ba557 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -226,6 +226,11 @@ u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm)
 {
 	union loongarch_instruction insn;
 
+	if (imm < -SZ_512K || imm >= SZ_512K) {
+		pr_warn("The generated lu12i.w instruction is out of range.\n");
+		return INSN_BREAK;
+	}
+
 	emit_lu12iw(&insn, rd, imm);
 
 	return insn.word;
@@ -235,6 +240,11 @@ u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm)
 {
 	union loongarch_instruction insn;
 
+	if (imm < -SZ_512K || imm >= SZ_512K) {
+		pr_warn("The generated lu32i.d instruction is out of range.\n");
+		return INSN_BREAK;
+	}
+
 	emit_lu32id(&insn, rd, imm);
 
 	return insn.word;
@@ -244,16 +254,26 @@ u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
 {
 	union loongarch_instruction insn;
 
+	if (imm < -SZ_2K || imm >= SZ_2K) {
+		pr_warn("The generated lu52i.d instruction is out of range.\n");
+		return INSN_BREAK;
+	}
+
 	emit_lu52id(&insn, rd, rj, imm);
 
 	return insn.word;
 }
 
-u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest)
+u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
 {
 	union loongarch_instruction insn;
 
-	emit_jirl(&insn, rj, rd, (dest - pc) >> 2);
+	if ((imm & 3) || imm < -SZ_128K || imm >= SZ_128K) {
+		pr_warn("The generated jirl instruction is out of range.\n");
+		return INSN_BREAK;
+	}
+
+	emit_jirl(&insn, rj, rd, imm >> 2);
 
 	return insn.word;
 }
-- 
2.39.3

