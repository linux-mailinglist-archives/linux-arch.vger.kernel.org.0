Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2A355501A
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 17:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiFVPyI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 11:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359658AbiFVPxC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 11:53:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA6B2D1E6;
        Wed, 22 Jun 2022 08:52:47 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LSnsx4Rs9zkWMD;
        Wed, 22 Jun 2022 23:51:01 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:43 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:42 +0800
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
Subject: [PATCH v5 06/33] objtool: arm64: Decode load/store instructions
Date:   Wed, 22 Jun 2022 23:48:53 +0800
Message-ID: <20220622154920.95075-7-chenzhongjin@huawei.com>
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

Decode load/store operations and create corresponding stack_ops for
operations targeting SP or FP.

Operations storing/loading multiple registers are split into separate
stack_ops storing single registers.

Operations modifying the base register get an additional stack_op
for the register update. Since the atomic register(s) load/store + base
register update gets split into multiple operations, to make sure
objtool always sees a valid stack, consider store instruction to perform
stack allocations (i.e. modifying the base pointer before the storing)
and loads de-allocations (i.e. modifying the base pointer after the
load).

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/objtool/arch/arm64/decode.c | 113 ++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 19840862f3aa..c8d50d041889 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -132,6 +132,114 @@ static inline void make_add_op(enum aarch64_insn_register dest,
 	op->src.offset = val;
 }
 
+static inline void make_store_op(enum aarch64_insn_register base,
+					  enum aarch64_insn_register reg,
+					  int offset, struct stack_op *op)
+{
+	op->dest.type = OP_DEST_REG_INDIRECT;
+	op->dest.reg = base;
+	op->dest.offset = offset;
+	op->src.type = OP_SRC_REG;
+	op->src.reg = reg;
+	op->src.offset = 0;
+}
+
+static inline void make_load_op(enum aarch64_insn_register base,
+					 enum aarch64_insn_register reg,
+					 int offset, struct stack_op *op)
+{
+	op->dest.type = OP_DEST_REG;
+	op->dest.reg = reg;
+	op->dest.offset = 0;
+	op->src.type = OP_SRC_REG_INDIRECT;
+	op->src.reg = base;
+	op->src.offset = offset;
+}
+
+static inline bool aarch64_insn_is_ldst_pre(u32 insn)
+{
+	return aarch64_insn_is_store_pre(insn) ||
+		   aarch64_insn_is_load_pre(insn) ||
+		   aarch64_insn_is_stp_pre(insn) ||
+		   aarch64_insn_is_ldp_pre(insn);
+}
+
+static inline bool aarch64_insn_is_ldst_post(u32 insn)
+{
+	return aarch64_insn_is_store_post(insn) ||
+		   aarch64_insn_is_load_post(insn) ||
+		   aarch64_insn_is_stp_post(insn) ||
+		   aarch64_insn_is_ldp_post(insn);
+}
+
+static int decode_load_store(u32 insn, unsigned long *immediate,
+				 struct list_head *ops_list)
+{
+	enum aarch64_insn_register base;
+	enum aarch64_insn_register rt;
+	struct stack_op *op;
+	int size;
+	int offset;
+
+	if (aarch64_insn_is_store_single(insn) ||
+			aarch64_insn_is_load_single(insn))
+		size = 1 << ((insn & GENMASK(31, 30)) >> 30);
+	else
+		size = 4 << ((insn >> 31) & 1);
+
+	if (aarch64_insn_is_store_pair(insn) ||
+			aarch64_insn_is_load_pair(insn))
+		*immediate = size * sign_extend(aarch64_insn_decode_immediate(AARCH64_INSN_IMM_7,
+									      insn), 7);
+	else if (aarch64_insn_is_store_imm(insn) ||
+			aarch64_insn_is_load_imm(insn))
+		*immediate = size * aarch64_insn_decode_immediate(AARCH64_INSN_IMM_12, insn);
+	else /* load/store_pre/post */ 
+		*immediate = sign_extend(aarch64_insn_decode_immediate(AARCH64_INSN_IMM_9,
+								       insn), 9);
+
+	base = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, insn);
+	if (!is_SPFP(base))
+		return 0;
+
+	if (aarch64_insn_is_ldst_post(insn))
+		offset = 0;
+	else
+		offset = *immediate;
+
+	/* First register */
+	rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
+	ADD_OP(op) {
+		if (aarch64_insn_is_store_single(insn) ||
+			aarch64_insn_is_store_pair(insn))
+			make_store_op(base, rt, offset, op);
+		else
+			make_load_op(base, rt, offset, op);
+	}
+
+	/* Second register (if present) */
+	if (aarch64_insn_is_store_pair(insn) ||
+			aarch64_insn_is_load_pair(insn)) {
+		rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT2,
+						  insn);
+		ADD_OP(op) {
+			if (aarch64_insn_is_store_pair(insn))
+				make_store_op(base, rt, offset + size, op);
+			else
+				make_load_op(base, rt, offset + size, op);
+		}
+	}
+
+	if (aarch64_insn_is_ldst_pre(insn) ||
+			aarch64_insn_is_ldst_post(insn)) {
+		ADD_OP(op) {
+			make_add_op(base, base, *immediate, op);
+		}
+	}
+
+	return 0;
+}
+
 static void decode_add_sub_imm(u32 instr, bool set_flags,
 				  unsigned long *immediate,
 				  struct stack_op *op)
@@ -241,6 +349,11 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			*immediate = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn);
 		}
 		break;
+	case AARCH64_INSN_CLS_LDST:
+	{
+		return decode_load_store(insn, immediate, ops_list);
+	}
 	default:
 		break;
 	}
-- 
2.17.1

