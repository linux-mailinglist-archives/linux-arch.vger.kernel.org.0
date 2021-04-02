Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B589335281E
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 11:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhDBJH4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 05:07:56 -0400
Received: from marcansoft.com ([212.63.210.85]:35002 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234849AbhDBJHt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 05:07:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 975BB4272F;
        Fri,  2 Apr 2021 09:07:38 +0000 (UTC)
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
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/18] arm64: Kconfig: Introduce CONFIG_ARCH_APPLE
Date:   Fri,  2 Apr 2021 18:05:40 +0900
Message-Id: <20210402090542.131194-17-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210402090542.131194-1-marcan@marcan.st>
References: <20210402090542.131194-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This adds a Kconfig option to toggle support for Apple ARM SoCs.
At this time this targets the M1 and later "Apple Silicon" Mac SoCs.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/Kconfig.platforms | 7 +++++++
 arch/arm64/configs/defconfig | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index cdfd5fed457f..df320a13915a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -36,6 +36,13 @@ config ARCH_ALPINE
 	  This enables support for the Annapurna Labs Alpine
 	  Soc family.
 
+config ARCH_APPLE
+	bool "Apple Silicon SoC family"
+	select APPLE_AIC
+	help
+	  This enables support for Apple's in-house ARM SoC family, starting
+	  with the Apple M1.
+
 config ARCH_BCM2835
 	bool "Broadcom BCM2835 family"
 	select TIMER_OF
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d612f633b771..54fb257e55f7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -31,6 +31,7 @@ CONFIG_ARCH_ACTIONS=y
 CONFIG_ARCH_AGILEX=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_ALPINE=y
+CONFIG_ARCH_APPLE=y
 CONFIG_ARCH_BCM2835=y
 CONFIG_ARCH_BCM4908=y
 CONFIG_ARCH_BCM_IPROC=y
-- 
2.30.0

