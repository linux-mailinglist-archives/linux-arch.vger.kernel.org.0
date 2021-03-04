Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F117732DC11
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 22:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbhCDVl7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Mar 2021 16:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbhCDVlm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2021 16:41:42 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE288C061574;
        Thu,  4 Mar 2021 13:41:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id EA1C0425B5;
        Thu,  4 Mar 2021 21:40:09 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v3 07/27] arm64: arch_timer: implement support for interrupt-names
Date:   Fri,  5 Mar 2021 06:38:42 +0900
Message-Id: <20210304213902.83903-8-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This allows the devicetree to correctly represent the available set of
timers, which varies from device to device, without the need for fake
dummy interrupts for unavailable slots.

Also add the hyp-virt timer/PPI, which is not currently used, but worth
representing.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/arm_arch_timer.c | 24 +++++++++++++++++++++---
 include/clocksource/arm_arch_timer.h |  1 +
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d0177824c518..ee2501a17697 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -63,6 +63,14 @@ struct arch_timer {
 static u32 arch_timer_rate;
 static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI];
 
+static const char *arch_timer_ppi_names[ARCH_TIMER_MAX_TIMER_PPI] = {
+	[ARCH_TIMER_PHYS_SECURE_PPI]	= "phys-secure",
+	[ARCH_TIMER_PHYS_NONSECURE_PPI]	= "phys",
+	[ARCH_TIMER_VIRT_PPI]		= "virt",
+	[ARCH_TIMER_HYP_PPI]		= "hyp-phys",
+	[ARCH_TIMER_HYP_VIRT_PPI]	= "hyp-virt",
+};
+
 static struct clock_event_device __percpu *arch_timer_evt;
 
 static enum arch_timer_ppi_nr arch_timer_uses_ppi = ARCH_TIMER_VIRT_PPI;
@@ -1280,8 +1288,9 @@ static void __init arch_timer_populate_kvm_info(void)
 
 static int __init arch_timer_of_init(struct device_node *np)
 {
-	int i, ret;
+	int i, irq, ret;
 	u32 rate;
+	bool has_names;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
 		pr_warn("multiple nodes in dt, skipping\n");
@@ -1289,8 +1298,17 @@ static int __init arch_timer_of_init(struct device_node *np)
 	}
 
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
-	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
-		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
+
+	has_names = of_property_read_bool(np, "interrupt-names");
+
+	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++) {
+		if (has_names)
+			irq = of_irq_get_byname(np, arch_timer_ppi_names[i]);
+		else
+			irq = of_irq_get(np, i);
+		if (irq > 0)
+			arch_timer_ppi[i] = irq;
+	}
 
 	arch_timer_populate_kvm_info();
 
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 1d68d5613dae..73c7139c866f 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -32,6 +32,7 @@ enum arch_timer_ppi_nr {
 	ARCH_TIMER_PHYS_NONSECURE_PPI,
 	ARCH_TIMER_VIRT_PPI,
 	ARCH_TIMER_HYP_PPI,
+	ARCH_TIMER_HYP_VIRT_PPI,
 	ARCH_TIMER_MAX_TIMER_PPI
 };
 
-- 
2.30.0

