Return-Path: <linux-arch+bounces-42-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD767E395B
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 11:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CE9280A01
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EF71C68A;
	Tue,  7 Nov 2023 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Abmqv0Kd"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EA31A28A;
	Tue,  7 Nov 2023 10:30:30 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE09B10E5;
	Tue,  7 Nov 2023 02:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p6rNywfcWH+rY5/5yuS2goEj7UjffB2rbRgVPynUNSU=; b=Abmqv0KdOT16ptxU6xdSI4r3wJ
	ASOjVcyQVToT1DJ3hdRLTjAzCCD9+Pokw6JBW8tDsNsYXxU6qk+IeyfnXnM9oMvyCGXRD50KDCEsF
	n2sjLfVqgJc9+8fEXs8cGa0HrEu6y2oI2gM1FysGuZG/Zjx6DAJCxlwV5pR7/erH/HugKmPQIBBRc
	GlwSMJ69Woo8p7GiPfSi8i2vq0t34ou5gergbQFJfPvyqOpLGvP7lOIwnEKZOxkO5FpVXbU6BP+bA
	mWL5l1kkogvjKgsBnHhqvzbGy5VKwMJeEsBziKS8mckd9WnZ5paJf3Vho4GFqIVS6fTfZaSaw12iH
	eYGqDdMA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54774 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r0JLj-0000Hj-1a;
	Tue, 07 Nov 2023 10:30:23 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r0JLl-00CTxk-7O; Tue, 07 Nov 2023 10:30:25 +0000
In-Reply-To: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: linux-pm@vger.kernel.org,
	 loongarch@lists.linux.dev,
	 linux-acpi@vger.kernel.org,
	 linux-arch@vger.kernel.org,
	 linux-kernel@vger.kernel.org,
	 linux-arm-kernel@lists.infradead.org,
	 linux-riscv@lists.infradead.org,
	 kvmarm@lists.linux.dev,
	 x86@kernel.org,
	 linux-csky@vger.kernel.org,
	 linux-doc@vger.kernel.org,
	 linux-ia64@vger.kernel.org,
	 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	 Jean-Philippe Brucker <jean-philippe@linaro.org>,
	 jianyong.wu@arm.com,
	 justin.he@arm.com,
	 James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH RFC 13/22] arm64: setup: Switch over to GENERIC_CPU_DEVICES
 using arch_register_cpu()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r0JLl-00CTxk-7O@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Nov 2023 10:30:25 +0000

From: James Morse <james.morse@arm.com>

To allow ACPI's _STA value to hide CPUs that are present, but not
available to online right now due to VMM or firmware policy, the
register_cpu() call needs to be made by the ACPI machinery when ACPI
is in use. This allows it to hide CPUs that are unavailable from sysfs.

Switching to GENERIC_CPU_DEVICES is an intermediate step to allow all
five ACPI architectures to be modified at once.

Switch over to GENERIC_CPU_DEVICES, and provide an arch_register_cpu()
that populates the hotpluggable flag. arch_register_cpu() is also the
interface the ACPI machinery expects.

The struct cpu in struct cpuinfo_arm64 is never used directly, remove
it to use the one GENERIC_CPU_DEVICES provides.

This changes the CPUs visible in sysfs from possible to present, but
on arm64 smp_prepare_cpus() ensures these are the same.

This patch also has the effect of moving the registration of CPUs from
subsys to driver core initialisation, prior to any initcalls running.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Add note about initialisation order change.
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/cpu.h |  1 -
 arch/arm64/kernel/setup.c    | 13 ++++---------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..84bce830e365 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -132,6 +132,7 @@ config ARM64
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index f3034099fd95..b1e43f56ee46 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -38,7 +38,6 @@ struct cpuinfo_32bit {
 };
 
 struct cpuinfo_arm64 {
-	struct cpu	cpu;
 	struct kobject	kobj;
 	u64		reg_ctr;
 	u64		reg_cntfrq;
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 417a8a86b2db..165bd2c0dd5a 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -402,19 +402,14 @@ static inline bool cpu_can_disable(unsigned int cpu)
 	return false;
 }
 
-static int __init topology_init(void)
+int arch_register_cpu(int num)
 {
-	int i;
+	struct cpu *cpu = &per_cpu(cpu_devices, num);
 
-	for_each_possible_cpu(i) {
-		struct cpu *cpu = &per_cpu(cpu_data.cpu, i);
-		cpu->hotpluggable = cpu_can_disable(i);
-		register_cpu(cpu, i);
-	}
+	cpu->hotpluggable = cpu_can_disable(num);
 
-	return 0;
+	return register_cpu(cpu, num);
 }
-subsys_initcall(topology_init);
 
 static void dump_kernel_offset(void)
 {
-- 
2.30.2


