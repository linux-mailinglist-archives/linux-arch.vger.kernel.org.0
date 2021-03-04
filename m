Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0256732DBF3
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 22:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbhCDVl0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Mar 2021 16:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240135AbhCDVlM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2021 16:41:12 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Mar 2021 13:40:31 PST
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD230C061760;
        Thu,  4 Mar 2021 13:40:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6C000424BA;
        Thu,  4 Mar 2021 21:39:41 +0000 (UTC)
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
Subject: [RFT PATCH v3 03/27] dt-bindings: arm: apple: Add bindings for Apple ARM platforms
Date:   Fri,  5 Mar 2021 06:38:38 +0900
Message-Id: <20210304213902.83903-4-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This introduces bindings for all three 2020 Apple M1 devices:

* apple,j274 - Mac mini (M1, 2020)
* apple,j293 - MacBook Pro (13-inch, M1, 2020)
* apple,j313 - MacBook Air (M1, 2020)

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../devicetree/bindings/arm/apple.yaml        | 64 +++++++++++++++++++
 MAINTAINERS                                   | 10 +++
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/apple.yaml

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
new file mode 100644
index 000000000000..1e772c85206c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/apple.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple ARM Machine Device Tree Bindings
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+description: |
+  ARM platforms using SoCs designed by Apple Inc., branded "Apple Silicon".
+
+  This currently includes devices based on the "M1" SoC, starting with the
+  three Mac models released in late 2020:
+
+  - Mac mini (M1, 2020)
+  - MacBook Pro (13-inch, M1, 2020)
+  - MacBook Air (M1, 2020)
+
+  The compatible property should follow this format:
+
+  compatible = "apple,<targettype>", "apple,<socid>", "apple,arm-platform";
+
+  <targettype> represents the board/device and comes from the `target-type`
+  property of the root node of the Apple Device Tree, lowercased. It can be
+  queried on macOS using the following command:
+
+  $ ioreg -d2 -l | grep target-type
+
+  <socid> is the lowercased SoC ID. Apple uses at least *five* different
+  names for their SoCs:
+
+  - Marketing name ("M1")
+  - Internal name ("H13G")
+  - Codename ("Tonga")
+  - SoC ID ("T8103")
+  - Package/IC part number ("APL1102")
+
+  Devicetrees should use the lowercased SoC ID, to avoid confusion if
+  multiple SoCs share the same marketing name. This can be obtained from
+  the `compatible` property of the arm-io node of the Apple Device Tree,
+  which can be queried as follows on macOS:
+
+  $ ioreg -n arm-io | grep compatible
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+      - description: Apple M1 SoC based platforms
+        items:
+          - enum:
+              - apple,j274 # Mac mini (M1, 2020)
+              - apple,j293 # MacBook Pro (13-inch, M1, 2020)
+              - apple,j313 # MacBook Air (M1, 2020)
+          - const: apple,t8103
+          - const: apple,arm-platform
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..aec14fbd61b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1637,6 +1637,16 @@ F:	arch/arm/mach-alpine/
 F:	arch/arm64/boot/dts/amazon/
 F:	drivers/*/*alpine*
 
+ARM/APPLE MACHINE SUPPORT
+M:	Hector Martin <marcan@marcan.st>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+W:	https://asahilinux.org
+B:	https://github.com/AsahiLinux/linux/issues
+C:	irc://chat.freenode.net/asahi-dev
+T:	git https://github.com/AsahiLinux/linux.git
+F:	Documentation/devicetree/bindings/arm/apple.yaml
+
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>
-- 
2.30.0

