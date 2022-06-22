Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084F4555007
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 17:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358820AbiFVPxL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 11:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358532AbiFVPxC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 11:53:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C7F2EA12;
        Wed, 22 Jun 2022 08:52:48 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LSnsz5tRnzkWPF;
        Wed, 22 Jun 2022 23:51:03 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:45 +0800
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
Subject: [PATCH v5 17/33] objtool: arm64: Add unwind_hint support
Date:   Wed, 22 Jun 2022 23:49:04 +0800
Message-ID: <20220622154920.95075-18-chenzhongjin@huawei.com>
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

Provide unwind hint defines for arm64 and objtool hint decoding.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm64/include/asm/unwind_hints.h       | 26 +++++++++++++++++++++
 tools/arch/arm64/include/asm/unwind_hints.h | 26 +++++++++++++++++++++
 tools/objtool/arch/arm64/decode.c           | 14 ++++++++++-
 3 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/unwind_hints.h
 create mode 100644 tools/arch/arm64/include/asm/unwind_hints.h

diff --git a/arch/arm64/include/asm/unwind_hints.h b/arch/arm64/include/asm/unwind_hints.h
new file mode 100644
index 000000000000..ffee9472b30d
--- /dev/null
+++ b/arch/arm64/include/asm/unwind_hints.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_UNWIND_HINTS_H
+#define __ASM_UNWIND_HINTS_H
+
+#include <linux/objtool.h>
+
+#include "orc_types.h"
+
+#ifdef __ASSEMBLY__
+
+.macro UNWIND_HINT_EMPTY
+	UNWIND_HINT sp_reg=ORC_REG_UNDEFINED type=UNWIND_HINT_TYPE_CALL end=1
+.endm
+
+.macro UNWIND_HINT_FUNC sp_offset=0
+	UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=\sp_offset type=UNWIND_HINT_TYPE_CALL
+.endm
+
+.macro UNWIND_HINT_REGS base=ORC_REG_SP offset=0
+	UNWIND_HINT sp_reg=\base sp_offset=\offset type=UNWIND_HINT_TYPE_REGS
+.endm
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_UNWIND_HINTS_H */
diff --git a/tools/arch/arm64/include/asm/unwind_hints.h b/tools/arch/arm64/include/asm/unwind_hints.h
new file mode 100644
index 000000000000..ffee9472b30d
--- /dev/null
+++ b/tools/arch/arm64/include/asm/unwind_hints.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_UNWIND_HINTS_H
+#define __ASM_UNWIND_HINTS_H
+
+#include <linux/objtool.h>
+
+#include "orc_types.h"
+
+#ifdef __ASSEMBLY__
+
+.macro UNWIND_HINT_EMPTY
+	UNWIND_HINT sp_reg=ORC_REG_UNDEFINED type=UNWIND_HINT_TYPE_CALL end=1
+.endm
+
+.macro UNWIND_HINT_FUNC sp_offset=0
+	UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=\sp_offset type=UNWIND_HINT_TYPE_CALL
+.endm
+
+.macro UNWIND_HINT_REGS base=ORC_REG_SP offset=0
+	UNWIND_HINT sp_reg=\base sp_offset=\offset type=UNWIND_HINT_TYPE_REGS
+.endm
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_UNWIND_HINTS_H */
diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 37e42148dbe0..aa8d27c2bac9 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -5,6 +5,7 @@
 #include <stdint.h>
 
 #include <asm/insn.h>
+#include <asm/unwind_hints.h>
 
 #include <objtool/check.h>
 #include <objtool/arch.h>
@@ -176,7 +177,18 @@ static int is_arm64(const struct elf *elf)
 
 int arch_decode_hint_reg(u8 sp_reg, int *base)
 {
-	return -1;
+	switch (sp_reg) {
+	case ORC_REG_UNDEFINED:
+		*base = CFI_UNDEFINED;
+		break;
+	case ORC_REG_SP:
+		*base = CFI_SP;
+		break;
+	default:
+		return -1;
+	}
+
+	return 0;
 }
 
 static inline void make_add_op(enum aarch64_insn_register dest,
-- 
2.17.1

