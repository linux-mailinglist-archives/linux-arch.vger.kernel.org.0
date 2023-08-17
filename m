Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C607780095
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 00:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355520AbjHQWCV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 18:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355504AbjHQWCD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 18:02:03 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B56B5358E;
        Thu, 17 Aug 2023 15:02:01 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id C682F211F7DE;
        Thu, 17 Aug 2023 15:01:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C682F211F7DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692309719;
        bh=vDq2Xl+2Hg8RsZrUjDaPS7fZtEYDcSXeQJMc9Jbudz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJe7Z77vliog483EGGQbssJA7tIw3kBE8Alfl//AgnPM8C/C1viKfyvlwNAIUAMY4
         /jdQfShpvfZLzx7KBNVTt50yTi1eH6Drj/EqdV3Y9zl2ZOWg/Tvf31hUO+bEzfNwFb
         nw8KszefKFtvtKLpt9frbqnLv6RDkSTimnWcK/hc=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: [PATCH v2 10/15] x86: hyperv: Add mshv_handler irq handler and setup function
Date:   Thu, 17 Aug 2023 15:01:46 -0700
Message-Id: <1692309711-5573-11-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This will handle SYNIC interrupts such as intercepts, doorbells, and
scheduling messages intended for the mshv driver.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/kernel/cpu/mshyperv.c | 9 +++++++++
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e80e503c8cf5..6568d73e7d60 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -105,6 +105,7 @@ void hv_set_register(unsigned int reg, u64 value)
 }
 EXPORT_SYMBOL_GPL(hv_set_register);
 
+static void (*mshv_handler)(void);
 static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
@@ -115,6 +116,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	inc_irq_stat(irq_hv_callback_count);
+	if (mshv_handler)
+		mshv_handler();
+
 	if (vmbus_handler)
 		vmbus_handler();
 
@@ -124,6 +128,11 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 	set_irq_regs(old_regs);
 }
 
+void hv_setup_mshv_irq(void (*handler)(void))
+{
+	mshv_handler = handler;
+}
+
 void hv_setup_vmbus_handler(void (*handler)(void))
 {
 	vmbus_handler = handler;
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 79efedc8bf39..13f972e72375 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -548,6 +548,11 @@ void __weak hv_remove_vmbus_handler(void)
 }
 EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
 
+void __weak hv_setup_mshv_irq(void (*handler)(void))
+{
+}
+EXPORT_SYMBOL_GPL(hv_setup_mshv_irq);
+
 void __weak hv_setup_kexec_handler(void (*handler)(void))
 {
 }
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 9118d678b27a..2b20994d809e 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -193,6 +193,8 @@ void hv_remove_vmbus_handler(void);
 void hv_setup_stimer0_handler(void (*handler)(void));
 void hv_remove_stimer0_handler(void);
 
+void hv_setup_mshv_irq(void (*handler)(void));
+
 void hv_setup_kexec_handler(void (*handler)(void));
 void hv_remove_kexec_handler(void);
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
-- 
2.25.1

