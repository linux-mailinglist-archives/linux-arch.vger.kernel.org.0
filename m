Return-Path: <linux-arch+bounces-996-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E45B811201
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 13:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B071A1C20A70
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 12:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE392C19B;
	Wed, 13 Dec 2023 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vjgZ5o4F"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40A819A4;
	Wed, 13 Dec 2023 04:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lmtH59uo0RH6OWln4SWiUMu9ATT5+EWsaWDCzIDILMw=; b=vjgZ5o4FgP2eXJBezIZp2zJ0xr
	t6xOqiS/tNc9Agtr4/gEtULHWFMdo+cMAqDbsj713CNHaHJh2E0IqnABMfHkAOf9zrsn8DfVcJDcA
	WkPWWZdNLaXZYBdXwmXvxAT4XOzI7++DthIonECZ/hHPO8CCBoK7myVrtmg7BcHy9HoM5Z1D8HRRy
	EeIGP/Kl3ObL1mjz6SIe0wNRspxRzY3s7YWxE88eF3Uk+9CSW1a2I7yhLMFjyPBF6Unn/nd9LnM7z
	EhdbIpoz0zO5WdAFp06vz+2/m5mcxpTMeF2HPrsXAVjTO1hJ+KQySmSlpsrEjacXbVpeeo8+7e5uu
	ck4N+yzw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51452 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rDOhF-0008HS-2A;
	Wed, 13 Dec 2023 12:50:41 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rDOhH-00DvlO-UP; Wed, 13 Dec 2023 12:50:43 +0000
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
Subject: [PATCH RFC v3 18/21] ACPI: processor: Only call arch_unregister_cpu()
 if HOTPLUG_CPU is selected
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rDOhH-00DvlO-UP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 13 Dec 2023 12:50:43 +0000

From: James Morse <james.morse@arm.com>

The kbuild robot points out that configurations without HOTPLUG_CPU
selected can try to build acpi_processor_post_eject() without success
as arch_unregister_cpu() is not defined.

Check this explicitly. This will be merged into:
| ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
for any subsequent posting.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
---
This should probably be squashed into an earlier patch.
---
 drivers/acpi/acpi_processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 5dabb426481f..ea12e70dfd39 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -537,7 +537,7 @@ static void acpi_processor_post_eject(struct acpi_device *device)
 	unsigned long long sta;
 	acpi_status status;
 
-	if (!device)
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) || !device)
 		return;
 
 	pr = acpi_driver_data(device);
-- 
2.30.2


