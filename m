Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3B714C6D
	for <lists+linux-arch@lfdr.de>; Mon, 29 May 2023 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjE2Otr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 May 2023 10:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjE2Otp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2023 10:49:45 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60184E5;
        Mon, 29 May 2023 07:49:41 -0700 (PDT)
Received: from tp8.. (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DC85E5CC;
        Mon, 29 May 2023 14:49:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DC85E5CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1685371780; bh=qNswSaB1rsYK39qc93wLacaWCqvSv3BALS+O8tlq2Iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZO4v+5KcvByaNdUK7MWOpCXLrPFFf2KtlOumFM8uDXxuDbvQ4FJbKeuAcHsrod2rS
         lS8yzaVHlMiRHiGIfoYrY7JC+Fbietmb0KFcqnfe6KWtzXwUgxbo1QAd4c8JTkwnpO
         ZIDSfl++VeCIyWgFbe74fPfcgZ2XQpMLFu2c+ZI+zEdeKpBPA1au2+rF6Ev1p1h8SV
         lymNucxBNM5B1WRDWKFYKDBOIRyY9ENCOWJ6tNPZYStKpH5JpbXfDrC4C1g4aa6uCj
         BGJLGi0CAd+RvrVtV3AX9EkF11j4LO9SM4SN4drTnQkpeOGtOWmHGv19Jf71huM/YX
         qm9vVjDB43QDQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 7/7] dt-bindings: Update Documentation/arm references
Date:   Mon, 29 May 2023 08:48:56 -0600
Message-Id: <20230529144856.102755-8-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230529144856.102755-1-corbet@lwn.net>
References: <20230529144856.102755-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Arm documentation has moved to Documentation/arch/arm; update one
devicetree reference to match.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/devicetree/bindings/arm/xen.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
index 61d77acbeb5e..f925290d4641 100644
--- a/Documentation/devicetree/bindings/arm/xen.txt
+++ b/Documentation/devicetree/bindings/arm/xen.txt
@@ -56,7 +56,7 @@ hypervisor {
 };
 
 The format and meaning of the "xen,uefi-*" parameters are similar to those in
-Documentation/arm/uefi.rst, which are provided by the regular UEFI stub. However
+Documentation/arch/arm/uefi.rst, which are provided by the regular UEFI stub. However
 they differ because they are provided by the Xen hypervisor, together with a set
 of UEFI runtime services implemented via hypercalls, see
 http://xenbits.xen.org/docs/unstable/hypercall/x86_64/include,public,platform.h.html.
-- 
2.40.1

