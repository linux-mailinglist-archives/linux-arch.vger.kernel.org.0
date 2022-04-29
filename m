Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1D95145AD
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 11:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356882AbiD2Jtc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 05:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356872AbiD2Js6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 05:48:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FF2A6E3D;
        Fri, 29 Apr 2022 02:45:40 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KqSJB2Ncdz1JBmy;
        Fri, 29 Apr 2022 17:44:42 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:10 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:10 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arch@vger.kernel.org>
CC:     <jthierry@redhat.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <masahiroy@kernel.org>, <jpoimboe@redhat.com>,
        <peterz@infradead.org>, <ycote@redhat.com>,
        <herbert@gondor.apana.org.au>, <mark.rutland@arm.com>,
        <davem@davemloft.net>, <ardb@kernel.org>, <maz@kernel.org>,
        <tglx@linutronix.de>, <luc.vanoostenryck@gmail.com>,
        <chenzhongjin@huawei.com>
Subject: [RFC PATCH v4 08/37] objtool: arm64: Decode load/store instructions
Date:   Fri, 29 Apr 2022 17:43:26 +0800
Message-ID: <20220429094355.122389-9-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220429094355.122389-1-chenzhongjin@huawei.com>
References: <20220429094355.122389-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Julien Thierry <jthierry@redhat.com>

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
 tools/objtool/arch/arm64/decode.c | 144 ++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index b07e0f51637e..4a868945dcfb 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -112,6 +112,48 @@ int arch_decode_hint_reg(u8 sp_reg, int *base)
 	return -1;
 }
 
+static struct stack_op *arm_make_store_op(enum aarch64_insn_register base,
+					  enum aarch64_insn_register reg,
+					  int offset)
+{
+	struct stack_op *op;
+
+	op = calloc(1, sizeof(*op));
+	if (!op) {
+		WARN("calloc failed");
+		return NULL;
+	}
+	op->dest.type = OP_DEST_REG_INDIRECT;
+	op->dest.reg = base;
+	op->dest.offset = offset;
+	op->src.type = OP_SRC_REG;
+	op->src.reg = reg;
+	op->src.offset = 0;
+
+	return op;
+}
+
+static struct stack_op *arm_make_load_op(enum aarch64_insn_register base,
+					 enum aarch64_insn_register reg,
+					 int offset)
+{
+	struct stack_op *op;
+
+	op = calloc(1, sizeof(*op));
+	if (!op) {
+		WARN("calloc failed");
+		return NULL;
+	}
+	op->dest.type = OP_DEST_REG;
+	op->dest.reg = reg;
+	op->dest.offset = 0;
+	op->src.type = OP_SRC_REG_INDIRECT;
+	op->src.reg = base;
+	op->src.offset = offset;
+
+	return op;
+}
+
 static struct stack_op *arm_make_add_op(enum aarch64_insn_register dest,
 					enum aarch64_insn_register src,
 					int val)
@@ -132,6 +174,98 @@ static struct stack_op *arm_make_add_op(enum aarch64_insn_register dest,
 	return op;
 }
 
+static int arm_decode_load_store(u32 insn, unsigned long *immediate,
+				 struct list_head *ops_list)
+{
+	enum aarch64_insn_register base;
+	enum aarch64_insn_register rt;
+	struct stack_op *op;
+	int size;
+	int offset;
+
+	if (aarch64_insn_is_store_single(insn) ||
+	    aarch64_insn_is_load_single(insn))
+		size = 1 << ((insn & GENMASK(31, 30)) >> 30);
+	else
+		size = 4 << ((insn >> 31) & 1);
+
+	if (aarch64_insn_is_store_imm(insn) || aarch64_insn_is_load_imm(insn))
+		*immediate = size * aarch64_insn_decode_immediate(AARCH64_INSN_IMM_12,
+								  insn);
+	else if (aarch64_insn_is_store_pre(insn) ||
+		 aarch64_insn_is_load_pre(insn) ||
+		 aarch64_insn_is_store_post(insn) ||
+		 aarch64_insn_is_load_post(insn))
+		*immediate = sign_extend(aarch64_insn_decode_immediate(AARCH64_INSN_IMM_9,
+								       insn),
+					 9);
+	else if (aarch64_insn_is_stp(insn) || aarch64_insn_is_ldp(insn) ||
+		 aarch64_insn_is_stp_pre(insn) ||
+		 aarch64_insn_is_ldp_pre(insn) ||
+		 aarch64_insn_is_stp_post(insn) ||
+		 aarch64_insn_is_ldp_post(insn))
+		*immediate = size * sign_extend(aarch64_insn_decode_immediate(AARCH64_INSN_IMM_7,
+									      insn),
+						7);
+	else
+		return 1;
+
+	base = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, insn);
+	if (base != AARCH64_INSN_REG_FP && base != AARCH64_INSN_REG_SP)
+		return 0;
+
+	offset = *immediate;
+
+	if (aarch64_insn_is_store_pre(insn) || aarch64_insn_is_stp_pre(insn) ||
+	    aarch64_insn_is_store_post(insn) || aarch64_insn_is_stp_post(insn)) {
+		op = arm_make_add_op(base, base, *immediate);
+		list_add_tail(&op->list, ops_list);
+
+		if (aarch64_insn_is_store_post(insn) || aarch64_insn_is_stp_post(insn))
+			offset = -*immediate;
+		else
+			offset = 0;
+	} else if (aarch64_insn_is_load_post(insn) || aarch64_insn_is_ldp_post(insn)) {
+		offset = 0;
+	}
+
+	/* First register */
+	rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
+	if (aarch64_insn_is_store_single(insn) ||
+	    aarch64_insn_is_store_pair(insn))
+		op = arm_make_store_op(base, rt, offset);
+	else
+		op = arm_make_load_op(base, rt, offset);
+
+	if (!op)
+		return -1;
+	list_add_tail(&op->list, ops_list);
+
+	/* Second register (if present) */
+	if (aarch64_insn_is_store_pair(insn) ||
+	    aarch64_insn_is_load_pair(insn)) {
+		rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT2,
+						  insn);
+		if (aarch64_insn_is_store_pair(insn))
+			op = arm_make_store_op(base, rt, offset + size);
+		else
+			op = arm_make_load_op(base, rt, offset + size);
+		if (!op)
+			return -1;
+		list_add_tail(&op->list, ops_list);
+	}
+
+	if (aarch64_insn_is_load_pre(insn) || aarch64_insn_is_ldp_pre(insn) ||
+	    aarch64_insn_is_load_post(insn) || aarch64_insn_is_ldp_post(insn)) {
+		op = arm_make_add_op(base, base, *immediate);
+		if (!op)
+			return -1;
+		list_add_tail(&op->list, ops_list);
+	}
+
+	return 0;
+}
+
 static int arm_decode_add_sub_imm(u32 instr, bool set_flags,
 				  unsigned long *immediate,
 				  struct list_head *ops_list)
@@ -247,6 +381,16 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			*immediate = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn);
 		}
 		break;
+	case AARCH64_INSN_CLS_LDST:
+	{
+		int ret;
+
+		ret = arm_decode_load_store(insn, immediate, ops_list);
+		if (ret <= 0)
+			return ret;
+
+		break;
+	}
 	default:
 		break;
 	}
-- 
2.17.1

