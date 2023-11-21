Return-Path: <linux-arch+bounces-322-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 447D47F2F1D
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 14:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9106B21EA4
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F99F537EB;
	Tue, 21 Nov 2023 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yzid5gv5"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FF42137;
	Tue, 21 Nov 2023 05:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MybTCs6tsYZDrwJz/++A+jmJRhrdL7CvULTcPkTUtec=; b=yzid5gv5SI5zY82Hlc1Gt6Bd9y
	m9LlGnvDe1oaHlCUMboOtTQz5h6uH+Ke+69oLozVrDB6dLaORXxXl/DbU6QPKyWF5l0zxta33zkKG
	cWFLEBGo7dus40E3F+EA+glDPsU7Vj5WNTCB11yCB3RakaNWaCQ9L64M0i8WZpwaP074iuyAl44tP
	H0ieRtkQOt4gZijRMlEVjeHmr9p3sPOD7shJvXB8jyy5p7eF/kJ/7LFE2eGUed00r5eWDSYwl//fN
	t5iFOFTK0Ng7gnrCXr4WCSAoouBK3GUsmLGOi9NXTSNb73eKSfyYpuzymHp4J4xHG88yq9zmZ0R59
	/VUfegHQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:32994 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r5R4E-0007Bi-2f;
	Tue, 21 Nov 2023 13:45:30 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r5R4G-00Ct0M-PS; Tue, 21 Nov 2023 13:45:32 +0000
In-Reply-To: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
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
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 20/21] riscv: Switch over to GENERIC_CPU_DEVICES
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5R4G-00Ct0M-PS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 21 Nov 2023 13:45:32 +0000

From: James Morse <james.morse@arm.com>

Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
overridden by the arch code, switch over to this to allow common code
to choose when the register_cpu() call is made.

This allows topology_init() to be removed.

This is an intermediate step to the logic being moved to drivers/acpi,
where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.

This patch also has the effect of moving the registration of CPUs from
subsys to driver core initialisation, prior to any initcalls running.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Add note about initialisation order change.
---
 arch/riscv/Kconfig        |  1 +
 arch/riscv/kernel/setup.c | 19 ++++---------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a..162425cb9739 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -71,6 +71,7 @@ config RISCV
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select GENERIC_CPU_DEVICES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 535a837de55d..b3a0aa2b78d5 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -51,7 +51,6 @@ atomic_t hart_lottery __section(".sdata")
 #endif
 ;
 unsigned long boot_cpu_hartid;
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
 /*
  * Place kernel memory regions on the resource tree so that
@@ -299,23 +298,13 @@ void __init setup_arch(char **cmdline_p)
 	riscv_user_isa_enable();
 }
 
-static int __init topology_init(void)
+int arch_register_cpu(int cpu)
 {
-	int i, ret;
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
 
-	for_each_possible_cpu(i) {
-		struct cpu *cpu = &per_cpu(cpu_devices, i);
-
-		cpu->hotpluggable = cpu_has_hotplug(i);
-		ret = register_cpu(cpu, i);
-		if (unlikely(ret))
-			pr_warn("Warning: %s: register_cpu %d failed (%d)\n",
-			       __func__, i, ret);
-	}
-
-	return 0;
+	c->hotpluggable = cpu_has_hotplug(cpu);
+	return register_cpu(c, cpu);
 }
-subsys_initcall(topology_init);
 
 void free_initmem(void)
 {
-- 
2.30.2


