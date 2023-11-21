Return-Path: <linux-arch+bounces-313-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905B27F2EE7
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 14:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10CA1C2187F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 13:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28721537E2;
	Tue, 21 Nov 2023 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uR0WCwzc"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45641719;
	Tue, 21 Nov 2023 05:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OkDhpe8Fjqhy+RwbS5GO6YsrbQf6HnPLrJyOGiqcGrs=; b=uR0WCwzcX0Tghl5H8yimLbqsQM
	yEr4C9gly46wqpaUIHGVKbiccXUi2NW8qB5k6JnTqH/O9Rsi0Yl1odaX14EER7zTlt7WxWUTkX9lY
	LbS1YdCd4s8DozBLUITh/wK6QEtwSF+iis8PrEC/edX9bdlUaXzmwOxwqrc91BOEgT21goKImrNFh
	PNPnR+SX+0QWSViOV2aVj1z6nyA8guj+7rda0ZRznfMOhsmpQi08zlAGz6oLgFQDvaKW0wy2ng0/l
	KVZb37PuuFrS5G+iPFgYd+J+djBIW5utxZpbotE0ysEaD4MWMv5+FH0NVVw0L8BmoKYhWQxXTegIi
	SeObvE8w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50550 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r5R3U-00078z-1k;
	Tue, 21 Nov 2023 13:44:44 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r5R3W-00CszU-GM; Tue, 21 Nov 2023 13:44:46 +0000
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
Subject: [PATCH 11/21] drivers: base: Print a warning instead of panic() when
 register_cpu() fails
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5R3W-00CszU-GM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 21 Nov 2023 13:44:46 +0000

From: James Morse <james.morse@arm.com>

loongarch, mips, parisc, riscv and sh all print a warning if
register_cpu() returns an error. Architectures that use
GENERIC_CPU_DEVICES call panic() instead.

Errors in this path indicate something is wrong with the firmware
description of the platform, but the kernel is able to keep running.

Downgrade this to a warning to make it easier to debug this issue.

This will allow architectures that switching over to GENERIC_CPU_DEVICES
to drop their warning, but keep the existing behaviour.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/base/cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 221ffbeb1c9b..82b6a76125f5 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -551,14 +551,15 @@ void __weak arch_unregister_cpu(int num)
 
 static void __init cpu_dev_register_generic(void)
 {
-	int i;
+	int i, ret;
 
 	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
 		return;
 
 	for_each_present_cpu(i) {
-		if (arch_register_cpu(i))
-			panic("Failed to register CPU device");
+		ret = arch_register_cpu(i);
+		if (ret)
+			pr_warn("register_cpu %d failed (%d)\n", i, ret);
 	}
 }
 
-- 
2.30.2


