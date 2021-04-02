Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545E83527D9
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 11:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhDBJGG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 05:06:06 -0400
Received: from marcansoft.com ([212.63.210.85]:34098 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234536AbhDBJGG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 05:06:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C3D8342725;
        Fri,  2 Apr 2021 09:05:57 +0000 (UTC)
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
Subject: [PATCH v4 01/18] dt-bindings: vendor-prefixes: Add apple prefix
Date:   Fri,  2 Apr 2021 18:05:25 +0900
Message-Id: <20210402090542.131194-2-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210402090542.131194-1-marcan@marcan.st>
References: <20210402090542.131194-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is different from the legacy AAPL prefix used on PPC, but
consensus is that we prefer `apple` for these new platforms.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f6064d84a424..7b59b6d3f526 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -103,6 +103,8 @@ patternProperties:
     description: Anvo-Systems Dresden GmbH
   "^apm,.*":
     description: Applied Micro Circuits Corporation (APM)
+  "^apple,.*":
+    description: Apple Inc.
   "^aptina,.*":
     description: Aptina Imaging
   "^arasan,.*":
-- 
2.30.0

