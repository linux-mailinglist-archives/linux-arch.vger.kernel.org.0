Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01DD554FDA
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 17:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359516AbiFVPws (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 11:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358390AbiFVPwr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 11:52:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDC310D4;
        Wed, 22 Jun 2022 08:52:44 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LSnvD5W9HzDsH1;
        Wed, 22 Jun 2022 23:52:08 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:42 +0800
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
Subject: [PATCH v5 02/33] objtool: arm64: Add base definition for arm64 backend
Date:   Wed, 22 Jun 2022 23:48:49 +0800
Message-ID: <20220622154920.95075-3-chenzhongjin@huawei.com>
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

Provide needed definitions for a new architecture instruction decoder.
No proper decoding is done yet.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/objtool/Makefile                        |   4 +
 tools/objtool/arch/arm64/Build                |   8 +
 tools/objtool/arch/arm64/decode.c             | 138 ++++++++++++++++++
 .../arch/arm64/include/arch/cfi_regs.h        |  14 ++
 tools/objtool/arch/arm64/include/arch/elf.h   |  12 ++
 .../arch/arm64/include/arch/endianness.h      |   9 ++
 .../objtool/arch/arm64/include/arch/special.h |  22 +++
 tools/objtool/arch/arm64/special.c            |  21 +++
 8 files changed, 228 insertions(+)
 create mode 100644 tools/objtool/arch/arm64/Build
 create mode 100644 tools/objtool/arch/arm64/decode.c
 create mode 100644 tools/objtool/arch/arm64/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/elf.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/endianness.h
 create mode 100644 tools/objtool/arch/arm64/include/arch/special.h
 create mode 100644 tools/objtool/arch/arm64/special.c

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 2b97720ab608..3f7c7b54c741 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -45,6 +45,10 @@ ifeq ($(SRCARCH),x86)
 	BUILD_ORC := y
 endif
 
+ifeq ($(SRCARCH),arm64)
+	CFLAGS  += -Wno-nested-externs
+endif
+
 export BUILD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/objtool/arch/arm64/Build b/tools/objtool/arch/arm64/Build
new file mode 100644
index 000000000000..f3de3a50d541
--- /dev/null
+++ b/tools/objtool/arch/arm64/Build
@@ -0,0 +1,8 @@
+objtool-y += special.o
+objtool-y += decode.o
+
+objtool-y += libhweight.o
+
+$(OUTPUT)arch/arm64/libhweight.o: ../lib/hweight.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
new file mode 100644
index 000000000000..afe22c4593c8
--- /dev/null
+++ b/tools/objtool/arch/arm64/decode.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+
+#include <asm/insn.h>
+
+#include <objtool/check.h>
+#include <objtool/arch.h>
+#include <objtool/elf.h>
+#include <objtool/warn.h>
+#include <objtool/builtin.h>
+#include <arch/cfi_regs.h>
+
+#include "../../../arch/arm64/lib/insn.c"
+
+bool arch_callee_saved_reg(unsigned char reg)
+{
+	switch (reg) {
+	case AARCH64_INSN_REG_19:
+	case AARCH64_INSN_REG_20:
+	case AARCH64_INSN_REG_21:
+	case AARCH64_INSN_REG_22:
+	case AARCH64_INSN_REG_23:
+	case AARCH64_INSN_REG_24:
+	case AARCH64_INSN_REG_25:
+	case AARCH64_INSN_REG_26:
+	case AARCH64_INSN_REG_27:
+	case AARCH64_INSN_REG_28:
+	case AARCH64_INSN_REG_FP:
+	case AARCH64_INSN_REG_LR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+void arch_initial_func_cfi_state(struct cfi_init_state *state)
+{
+	int i;
+
+	for (i = 0; i < CFI_NUM_REGS; i++) {
+		state->regs[i].base = CFI_UNDEFINED;
+		state->regs[i].offset = 0;
+	}
+
+	/* initial CFA (call frame address) */
+	state->cfa.base = CFI_SP;
+	state->cfa.offset = 0;
+}
+
+unsigned long arch_dest_reloc_offset(int addend)
+{
+	return addend;
+}
+
+unsigned long arch_jump_destination(struct instruction *insn)
+{
+	return insn->offset + insn->immediate;
+}
+
+const char *arch_nop_insn(int len)
+{
+	static u32 nop;
+
+	if (len != AARCH64_INSN_SIZE)
+		WARN("invalid NOP size: %d\n", len);
+
+	if (!nop)
+		nop = aarch64_insn_gen_nop();
+
+	return (const char *)&nop;
+}
+
+const char *arch_ret_insn(int len)
+{
+	static u32 ret;
+
+	if (len != AARCH64_INSN_SIZE)
+		WARN("invalid RET size: %d\n", len);
+
+	if (!ret) {
+		ret = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_LR,
+				AARCH64_INSN_BRANCH_RETURN);
+	}
+
+	return (const char *)&ret;
+}
+
+static int is_arm64(const struct elf *elf)
+{
+	switch (elf->ehdr.e_machine) {
+	case EM_AARCH64: //0xB7
+		return 1;
+	default:
+		WARN("unexpected ELF machine type %x",
+		     elf->ehdr.e_machine);
+		return 0;
+	}
+}
+
+int arch_decode_hint_reg(u8 sp_reg, int *base)
+{
+	return -1;
+}
+
+int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
+			    unsigned long offset, unsigned int maxlen,
+			    unsigned int *len, enum insn_type *type,
+			    unsigned long *immediate,
+			    struct list_head *ops_list)
+{
+	const struct elf *elf = file->elf;
+	u32 insn;
+
+	if (!is_arm64(elf))
+		return -1;
+
+	if (maxlen < AARCH64_INSN_SIZE)
+		return 0;
+
+	*len = AARCH64_INSN_SIZE;
+	*immediate = 0;
+	*type = INSN_OTHER;
+
+	insn = *(u32 *)(sec->data->d_buf + offset);
+
+	switch (aarch64_get_insn_class(insn)) {
+	case AARCH64_INSN_CLS_UNKNOWN:
+		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
+		return -1;
+	default:
+		break;
+	}
+
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/arch/cfi_regs.h b/tools/objtool/arch/arm64/include/arch/cfi_regs.h
new file mode 100644
index 000000000000..a5185649686b
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/arch/cfi_regs.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _OBJTOOL_CFI_REGS_H
+#define _OBJTOOL_CFI_REGS_H
+
+#include <asm/insn.h>
+
+#define CFI_BP			AARCH64_INSN_REG_FP
+#define CFI_RA			AARCH64_INSN_REG_LR
+#define CFI_SP			AARCH64_INSN_REG_SP
+
+#define CFI_NUM_REGS		32
+
+#endif /* _OBJTOOL_CFI_REGS_H */
diff --git a/tools/objtool/arch/arm64/include/arch/elf.h b/tools/objtool/arch/arm64/include/arch/elf.h
new file mode 100644
index 000000000000..a59888a906b5
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/arch/elf.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+
+#ifndef _OBJTOOL_ARCH_ELF
+#define _OBJTOOL_ARCH_ELF
+
+#define R_NTYPE	-1
+#define R_NONE	R_AARCH64_NONE
+#define R_ABS64	R_AARCH64_ABS64
+#define R_REL32	R_AARCH64_PREL32
+#define R_PLT32	R_NTYPE
+
+#endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/arch/arm64/include/arch/endianness.h b/tools/objtool/arch/arm64/include/arch/endianness.h
new file mode 100644
index 000000000000..7c362527da20
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/arch/endianness.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ARCH_ENDIANNESS_H
+#define _ARCH_ENDIANNESS_H
+
+#include <endian.h>
+
+#define __TARGET_BYTE_ORDER __LITTLE_ENDIAN
+
+#endif /* _ARCH_ENDIANNESS_H */
diff --git a/tools/objtool/arch/arm64/include/arch/special.h b/tools/objtool/arch/arm64/include/arch/special.h
new file mode 100644
index 000000000000..63a705c622a4
--- /dev/null
+++ b/tools/objtool/arch/arm64/include/arch/special.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ARM64_ARCH_SPECIAL_H
+#define _ARM64_ARCH_SPECIAL_H
+
+#define EX_ENTRY_SIZE		12
+#define EX_ORIG_OFFSET		0
+#define EX_NEW_OFFSET		4
+
+#define JUMP_ENTRY_SIZE		16
+#define JUMP_ORIG_OFFSET	0
+#define JUMP_NEW_OFFSET		4
+#define JUMP_KEY_OFFSET		8
+
+#define ALT_ENTRY_SIZE		12
+#define ALT_ORIG_OFFSET		0
+#define ALT_NEW_OFFSET		4
+#define ALT_FEATURE_OFFSET	8
+#define ALT_ORIG_LEN_OFFSET	10
+#define ALT_NEW_LEN_OFFSET	11
+
+#endif /* _ARM64_ARCH_SPECIAL_H */
diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
new file mode 100644
index 000000000000..45f283283091
--- /dev/null
+++ b/tools/objtool/arch/arm64/special.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <objtool/special.h>
+
+void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
+{
+}
+
+bool arch_support_alt_relocation(struct special_alt *special_alt,
+				 struct instruction *insn,
+				 struct reloc *reloc)
+{
+	return false;
+}
+
+
+struct reloc *arch_find_switch_table(struct objtool_file *file,
+				     struct instruction *insn)
+{
+	return NULL;
+}
-- 
2.17.1

