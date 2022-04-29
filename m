Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFE75145BE
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 11:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356804AbiD2JtS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 05:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356797AbiD2Jss (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 05:48:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB8D939A9;
        Fri, 29 Apr 2022 02:45:21 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KqSJb6z1pzhYqK;
        Fri, 29 Apr 2022 17:45:03 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:12 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:12 +0800
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
Subject: [RFC PATCH v4 15/37] objtool: arm64: Add unwind_hint support
Date:   Fri, 29 Apr 2022 17:43:33 +0800
Message-ID: <20220429094355.122389-16-chenzhongjin@huawei.com>
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

Provide unwind hint defines for arm64 and objtool hint decoding.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm64/include/asm/unwind_hints.h       | 27 +++++++++++++++++++++
 tools/arch/arm64/include/asm/unwind_hints.h | 27 +++++++++++++++++++++
 tools/objtool/arch/arm64/decode.c           |  8 +++++-
 3 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/unwind_hints.h
 create mode 100644 tools/arch/arm64/include/asm/unwind_hints.h

diff --git a/arch/arm64/include/asm/unwind_hints.h b/arch/arm64/include/asm/unwind_hints.h
new file mode 100644
index 000000000000..60f866e4e12c
--- /dev/null
+++ b/arch/arm64/include/asm/unwind_hints.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_UNWIND_HINTS_H
+#define __ASM_UNWIND_HINTS_H
+
+#include <linux/objtool.h>
+
+#define UNWIND_HINT_REG_UNDEFINED	0xff
+#define UNWIND_HINT_REG_SP		31
+
+#ifdef __ASSEMBLY__
+
+.macro UNWIND_HINT_EMPTY
+	UNWIND_HINT sp_reg=UNWIND_HINT_REG_UNDEFINED type=UNWIND_HINT_TYPE_CALL
+.endm
+
+.macro UNWIND_HINT_FUNC sp_offset=0
+	UNWIND_HINT sp_reg=UNWIND_HINT_REG_SP sp_offset=\sp_offset type=UNWIND_HINT_TYPE_CALL
+.endm
+
+.macro UNWIND_HINT_REGS base=UNWIND_HINT_REG_SP offset=0
+	UNWIND_HINT sp_reg=\base sp_offset=\offset type=UNWIND_HINT_TYPE_REGS
+.endm
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_UNWIND_HINTS_H */
diff --git a/tools/arch/arm64/include/asm/unwind_hints.h b/tools/arch/arm64/include/asm/unwind_hints.h
new file mode 100644
index 000000000000..60f866e4e12c
--- /dev/null
+++ b/tools/arch/arm64/include/asm/unwind_hints.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_UNWIND_HINTS_H
+#define __ASM_UNWIND_HINTS_H
+
+#include <linux/objtool.h>
+
+#define UNWIND_HINT_REG_UNDEFINED	0xff
+#define UNWIND_HINT_REG_SP		31
+
+#ifdef __ASSEMBLY__
+
+.macro UNWIND_HINT_EMPTY
+	UNWIND_HINT sp_reg=UNWIND_HINT_REG_UNDEFINED type=UNWIND_HINT_TYPE_CALL
+.endm
+
+.macro UNWIND_HINT_FUNC sp_offset=0
+	UNWIND_HINT sp_reg=UNWIND_HINT_REG_SP sp_offset=\sp_offset type=UNWIND_HINT_TYPE_CALL
+.endm
+
+.macro UNWIND_HINT_REGS base=UNWIND_HINT_REG_SP offset=0
+	UNWIND_HINT sp_reg=\base sp_offset=\offset type=UNWIND_HINT_TYPE_REGS
+.endm
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_UNWIND_HINTS_H */
diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index d2522ef43101..2e7affca1ec9 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -5,6 +5,7 @@
 #include <stdint.h>
 
 #include <asm/insn.h>
+#include <asm/unwind_hints.h>
 
 #include <objtool/check.h>
 #include <objtool/arch.h>
@@ -176,7 +177,12 @@ static int is_arm64(const struct elf *elf)
 
 int arch_decode_hint_reg(u8 sp_reg, int *base)
 {
-	return -1;
+	if (sp_reg == UNWIND_HINT_REG_UNDEFINED)
+		*base = CFI_UNDEFINED;
+	else
+		*base = sp_reg;
+
+	return 0;
 }
 
 static struct stack_op *arm_make_store_op(enum aarch64_insn_register base,
-- 
2.17.1

