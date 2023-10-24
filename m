Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FCB7D55BE
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 17:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbjJXPU4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 11:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjJXPTk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 11:19:40 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A98126AB;
        Tue, 24 Oct 2023 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WbkJcP8EfdoxIJZCXfcMKFVW/i0XQ0H+6U5ilPscurM=; b=UFpyf7IBgalvU1WbMK4uFsjopi
        n3QYxKYZyHK3GPF00+ghNLXiOFCtl6pp8wlAjZdeBBo+1hsVMpqhTFYqVSDnaXMgPqZAaLKwUQiDG
        9uvr3egTxe1FOV02vpFPdUDsfkp9i6U6JHam5QzXbOYxN7X33nA9s439YqSld4/s9jCJov8XGKHL+
        JNp7n/Wabc3e93CgHUO+oxPhtxw4O4WRPce1ABFGYGzKuH5/kRJqlr0K6ewJyURrQiZVlLdhSRdP7
        w3C055XibslaZrjOpVNLKJDdeaJjqxnvqA4rMmD9NMA6hA95tQ/sT/XqTlIor9TKsrxuKAy4xVBXP
        pfpMPhIg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36712 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qvJAE-0004Rl-2N;
        Tue, 24 Oct 2023 16:17:50 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qvJAG-00AqQm-6R; Tue, 24 Oct 2023 16:17:52 +0100
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH 20/39] ACPI: processor: Register CPUs that are online, but not
 described in the DSDT
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJAG-00AqQm-6R@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 24 Oct 2023 16:17:52 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: James Morse <james.morse@arm.com>

ACPI has two descriptions of CPUs, one in the MADT/APIC table, the other
in the DSDT. Both are required. (ACPI 6.5's 8.4 "Declaring Processors"
says "Each processor in the system must be declared in the ACPI
namespace"). Having two descriptions allows firmware authors to get
this wrong.

If CPUs are described in the MADT/APIC, they will be brought online
early during boot. Once the register_cpu() calls are moved to ACPI,
they will be based on the DSDT description of the CPUs. When CPUs are
missing from the DSDT description, they will end up online, but not
registered.

Add a helper that runs after acpi_init() has completed to register
CPUs that are online, but weren't found in the DSDT. Any CPU that
is registered by this code triggers a firmware-bug warning and kernel
taint.

Qemu TCG only describes the first CPU in the DSDT, unless cpu-hotplug
is configured.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/acpi/acpi_processor.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 6a542e0ce396..0511f2bc10bc 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -791,6 +791,25 @@ void __init acpi_processor_init(void)
 	acpi_pcc_cpufreq_init();
 }
 
+static int __init acpi_processor_register_missing_cpus(void)
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

