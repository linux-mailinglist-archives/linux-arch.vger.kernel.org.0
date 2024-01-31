Return-Path: <linux-arch+bounces-1935-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D305584450E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 17:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E8F1C21C0C
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F94812FF72;
	Wed, 31 Jan 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bU/a2cQU"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C612FF6D;
	Wed, 31 Jan 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719827; cv=none; b=J9IP8ZZE7um+vezVFjhNuNJ/FQL49nRSvwjvPMnozc+/4bK8NcjwfE8MHK4qkMfuajOXIINILpCV+D9rbh72ie5Xs6AGrE1RKXoIMx1Gn4pxORcpNf7ce5rfB3vjLHDX40YGQYWkliMwSzBUACnUIbYa7NUxogBAZ4o9R++qTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719827; c=relaxed/simple;
	bh=BiOLuzUeLXKKkwUEvGrU9puRrhIRHU5YxA5gqIR3aTc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Fk/rSpSj3ExxFwHcrIYL9Shtm4H2QmUjU2CQUtBYS/UBJj07glYf1TRUL4Jus6PQbiYXGk8m/2AQmUIi/RnYS3fqccwXsHH9uVo4Zs7Na7UAO1hoUokwxTHrIxLJGV5WuuEm59U/R3IgQV30LwMJA+Qwyo1/x0uXJ8n1UmCWenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bU/a2cQU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o2MrjFvCOw1b7pTxYA5/NEaOWmpus9U7QuVGDdVa0nE=; b=bU/a2cQUIWp4jFJhM2Z3n0C5WV
	uet9BddEoodtQ+GVvml+UvDt7YB2LuSm3+WYt9gHC8BESWulwJ7CDhKsY/dV4p92LzgphJLZfyjNc
	M6PLDkarQ6PzpuRhmreeo64qoAiZHsMFOJekaW5ywN6mOqys4dkJS59ly2KB0nZSf5oUmGYJQpJFf
	sQUGtj4Du98gprRQDrhgC1LkpUUGVwV7j/IbdbxCPsez4hgIybJUOpJLq1VeQdo6lRfl5XjAcbplW
	VYj5zQR5GMuZU1AOJhl9BQpqM69MY9d8ZSjlk2b0RNARabo1r7uDnH1z6zZyaWnGuklMnM+ffmIa3
	WrzoOnNw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56564 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVDmt-0003Ub-31;
	Wed, 31 Jan 2024 16:50:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVDmp-0027Yn-5x; Wed, 31 Jan 2024 16:50:07 +0000
In-Reply-To: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
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
Subject: [PATCH RFC v4 06/15] ACPI: convert acpi_processor_post_eject() to use
 IS_ENABLED()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVDmp-0027Yn-5x@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 31 Jan 2024 16:50:07 +0000

Rather than ifdef'ing acpi_processor_post_eject() and its use site, use
IS_ENABLED() to increase compile coverage.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/acpi/acpi_processor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 00809c3b09f7..5351095b6968 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -457,12 +457,14 @@ static int acpi_processor_add(struct acpi_device *device,
 	return result;
 }
 
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Removal */
 static void acpi_processor_post_eject(struct acpi_device *device)
 {
 	struct acpi_processor *pr;
 
+	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_CPU))
+		return;
+
 	if (!device || !acpi_driver_data(device))
 		return;
 
@@ -501,7 +503,6 @@ static void acpi_processor_post_eject(struct acpi_device *device)
 	free_cpumask_var(pr->throttling.shared_cpu_map);
 	kfree(pr);
 }
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
 bool __init processor_physically_present(acpi_handle handle)
@@ -626,9 +627,7 @@ static const struct acpi_device_id processor_device_ids[] = {
 static struct acpi_scan_handler processor_handler = {
 	.ids = processor_device_ids,
 	.attach = acpi_processor_add,
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
 	.post_eject = acpi_processor_post_eject,
-#endif
 	.hotplug = {
 		.enabled = true,
 	},
-- 
2.30.2


