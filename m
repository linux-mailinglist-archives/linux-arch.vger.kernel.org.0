Return-Path: <linux-arch+bounces-995-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD608111F8
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 13:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADB31C20F07
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7162C196;
	Wed, 13 Dec 2023 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="C8V6ZPDm"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F9172E;
	Wed, 13 Dec 2023 04:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zH347rXIT/Wy1fT2AxJrWucdhRljJuHMrMKFDlPOdGs=; b=C8V6ZPDmidjU0rPM3MNO+Oz7/r
	9Q4u3gedUI33lJ3NyGNwKUy257pNGfSyYof4TiYnY84kRmEo7Mjfg8LvEbcLtLDFgYbhhYPYk2DM6
	qL91mkIsdsCL8QpgAEvD98lEcW9ZWUCCtXbaZRScR4ytVUzn0OSU3bWGhXZ0f+Zow2X/C+jtBjBCJ
	8k7jFCMRILZ83BDKElnsNyxKh8EE1JHqMJBWe4q2OZIRUlrlhx2Gv/XPkllFPQS3+FndJm9Ov670Y
	khCRzwlW2Se1hrI6UNoeQT7K33f2KTHrEpmLBpfwq30WM335VyRik2rw9Vls1PanX7hwhyv2vD+Cu
	BIEJ2DIw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51442 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rDOhA-0008HE-1e;
	Wed, 13 Dec 2023 12:50:36 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rDOhC-00DvlI-Pp; Wed, 13 Dec 2023 12:50:38 +0000
In-Reply-To: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
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
	James Morse <james.morse@arm.com>
Subject: [PATCH RFC v3 17/21] ACPI: add support to register CPUs based on the
 _STA enabled bit
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rDOhC-00DvlI-Pp@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 13 Dec 2023 12:50:38 +0000

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
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
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


