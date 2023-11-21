Return-Path: <linux-arch+bounces-312-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58CF7F2EE3
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 14:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4691C218BD
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 13:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FBC524CA;
	Tue, 21 Nov 2023 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aK8Z+bb3"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BA4D7F;
	Tue, 21 Nov 2023 05:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NBEBqsxRM69zEZyAIr1RVA2X5y0uA8ns6dIxJb5hWFo=; b=aK8Z+bb3TgcPd5wkyjOnWMdsUr
	CR/23xnuLXKcjxCRbrdd3D+ewu78B0gPfphwNcz1QIjrxiuoV0Ato8p1rSqUHB0MPsaEpBMouQIqn
	xly3fPxymctQzSay2+f3oSgBodJsMNPMuryRSWF1zC3cDYTy62Mf76oQiEpNO+9TQY8igbZTcGDhT
	gR6VtecfEH6lEtdyDkvGiPbIaEhtwWcpWrRCzCythPNCZEbbKOQ1f/q0IT1yfpQBJxGagkSAlpWJw
	5TDxfPuFa+CKCDW2mbEddGk68g3+cZdPuhz9g3Kprk+hRGMOxntNOrNR12GV5oMW+1v4tMF+ufpUc
	mvEc6SDQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44202 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r5R3K-00077s-1d;
	Tue, 21 Nov 2023 13:44:34 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r5R3H-00CszC-2n; Tue, 21 Nov 2023 13:44:31 +0000
In-Reply-To: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
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
	 linux-csky@vger.kernel.org,
	 linux-doc@vger.kernel.org,
	 linux-ia64@vger.kernel.org,
	 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	 Jean-Philippe Brucker <jean-philippe@linaro.org>,
	 jianyong.wu@arm.com,
	 justin.he@arm.com,
	 James Morse <james.morse@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 08/21] drivers: base: Implement weak arch_unregister_cpu()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5R3H-00CszC-2n@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 21 Nov 2023 13:44:31 +0000

From: James Morse <james.morse@arm.com>

Add arch_unregister_cpu() to allow the ACPI machinery to call
unregister_cpu(). This is enough for arm64, riscv and loongarch, but
needs to be overridden by x86 and ia64 who need to do more work.

CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
An open question remains from the RFC v2 posting: should we provide a
__weak stub for !HOTPLUG_CPU as well, since in later patches ACPI may
reference this if the compiler doesn't optimise as we expect?

Changes since v1:
 * Added CONFIG_HOTPLUG_CPU ifdeffery around unregister_cpu
Changes since RFC v2:
 * Move earlier in the series
---
 drivers/base/cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 579064fda97b..58bb86091b34 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -531,7 +531,14 @@ int __weak arch_register_cpu(int cpu)
 {
 	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
 }
-#endif
+
+#ifdef CONFIG_HOTPLUG_CPU
+void __weak arch_unregister_cpu(int num)
+{
+	unregister_cpu(&per_cpu(cpu_devices, num));
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+#endif /* CONFIG_GENERIC_CPU_DEVICES */
 
 static void __init cpu_dev_register_generic(void)
 {
-- 
2.30.2


