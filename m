Return-Path: <linux-arch+bounces-1933-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73487844502
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 17:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE4C288E4B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 16:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2232612DDB1;
	Wed, 31 Jan 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vfg3ZyYu"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005796AA7;
	Wed, 31 Jan 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719813; cv=none; b=tucbRmMqABLx7DDg2Mt86tUhxIV0NrOBS/nXN9tYP2OWY6DOdVTtgma25PboS5kHnTDM5zdKlZnrHM1tGtFx1eIVkUI32pdx1X+QrEsuI7SMgbqmc1r+5bqZo0415xI+qNMZAq2FDFhFLxGnjoyEtZTiqxYUzQHoNKs57BTYPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719813; c=relaxed/simple;
	bh=KMF9eAGOkqi5sf2htsxoVtMvkUncKmjULA9ffc9z/Sw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=SOZD8Kw+oPMGbGBMAFiClG2da7Ho3R2At3mONLN3a1wuOTd/Mbs5VhLShKJVwj3ArxXbiq10LZAwv6PLvpqlY/q0F4h2B2dnXp4eWMS9BVD5Tgxx1bWiFCde+OCEliOAZoulOt71T75VYNUSQRO1IG4GVjwScMNjp2wO9pXN9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Vfg3ZyYu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GTt+zTRDJEWcpx9Xy5W4TT50pzwG/YUzwyuwhrcyZOM=; b=Vfg3ZyYuaYmNOkoqPCz1o+2zX1
	CHnbf95wXJ8iNQiPXvhkhc71pS2lEmL0BjG7UDAkKM1AmeyI7Hw99+IZwxMqV5xfG1dQOVWjNSrxK
	nI3mFn7sO8gfuf0xTZKKwsKxmf2IzsZb34MG2VsL+7+xdTfxL6cE2U68ZrM3R26CuzvWpwCvBd1t4
	4Llyd4+LA4apOlJDyKGd1H/tl8vBYcuWS08mc9fxhgh51HY0tUVfcCaZaue37+yhtiShI5us6dzOo
	5eYvo3a6Z1EG6k7xWrBQKjDSZHMvLwt1uMzkpqvdjlF4ZhHXWeNk5U3HIqxksMV1sDVaOFFu97D/L
	iESmz7Pw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35968 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVDmg-0003U8-0E;
	Wed, 31 Jan 2024 16:49:58 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVDme-0027Yb-Sj; Wed, 31 Jan 2024 16:49:56 +0000
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
Subject: [PATCH RFC v4 04/15] ACPI: Rename acpi_processor_hotadd_init and
 remove pre-processor guards
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVDme-0027Yb-Sj@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 31 Jan 2024 16:49:56 +0000

From: James Morse <james.morse@arm.com>

acpi_processor_hotadd_init() will make a CPU present by mapping it
based on its hardware id.

'hotadd_init' is ambiguous once there are two different behaviours
for cpu hotplug. This is for toggling the _STA present bit. Subsequent
patches will add support for toggling the _STA enabled bit, named
acpi_processor_make_enabled().

Rename it acpi_processor_make_present() to make it clear this is
for CPUs that were not previously present.

Expose the function prototypes it uses to allow the preprocessor
guards to be removed. The IS_ENABLED() check will let the compiler
dead-code elimination pass remove this if it isn't going to be
used.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/acpi/acpi_processor.c | 14 +++++---------
 include/linux/acpi.h          |  2 --
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index a68c475cdea5..fd8f3a0572cb 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -183,13 +183,15 @@ static void __init acpi_pcc_cpufreq_init(void) {}
 #endif /* CONFIG_X86 */
 
 /* Initialization */
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
-static int acpi_processor_hotadd_init(struct acpi_processor *pr)
+static int acpi_processor_make_present(struct acpi_processor *pr)
 {
 	unsigned long long sta;
 	acpi_status status;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU))
+		return -ENODEV;
+
 	if (invalid_phys_cpuid(pr->phys_id))
 		return -ENODEV;
 
@@ -223,12 +225,6 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	cpu_maps_update_done();
 	return ret;
 }
-#else
-static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
-{
-	return -ENODEV;
-}
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
 static int acpi_processor_get_info(struct acpi_device *device)
 {
@@ -335,7 +331,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *  because cpuid <-> apicid mapping is persistent now.
 	 */
 	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
-		int ret = acpi_processor_hotadd_init(pr);
+		int ret = acpi_processor_make_present(pr);
 
 		if (ret)
 			return ret;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b7165e52b3c6..76ad43f7860b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -302,12 +302,10 @@ static inline int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 }
 #endif
 
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
 		 int *pcpu);
 int acpi_unmap_cpu(int cpu);
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
-- 
2.30.2


