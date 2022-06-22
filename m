Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFBD55503C
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359362AbiFVPyS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359721AbiFVPxX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 11:53:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55993EAF;
        Wed, 22 Jun 2022 08:52:53 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LSnt21Mv0zkWPy;
        Wed, 22 Jun 2022 23:51:06 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:47 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:47 +0800
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
Subject: [PATCH v5 29/33] arm64: compat: Move VDSO code to .rodata section
Date:   Wed, 22 Jun 2022 23:49:16 +0800
Message-ID: <20220622154920.95075-30-chenzhongjin@huawei.com>
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

VDSO code should be inside .rodata.

Now code in kuser32.S and sigreturn32.S are inside .text section and never
executed.
Move them to .rodata.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm64/kernel/kuser32.S     | 1 +
 arch/arm64/kernel/sigreturn32.S | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
index 42bd8c0c60e0..692e9d2e31e5 100644
--- a/arch/arm64/kernel/kuser32.S
+++ b/arch/arm64/kernel/kuser32.S
@@ -15,6 +15,7 @@
 
 #include <asm/unistd.h>
 
+	.section .rodata
 	.align	5
 	.globl	__kuser_helper_start
 __kuser_helper_start:
diff --git a/arch/arm64/kernel/sigreturn32.S b/arch/arm64/kernel/sigreturn32.S
index 475d30d471ac..ccbd4aab4ba4 100644
--- a/arch/arm64/kernel/sigreturn32.S
+++ b/arch/arm64/kernel/sigreturn32.S
@@ -15,6 +15,7 @@
 
 #include <asm/unistd.h>
 
+	.section .rodata
 	.globl __aarch32_sigret_code_start
 __aarch32_sigret_code_start:
 
-- 
2.17.1

