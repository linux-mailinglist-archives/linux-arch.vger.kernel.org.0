Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2520D689A84
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 14:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjBCNzF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 08:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjBCNyp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 08:54:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F35682B090;
        Fri,  3 Feb 2023 05:53:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFE5E1596;
        Fri,  3 Feb 2023 05:53:25 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EB193F71E;
        Fri,  3 Feb 2023 05:52:39 -0800 (PST)
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
Subject: [RFC PATCH 12/32] ACPI: processor: Register CPUs that are online, but not described in the DSDT
Date:   Fri,  3 Feb 2023 13:50:23 +0000
Message-Id: <20230203135043.409192-13-james.morse@arm.com>
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

ACPI has two descriptions of CPUs, on in the MADT/APIC table, the other
in the DSDT. Both are required. (ACPI 6.5's 8.4 "Declaring Processors"
says "Each processor in the system must be declared in the ACPI
namespace"). Having two descriptions allows firmware authors to get
this wrong.

If CPUs are described in the MADT/APIC, they will be brought online
early during boot. Once the register_cpu() calls are moved to ACPI,
they will be based on the ACPI description of the CPUs. When CPUs are
missing from the ACPI description, they will end up online, but not
registered.

Add a helper that runs after acpi_init() has completed to register
CPUs that are online, but weren't found in the DSDT. Any CPU that
is registered by this code triggers a firmware-bug warning and kernel
taint.

Qemu TCG only describes the first CPU in the DSDT, unless cpu-hotplug
is configured.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/acpi_processor.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 52668fa22c51..967837b60453 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -694,6 +694,25 @@ void __init acpi_processor_init(void)
 	acpi_scan_add_handler(&processor_container_handler);
 }
 
+static int acpi_processor_register_missing_cpus(void)
+{
+	int cpu;
+
+	if (acpi_disabled)
+		return 0;
+
+	for_each_online_cpu(cpu) {
+		if (!get_cpu_device(cpu)) {
+			pr_err_once(FW_BUG "CPU %u has no ACPI namespace description!\n", cpu);
+			add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+			arch_register_cpu(cpu);
+		}
+	}
+
+	return 0;
+}
+subsys_initcall_sync(acpi_processor_register_missing_cpus);
+
 #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
 /**
  * acpi_processor_claim_cst_control - Request _CST control from the platform.
-- 
2.30.2

