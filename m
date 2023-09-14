Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29347A07B1
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 16:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbjINOrs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjINOrr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 10:47:47 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4D71BFC;
        Thu, 14 Sep 2023 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:From:To:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k/kzubGMoF55SY8q/NSTULYXd8nOQVDVaZO5jElyano=; b=dBVhc8oknmbKL8K6SMVUV7f8Iq
        x/L3g6I+OXnEQzlek24sVI6zZt3F1Mp//EWFJENAl5DLknigcxE+wIFrBH4QtwaBOvy4kQzw86szc
        bspe08fwfuPk4ezDVX49czJQqmZKnI4d5Yq+j9k/dhj0JlOzL+9CTy9JBMIRs7JlxeOkzQNBHi8iX
        iIHg/PccSEOhvYpUzMo5EHC0DHTh1fWWX4N3HCewZ62JfQThx5971APFS7Q5KOwuruOFp4Pt5rSf+
        V16Nl7DCjt1Bsm4r8eZaOKsAlIRsOGEiKCsiS+Ncm//5HeiShoBkg9Nnp/HlLl+8aC41Y38BzufZN
        hLUi7wcg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46516 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qgnd2-0004Nf-2B;
        Thu, 14 Sep 2023 15:47:36 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qgnd3-007ZQF-Ds; Thu, 14 Sep 2023 15:47:37 +0100
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>
Subject: [PATCH RFC] cpu-hotplug: provide prototypes for arch CPU registration
MIME-Version: 1.0
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Salil Mehta <salil.mehta@huawei.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-ia64@vger.kernel.org
Subject: [PATCH] cpu-hotplug: provide prototypes for arch CPU registration
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qgnd3-007ZQF-Ds@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Thu, 14 Sep 2023 15:47:37 +0100
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
Spotted during the review of James Morse's patches, I think rather than
adding prototypes for loongarch to its asm/cpu.h, it would make more
sense to provide the prototypes in a non-arch specific header file so
everyone can benefit, rather than having each architecture do its own
thing.

I'm sending this as RFC as James has yet to comment on my proposal, and
also to a wider audience, and although it makes a little more work for
James (to respin his series) it does mean that his series should get a
little smaller.

See:
 https://lore.kernel.org/r/20230913163823.7880-2-james.morse@arm.com
 https://lore.kernel.org/r/20230913163823.7880-4-james.morse@arm.com
 https://lore.kernel.org/r/20230913163823.7880-23-james.morse@arm.com

 arch/ia64/include/asm/cpu.h | 5 -----
 arch/ia64/kernel/topology.c | 2 +-
 arch/x86/include/asm/cpu.h  | 2 --
 include/linux/cpu.h         | 2 ++
 4 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/include/asm/cpu.h b/arch/ia64/include/asm/cpu.h
index db125df9e088..642d71675ddb 100644
--- a/arch/ia64/include/asm/cpu.h
+++ b/arch/ia64/include/asm/cpu.h
@@ -15,9 +15,4 @@ DECLARE_PER_CPU(struct ia64_cpu, cpu_devices);
 
 DECLARE_PER_CPU(int, cpu_state);
 
-#ifdef CONFIG_HOTPLUG_CPU
-extern int arch_register_cpu(int num);
-extern void arch_unregister_cpu(int);
-#endif
-
 #endif /* _ASM_IA64_CPU_H_ */
diff --git a/arch/ia64/kernel/topology.c b/arch/ia64/kernel/topology.c
index 94a848b06f15..741863a187a6 100644
--- a/arch/ia64/kernel/topology.c
+++ b/arch/ia64/kernel/topology.c
@@ -59,7 +59,7 @@ void __ref arch_unregister_cpu(int num)
 }
 EXPORT_SYMBOL(arch_unregister_cpu);
 #else
-static int __init arch_register_cpu(int num)
+int __init arch_register_cpu(int num)
 {
 	return register_cpu(&sysfs_cpus[num].cpu, num);
 }
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

Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

Provide common prototypes for arch_register_cpu() and
arch_unregister_cpu(). These are called by acpi_processor.c, with
weak versions, so the prototype for this is already set. It is
generally not necessary for function prototypes to be conditional
on preprocessor macros.

Some architectures (e.g. Loongarch) are missing the prototype for this,
and rather than add it to Loongarch's asm/cpu.h, lets do the job once
for everyone.

Since this covers everyone, remove the now unnecessary prototypes in
asm/cpu.h

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---


 arch/ia64/include/asm/cpu.h | 5 -----
 arch/x86/include/asm/cpu.h  | 2 --
 include/linux/cpu.h         | 2 ++
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/ia64/include/asm/cpu.h b/arch/ia64/include/asm/cpu.h
index db125df9e088..642d71675ddb 100644
--- a/arch/ia64/include/asm/cpu.h
+++ b/arch/ia64/include/asm/cpu.h
@@ -15,9 +15,4 @@ DECLARE_PER_CPU(struct ia64_cpu, cpu_devices);
 
 DECLARE_PER_CPU(int, cpu_state);
 
-#ifdef CONFIG_HOTPLUG_CPU
-extern int arch_register_cpu(int num);
-extern void arch_unregister_cpu(int);
-#endif
-
 #endif /* _ASM_IA64_CPU_H_ */
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

