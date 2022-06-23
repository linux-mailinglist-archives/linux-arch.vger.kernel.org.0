Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8E557056
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 03:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377938AbiFWBxB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 21:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiFWBwH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 21:52:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B405243ACC;
        Wed, 22 Jun 2022 18:51:50 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LT38h68Xpz1KBY6;
        Thu, 23 Jun 2022 09:49:40 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:51:48 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:51:48 +0800
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
Subject: [PATCH v6 14/33] objtool: arm64: Add annotate_reachable() for objtools
Date:   Thu, 23 Jun 2022 09:48:58 +0800
Message-ID: <20220623014917.199563-15-chenzhongjin@huawei.com>
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

x86 removed annotate_reachable and replaced it with ASM_REACHABLE
which is not suitable for arm64 micro because there are some cases
GCC will merge duplicate inline asm.

Re-add annotation_reachable() for arm64.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 include/linux/compiler.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 01ce94b58b42..c8bce9421fa7 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -117,6 +117,14 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  */
 #define __stringify_label(n) #n
 
+#define __annotate_reachable(c) ({					\
+	asm volatile(__stringify_label(c) ":\n\t"			\
+			".pushsection .discard.reachable\n\t"		\
+			".long " __stringify_label(c) "b - .\n\t"		\
+			".popsection\n\t");				\
+})
+#define annotate_reachable() __annotate_reachable(__COUNTER__)
+
 #define __annotate_unreachable(c) ({					\
 	asm volatile(__stringify_label(c) ":\n\t"			\
 		     ".pushsection .discard.unreachable\n\t"		\
@@ -129,6 +137,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define __annotate_jump_table __section(".rodata..c_jump_table")
 
 #else /* !CONFIG_OBJTOOL */
+#define annotate_reachable()
 #define annotate_unreachable()
 #define __annotate_jump_table
 #endif /* CONFIG_OBJTOOL */
-- 
2.17.1

