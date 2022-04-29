Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFDE5145A9
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 11:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356770AbiD2Jsi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 05:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245068AbiD2Jsc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 05:48:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1551A3BF;
        Fri, 29 Apr 2022 02:45:13 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KqSCS2d4HzCsRc;
        Fri, 29 Apr 2022 17:40:36 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:11 +0800
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
Subject: [RFC PATCH v4 09/37] objtool: arm64: Decode LDR instructions
Date:   Fri, 29 Apr 2022 17:43:27 +0800
Message-ID: <20220429094355.122389-10-chenzhongjin@huawei.com>
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

Load literal instructions can generate constants inside code sections.
Record the locations of the constants in order to be able to remove
their corresponding "struct instruction".

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/objtool/arch/arm64/decode.c    | 86 ++++++++++++++++++++++++++++
 tools/objtool/arch/x86/decode.c      |  5 ++
 tools/objtool/check.c                |  3 +
 tools/objtool/include/objtool/arch.h |  3 +
 4 files changed, 97 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 4a868945dcfb..b62addece734 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -22,6 +22,73 @@ static unsigned long sign_extend(unsigned long x, int nbits)
 	return ((~0UL + (sign_bit ^ 1)) << nbits) | x;
 }
 
+struct insn_loc {
+	const struct section *sec;
+	unsigned long offset;
+	struct hlist_node hnode;
+	bool delete;
+};
+
+DEFINE_HASHTABLE(invalid_insns, 16);
+
+static int record_invalid_insn(const struct section *sec,
+			       unsigned long offset,
+			       bool delete)
+{
+	struct insn_loc *loc;
+	struct hlist_head *l;
+
+	l = &invalid_insns[hash_min(offset, HASH_BITS(invalid_insns))];
+	if (!hlist_empty(l)) {
+		loc = hlist_entry(l->first, struct insn_loc, hnode);
+		loc->delete |= delete;
+		return 0;
+	}
+
+	loc = malloc(sizeof(*loc));
+	if (!loc) {
+		WARN("malloc failed");
+		return -1;
+	}
+
+	loc->sec = sec;
+	loc->offset = offset;
+	loc->delete = delete;
+
+	hash_add(invalid_insns, &loc->hnode, loc->offset);
+
+	return 0;
+}
+
+int arch_post_process_instructions(struct objtool_file *file)
+{
+	struct hlist_node *tmp;
+	struct insn_loc *loc;
+	unsigned int bkt;
+	int res = 0;
+
+	hash_for_each_safe(invalid_insns, bkt, tmp, loc, hnode) {
+		struct instruction *insn;
+
+		insn = find_insn(file, (struct section *) loc->sec, loc->offset);
+		if (insn) {
+			if (loc->delete) {
+				list_del(&insn->list);
+				hash_del(&insn->hash);
+				free(insn);
+			} else {
+				WARN_FUNC("can't decode instruction", insn->sec, insn->offset);
+				insn->ignore = true;
+			}
+		}
+
+		hash_del(&loc->hnode);
+		free(loc);
+	}
+
+	return res;
+}
+
 bool arch_callee_saved_reg(unsigned char reg)
 {
 	switch (reg) {
@@ -389,6 +456,25 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		if (ret <= 0)
 			return ret;
 
+		if (aarch64_insn_is_ldr_lit(insn)) {
+			long pc_offset;
+
+			pc_offset = insn & GENMASK(23, 5);
+			/* Sign extend and multiply by 4 */
+			pc_offset = (pc_offset << (64 - 23));
+			pc_offset = ((pc_offset >> (64 - 23)) >> 5) << 2;
+
+			if (record_invalid_insn(sec, offset + pc_offset, true))
+				return -1;
+
+			/* 64-bit literal */
+			if (insn & BIT(30)) {
+				if (record_invalid_insn(sec,
+							offset + pc_offset + 4,
+							true))
+					return -1;
+			}
+		}
 		break;
 	}
 	default:
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 943cb41cddf7..c116b6a58898 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -693,6 +693,11 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 	return 0;
 }
 
+int arch_post_process_instructions(struct objtool_file *file)
+{
+	return 0;
+}
+
 void arch_initial_func_cfi_state(struct cfi_init_state *state)
 {
 	int i;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bd0c2c828940..e71c2ab7327a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -436,6 +436,9 @@ static int decode_instructions(struct objtool_file *file)
 	if (stats)
 		printf("nr_insns: %lu\n", nr_insns);
 
+	if (arch_post_process_instructions(file))
+		return -1;
+
 	return 0;
 
 err:
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 9b19cc304195..ccd76ce1c92b 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -67,6 +67,7 @@ struct stack_op {
 	struct list_head list;
 };
 
+struct objtool_file;
 struct instruction;
 
 void arch_initial_func_cfi_state(struct cfi_init_state *state);
@@ -77,6 +78,8 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			    unsigned long *immediate,
 			    struct list_head *ops_list);
 
+int arch_post_process_instructions(struct objtool_file *file);
+
 bool arch_callee_saved_reg(unsigned char reg);
 
 unsigned long arch_jump_destination(struct instruction *insn);
-- 
2.17.1

