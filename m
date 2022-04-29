Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B63A5145C3
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356745AbiD2Jse (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356742AbiD2Jsd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 05:48:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C02C1DA6A;
        Fri, 29 Apr 2022 02:45:15 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KqSCV5NPszCsP6;
        Fri, 29 Apr 2022 17:40:38 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
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
Subject: [RFC PATCH v4 21/37] arm64: kernel: Skip validation of proton-pack.c.c and hibernate.c
Date:   Fri, 29 Apr 2022 17:43:39 +0800
Message-ID: <20220429094355.122389-22-chenzhongjin@huawei.com>
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

Julien Said,
"""
This workaround code is more akin to an ancient incantation than
sensible code. And since the function does not call another function
than itself, unwinding from instructions in it should be reliable.
"""

Also add mark for swsusp_arch_resume. It's a noreturn function called
by special ABI.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm64/kernel/hibernate.c   | 2 ++
 arch/arm64/kernel/proton-pack.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 6328308be272..f5422ae77dc6 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/suspend.h>
 #include <linux/utsname.h>
+#include <linux/objtool.h>
 
 #include <asm/barrier.h>
 #include <asm/cacheflush.h>
@@ -471,6 +472,7 @@ int swsusp_arch_resume(void)
 
 	return 0;
 }
+STACK_FRAME_NON_STANDARD(swsusp_arch_resume);
 
 int hibernate_resume_nonboot_cpu_disable(void)
 {
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 40be3a7c2c53..9439e62d4b57 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -22,6 +22,7 @@
 #include <linux/cpu.h>
 #include <linux/device.h>
 #include <linux/nospec.h>
+#include <linux/objtool.h>
 #include <linux/prctl.h>
 #include <linux/sched/task_stack.h>
 
@@ -257,6 +258,7 @@ static noinstr void qcom_link_stack_sanitisation(void)
 		     "mov	x30, %0		\n"
 		     : "=&r" (tmp));
 }
+STACK_FRAME_NON_STANDARD(qcom_link_stack_sanitisation);
 
 static bp_hardening_cb_t spectre_v2_get_sw_mitigation_cb(void)
 {
-- 
2.17.1

