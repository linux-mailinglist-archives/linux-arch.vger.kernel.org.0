Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA3B32DC30
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 22:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbhCDVmb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Mar 2021 16:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240616AbhCDVmN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2021 16:42:13 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14E7C061764;
        Thu,  4 Mar 2021 13:41:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4B5C6426F5;
        Thu,  4 Mar 2021 21:41:07 +0000 (UTC)
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
Subject: [RFT PATCH v3 15/27] dt-bindings: interrupt-controller: Add DT bindings for apple-aic
Date:   Fri,  5 Mar 2021 06:38:50 +0900
Message-Id: <20210304213902.83903-16-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

AIC is the Apple Interrupt Controller found on Apple ARM SoCs, such as
the M1.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../interrupt-controller/apple,aic.yaml       | 88 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 .../interrupt-controller/apple-aic.h          | 15 ++++
 3 files changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 create mode 100644 include/dt-bindings/interrupt-controller/apple-aic.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
new file mode 100644
index 000000000000..cf6c091a07b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/apple,aic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Interrupt Controller
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+description: |
+  The Apple Interrupt Controller is a simple interrupt controller present on
+  Apple ARM SoC platforms, including various iPhone and iPad devices and the
+  "Apple Silicon" Macs.
+
+  It provides the following features:
+
+  - Level-triggered hardware IRQs wired to SoC blocks
+    - Single mask bit per IRQ
+    - Per-IRQ affinity setting
+    - Automatic masking on event delivery (auto-ack)
+    - Software triggering (ORed with hw line)
+  - 2 per-CPU IPIs (meant as "self" and "other", but they are interchangeable
+    if not symmetric)
+  - Automatic prioritization (single event/ack register per CPU, lower IRQs =
+    higher priority)
+  - Automatic masking on ack
+  - Default "this CPU" register view and explicit per-CPU views
+
+  This device also represents the FIQ interrupt sources on platforms using AIC,
+  which do not go through a discrete interrupt controller.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: apple,t8103-aic
+      - const: apple,aic
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 3
+    description: |
+      The 1st cell contains the interrupt type:
+        - 0: Hardware IRQ
+        - 1: FIQ
+
+      The 2nd cell contains the interrupt number.
+        - HW IRQs: interrupt number
+        - FIQs:
+          - 0: physical HV timer
+          - 1: virtual HV timer
+          - 2: physical guest timer
+          - 3: virtual guest timer
+
+      The 3rd cell contains the interrupt flags. This is normally
+      IRQ_TYPE_LEVEL_HIGH (4).
+
+  reg:
+    description: |
+      Specifies base physical address and size of the AIC registers.
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        aic: interrupt-controller@23b100000 {
+            compatible = "apple,t8103-aic", "apple,aic";
+            #interrupt-cells = <3>;
+            interrupt-controller;
+            reg = <0x2 0x3b100000 0x0 0x8000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a352c687d4b..744e086d28cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1646,6 +1646,7 @@ B:	https://github.com/AsahiLinux/linux/issues
 C:	irc://chat.freenode.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 F:	arch/arm64/include/asm/sysreg_apple.h
 
 ARM/ARTPEC MACHINE SUPPORT
diff --git a/include/dt-bindings/interrupt-controller/apple-aic.h b/include/dt-bindings/interrupt-controller/apple-aic.h
new file mode 100644
index 000000000000..9ac56a7e6d3f
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/apple-aic.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_APPLE_AIC_H
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_APPLE_AIC_H
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#define AIC_IRQ	0
+#define AIC_FIQ	1
+
+#define AIC_TMR_HV_PHYS		0
+#define AIC_TMR_HV_VIRT		1
+#define AIC_TMR_GUEST_PHYS	2
+#define AIC_TMR_GUEST_VIRT	3
+
+#endif
-- 
2.30.0

