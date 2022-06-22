Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE20E554FF6
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 17:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiFVPxF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 11:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359643AbiFVPwu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 11:52:50 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087A838B7;
        Wed, 22 Jun 2022 08:52:45 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LSnsQ5NxBz1KC3Z;
        Wed, 22 Jun 2022 23:50:34 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:42 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:41 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <live-patching@vger.kernel.org>
CC:     <jpoimboe@kernel.org>, <peterz@infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <ndesaulniers@google.com>, <mark.rutland@arm.com>,
        <pasha.tatashin@soleen.com>, <broonie@kernel.org>,
        <chenzhongjin@huawei.com>, <rmk+kernel@armlinux.org.uk>,
        <madvenka@linux.microsoft.com>, <christophe.leroy@csgroup.eu>
Subject: [PATCH v5 01/33] tools: arm64: Make aarch64 instruction decoder available to tools
Date:   Wed, 22 Jun 2022 23:48:48 +0800
Message-ID: <20220622154920.95075-2-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220622154920.95075-1-chenzhongjin@huawei.com>
References: <20220622154920.95075-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add aarch64 encoder/decoder implementation under tools/.

The insn.h/.c are fixed version for user space tools. Some functions
(mainly about instructions generator code) and macros are deleted so that
it won't depend on too much head files.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/arch/arm64/include/asm/insn.h | 458 ++++++++++++++++++++++++++++
 tools/arch/arm64/lib/insn.c         | 335 ++++++++++++++++++++
 2 files changed, 793 insertions(+)
 create mode 100644 tools/arch/arm64/include/asm/insn.h
 create mode 100644 tools/arch/arm64/lib/insn.c

diff --git a/tools/arch/arm64/include/asm/insn.h b/tools/arch/arm64/include/asm/insn.h
new file mode 100644
index 000000000000..839345692214
--- /dev/null
+++ b/tools/arch/arm64/include/asm/insn.h
@@ -0,0 +1,458 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2013 Huawei Ltd.
+ * Author: Jiang Liu <liuj97@gmail.com>
+ *
+ * Copyright (C) 2014 Zi Shen Lim <zlim.lnx@gmail.com>
+ */
+#ifndef	__ASM_INSN_H
+#define	__ASM_INSN_H
+#include <linux/build_bug.h>
+#include <linux/types.h>
+
+/* A64 instructions are always 32 bits. */
+#define AARCH64_INSN_SIZE	4
+
+#ifndef __ASSEMBLY__
+/*
+ * ARM Architecture Reference Manual for ARMv8 Profile-A, Issue A.a
+ * Section C3.1 "A64 instruction index by encoding":
+ * AArch64 main encoding table
+ *  Bit position
+ *   28 27 26 25	Encoding Group
+ *   0  0  -  -		Unallocated
+ *   1  0  0  -		Data processing, immediate
+ *   1  0  1  -		Branch, exception generation and system instructions
+ *   -  1  -  0		Loads and stores
+ *   -  1  0  1		Data processing - register
+ *   0  1  1  1		Data processing - SIMD and floating point
+ *   1  1  1  1		Data processing - SIMD and floating point
+ * "-" means "don't care"
+ */
+enum aarch64_insn_encoding_class {
+	AARCH64_INSN_CLS_UNKNOWN,	/* UNALLOCATED */
+	AARCH64_INSN_CLS_SVE,		/* SVE instructions */
+	AARCH64_INSN_CLS_DP_IMM,	/* Data processing - immediate */
+	AARCH64_INSN_CLS_DP_REG,	/* Data processing - register */
+	AARCH64_INSN_CLS_DP_FPSIMD,	/* Data processing - SIMD and FP */
+	AARCH64_INSN_CLS_LDST,		/* Loads and stores */
+	AARCH64_INSN_CLS_BR_SYS,	/* Branch, exception generation and
+					 * system instructions */
+};
+
+enum aarch64_insn_hint_cr_op {
+	AARCH64_INSN_HINT_NOP	= 0x0 << 5,
+	AARCH64_INSN_HINT_YIELD	= 0x1 << 5,
+	AARCH64_INSN_HINT_WFE	= 0x2 << 5,
+	AARCH64_INSN_HINT_WFI	= 0x3 << 5,
+	AARCH64_INSN_HINT_SEV	= 0x4 << 5,
+	AARCH64_INSN_HINT_SEVL	= 0x5 << 5,
+
+	AARCH64_INSN_HINT_XPACLRI    = 0x07 << 5,
+	AARCH64_INSN_HINT_PACIA_1716 = 0x08 << 5,
+	AARCH64_INSN_HINT_PACIB_1716 = 0x0A << 5,
+	AARCH64_INSN_HINT_AUTIA_1716 = 0x0C << 5,
+	AARCH64_INSN_HINT_AUTIB_1716 = 0x0E << 5,
+	AARCH64_INSN_HINT_PACIAZ     = 0x18 << 5,
+	AARCH64_INSN_HINT_PACIASP    = 0x19 << 5,
+	AARCH64_INSN_HINT_PACIBZ     = 0x1A << 5,
+	AARCH64_INSN_HINT_PACIBSP    = 0x1B << 5,
+	AARCH64_INSN_HINT_AUTIAZ     = 0x1C << 5,
+	AARCH64_INSN_HINT_AUTIASP    = 0x1D << 5,
+	AARCH64_INSN_HINT_AUTIBZ     = 0x1E << 5,
+	AARCH64_INSN_HINT_AUTIBSP    = 0x1F << 5,
+
+	AARCH64_INSN_HINT_ESB  = 0x10 << 5,
+	AARCH64_INSN_HINT_PSB  = 0x11 << 5,
+	AARCH64_INSN_HINT_TSB  = 0x12 << 5,
+	AARCH64_INSN_HINT_CSDB = 0x14 << 5,
+
+	AARCH64_INSN_HINT_BTI   = 0x20 << 5,
+	AARCH64_INSN_HINT_BTIC  = 0x22 << 5,
+	AARCH64_INSN_HINT_BTIJ  = 0x24 << 5,
+	AARCH64_INSN_HINT_BTIJC = 0x26 << 5,
+};
+
+enum aarch64_insn_imm_type {
+	AARCH64_INSN_IMM_ADR,
+	AARCH64_INSN_IMM_26,
+	AARCH64_INSN_IMM_19,
+	AARCH64_INSN_IMM_16,
+	AARCH64_INSN_IMM_14,
+	AARCH64_INSN_IMM_12,
+	AARCH64_INSN_IMM_9,
+	AARCH64_INSN_IMM_7,
+	AARCH64_INSN_IMM_6,
+	AARCH64_INSN_IMM_S,
+	AARCH64_INSN_IMM_R,
+	AARCH64_INSN_IMM_N,
+	AARCH64_INSN_IMM_MAX
+};
+
+enum aarch64_insn_register_type {
+	AARCH64_INSN_REGTYPE_RT,
+	AARCH64_INSN_REGTYPE_RN,
+	AARCH64_INSN_REGTYPE_RT2,
+	AARCH64_INSN_REGTYPE_RM,
+	AARCH64_INSN_REGTYPE_RD,
+	AARCH64_INSN_REGTYPE_RA,
+	AARCH64_INSN_REGTYPE_RS,
+};
+
+enum aarch64_insn_register {
+	AARCH64_INSN_REG_0  = 0,
+	AARCH64_INSN_REG_1  = 1,
+	AARCH64_INSN_REG_2  = 2,
+	AARCH64_INSN_REG_3  = 3,
+	AARCH64_INSN_REG_4  = 4,
+	AARCH64_INSN_REG_5  = 5,
+	AARCH64_INSN_REG_6  = 6,
+	AARCH64_INSN_REG_7  = 7,
+	AARCH64_INSN_REG_8  = 8,
+	AARCH64_INSN_REG_9  = 9,
+	AARCH64_INSN_REG_10 = 10,
+	AARCH64_INSN_REG_11 = 11,
+	AARCH64_INSN_REG_12 = 12,
+	AARCH64_INSN_REG_13 = 13,
+	AARCH64_INSN_REG_14 = 14,
+	AARCH64_INSN_REG_15 = 15,
+	AARCH64_INSN_REG_16 = 16,
+	AARCH64_INSN_REG_17 = 17,
+	AARCH64_INSN_REG_18 = 18,
+	AARCH64_INSN_REG_19 = 19,
+	AARCH64_INSN_REG_20 = 20,
+	AARCH64_INSN_REG_21 = 21,
+	AARCH64_INSN_REG_22 = 22,
+	AARCH64_INSN_REG_23 = 23,
+	AARCH64_INSN_REG_24 = 24,
+	AARCH64_INSN_REG_25 = 25,
+	AARCH64_INSN_REG_26 = 26,
+	AARCH64_INSN_REG_27 = 27,
+	AARCH64_INSN_REG_28 = 28,
+	AARCH64_INSN_REG_29 = 29,
+	AARCH64_INSN_REG_FP = 29, /* Frame pointer */
+	AARCH64_INSN_REG_30 = 30,
+	AARCH64_INSN_REG_LR = 30, /* Link register */
+	AARCH64_INSN_REG_ZR = 31, /* Zero: as source register */
+	AARCH64_INSN_REG_SP = 31  /* Stack pointer: as load/store base reg */
+};
+
+enum aarch64_insn_special_register {
+	AARCH64_INSN_SPCLREG_SPSR_EL1	= 0xC200,
+	AARCH64_INSN_SPCLREG_ELR_EL1	= 0xC201,
+	AARCH64_INSN_SPCLREG_SP_EL0	= 0xC208,
+	AARCH64_INSN_SPCLREG_SPSEL	= 0xC210,
+	AARCH64_INSN_SPCLREG_CURRENTEL	= 0xC212,
+	AARCH64_INSN_SPCLREG_DAIF	= 0xDA11,
+	AARCH64_INSN_SPCLREG_NZCV	= 0xDA10,
+	AARCH64_INSN_SPCLREG_FPCR	= 0xDA20,
+	AARCH64_INSN_SPCLREG_DSPSR_EL0	= 0xDA28,
+	AARCH64_INSN_SPCLREG_DLR_EL0	= 0xDA29,
+	AARCH64_INSN_SPCLREG_SPSR_EL2	= 0xE200,
+	AARCH64_INSN_SPCLREG_ELR_EL2	= 0xE201,
+	AARCH64_INSN_SPCLREG_SP_EL1	= 0xE208,
+	AARCH64_INSN_SPCLREG_SPSR_INQ	= 0xE218,
+	AARCH64_INSN_SPCLREG_SPSR_ABT	= 0xE219,
+	AARCH64_INSN_SPCLREG_SPSR_UND	= 0xE21A,
+	AARCH64_INSN_SPCLREG_SPSR_FIQ	= 0xE21B,
+	AARCH64_INSN_SPCLREG_SPSR_EL3	= 0xF200,
+	AARCH64_INSN_SPCLREG_ELR_EL3	= 0xF201,
+	AARCH64_INSN_SPCLREG_SP_EL2	= 0xF210
+};
+
+enum aarch64_insn_variant {
+	AARCH64_INSN_VARIANT_32BIT,
+	AARCH64_INSN_VARIANT_64BIT
+};
+
+enum aarch64_insn_condition {
+	AARCH64_INSN_COND_EQ = 0x0, /* == */
+	AARCH64_INSN_COND_NE = 0x1, /* != */
+	AARCH64_INSN_COND_CS = 0x2, /* unsigned >= */
+	AARCH64_INSN_COND_CC = 0x3, /* unsigned < */
+	AARCH64_INSN_COND_MI = 0x4, /* < 0 */
+	AARCH64_INSN_COND_PL = 0x5, /* >= 0 */
+	AARCH64_INSN_COND_VS = 0x6, /* overflow */
+	AARCH64_INSN_COND_VC = 0x7, /* no overflow */
+	AARCH64_INSN_COND_HI = 0x8, /* unsigned > */
+	AARCH64_INSN_COND_LS = 0x9, /* unsigned <= */
+	AARCH64_INSN_COND_GE = 0xa, /* signed >= */
+	AARCH64_INSN_COND_LT = 0xb, /* signed < */
+	AARCH64_INSN_COND_GT = 0xc, /* signed > */
+	AARCH64_INSN_COND_LE = 0xd, /* signed <= */
+	AARCH64_INSN_COND_AL = 0xe, /* always */
+};
+
+enum aarch64_insn_branch_type {
+	AARCH64_INSN_BRANCH_NOLINK,
+	AARCH64_INSN_BRANCH_LINK,
+	AARCH64_INSN_BRANCH_RETURN,
+	AARCH64_INSN_BRANCH_COMP_ZERO,
+	AARCH64_INSN_BRANCH_COMP_NONZERO,
+};
+
+enum aarch64_insn_size_type {
+	AARCH64_INSN_SIZE_8,
+	AARCH64_INSN_SIZE_16,
+	AARCH64_INSN_SIZE_32,
+	AARCH64_INSN_SIZE_64,
+};
+
+enum aarch64_insn_ldst_type {
+	AARCH64_INSN_LDST_LOAD_REG_OFFSET,
+	AARCH64_INSN_LDST_STORE_REG_OFFSET,
+	AARCH64_INSN_LDST_LOAD_PAIR_PRE_INDEX,
+	AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX,
+	AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
+	AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX,
+	AARCH64_INSN_LDST_LOAD_EX,
+	AARCH64_INSN_LDST_STORE_EX,
+};
+
+enum aarch64_insn_adsb_type {
+	AARCH64_INSN_ADSB_ADD,
+	AARCH64_INSN_ADSB_SUB,
+	AARCH64_INSN_ADSB_ADD_SETFLAGS,
+	AARCH64_INSN_ADSB_SUB_SETFLAGS
+};
+
+enum aarch64_insn_movewide_type {
+	AARCH64_INSN_MOVEWIDE_ZERO,
+	AARCH64_INSN_MOVEWIDE_KEEP,
+	AARCH64_INSN_MOVEWIDE_INVERSE
+};
+
+enum aarch64_insn_bitfield_type {
+	AARCH64_INSN_BITFIELD_MOVE,
+	AARCH64_INSN_BITFIELD_MOVE_UNSIGNED,
+	AARCH64_INSN_BITFIELD_MOVE_SIGNED
+};
+
+enum aarch64_insn_data1_type {
+	AARCH64_INSN_DATA1_REVERSE_16,
+	AARCH64_INSN_DATA1_REVERSE_32,
+	AARCH64_INSN_DATA1_REVERSE_64,
+};
+
+enum aarch64_insn_data2_type {
+	AARCH64_INSN_DATA2_UDIV,
+	AARCH64_INSN_DATA2_SDIV,
+	AARCH64_INSN_DATA2_LSLV,
+	AARCH64_INSN_DATA2_LSRV,
+	AARCH64_INSN_DATA2_ASRV,
+	AARCH64_INSN_DATA2_RORV,
+};
+
+enum aarch64_insn_data3_type {
+	AARCH64_INSN_DATA3_MADD,
+	AARCH64_INSN_DATA3_MSUB,
+};
+
+enum aarch64_insn_logic_type {
+	AARCH64_INSN_LOGIC_AND,
+	AARCH64_INSN_LOGIC_BIC,
+	AARCH64_INSN_LOGIC_ORR,
+	AARCH64_INSN_LOGIC_ORN,
+	AARCH64_INSN_LOGIC_EOR,
+	AARCH64_INSN_LOGIC_EON,
+	AARCH64_INSN_LOGIC_AND_SETFLAGS,
+	AARCH64_INSN_LOGIC_BIC_SETFLAGS
+};
+
+enum aarch64_insn_prfm_type {
+	AARCH64_INSN_PRFM_TYPE_PLD,
+	AARCH64_INSN_PRFM_TYPE_PLI,
+	AARCH64_INSN_PRFM_TYPE_PST,
+};
+
+enum aarch64_insn_prfm_target {
+	AARCH64_INSN_PRFM_TARGET_L1,
+	AARCH64_INSN_PRFM_TARGET_L2,
+	AARCH64_INSN_PRFM_TARGET_L3,
+};
+
+enum aarch64_insn_prfm_policy {
+	AARCH64_INSN_PRFM_POLICY_KEEP,
+	AARCH64_INSN_PRFM_POLICY_STRM,
+};
+
+enum aarch64_insn_adr_type {
+	AARCH64_INSN_ADR_TYPE_ADRP,
+	AARCH64_INSN_ADR_TYPE_ADR,
+};
+
+#define	__AARCH64_INSN_FUNCS(abbr, mask, val)				\
+static __always_inline bool aarch64_insn_is_##abbr(u32 code)		\
+{									\
+	BUILD_BUG_ON(~(mask) & (val));					\
+	return (code & (mask)) == (val);				\
+}									\
+static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
+{									\
+	return (val);							\
+}
+
+__AARCH64_INSN_FUNCS(adr,	0x9F000000, 0x10000000)
+__AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
+__AARCH64_INSN_FUNCS(prfm,	0x3FC00000, 0x39800000)
+__AARCH64_INSN_FUNCS(prfm_lit,	0xFF000000, 0xD8000000)
+__AARCH64_INSN_FUNCS(store_imm,	0x3FC00000, 0x39000000)
+__AARCH64_INSN_FUNCS(load_imm,	0x3FC00000, 0x39400000)
+__AARCH64_INSN_FUNCS(store_pre,	0x3FE00C00, 0x38000C00)
+__AARCH64_INSN_FUNCS(load_pre,	0x3FE00C00, 0x38400C00)
+__AARCH64_INSN_FUNCS(store_post,	0x3FE00C00, 0x38000400)
+__AARCH64_INSN_FUNCS(load_post,	0x3FE00C00, 0x38400400)
+__AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
+__AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
+__AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
+__AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
+__AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
+__AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
+__AARCH64_INSN_FUNCS(load_ex,	0x3F400000, 0x08400000)
+__AARCH64_INSN_FUNCS(store_ex,	0x3F400000, 0x08000000)
+__AARCH64_INSN_FUNCS(stp,	0x7FC00000, 0x29000000)
+__AARCH64_INSN_FUNCS(ldp,	0x7FC00000, 0x29400000)
+__AARCH64_INSN_FUNCS(stp_post,	0x7FC00000, 0x28800000)
+__AARCH64_INSN_FUNCS(ldp_post,	0x7FC00000, 0x28C00000)
+__AARCH64_INSN_FUNCS(stp_pre,	0x7FC00000, 0x29800000)
+__AARCH64_INSN_FUNCS(ldp_pre,	0x7FC00000, 0x29C00000)
+__AARCH64_INSN_FUNCS(add_imm,	0x7F000000, 0x11000000)
+__AARCH64_INSN_FUNCS(adds_imm,	0x7F000000, 0x31000000)
+__AARCH64_INSN_FUNCS(sub_imm,	0x7F000000, 0x51000000)
+__AARCH64_INSN_FUNCS(subs_imm,	0x7F000000, 0x71000000)
+__AARCH64_INSN_FUNCS(movn,	0x7F800000, 0x12800000)
+__AARCH64_INSN_FUNCS(sbfm,	0x7F800000, 0x13000000)
+__AARCH64_INSN_FUNCS(bfm,	0x7F800000, 0x33000000)
+__AARCH64_INSN_FUNCS(movz,	0x7F800000, 0x52800000)
+__AARCH64_INSN_FUNCS(ubfm,	0x7F800000, 0x53000000)
+__AARCH64_INSN_FUNCS(movk,	0x7F800000, 0x72800000)
+__AARCH64_INSN_FUNCS(add,	0x7F200000, 0x0B000000)
+__AARCH64_INSN_FUNCS(adds,	0x7F200000, 0x2B000000)
+__AARCH64_INSN_FUNCS(sub,	0x7F200000, 0x4B000000)
+__AARCH64_INSN_FUNCS(subs,	0x7F200000, 0x6B000000)
+__AARCH64_INSN_FUNCS(madd,	0x7FE08000, 0x1B000000)
+__AARCH64_INSN_FUNCS(msub,	0x7FE08000, 0x1B008000)
+__AARCH64_INSN_FUNCS(udiv,	0x7FE0FC00, 0x1AC00800)
+__AARCH64_INSN_FUNCS(sdiv,	0x7FE0FC00, 0x1AC00C00)
+__AARCH64_INSN_FUNCS(lslv,	0x7FE0FC00, 0x1AC02000)
+__AARCH64_INSN_FUNCS(lsrv,	0x7FE0FC00, 0x1AC02400)
+__AARCH64_INSN_FUNCS(asrv,	0x7FE0FC00, 0x1AC02800)
+__AARCH64_INSN_FUNCS(rorv,	0x7FE0FC00, 0x1AC02C00)
+__AARCH64_INSN_FUNCS(rev16,	0x7FFFFC00, 0x5AC00400)
+__AARCH64_INSN_FUNCS(rev32,	0x7FFFFC00, 0x5AC00800)
+__AARCH64_INSN_FUNCS(rev64,	0x7FFFFC00, 0x5AC00C00)
+__AARCH64_INSN_FUNCS(and,	0x7F200000, 0x0A000000)
+__AARCH64_INSN_FUNCS(bic,	0x7F200000, 0x0A200000)
+__AARCH64_INSN_FUNCS(orr,	0x7F200000, 0x2A000000)
+__AARCH64_INSN_FUNCS(mov_reg,	0x7FE0FFE0, 0x2A0003E0)
+__AARCH64_INSN_FUNCS(orn,	0x7F200000, 0x2A200000)
+__AARCH64_INSN_FUNCS(eor,	0x7F200000, 0x4A000000)
+__AARCH64_INSN_FUNCS(eon,	0x7F200000, 0x4A200000)
+__AARCH64_INSN_FUNCS(ands,	0x7F200000, 0x6A000000)
+__AARCH64_INSN_FUNCS(bics,	0x7F200000, 0x6A200000)
+__AARCH64_INSN_FUNCS(and_imm,	0x7F800000, 0x12000000)
+__AARCH64_INSN_FUNCS(orr_imm,	0x7F800000, 0x32000000)
+__AARCH64_INSN_FUNCS(eor_imm,	0x7F800000, 0x52000000)
+__AARCH64_INSN_FUNCS(ands_imm,	0x7F800000, 0x72000000)
+__AARCH64_INSN_FUNCS(extr,	0x7FA00000, 0x13800000)
+__AARCH64_INSN_FUNCS(b,		0xFC000000, 0x14000000)
+__AARCH64_INSN_FUNCS(bl,	0xFC000000, 0x94000000)
+__AARCH64_INSN_FUNCS(cbz,	0x7F000000, 0x34000000)
+__AARCH64_INSN_FUNCS(cbnz,	0x7F000000, 0x35000000)
+__AARCH64_INSN_FUNCS(tbz,	0x7F000000, 0x36000000)
+__AARCH64_INSN_FUNCS(tbnz,	0x7F000000, 0x37000000)
+__AARCH64_INSN_FUNCS(bcond,	0xFF000010, 0x54000000)
+__AARCH64_INSN_FUNCS(svc,	0xFFE0001F, 0xD4000001)
+__AARCH64_INSN_FUNCS(hvc,	0xFFE0001F, 0xD4000002)
+__AARCH64_INSN_FUNCS(smc,	0xFFE0001F, 0xD4000003)
+__AARCH64_INSN_FUNCS(brk,	0xFFE0001F, 0xD4200000)
+__AARCH64_INSN_FUNCS(exception,	0xFF000000, 0xD4000000)
+__AARCH64_INSN_FUNCS(hint,	0xFFFFF01F, 0xD503201F)
+__AARCH64_INSN_FUNCS(br,	0xFFFFFC1F, 0xD61F0000)
+__AARCH64_INSN_FUNCS(br_auth,	0xFEFFF800, 0xD61F0800)
+__AARCH64_INSN_FUNCS(blr,	0xFFFFFC1F, 0xD63F0000)
+__AARCH64_INSN_FUNCS(blr_auth,	0xFEFFF800, 0xD63F0800)
+__AARCH64_INSN_FUNCS(ret,	0xFFFFFC1F, 0xD65F0000)
+__AARCH64_INSN_FUNCS(ret_auth,	0xFFFFFBFF, 0xD65F0BFF)
+__AARCH64_INSN_FUNCS(eret,	0xFFFFFFFF, 0xD69F03E0)
+__AARCH64_INSN_FUNCS(eret_auth,	0xFFFFFBFF, 0xD69F0BFF)
+__AARCH64_INSN_FUNCS(mrs,	0xFFF00000, 0xD5300000)
+__AARCH64_INSN_FUNCS(msr_imm,	0xFFF8F01F, 0xD500401F)
+__AARCH64_INSN_FUNCS(msr_reg,	0xFFF00000, 0xD5100000)
+__AARCH64_INSN_FUNCS(dmb,	0xFFFFF0FF, 0xD50330BF)
+__AARCH64_INSN_FUNCS(dsb_base,	0xFFFFF0FF, 0xD503309F)
+__AARCH64_INSN_FUNCS(dsb_nxs,	0xFFFFF3FF, 0xD503323F)
+__AARCH64_INSN_FUNCS(isb,	0xFFFFF0FF, 0xD50330DF)
+__AARCH64_INSN_FUNCS(sb,	0xFFFFFFFF, 0xD50330FF)
+__AARCH64_INSN_FUNCS(clrex,	0xFFFFF0FF, 0xD503305F)
+__AARCH64_INSN_FUNCS(ssbb,	0xFFFFFFFF, 0xD503309F)
+__AARCH64_INSN_FUNCS(pssbb,	0xFFFFFFFF, 0xD503349F)
+
+#undef	__AARCH64_INSN_FUNCS
+
+bool aarch64_insn_is_steppable_hint(u32 insn);
+bool aarch64_insn_is_branch_imm(u32 insn);
+
+static inline bool aarch64_insn_is_adr_adrp(u32 insn)
+{
+	return aarch64_insn_is_adr(insn) || aarch64_insn_is_adrp(insn);
+}
+
+static inline bool aarch64_insn_is_dsb(u32 insn)
+{
+	return (aarch64_insn_is_dsb_base(insn) && (insn & 0xb00)) ||
+		aarch64_insn_is_dsb_nxs(insn);
+}
+
+static inline bool aarch64_insn_is_barrier(u32 insn)
+{
+	return aarch64_insn_is_dmb(insn) || aarch64_insn_is_dsb(insn) ||
+	       aarch64_insn_is_isb(insn) || aarch64_insn_is_sb(insn) ||
+	       aarch64_insn_is_clrex(insn) || aarch64_insn_is_ssbb(insn) ||
+	       aarch64_insn_is_pssbb(insn);
+}
+
+static inline bool aarch64_insn_is_store_single(u32 insn)
+{
+	return aarch64_insn_is_store_imm(insn) ||
+	       aarch64_insn_is_store_pre(insn) ||
+	       aarch64_insn_is_store_post(insn);
+}
+
+static inline bool aarch64_insn_is_store_pair(u32 insn)
+{
+	return aarch64_insn_is_stp(insn) ||
+	       aarch64_insn_is_stp_pre(insn) ||
+	       aarch64_insn_is_stp_post(insn);
+}
+
+static inline bool aarch64_insn_is_load_single(u32 insn)
+{
+	return aarch64_insn_is_load_imm(insn) ||
+	       aarch64_insn_is_load_pre(insn) ||
+	       aarch64_insn_is_load_post(insn);
+}
+
+static inline bool aarch64_insn_is_load_pair(u32 insn)
+{
+	return aarch64_insn_is_ldp(insn) ||
+	       aarch64_insn_is_ldp_pre(insn) ||
+	       aarch64_insn_is_ldp_post(insn);
+}
+
+enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
+bool aarch64_insn_uses_literal(u32 insn);
+bool aarch64_insn_is_branch(u32 insn);
+u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
+u32 aarch64_insn_decode_register(enum aarch64_insn_register_type type,
+					 u32 insn);
+u32 aarch64_insn_gen_hint(enum aarch64_insn_hint_cr_op op);
+u32 aarch64_insn_gen_nop(void);
+u32 aarch64_insn_gen_branch_reg(enum aarch64_insn_register reg,
+				enum aarch64_insn_branch_type type);
+s32 aarch64_get_branch_offset(u32 insn);
+s32 aarch64_insn_adrp_get_offset(u32 insn);
+
+#endif /* __ASSEMBLY__ */
+
+#endif	/* __ASM_INSN_H */
diff --git a/tools/arch/arm64/lib/insn.c b/tools/arch/arm64/lib/insn.c
new file mode 100644
index 000000000000..b0cc984fcf6a
--- /dev/null
+++ b/tools/arch/arm64/lib/insn.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2013 Huawei Ltd.
+ * Author: Jiang Liu <liuj97@gmail.com>
+ *
+ * Copyright (C) 2014-2016 Zi Shen Lim <zlim.lnx@gmail.com>
+ */
+#include <linux/bitops.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+#include <asm/errno.h>
+#include <asm/insn.h>
+
+#define AARCH64_DECODE_FAULT 0xFFFFFFFF
+
+#define AARCH64_INSN_SF_BIT	BIT(31)
+#define AARCH64_INSN_N_BIT	BIT(22)
+#define AARCH64_INSN_LSL_12	BIT(22)
+
+static const int aarch64_insn_encoding_class[] = {
+	AARCH64_INSN_CLS_UNKNOWN,
+	AARCH64_INSN_CLS_UNKNOWN,
+	AARCH64_INSN_CLS_SVE,
+	AARCH64_INSN_CLS_UNKNOWN,
+	AARCH64_INSN_CLS_LDST,
+	AARCH64_INSN_CLS_DP_REG,
+	AARCH64_INSN_CLS_LDST,
+	AARCH64_INSN_CLS_DP_FPSIMD,
+	AARCH64_INSN_CLS_DP_IMM,
+	AARCH64_INSN_CLS_DP_IMM,
+	AARCH64_INSN_CLS_BR_SYS,
+	AARCH64_INSN_CLS_BR_SYS,
+	AARCH64_INSN_CLS_LDST,
+	AARCH64_INSN_CLS_DP_REG,
+	AARCH64_INSN_CLS_LDST,
+	AARCH64_INSN_CLS_DP_FPSIMD,
+};
+
+enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn)
+{
+	return aarch64_insn_encoding_class[(insn >> 25) & 0xf];
+}
+
+bool aarch64_insn_is_steppable_hint(u32 insn)
+{
+	if (!aarch64_insn_is_hint(insn))
+		return false;
+
+	switch (insn & 0xFE0) {
+	case AARCH64_INSN_HINT_XPACLRI:
+	case AARCH64_INSN_HINT_PACIA_1716:
+	case AARCH64_INSN_HINT_PACIB_1716:
+	case AARCH64_INSN_HINT_PACIAZ:
+	case AARCH64_INSN_HINT_PACIASP:
+	case AARCH64_INSN_HINT_PACIBZ:
+	case AARCH64_INSN_HINT_PACIBSP:
+	case AARCH64_INSN_HINT_BTI:
+	case AARCH64_INSN_HINT_BTIC:
+	case AARCH64_INSN_HINT_BTIJ:
+	case AARCH64_INSN_HINT_BTIJC:
+	case AARCH64_INSN_HINT_NOP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+bool aarch64_insn_is_branch_imm(u32 insn)
+{
+	return (aarch64_insn_is_b(insn) || aarch64_insn_is_bl(insn) ||
+		aarch64_insn_is_tbz(insn) || aarch64_insn_is_tbnz(insn) ||
+		aarch64_insn_is_cbz(insn) || aarch64_insn_is_cbnz(insn) ||
+		aarch64_insn_is_bcond(insn));
+}
+
+bool aarch64_insn_uses_literal(u32 insn)
+{
+	/* ldr/ldrsw (literal), prfm */
+
+	return aarch64_insn_is_ldr_lit(insn) ||
+		aarch64_insn_is_ldrsw_lit(insn) ||
+		aarch64_insn_is_adr_adrp(insn) ||
+		aarch64_insn_is_prfm_lit(insn);
+}
+
+bool aarch64_insn_is_branch(u32 insn)
+{
+	/* b, bl, cb*, tb*, ret*, b.cond, br*, blr* */
+
+	return aarch64_insn_is_b(insn) ||
+		aarch64_insn_is_bl(insn) ||
+		aarch64_insn_is_cbz(insn) ||
+		aarch64_insn_is_cbnz(insn) ||
+		aarch64_insn_is_tbz(insn) ||
+		aarch64_insn_is_tbnz(insn) ||
+		aarch64_insn_is_ret(insn) ||
+		aarch64_insn_is_ret_auth(insn) ||
+		aarch64_insn_is_br(insn) ||
+		aarch64_insn_is_br_auth(insn) ||
+		aarch64_insn_is_blr(insn) ||
+		aarch64_insn_is_blr_auth(insn) ||
+		aarch64_insn_is_bcond(insn);
+}
+
+static int aarch64_get_imm_shift_mask(enum aarch64_insn_imm_type type,
+						u32 *maskp, int *shiftp)
+{
+	u32 mask;
+	int shift;
+
+	switch (type) {
+	case AARCH64_INSN_IMM_26:
+		mask = BIT(26) - 1;
+		shift = 0;
+		break;
+	case AARCH64_INSN_IMM_19:
+		mask = BIT(19) - 1;
+		shift = 5;
+		break;
+	case AARCH64_INSN_IMM_16:
+		mask = BIT(16) - 1;
+		shift = 5;
+		break;
+	case AARCH64_INSN_IMM_14:
+		mask = BIT(14) - 1;
+		shift = 5;
+		break;
+	case AARCH64_INSN_IMM_12:
+		mask = BIT(12) - 1;
+		shift = 10;
+		break;
+	case AARCH64_INSN_IMM_9:
+		mask = BIT(9) - 1;
+		shift = 12;
+		break;
+	case AARCH64_INSN_IMM_7:
+		mask = BIT(7) - 1;
+		shift = 15;
+		break;
+	case AARCH64_INSN_IMM_6:
+	case AARCH64_INSN_IMM_S:
+		mask = BIT(6) - 1;
+		shift = 10;
+		break;
+	case AARCH64_INSN_IMM_R:
+		mask = BIT(6) - 1;
+		shift = 16;
+		break;
+	case AARCH64_INSN_IMM_N:
+		mask = 1;
+		shift = 22;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*maskp = mask;
+	*shiftp = shift;
+
+	return 0;
+}
+
+#define ADR_IMM_HILOSPLIT	2
+#define ADR_IMM_SIZE		SZ_2M
+#define ADR_IMM_LOMASK		((1 << ADR_IMM_HILOSPLIT) - 1)
+#define ADR_IMM_HIMASK		((ADR_IMM_SIZE >> ADR_IMM_HILOSPLIT) - 1)
+#define ADR_IMM_LOSHIFT		29
+#define ADR_IMM_HISHIFT		5
+
+u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn)
+{
+	u32 immlo, immhi, mask;
+	int shift;
+
+	switch (type) {
+	case AARCH64_INSN_IMM_ADR:
+		shift = 0;
+		immlo = (insn >> ADR_IMM_LOSHIFT) & ADR_IMM_LOMASK;
+		immhi = (insn >> ADR_IMM_HISHIFT) & ADR_IMM_HIMASK;
+		insn = (immhi << ADR_IMM_HILOSPLIT) | immlo;
+		mask = ADR_IMM_SIZE - 1;
+		break;
+	default:
+		if (aarch64_get_imm_shift_mask(type, &mask, &shift) < 0) {
+			WARN("aarch64_insn_decode_immediate: unknown immediate encoding %d\n",
+					type);
+			return AARCH64_DECODE_FAULT;
+		}
+	}
+
+	return (insn >> shift) & mask;
+}
+
+u32 aarch64_insn_decode_register(enum aarch64_insn_register_type type,
+					u32 insn)
+{
+	int shift;
+
+	switch (type) {
+	case AARCH64_INSN_REGTYPE_RT:
+	case AARCH64_INSN_REGTYPE_RD:
+		shift = 0;
+		break;
+	case AARCH64_INSN_REGTYPE_RN:
+		shift = 5;
+		break;
+	case AARCH64_INSN_REGTYPE_RT2:
+	case AARCH64_INSN_REGTYPE_RA:
+		shift = 10;
+		break;
+	case AARCH64_INSN_REGTYPE_RM:
+		shift = 16;
+		break;
+	default:
+		WARN("%s: unknown register type encoding %d\n", __func__,
+				type);
+		return AARCH64_DECODE_FAULT;
+	}
+
+	return (insn >> shift) & GENMASK(4, 0);
+}
+
+u32 aarch64_insn_gen_hint(enum aarch64_insn_hint_cr_op op)
+{
+	return aarch64_insn_get_hint_value() | op;
+}
+
+u32 aarch64_insn_gen_nop(void)
+{
+	return aarch64_insn_gen_hint(AARCH64_INSN_HINT_NOP);
+}
+
+static u32 aarch64_insn_encode_register(enum aarch64_insn_register_type type,
+					u32 insn,
+					enum aarch64_insn_register reg)
+{
+	int shift;
+
+	if (insn == AARCH64_DECODE_FAULT)
+		return AARCH64_DECODE_FAULT;
+
+	if (reg < AARCH64_INSN_REG_0 || reg > AARCH64_INSN_REG_SP) {
+		WARN("%s: unknown register encoding %d\n", __func__, reg);
+		return AARCH64_DECODE_FAULT;
+	}
+
+	switch (type) {
+	case AARCH64_INSN_REGTYPE_RT:
+	case AARCH64_INSN_REGTYPE_RD:
+		shift = 0;
+		break;
+	case AARCH64_INSN_REGTYPE_RN:
+		shift = 5;
+		break;
+	case AARCH64_INSN_REGTYPE_RT2:
+	case AARCH64_INSN_REGTYPE_RA:
+		shift = 10;
+		break;
+	case AARCH64_INSN_REGTYPE_RM:
+	case AARCH64_INSN_REGTYPE_RS:
+		shift = 16;
+		break;
+	default:
+		WARN("%s: unknown register type encoding %d\n", __func__,
+		       type);
+		return AARCH64_DECODE_FAULT;
+	}
+
+	insn &= ~(GENMASK(4, 0) << shift);
+	insn |= reg << shift;
+
+	return insn;
+}
+
+u32 aarch64_insn_gen_branch_reg(enum aarch64_insn_register reg,
+				enum aarch64_insn_branch_type type)
+{
+	u32 insn;
+
+	switch (type) {
+	case AARCH64_INSN_BRANCH_NOLINK:
+		insn = aarch64_insn_get_br_value();
+		break;
+	case AARCH64_INSN_BRANCH_LINK:
+		insn = aarch64_insn_get_blr_value();
+		break;
+	case AARCH64_INSN_BRANCH_RETURN:
+		insn = aarch64_insn_get_ret_value();
+		break;
+	default:
+		WARN("%s: unknown branch encoding %d\n", __func__, type);
+		return AARCH64_DECODE_FAULT;
+	}
+
+	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, reg);
+}
+
+/*
+ * Decode the imm field of a branch, and return the byte offset as a
+ * signed value (so it can be used when computing a new branch
+ * target).
+ */
+s32 aarch64_get_branch_offset(u32 insn)
+{
+	s32 imm;
+
+	if (aarch64_insn_is_b(insn) || aarch64_insn_is_bl(insn)) {
+		imm = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_26, insn);
+		return (imm << 6) >> 4;
+	}
+
+	if (aarch64_insn_is_cbz(insn) || aarch64_insn_is_cbnz(insn) ||
+	    aarch64_insn_is_bcond(insn)) {
+		imm = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_19, insn);
+		return (imm << 13) >> 11;
+	}
+
+	if (aarch64_insn_is_tbz(insn) || aarch64_insn_is_tbnz(insn)) {
+		imm = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_14, insn);
+		return (imm << 18) >> 16;
+	}
+
+	WARN("Unhandled instruction %x", insn);
+	return AARCH64_DECODE_FAULT;
+}
+
+s32 aarch64_insn_adrp_get_offset(u32 insn)
+{
+	if (!aarch64_insn_is_adrp(insn)) {
+		WARN("Unhandled instruction %x", insn);
+		return AARCH64_DECODE_FAULT;
+	}
+	return aarch64_insn_decode_immediate(AARCH64_INSN_IMM_ADR, insn) << 12;
+}
-- 
2.17.1

