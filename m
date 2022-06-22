Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3431554FE9
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 17:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359164AbiFVPw4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 11:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359627AbiFVPws (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 11:52:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6856955A2;
        Wed, 22 Jun 2022 08:52:46 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LSntW4dPDzkWZl;
        Wed, 22 Jun 2022 23:51:31 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:44 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:44 +0800
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
Subject: [PATCH v5 13/33] objtool: arm64: Enable ORC for arm64
Date:   Wed, 22 Jun 2022 23:49:00 +0800
Message-ID: <20220622154920.95075-14-chenzhongjin@huawei.com>
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

Add orc_type, orc build and ld options for arm64.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm64/Kconfig.debug                 |  10 ++
 arch/arm64/include/asm/module.h          |   7 ++
 arch/arm64/include/asm/orc_types.h       |  68 +++++++++++++
 arch/arm64/kernel/vmlinux.lds.S          |   3 +
 scripts/Makefile                         |   6 +-
 tools/arch/arm64/include/asm/orc_types.h |  68 +++++++++++++
 tools/objtool/Makefile                   |   1 +
 tools/objtool/arch/arm64/Build           |   1 +
 tools/objtool/arch/arm64/orc.c           | 117 +++++++++++++++++++++++
 9 files changed, 280 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/orc_types.h
 create mode 100644 tools/arch/arm64/include/asm/orc_types.h
 create mode 100644 tools/objtool/arch/arm64/orc.c

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index c2c68c6f7557..ec804a21c753 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -39,6 +39,16 @@ config UNWINDER_FRAME_POINTER
       unwinder, but the kernel text size will grow by ~3% and the kernel's
       overall performance will degrade by roughly 5-10%.
 
+config UNWINDER_ORC
+	bool "ORC unwinder"
+	select OBJTOOL
+	help
+	  This option enables the ORC (Oops Rewind Capability) unwinder for
+	  unwinding kernel stack traces.  It uses a custom data format which is
+	  a simplified version of the DWARF Call Frame Information standard.
+
+	  The orc unwinder is not implemented on arm64 now, this option is only
+	  used for testing orc data generation.
 endchoice
 
 source "drivers/hwtracing/coresight/Kconfig"
diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 4e7fa2623896..782ac8e120dd 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -6,6 +6,7 @@
 #define __ASM_MODULE_H
 
 #include <asm-generic/module.h>
+#include <asm/orc_types.h>
 
 #ifdef CONFIG_ARM64_MODULE_PLTS
 struct mod_plt_sec {
@@ -20,6 +21,12 @@ struct mod_arch_specific {
 
 	/* for CONFIG_DYNAMIC_FTRACE */
 	struct plt_entry	*ftrace_trampolines;
+
+#ifdef CONFIG_UNWINDER_ORC
+	unsigned int num_orcs;
+	int *orc_unwind_ip;
+	struct orc_entry *orc_unwind;
+#endif
 };
 #endif
 
diff --git a/arch/arm64/include/asm/orc_types.h b/arch/arm64/include/asm/orc_types.h
new file mode 100644
index 000000000000..9c06e7a6ed55
--- /dev/null
+++ b/arch/arm64/include/asm/orc_types.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#ifndef _ORC_TYPES_H
+#define _ORC_TYPES_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+
+/*
+ * The ORC_REG_* registers are base registers which are used to find other
+ * registers on the stack.
+ *
+ * ORC_REG_PREV_SP, also known as DWARF Call Frame Address (CFA), is the
+ * address of the previous frame: the caller's SP before it called the current
+ * function.
+ *
+ * ORC_REG_UNDEFINED means the corresponding register's value didn't change in
+ * the current frame.
+ *
+ * The most commonly used base registers are SP and BP -- which the previous SP
+ * is usually based on -- and PREV_SP and UNDEFINED -- which the previous BP is
+ * usually based on.
+ *
+ * The rest of the base registers are needed for special cases like entry code
+ * and GCC realigned stacks.
+ */
+#define ORC_REG_UNDEFINED		0
+#define ORC_REG_PREV_SP			1
+#define ORC_REG_BP			2
+#define ORC_REG_SP			3
+#define ORC_REG_BP_INDIRECT		4
+#define ORC_REG_SP_INDIRECT		5
+#define ORC_REG_MAX			6
+
+#ifndef __ASSEMBLY__
+#include <asm/byteorder.h>
+
+/*
+ * This struct is more or less a vastly simplified version of the DWARF Call
+ * Frame Information standard.  It contains only the necessary parts of DWARF
+ * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
+ * unwinder how to find the previous SP and BP (and sometimes entry regs) on
+ * the stack for a given code address.  Each instance of the struct corresponds
+ * to one or more code locations.
+ */
+struct orc_entry {
+	s16		sp_offset;
+	s16		bp_offset;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	unsigned	sp_reg:4;
+	unsigned	bp_reg:4;
+	unsigned	type:2;
+	unsigned	end:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	unsigned	bp_reg:4;
+	unsigned	sp_reg:4;
+	unsigned	unused:5;
+	unsigned	end:1;
+	unsigned	type:2;
+#endif
+} __packed;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ORC_TYPES_H */
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index edaf0faf766f..339cf3bf5ce2 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -61,6 +61,7 @@
 #define RUNTIME_DISCARD_EXIT
 
 #include <asm-generic/vmlinux.lds.h>
+#include <asm-generic/orc_lookup.h>
 #include <asm/cache.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/kexec.h>
@@ -306,6 +307,8 @@ SECTIONS
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
 
+	ORC_UNWIND_TABLE
+
 	STABS_DEBUG
 	DWARF_DEBUG
 	ELF_DETAILS
diff --git a/scripts/Makefile b/scripts/Makefile
index ce5aa9030b74..5be2552e4d02 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -20,8 +20,12 @@ HOSTLDLIBS_sign-file = $(shell pkg-config --libs libcrypto 2> /dev/null || echo
 ifdef CONFIG_UNWINDER_ORC
 ifeq ($(ARCH),x86_64)
 ARCH := x86
-endif
 HOSTCFLAGS_sorttable.o += -I$(srctree)/tools/arch/x86/include
+endif
+ifeq ($(ARCH),arm64)
+HOSTCFLAGS_sorttable.o += -I$(srctree)/tools/arch/arm64/include
+endif
+
 HOSTCFLAGS_sorttable.o += -DUNWINDER_ORC_ENABLED
 endif
 
diff --git a/tools/arch/arm64/include/asm/orc_types.h b/tools/arch/arm64/include/asm/orc_types.h
new file mode 100644
index 000000000000..9c06e7a6ed55
--- /dev/null
+++ b/tools/arch/arm64/include/asm/orc_types.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#ifndef _ORC_TYPES_H
+#define _ORC_TYPES_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+
+/*
+ * The ORC_REG_* registers are base registers which are used to find other
+ * registers on the stack.
+ *
+ * ORC_REG_PREV_SP, also known as DWARF Call Frame Address (CFA), is the
+ * address of the previous frame: the caller's SP before it called the current
+ * function.
+ *
+ * ORC_REG_UNDEFINED means the corresponding register's value didn't change in
+ * the current frame.
+ *
+ * The most commonly used base registers are SP and BP -- which the previous SP
+ * is usually based on -- and PREV_SP and UNDEFINED -- which the previous BP is
+ * usually based on.
+ *
+ * The rest of the base registers are needed for special cases like entry code
+ * and GCC realigned stacks.
+ */
+#define ORC_REG_UNDEFINED		0
+#define ORC_REG_PREV_SP			1
+#define ORC_REG_BP			2
+#define ORC_REG_SP			3
+#define ORC_REG_BP_INDIRECT		4
+#define ORC_REG_SP_INDIRECT		5
+#define ORC_REG_MAX			6
+
+#ifndef __ASSEMBLY__
+#include <asm/byteorder.h>
+
+/*
+ * This struct is more or less a vastly simplified version of the DWARF Call
+ * Frame Information standard.  It contains only the necessary parts of DWARF
+ * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
+ * unwinder how to find the previous SP and BP (and sometimes entry regs) on
+ * the stack for a given code address.  Each instance of the struct corresponds
+ * to one or more code locations.
+ */
+struct orc_entry {
+	s16		sp_offset;
+	s16		bp_offset;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	unsigned	sp_reg:4;
+	unsigned	bp_reg:4;
+	unsigned	type:2;
+	unsigned	end:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	unsigned	bp_reg:4;
+	unsigned	sp_reg:4;
+	unsigned	unused:5;
+	unsigned	end:1;
+	unsigned	type:2;
+#endif
+} __packed;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ORC_TYPES_H */
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 3f7c7b54c741..e17c1fd90982 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -46,6 +46,7 @@ ifeq ($(SRCARCH),x86)
 endif
 
 ifeq ($(SRCARCH),arm64)
+	BUILD_ORC := y
 	CFLAGS  += -Wno-nested-externs
 endif
 
diff --git a/tools/objtool/arch/arm64/Build b/tools/objtool/arch/arm64/Build
index f3de3a50d541..00221087eefe 100644
--- a/tools/objtool/arch/arm64/Build
+++ b/tools/objtool/arch/arm64/Build
@@ -1,5 +1,6 @@
 objtool-y += special.o
 objtool-y += decode.o
+objtool-y += orc.o
 
 objtool-y += libhweight.o
 
diff --git a/tools/objtool/arch/arm64/orc.c b/tools/objtool/arch/arm64/orc.c
new file mode 100644
index 000000000000..aa8404c482b6
--- /dev/null
+++ b/tools/objtool/arch/arm64/orc.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#include <stdlib.h>
+
+#include <linux/objtool.h>
+
+#include <objtool/orc.h>
+#include <objtool/warn.h>
+
+int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
+		   struct instruction *insn)
+{
+	struct cfi_reg *bp = &cfi->regs[CFI_BP];
+
+	memset(orc, 0, sizeof(*orc));
+
+	if (!cfi) {
+		orc->end = 0;
+		orc->sp_reg = ORC_REG_UNDEFINED;
+		return 0;
+	}
+
+	orc->end = cfi->end;
+
+	if (cfi->cfa.base == CFI_UNDEFINED) {
+		orc->sp_reg = ORC_REG_UNDEFINED;
+		return 0;
+	}
+
+	switch (cfi->cfa.base) {
+	case CFI_SP:
+		orc->sp_reg = ORC_REG_SP;
+		break;
+	case CFI_SP_INDIRECT:
+		orc->sp_reg = ORC_REG_SP_INDIRECT;
+		break;
+	case CFI_BP:
+		orc->sp_reg = ORC_REG_BP;
+		break;
+	case CFI_BP_INDIRECT:
+		orc->sp_reg = ORC_REG_BP_INDIRECT;
+		break;
+	default:
+		WARN_FUNC("unknown CFA base reg %d",
+			  insn->sec, insn->offset, cfi->cfa.base);
+		return -1;
+	}
+
+	switch (bp->base) {
+	case CFI_UNDEFINED:
+		orc->bp_reg = ORC_REG_UNDEFINED;
+		break;
+	case CFI_CFA:
+		orc->bp_reg = ORC_REG_PREV_SP;
+		break;
+	case CFI_BP:
+		orc->bp_reg = ORC_REG_BP;
+		break;
+	default:
+		WARN_FUNC("unknown BP base reg %d",
+			  insn->sec, insn->offset, bp->base);
+		return -1;
+	}
+
+	orc->sp_offset = cfi->cfa.offset;
+	orc->bp_offset = bp->offset;
+	orc->type = cfi->type;
+
+	return 0;
+}
+
+static const char *reg_name(unsigned int reg)
+{
+	switch (reg) {
+	case ORC_REG_PREV_SP:
+		return "prevsp";
+	case ORC_REG_BP:
+		return "fp";
+	case ORC_REG_SP:
+		return "sp";
+	case ORC_REG_BP_INDIRECT:
+		return "fp(ind)";
+	case ORC_REG_SP_INDIRECT:
+		return "sp(ind)";
+	default:
+		return "?";
+	}
+}
+
+const char *orc_type_name(unsigned int type)
+{
+	switch (type) {
+	case UNWIND_HINT_TYPE_CALL:
+		return "call";
+	case UNWIND_HINT_TYPE_REGS:
+		return "regs";
+	case UNWIND_HINT_TYPE_REGS_PARTIAL:
+		return "regs (partial)";
+	default:
+		return "?";
+	}
+}
+
+void orc_print_reg(unsigned int reg, int offset)
+{
+	if (reg == ORC_REG_BP_INDIRECT)
+		printf("(fp%+d)", offset);
+	else if (reg == ORC_REG_SP_INDIRECT)
+		printf("(sp%+d)", offset);
+	else if (reg == ORC_REG_UNDEFINED)
+		printf("(und)");
+	else
+		printf("%s%+d", reg_name(reg), offset);
+}
-- 
2.17.1

