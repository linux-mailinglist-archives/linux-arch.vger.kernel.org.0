Return-Path: <linux-arch+bounces-1937-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA4D844563
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 17:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 071EEB2CDED
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C9B135A72;
	Wed, 31 Jan 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e402SKqu"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7E12BF2B;
	Wed, 31 Jan 2024 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719839; cv=none; b=oixgwQb9Rc/sYrMMUAeRKpUexq17M4dLO6RQ/bT1pU3s8U5kAwRPt803EuujHNZ9IiijGUf651uQ3Z/8Kco/TtfrZbD4Wo+xH6R3wWSr5LanpzEWrSJIAUJMyA0l2iMT5Pidj7GqTuXWMF32EVEOa0dv64rsqmNMQiNJAmMwgwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719839; c=relaxed/simple;
	bh=LTKcInkLZgpAbNkbK0w8drlT6huu9tuFRYheHBlt1Jc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gbr5UFHzyf1azJTXMMR30nuMq4hm428iea+Zbga7jIsPKn7BgSt9NVx09OtO37afZ4XHmy9/pr3rUeYZ/iOdCIMHN5WMoQ8lJwwUaZdubMQ5mmicqndgxR4k7Kp0F6W4AZwgfqWs+rgPZ2Kr+dFeCJYiGkZoaGudeTWyuIKOteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=e402SKqu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mdSd4VjdwbsxcclalIflVyksZpCV5Xk/AHrd3gBtdjo=; b=e402SKqul6WttNElDpt+AMqLqX
	x5jFKIDt16+QHzeRcqYmGOGubS8UMfgDN8bqP8nRmaTrvxRputq4yO6pL5OHcCuSqCXnfdOrjY3HL
	rcFLlXSeAg091rFK4UF8JARMuJ9OJtXC1A900zRsHvmECXurcRfn5kFqlEG+gvWDEIdcvmLm6bxjb
	4bKtCvb/89L8ei0lw2/3mQj1ZaTuf62+Hsakf63GllIIY5xxoC28hjayNYOZ/Ay5wPHUrOrElC9JE
	agxW5DNqjrp0Fhvwl+8QXDUKNJiDOEC34v0aY4QKF6yMEXRzTzpzOQCd4jTFjspgERReOcVa20Mb/
	bsPodYFQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35774 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVDn3-0003V0-2w;
	Wed, 31 Jan 2024 16:50:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVDmz-0027Yz-GE; Wed, 31 Jan 2024 16:50:17 +0000
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
Subject: [PATCH RFC v4 08/15] ACPI: Warn when the present bit changes but the
 feature is not enabled
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVDmz-0027Yz-GE@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 31 Jan 2024 16:50:17 +0000

From: James Morse <james.morse@arm.com>

ACPI firmware can trigger the events to add and remove CPUs, but the
OS may not support this.

Print an error message when this happens.

This gives early warning on arm64 systems that don't support
CONFIG_ACPI_HOTPLUG_PRESENT_CPU, as making CPUs not present has
side effects for other parts of the system.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Update commit message with suggestion from Gavin Shan
---
 drivers/acpi/acpi_processor.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 77d47e6c2474..d1d33e74216c 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -189,8 +189,10 @@ static int acpi_processor_make_present(struct acpi_processor *pr)
 	acpi_status status;
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU))
+	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU)) {
+		pr_err_once("Changing CPU present bit is not supported\n");
 		return -ENODEV;
+	}
 
 	if (invalid_phys_cpuid(pr->phys_id))
 		return -ENODEV;
@@ -462,8 +464,10 @@ static void acpi_processor_make_not_present(struct acpi_device *device)
 {
 	struct acpi_processor *pr;
 
-	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU))
+	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU)) {
+		pr_err_once("Changing CPU present bit is not supported");
 		return;
+	}
 
 	pr = acpi_driver_data(device);
 	if (pr->id >= nr_cpu_ids)
-- 
2.30.2


