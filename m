Return-Path: <linux-arch+bounces-1942-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 325798445BC
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 18:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF867B2E062
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF1412C534;
	Wed, 31 Jan 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rZ+y9KQN"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116012C522;
	Wed, 31 Jan 2024 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720177; cv=none; b=cr4OwY9TWqOSoXFMFQrxpiT5QMeCfYkFkg39OoSXxqydHrsqBPj1y9ouRfqX1yHldnx+1nTGvbiumhLPPRhT1aWm11Csn3wLwdYv4o8DV9yIL5NopPaHsisqu0IqySRy1tiTTlg44TbsEkQcdHFZA+lsYMmJGP1BTB6Wz1ctDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720177; c=relaxed/simple;
	bh=wqEyR5IykLjkRZWjBqfISdN6LAuQbshQspGGNzb4xB4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GnU3I8unCQwvB1RqUaDyD/mypXv+VfI4boj/l4H1TVjWMskOn42+zZQjjVePvWl1iuUCrGQ5GhesSDRYmfZb/9MO6c9Z9PKtqC4PK+f5wlrRogH7a3sjyCYJjXuCSbATPFzGuTVlnK/K+bywg/dc9FNiT49sauSxBtDki34D83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rZ+y9KQN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f5npkqxZTlvintQfJQR7JFbNovddfzG1yIBSkxo5huM=; b=rZ+y9KQNys/vt6EBJk4R2yPaCi
	4OKNmwHWIF+OvTh5I/L9c8gwiS0OLuRncsIm3vvJTYzYGyPl24yFVpR090gnimcgSNH4/GiyFcrOL
	lo7MDovAf/jMcoyctkWeHbWsOhFg1IxstP5eHZd5CdG23fpLnqXRtDHdHfWjdJ3oosl9pHh3hxHZg
	r2+PFBLmUHdJ4D/F3kO4APh+Oc6e2sTVlnuToDH0/pAkBPVdmJqL+SJY0KZArZMEf0BAplgmV1BIc
	QZwZ7uqRz3oAg8aTWw8NVtu2aty6N2PFsYTvEqAMD1hsLAhC9AMdtmWwhXCCxy7U0WDeoMRR67yJb
	aL9h6OEQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33590 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVDnT-0003WQ-1m;
	Wed, 31 Jan 2024 16:50:47 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVDnP-0027ZZ-BN; Wed, 31 Jan 2024 16:50:43 +0000
In-Reply-To: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
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
	 acpica-devel@lists.linuxfoundation.org,
	 linux-csky@vger.kernel.org,
	 linux-doc@vger.kernel.org,
	 linux-ia64@vger.kernel.org,
	 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	 Jean-Philippe Brucker <jean-philippe@linaro.org>,
	 jianyong.wu@arm.com,
	 justin.he@arm.com,
	 James Morse <james.morse@arm.com>,
	 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH RFC v4 13/15] ACPI: add support to (un)register CPUs based on
 the _STA enabled bit
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVDnP-0027ZZ-BN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 31 Jan 2024 16:50:43 +0000

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

When firmware clears the enabled bit, we need to unregister the CPU
for symetry. As this is dependent on hotplug CPU being support, and
arch_unregister_cpu() only exists when hotplug CPU is supported,
we need to add a check for that configuration symbol.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v3 (smaller series):
 * Squash "ACPI: processor: Only call arch_unregister_cpu() if
   HOTPLUG_CPU is selected" into this patch.
---
 drivers/acpi/acpi_processor.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index d1d33e74216c..5e641180c45a 100644
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
@@ -511,7 +537,7 @@ static void acpi_processor_post_eject(struct acpi_device *device)
 	unsigned long long sta;
 	acpi_status status;
 
-	if (!device)
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) || !device)
 		return;
 
 	pr = acpi_driver_data(device);
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


