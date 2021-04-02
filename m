Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4043352810
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 11:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhDBJHn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 05:07:43 -0400
Received: from marcansoft.com ([212.63.210.85]:34878 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234928AbhDBJHf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 05:07:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1553942713;
        Fri,  2 Apr 2021 09:07:24 +0000 (UTC)
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
Subject: [PATCH v4 14/18] dt-bindings: interrupt-controller: Add DT bindings for apple-aic
Date:   Fri,  2 Apr 2021 18:05:38 +0900
Message-Id: <20210402090542.131194-15-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210402090542.131194-1-marcan@marcan.st>
References: <20210402090542.131194-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

AIC is the Apple Interrupt Controller found on Apple ARM SoCs, such as
the M1.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
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
index bee9a57e6cec..b26a7e23c512 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1646,6 +1646,7 @@ B:	https://github.com/AsahiLinux/linux/issues
 C:	irc://chat.freenode.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
diff --git a/include/dt-bindings/interrupt-controller/apple-aic.h b/include/dt-bindings/interrupt-controller/apple-aic.h
new file mode 100644
index 000000000000..604f2bb30ac0
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/apple-aic.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
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

