Return-Path: <linux-arch+bounces-982-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA9811174
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 13:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B5D281F65
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 12:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0687229421;
	Wed, 13 Dec 2023 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Jf/e7+SM"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA309E4;
	Wed, 13 Dec 2023 04:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZKS6pxC2YYfNhWwg82WjEwf9+rWwSBqqkCpc9wbmrvU=; b=Jf/e7+SMOBjpGIMb6Uk/wbjene
	LjN9KE/FW0snbFyWyMg6pDKsB+5IvmUU5qN5LnEIjVwaaA5a9S9TaSUdqA0JE4nxCdtkeW6f6yJHb
	Hpc+dvKih6ImW7DLJIuhosO/yJrIojS6z7MetDq6D4qLRtlFNRtkyCLtoH/8s7HGj46i9aqItRpnM
	jIgdW7rw8xlYZl80cDI26htD87Prb0hKAY5Up92iSfUG3f3NoIX5VHMpIzaLyhydFkSMyyeXzsocJ
	lgGarR0gEODrCWvRZO4uKb4MDZSwGZabqarJ6yQTqSXPxUFiSDdq2FTl2Zlz/IElIPZUXQQy49IWc
	Ci+FbtPw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43378 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rDOg5-0008DO-2J;
	Wed, 13 Dec 2023 12:49:30 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rDOg7-00Dvjq-VZ; Wed, 13 Dec 2023 12:49:32 +0000
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
Subject: [PATCH RFC v3 04/21] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rDOg7-00Dvjq-VZ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 13 Dec 2023 12:49:31 +0000

From: James Morse <james.morse@arm.com>

To allow ACPI to skip the call to arch_register_cpu() when the _STA
value indicates the CPU can't be brought online right now, move the
arch_register_cpu() call into acpi_processor_get_info().

Systems can still be booted with 'acpi=off', or not include an
ACPI description at all. For these, the CPUs continue to be
registered by cpu_dev_register_generic().

This moves the CPU register logic back to a subsys_initcall(),
while the memory nodes will have been registered earlier.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Fixup comment in acpi_processor_get_info() (Gavin Shan)
 * Add comment in cpu_dev_register_generic() (Gavin Shan)
---
 drivers/acpi/acpi_processor.c | 12 ++++++++++++
 drivers/base/cpu.c            |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 0511f2bc10bc..e7ed4730cbbe 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -314,6 +314,18 @@ static int acpi_processor_get_info(struct acpi_device *device)
 			cpufreq_add_device("acpi-cpufreq");
 	}
 
+	/*
+	 * Register CPUs that are present. get_cpu_device() is used to skip
+	 * duplicate CPU descriptions from firmware.
+	 */
+	if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
+	    !get_cpu_device(pr->id)) {
+		int ret = arch_register_cpu(pr->id);
+
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 *  Extra Processor objects may be enumerated on MP systems with
 	 *  less than the max # of CPUs. They should be ignored _iff
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 47de0f140ba6..13d052bf13f4 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -553,7 +553,11 @@ static void __init cpu_dev_register_generic(void)
 {
 	int i, ret;
 
-	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
+	/*
+	 * When ACPI is enabled, CPUs are registered via
+	 * acpi_processor_get_info().
+	 */
+	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_disabled)
 		return;
 
 	for_each_present_cpu(i) {
-- 
2.30.2


