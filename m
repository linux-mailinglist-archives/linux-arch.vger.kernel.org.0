Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6827D560A
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 17:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjJXPXF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 11:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343724AbjJXPWN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 11:22:13 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4E7172C;
        Tue, 24 Oct 2023 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=12w7K7dO29MbxfP53Lft0Z7mBOdLwfFt1jxGUMo5HMk=; b=CcWYSHtl24jmYPLwVNHVjlq7N4
        Az9LcXXkfoOTBLHiAFcg7vM5Xx08sBXtS538xT8Sv2pL/ULY5cdXRbkHqz2bCi/yC1pc/ACLn4yGc
        Sex71CVUnTKNmOwoP2v84PbhSe9QpnC8RqK9eU6M9znWxlO+4n7Wgxeq3WG9FUbrFSoTiuRCP/W6G
        TeGp5dYi/rCEzcdYNXju1XG8adI1tw1m1iASMqzrvBBamjDlu1jal6U+WzUcX/gi/BeI3lq+5ilhe
        NNU3Gstt86zag54UZnTAKVb9jBx1KtD+pjnrdXIeBLeQ6iv+DNwvL3vT5A2hnLupfLdTC3LxQuXAC
        VoAH4QUQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60314 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qvJBT-0004WQ-31;
        Tue, 24 Oct 2023 16:19:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qvJBV-00AqSE-Cu; Tue, 24 Oct 2023 16:19:09 +0100
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
Subject: [PATCH 35/39] ACPI: add support to register CPUs based on the _STA
 enabled bit
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJBV-00AqSE-Cu@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 24 Oct 2023 16:19:09 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: James Morse <james.morse@arm.com>

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
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/acpi/acpi_processor.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index b7a94c1348b0..5dabb426481f 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -228,6 +228,32 @@ static int acpi_processor_make_present(struct acpi_processor *pr)
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
+	return arch_register_cpu(pr->id);
+}
+
 static int acpi_processor_get_info(struct acpi_device *device)
 {
 	union acpi_object object = { 0 };
@@ -318,7 +344,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 */
 	if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
 	    !get_cpu_device(pr->id)) {
-		int ret = arch_register_cpu(pr->id);
+		int ret = acpi_processor_make_enabled(pr);
 
 		if (ret)
 			return ret;
@@ -526,6 +552,9 @@ static void acpi_processor_post_eject(struct acpi_device *device)
 		acpi_processor_make_not_present(device);
 		return;
 	}
+
+	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_ENABLED))
+		arch_unregister_cpu(pr->id);
 }
 
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
-- 
2.30.2

