Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1950A557062
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 03:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377969AbiFWBxG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 21:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377606AbiFWBwW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 21:52:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2073D43AF4;
        Wed, 22 Jun 2022 18:51:53 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LT39p1QfDzkWk6;
        Thu, 23 Jun 2022 09:50:38 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:51:51 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:51:51 +0800
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
        <madvenka@linux.microsoft.com>, <christophe.leroy@csgroup.eu>,
        <daniel.thompson@linaro.org>
Subject: [PATCH v6 27/33] arm64: Set intra-function call annotations
Date:   Thu, 23 Jun 2022 09:49:11 +0800
Message-ID: <20220623014917.199563-28-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220623014917.199563-1-chenzhongjin@huawei.com>
References: <20220623014917.199563-1-chenzhongjin@huawei.com>
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

Stack validation requires BL instructions to an address,
within the symbol containing the BL should be annotated as intra-function
calls.

Make __pmull_p8_core normally set frame because there's a intra-function
call destinating middle of it and the caller have set the frame. When
analyzing the insns there will be a cfi state mismatch between normal-call
and intra-call.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm64/crypto/crct10dif-ce-core.S | 5 +++++
 arch/arm64/kernel/entry.S             | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/crypto/crct10dif-ce-core.S b/arch/arm64/crypto/crct10dif-ce-core.S
index dce6dcebfca1..b3b8e56cb87d 100644
--- a/arch/arm64/crypto/crct10dif-ce-core.S
+++ b/arch/arm64/crypto/crct10dif-ce-core.S
@@ -63,6 +63,7 @@
 //
 
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <asm/assembler.h>
 
 	.text
@@ -132,6 +133,8 @@
 	.endm
 
 SYM_FUNC_START_LOCAL(__pmull_p8_core)
+	stp		x29, x30, [sp, #-16]!
+	mov		x29, sp
 .L__pmull_p8_core:
 	ext		t4.8b, ad.8b, ad.8b, #1			// A1
 	ext		t5.8b, ad.8b, ad.8b, #2			// A2
@@ -193,6 +196,7 @@ SYM_FUNC_START_LOCAL(__pmull_p8_core)
 
 	eor		t4.16b, t4.16b, t5.16b
 	eor		t6.16b, t6.16b, t3.16b
+	ldp		x29, x30, [sp], #16
 	ret
 SYM_FUNC_END(__pmull_p8_core)
 
@@ -207,6 +211,7 @@ SYM_FUNC_END(__pmull_p8_core)
 	pmull2		\rq\().8h, \ad\().16b, \bd\().16b	// D = A*B
 	.endif
 
+	ANNOTATE_INTRA_FUNCTION_CALL
 	bl		.L__pmull_p8_core\i
 
 	eor		\rq\().16b, \rq\().16b, t4.16b
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index bbc440379304..d49bfbe81a0d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -10,6 +10,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
@@ -694,6 +695,7 @@ alternative_else_nop_endif
 	 * entry onto the return stack and using a RET instruction to
 	 * enter the full-fat kernel vectors.
 	 */
+	ANNOTATE_INTRA_FUNCTION_CALL
 	bl	2f
 	UNWIND_HINT_EMPTY
 	b	.
-- 
2.17.1

