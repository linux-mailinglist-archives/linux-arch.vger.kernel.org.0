Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D257AB959
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjIVSiz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Sep 2023 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbjIVSit (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2023 14:38:49 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F6CEF1;
        Fri, 22 Sep 2023 11:38:43 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id EC78C212C5D1;
        Fri, 22 Sep 2023 11:38:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC78C212C5D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695407922;
        bh=hZuHNHNc96TSZL6yyLBe5wiPm/nLTQa1k0Xw7XRxngc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+yMBTWEfdBpfU1cLWO9lCtWjp/B6kZSPJb3O0M6SmX0fMKYe0Fq0HiXqeb7ltCPE
         0Bs/GbbPMZsARawTZuPVWNdCJt7ekl6x6gXLVSfMMYlxMfWRqGEC4TxX5FE5UO6IoI
         YDkxoZvlpxkfO3UNCj9RZ4065tcr8g9TZSRDXCpg=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, gregkh@linuxfoundation.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: [PATCH v3 10/15] x86: hyperv: Add mshv_handler irq handler and setup function
Date:   Fri, 22 Sep 2023 11:38:30 -0700
Message-Id: <1695407915-12216-11-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
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
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 9 +++++++++
 drivers/hv/hv_common.c         | 5 +++++
 include/asm-generic/mshyperv.h | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 73fbcc003d68..b8c3177d6389 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -110,6 +110,7 @@ void hv_set_register(unsigned int reg, u64 value)
 }
 EXPORT_SYMBOL_GPL(hv_set_register);
 
+static void (*mshv_handler)(void);
 static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
@@ -120,6 +121,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	inc_irq_stat(irq_hv_callback_count);
+	if (mshv_handler)
+		mshv_handler();
+
 	if (vmbus_handler)
 		vmbus_handler();
 
@@ -129,6 +133,11 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
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
index 89f5c1fb2a35..092b0c727db9 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -585,6 +585,11 @@ void __weak hv_remove_vmbus_handler(void)
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
index 5a12e5754e97..0a9e8ff31b73 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -198,6 +198,8 @@ void hv_remove_vmbus_handler(void);
 void hv_setup_stimer0_handler(void (*handler)(void));
 void hv_remove_stimer0_handler(void);
 
+void hv_setup_mshv_irq(void (*handler)(void));
+
 void hv_setup_kexec_handler(void (*handler)(void));
 void hv_remove_kexec_handler(void);
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
-- 
2.25.1

