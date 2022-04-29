Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A505145C8
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 11:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356817AbiD2JtU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 05:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356796AbiD2Jss (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 05:48:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2E7939BB;
        Fri, 29 Apr 2022 02:45:21 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KqSJc0LCwzhYq7;
        Fri, 29 Apr 2022 17:45:04 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:13 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:13 +0800
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
Subject: [RFC PATCH v4 20/37] arm64: Set intra-function call annotations
Date:   Fri, 29 Apr 2022 17:43:38 +0800
Message-ID: <20220429094355.122389-21-chenzhongjin@huawei.com>
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
index dce6dcebfca1..a1b10d2fb06d 100644
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
index ede028dee81b..47829a3077be 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -10,6 +10,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 
 #include <asm/alternative.h>
 #include <asm/assembler.h>
@@ -682,6 +683,7 @@ alternative_else_nop_endif
 	 * entry onto the return stack and using a RET instruction to
 	 * enter the full-fat kernel vectors.
 	 */
+	ANNOTATE_INTRA_FUNCTION_CALL
 	bl	2f
 	b	.
 2:
-- 
2.17.1

