Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B07689B05
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 15:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjBCOEg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 09:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjBCOEJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 09:04:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A733A58C2;
        Fri,  3 Feb 2023 06:01:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7B731763;
        Fri,  3 Feb 2023 05:54:37 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA7AA3F71E;
        Fri,  3 Feb 2023 05:53:51 -0800 (PST)
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
Subject: [RFC PATCH 28/32] ACPI: add support to register CPUs based on the _STA enabled bit
Date:   Fri,  3 Feb 2023 13:50:39 +0000
Message-Id: <20230203135043.409192-29-james.morse@arm.com>
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

acpi_processor_get_info() registers all present CPUs. Registering a
CPU is what creates the sysfs entries and triggers the udev
notifications.

arm64 virtual machines that support 'virtual cpu hotplug' use the
enabled bit to indicate whether the CPU can be brought online, as
the existing ACPI tables require all hardware to be described and
present.

If firmware describes a CPU as present, but disabled, skip the
registration. Such CPUs are present, but can't be brought online for
whatever reason. (e.g. firmware/hypervisor policy).

Once firmware sets the enabled bit, the CPU can be registered and
brought online by user-space. Online CPUs, or CPUs that are missing
an _STA method must always be registered.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/acpi_processor.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 572a12672c0e..20e810a066da 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -194,6 +194,35 @@ static int acpi_processor_make_present(struct acpi_processor *pr)
 	return ret;
 }
 
+static int acpi_processor_make_enabled(struct acpi_processor *pr)
+{
+	unsigned long long sta;
+	acpi_status status;
+	bool present, enabled;
+
+	if (!acpi_has_method(pr->handle, "_STA"))
+		return arch_register_cpu(pr->id);
+
+	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	present = sta & ACPI_STA_DEVICE_PRESENT;
+	enabled = sta & ACPI_STA_DEVICE_ENABLED;
+
+	if (cpu_online(pr->id) && (!present || !enabled)) {
+		pr_err_once(FW_BUG "CPU %u is online, but described as not present or disabled!\n", pr->id);
+		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+	} else if (!present || !enabled) {
+		return -ENODEV;
+	}
+
+	if (get_cpu_device(pr->id))
+		return -EEXIST;
+
+	return arch_register_cpu(pr->id);
+}
+
 static int acpi_processor_get_info(struct acpi_device *device)
 {
 	union acpi_object object = { 0 };
@@ -271,7 +300,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	}
 
 	if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id)) {
-		int ret = arch_register_cpu(pr->id);
+		int ret = acpi_processor_make_enabled(pr);
 		if (ret)
 			return ret;
 	}
@@ -478,6 +507,9 @@ static void acpi_processor_post_eject(struct acpi_device *device)
 		acpi_processor_make_not_present(device);
 		return;
 	}
+
+	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_ENABLED))
+		arch_unregister_cpu(pr->id);
 }
 
 #ifdef CONFIG_X86
-- 
2.30.2

