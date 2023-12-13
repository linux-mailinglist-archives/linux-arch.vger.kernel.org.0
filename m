Return-Path: <linux-arch+bounces-980-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A5A811166
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 13:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0371E281F28
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361102942E;
	Wed, 13 Dec 2023 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cohuG+LD"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65DACF;
	Wed, 13 Dec 2023 04:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+X6RbS8+FdE0yTZKPB4LhEuZYWtnagnPlrAoFbcwPjQ=; b=cohuG+LDvNgpd64HbLmHbpKUXp
	wxNPAKD5TR46g/lZehPoGpq7YgfCZwNooh/ByyYfKpefpXR22aovnRqW+RA5WU39sX1qqLVh8BcUU
	5Oyp825+gDNk6o9i4bApxpmqhlprYwzRvHWBe1G4qqjNvgDLrXmVxXNuL7tARCig7gykj6zvJRS3T
	iY72a4kgPGGJk4roa71Dwqclee4H33OSkqc8KZf4fj1ho/agpVWByd5HmSjd90KLhZYN00hAE7TWu
	qEDie8YSn6l6pEn0A/i2aDLiTck5BDTRfVj78USvT8+8H0wMV+gtHVoMS/AKx3eMft/2tK3i6xdSM
	4U/yXaAg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36780 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rDOfv-0008Cu-1l;
	Wed, 13 Dec 2023 12:49:19 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rDOfx-00Dvje-MS; Wed, 13 Dec 2023 12:49:21 +0000
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
Subject: [PATCH RFC v3 02/21] ACPI: processor: Add support for processors
 described as container packages
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 13 Dec 2023 12:49:21 +0000

From: James Morse <james.morse@arm.com>

ACPI has two ways of describing processors in the DSDT. From ACPI v6.5,
5.2.12:

"Starting with ACPI Specification 6.3, the use of the Processor() object
was deprecated. Only legacy systems should continue with this usage. On
the Itanium architecture only, a _UID is provided for the Processor()
that is a string object. This usage of _UID is also deprecated since it
can preclude an OSPM from being able to match a processor to a
non-enumerable device, such as those defined in the MADT. From ACPI
Specification 6.3 onward, all processor objects for all architectures
except Itanium must now use Device() objects with an _HID of ACPI0007,
and use only integer _UID values."

Also see https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#declaring-processors

Duplicate descriptions are not allowed, the ACPI processor driver already
parses the UID from both devices and containers. acpi_processor_get_info()
returns an error if the UID exists twice in the DSDT.

The missing probe for CPUs described as packages creates a problem for
moving the cpu_register() calls into the acpi_processor driver, as CPUs
described like this don't get registered, leading to errors from other
subsystems when they try to add new sysfs entries to the CPU node.
(e.g. topology_sysfs_init()'s use of topology_add_dev() via cpuhp)

To fix this, parse the processor container and call acpi_processor_add()
for each processor that is discovered like this. The processor container
handler is added with acpi_scan_add_handler(), so no detach call will
arrive.

Qemu TCG describes CPUs using processor devices in a processor container.
For more information, see build_cpus_aml() in Qemu hw/acpi/cpu.c and
https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#processor-container-device

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
---
Outstanding comments:
 https://lore.kernel.org/r/20230914145353.000072e2@Huawei.com
 https://lore.kernel.org/r/50571c2f-aa3c-baeb-3add-cd59e0eddc02@redhat.com
---
 drivers/acpi/acpi_processor.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 4fe2ef54088c..6a542e0ce396 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -626,9 +626,31 @@ static struct acpi_scan_handler processor_handler = {
 	},
 };
 
+static acpi_status acpi_processor_container_walk(acpi_handle handle,
+						 u32 lvl,
+						 void *context,
+						 void **rv)
+{
+	struct acpi_device *adev;
+	acpi_status status;
+
+	adev = acpi_get_acpi_dev(handle);
+	if (!adev)
+		return AE_ERROR;
+
+	status = acpi_processor_add(adev, &processor_device_ids[0]);
+	acpi_put_acpi_dev(adev);
+
+	return status;
+}
+
 static int acpi_processor_container_attach(struct acpi_device *dev,
 					   const struct acpi_device_id *id)
 {
+	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, dev->handle,
+			    ACPI_UINT32_MAX, acpi_processor_container_walk,
+			    NULL, NULL, NULL);
+
 	return 1;
 }
 
-- 
2.30.2


