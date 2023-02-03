Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDCB689AAC
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 14:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjBCNzp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 08:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjBCNzA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 08:55:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95487A147C;
        Fri,  3 Feb 2023 05:53:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EB6B15A1;
        Fri,  3 Feb 2023 05:53:30 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4197A3F71E;
        Fri,  3 Feb 2023 05:52:44 -0800 (PST)
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
Subject: [RFC PATCH 13/32] ACPI: processor: Register all CPUs from acpi_processor_get_info()
Date:   Fri,  3 Feb 2023 13:50:24 +0000
Message-Id: <20230203135043.409192-14-james.morse@arm.com>
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

To allow ACPI to skip the call to arch_register_cpu() when the _STA
value indicates the CPU can't be brought online right now, move the
arch_register_cpu() call into acpi_processor_get_info().

Systems can still be booted with 'acpi=off', or in the case of arm64,
not include an ACPI description at all. For these, the CPUs are
registered by cpu_dev_register_generic().

This moves the CPU register logic back to a subsys_initcall(),
while the memory nodes will have been registered earlier.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/acpi_processor.c | 6 ++++++
 drivers/base/cpu.c            | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 967837b60453..a93a6c4115c4 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -272,6 +272,12 @@ static int acpi_processor_get_info(struct acpi_device *device)
 			pr->id = 0;
 	}
 
+	if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id)) {
+		int ret = arch_register_cpu(pr->id);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 *  Extra Processor objects may be enumerated on MP systems with
 	 *  less than the max # of CPUs. They should be ignored _iff
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 178936533d87..0ba646022a5e 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -504,7 +504,7 @@ static void __init cpu_dev_register_generic(void)
 {
 	int i;
 
-	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
+	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_disabled)
 		return;
 
 	for_each_present_cpu(i) {
-- 
2.30.2

