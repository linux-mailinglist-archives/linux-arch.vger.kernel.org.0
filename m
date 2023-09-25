Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD337ADD0F
	for <lists+linux-arch@lfdr.de>; Mon, 25 Sep 2023 18:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjIYQ25 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Sep 2023 12:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjIYQ2z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Sep 2023 12:28:55 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7989AFC;
        Mon, 25 Sep 2023 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qjYxvP0mrwNQum3AINuFgWcLiPmukjSCAlOcMPWNC70=; b=H7LRzpeszu/NjlEcIS+36zsQZ6
        1B2GjUbmFECUohpWGtvulUpk25WC7XKYTRHHT/Eml4mDxX0AMEEVJ060wH21PeS3gfykNAY0NM0X4
        +GWdzx+YKVVo1kbovXqnfBMQBs1dqZfTnGZ7fo2JV+E0m3nna6kCsI5T89nijgI58vuJn5P29+V4C
        TXReirRZWjAEDIygIzmuA0o2B8fguAE2q+5Iicf9b35Wzovei5lcs3hzooqVcv2w+BQzFB8kmlAql
        ls3/NA9AIJUS/9j4ONw4bjJEaiyshFeUbtMhnMk82oY4iHK+oHm6dodVie7aPbYAkW55ITbJCUDoG
        wexoGNlg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56656 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qkoRq-0001Ke-1k;
        Mon, 25 Sep 2023 17:28:38 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qkoRr-0088Q8-Da; Mon, 25 Sep 2023 17:28:39 +0100
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Salil Mehta <salil.mehta@huawei.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-ia64@vger.kernel.org
Subject: [PATCH] cpu-hotplug: provide prototypes for arch CPU registration
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Mon, 25 Sep 2023 17:28:39 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Provide common prototypes for arch_register_cpu() and
arch_unregister_cpu(). These are called by acpi_processor.c, with
weak versions, so the prototype for this is already set. It is
generally not necessary for function prototypes to be conditional
on preprocessor macros.

Some architectures (e.g. Loongarch) are missing the prototype for this,
and rather than add it to Loongarch's asm/cpu.h, lets do the job once
for everyone.

Since this covers everyone, remove the now unnecessary prototypes in
asm/cpu.h, and we also need to remove the 'static' from one of ia64's
arch_register_cpu() definitions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 - drop ia64 changes, as ia64 has already been removed.

 arch/x86/include/asm/cpu.h  | 2 --
 arch/x86/kernel/topology.c  | 2 +-
 include/linux/cpu.h         | 2 ++
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 3a233ebff712..25050d953eee 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -28,8 +28,6 @@ struct x86_cpu {
 };
 
 #ifdef CONFIG_HOTPLUG_CPU
-extern int arch_register_cpu(int num);
-extern void arch_unregister_cpu(int);
 extern void soft_restart_cpu(void);
 #endif
 
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index ca004e2e4469..0bab03130033 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -54,7 +54,7 @@ void arch_unregister_cpu(int num)
 EXPORT_SYMBOL(arch_unregister_cpu);
 #else /* CONFIG_HOTPLUG_CPU */
 
-static int __init arch_register_cpu(int num)
+int __init arch_register_cpu(int num)
 {
 	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
 }
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 0abd60a7987b..eb768a866fe3 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -80,6 +80,8 @@ extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
 				 const struct attribute_group **groups,
 				 const char *fmt, ...);
+extern int arch_register_cpu(int cpu);
+extern void arch_unregister_cpu(int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
 extern ssize_t arch_cpu_probe(const char *, size_t);
-- 
2.30.2

