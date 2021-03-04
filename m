Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4058832DC8F
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 22:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbhCDVry (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Mar 2021 16:47:54 -0500
Received: from marcansoft.com ([212.63.210.85]:36204 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231640AbhCDVri (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Mar 2021 16:47:38 -0500
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Mar 2021 16:47:38 EST
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id CE7DE425B1;
        Thu,  4 Mar 2021 21:40:02 +0000 (UTC)
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
Subject: [RFT PATCH v3 06/27] dt-bindings: timer: arm,arch_timer: Add interrupt-names support
Date:   Fri,  5 Mar 2021 06:38:41 +0900
Message-Id: <20210304213902.83903-7-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Not all platforms provide the same set of timers/interrupts, and Linux
only needs one (plus kvm/guest ones); some platforms are working around
this by using dummy fake interrupts. Implementing interrupt-names allows
the devicetree to specify an arbitrary set of available interrupts, so
the timer code can pick the right one.

This also adds the hyp-virt timer/interrupt, which was previously not
expressed in the fixed 4-interrupt form.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../devicetree/bindings/timer/arm,arch_timer.yaml  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
index 2c75105c1398..ebe9b0bebe41 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
@@ -34,11 +34,25 @@ properties:
               - arm,armv8-timer
 
   interrupts:
+    minItems: 1
+    maxItems: 5
     items:
       - description: secure timer irq
       - description: non-secure timer irq
       - description: virtual timer irq
       - description: hypervisor timer irq
+      - description: hypervisor virtual timer irq
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 5
+    items:
+      enum:
+        - phys-secure
+        - phys
+        - virt
+        - hyp-phys
+        - hyp-virt
 
   clock-frequency:
     description: The frequency of the main counter, in Hz. Should be present
-- 
2.30.0

