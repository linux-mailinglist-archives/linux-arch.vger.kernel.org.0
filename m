Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C307D5588
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 17:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbjJXPTR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbjJXPS0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 11:18:26 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C0D1999;
        Tue, 24 Oct 2023 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5K2XQGzhzcpec7D/0nXB7CsQhNIskiD1q2Og2Kjac48=; b=hLNHvW+8oAX6VRKsR4eCM/z06u
        qApp1CIo0PA9XSXQc4m3gCZLj5+q2+waT/NzHKt2sx4xufRAmeZ4eZ2U+sZLE+H5dEJr9tUWGNanU
        xlRkUNDuUVH+WcNmJB7AbwmEL4JI5dKo8f7b6rU5x7vIFug+y721i7KmM0ExnSCS/PLbfPnDk9iZA
        kL7zP4B1qftMnSCJN3mer6g17MtzBWPI4Szhow/CTIJC0uFksrWEaZb3cXMJaBXTGPlMpdxcd//Mv
        qQpaZOiitEJpPHm3AV7P93nF+qhA9B7K86kWsyNlntBdgrHNiJgQmrYcSezBVqi2KhFr9mPDTX0By
        zy46moiA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34498 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qvJ9j-0004PJ-2p;
        Tue, 24 Oct 2023 16:17:19 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qvJ9l-00AqQB-AJ; Tue, 24 Oct 2023 16:17:21 +0100
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 14/39] x86/topology: Switch over to GENERIC_CPU_DEVICES
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJ9l-00AqQB-AJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 24 Oct 2023 16:17:21 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: James Morse <james.morse@arm.com>

Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
overridden by the arch code, switch over to this to allow common code
to choose when the register_cpu() call is made.

x86's struct cpus come from struct x86_cpu, which has no other members
or users. Remove this and use the version defined by common code.

This is an intermediate step to the logic being moved to drivers/acpi,
where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.

This patch also has the effect of moving the registration of CPUs from
subsys to driver core initialisation, prior to any initcalls running.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
----
Changes since RFC:
 * Fixed the second copy of arch_register_cpu() used for non-hotplug
Changes since RFC v2:
 * Remove duplicate of the weak generic arch_register_cpu(), spotted
   by Jonathan Cameron. Add note about initialisation order change.
---
 arch/x86/Kconfig           |  1 +
 arch/x86/include/asm/cpu.h |  4 ----
 arch/x86/kernel/topology.c | 27 ++++-----------------------
 3 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 18729edc879d..a11c0aea5176 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -148,6 +148,7 @@ config X86
 	select GENERIC_CLOCKEVENTS_MIN_ADJUST
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 25050d953eee..91867a6a9f8e 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -23,10 +23,6 @@ static inline void prefill_possible_map(void) {}
 
 #endif /* CONFIG_SMP */
 
-struct x86_cpu {
-	struct cpu cpu;
-};
-
 #ifdef CONFIG_HOTPLUG_CPU
 extern void soft_restart_cpu(void);
 #endif
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index 0bab03130033..027897054424 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -35,38 +35,19 @@
 #include <asm/io_apic.h>
 #include <asm/cpu.h>
 
-static DEFINE_PER_CPU(struct x86_cpu, cpu_devices);
-
 #ifdef CONFIG_HOTPLUG_CPU
 int arch_register_cpu(int cpu)
 {
-	struct x86_cpu *xc = per_cpu_ptr(&cpu_devices, cpu);
+	struct cpu *c = per_cpu_ptr(&cpu_devices, cpu);
 
-	xc->cpu.hotpluggable = cpu > 0;
-	return register_cpu(&xc->cpu, cpu);
+	c->hotpluggable = cpu > 0;
+	return register_cpu(c, cpu);
 }
 EXPORT_SYMBOL(arch_register_cpu);
 
 void arch_unregister_cpu(int num)
 {
-	unregister_cpu(&per_cpu(cpu_devices, num).cpu);
+	unregister_cpu(&per_cpu(cpu_devices, num));
 }
 EXPORT_SYMBOL(arch_unregister_cpu);
-#else /* CONFIG_HOTPLUG_CPU */
-
-int __init arch_register_cpu(int num)
-{
-	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
-}
 #endif /* CONFIG_HOTPLUG_CPU */
-
-static int __init topology_init(void)
-{
-	int i;
-
-	for_each_present_cpu(i)
-		arch_register_cpu(i);
-
-	return 0;
-}
-subsys_initcall(topology_init);
-- 
2.30.2

