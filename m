Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD4E689A49
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 14:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjBCNws (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 08:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjBCNwX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 08:52:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB7B29EE12;
        Fri,  3 Feb 2023 05:52:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0F021596;
        Fri,  3 Feb 2023 05:52:51 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2BF83F71E;
        Fri,  3 Feb 2023 05:52:05 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH 04/32] drivers: base: Allow parts of GENERIC_CPU_DEVICES to be overridden
Date:   Fri,  3 Feb 2023 13:50:15 +0000
Message-Id: <20230203135043.409192-5-james.morse@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230203135043.409192-1-james.morse@arm.com>
References: <20230203135043.409192-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

architectures often have extra per-cpu work that needs doing
before a CPU is registered, often to determine if a CPU is
hotpluggable.

To allow more architectures to use GENERIC_CPU_DEVICES, wrap the call
as a __weak arch_register_cpu(). This aligns with the way x86, ia64
and loongarch register hotplug CPUs when they become present.

ACPI's acpi_processor.c also has a __weak version of this symbol
because arm64 doesn't define one. The duplicate __weak definitions
are only a problem if arm64 selects GENERIC_CPU_DEVICES without
defining one. This gets fixed up in later patches.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/ia64/include/asm/cpu.h      |  1 -
 arch/loongarch/include/asm/cpu.h |  1 -
 arch/x86/include/asm/cpu.h       |  1 -
 drivers/base/cpu.c               | 14 ++++++++++----
 include/linux/cpu.h              |  5 +++++
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/ia64/include/asm/cpu.h b/arch/ia64/include/asm/cpu.h
index db125df9e088..a3e690e685e5 100644
--- a/arch/ia64/include/asm/cpu.h
+++ b/arch/ia64/include/asm/cpu.h
@@ -16,7 +16,6 @@ DECLARE_PER_CPU(struct ia64_cpu, cpu_devices);
 DECLARE_PER_CPU(int, cpu_state);
 
 #ifdef CONFIG_HOTPLUG_CPU
-extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
 #endif
 
diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
index da79862ff1f3..1e2c7c61dbea 100644
--- a/arch/loongarch/include/asm/cpu.h
+++ b/arch/loongarch/include/asm/cpu.h
@@ -126,7 +126,6 @@ enum cpu_type_enum {
 
 #if !defined(__ASSEMBLY__)
 #ifdef CONFIG_HOTPLUG_CPU
-extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
 #endif
 #endif /* ! __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 78796b98a544..a0a62ac00e88 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -28,7 +28,6 @@ struct x86_cpu {
 };
 
 #ifdef CONFIG_HOTPLUG_CPU
-extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
 extern void start_cpu0(void);
 #ifdef CONFIG_DEBUG_HOTPLUG_CPU0
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index cf6407c34ede..178936533d87 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -492,19 +492,25 @@ bool cpu_is_hotpluggable(unsigned int cpu)
 EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
 
 #ifdef CONFIG_GENERIC_CPU_DEVICES
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
+DEFINE_PER_CPU(struct cpu, cpu_devices);
+
+int __weak arch_register_cpu(int cpu)
+{
+	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
+}
 #endif
 
 static void __init cpu_dev_register_generic(void)
 {
-#ifdef CONFIG_GENERIC_CPU_DEVICES
 	int i;
 
+	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
+		return;
+
 	for_each_present_cpu(i) {
-		if (register_cpu(&per_cpu(cpu_devices, i), i))
+		if (arch_register_cpu(i))
 			panic("Failed to register CPU device");
 	}
-#endif
 }
 
 #ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 314802f98b9d..86e79e702325 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -75,12 +75,17 @@ extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
 				 const struct attribute_group **groups,
 				 const char *fmt, ...);
+extern int arch_register_cpu(int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
 extern ssize_t arch_cpu_probe(const char *, size_t);
 extern ssize_t arch_cpu_release(const char *, size_t);
 #endif
 
+#ifdef CONFIG_GENERIC_CPU_DEVICES
+DECLARE_PER_CPU(struct cpu, cpu_devices);
+#endif
+
 /*
  * These states are not related to the core CPU hotplug mechanism. They are
  * used by various (sub)architectures to track internal state
-- 
2.30.2

