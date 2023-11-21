Return-Path: <linux-arch+bounces-317-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7BD7F2F01
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 14:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8523B21713
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 13:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F12524CD;
	Tue, 21 Nov 2023 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="unb6CQu8"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3051BE8;
	Tue, 21 Nov 2023 05:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MhhE4Ut9mqeHhKVj+/PHQ3JCmojZ6M726/mjHJlz/w8=; b=unb6CQu8/SVIdkTDD0Bb5tw/M6
	U9/JXAYBfcu+nGmLJBQHSx1UV1S2/QPaGueE4yek069NzdBsBB+I7/4ojYiNwjGA3h6Bg1XXsmZpN
	3CSKIqMu997bXRRnuIwkaE8FD3xVWi3G12tr2CgGDps6zOXIoxhEyVAgWZ4YoUH0OJFxQZMLWK8dw
	Sh/sfXO4biONXAp/RC1d8c/MjfMAU5PndN/rBx5ETg7LCum7tsd6675hO1wpWIgOPlvZgUG/o6QUG
	eO0YsUZBYqKFqbzrftNN8UGAMTbnjfoUslVE5G0U+wH8GlDRMXlITXcwhRzULbXJoZK5hQ1AGp9j5
	6XMqG1Rw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52666 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r5R3p-0007AJ-0J;
	Tue, 21 Nov 2023 13:45:05 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r5R3r-00Cszs-2R; Tue, 21 Nov 2023 13:45:07 +0000
In-Reply-To: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
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
	 linux-csky@vger.kernel.org,
	 linux-doc@vger.kernel.org,
	 linux-ia64@vger.kernel.org,
	 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	 Jean-Philippe Brucker <jean-philippe@linaro.org>,
	 jianyong.wu@arm.com,
	 justin.he@arm.com,
	 James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 15/21] x86/topology: use weak version of arch_unregister_cpu()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5R3r-00Cszs-2R@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 21 Nov 2023 13:45:07 +0000

Since the x86 version of arch_unregister_cpu() is the same as the weak
version, drop the x86 specific version.

Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v3:
 * Adapt to removal of EXPORT_SYMBOL()s
---
 arch/x86/kernel/topology.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index c2ed3145a93b..211863cb5b81 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -43,9 +43,4 @@ int arch_register_cpu(int cpu)
 	c->hotpluggable = cpu > 0;
 	return register_cpu(c, cpu);
 }
-
-void arch_unregister_cpu(int num)
-{
-	unregister_cpu(&per_cpu(cpu_devices, num));
-}
 #endif /* CONFIG_HOTPLUG_CPU */
-- 
2.30.2


