Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F753709CBC
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 18:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjESQq3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 12:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjESQqZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 12:46:25 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6115DDC;
        Fri, 19 May 2023 09:46:24 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 30B901D45;
        Fri, 19 May 2023 16:46:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 30B901D45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684514783; bh=+oNarqgzE8R9UGH9zl+wdRnodH87HuPqTGakGRBmcWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvpTp8Enf6X11ZfvlNzzK03rQn1koW8H7F77AaYmANoHwi2cJTflwtVL7v9H8vpdk
         FgoW5xGsS7/MTJtV33lsDsazxPTJW68qsLQoubl+Kk9lWxHCiRsvJ+Ub6dXe3KIxb0
         e13ar6zLYLycO2FccnR2bEegf4Jeo4UxrwxaeUFG+v0f0naqLGB1ExAZ7tdFoTnT/U
         NKgt2kkTKK1nV1UaEJfbI+LFqK3jd1niCG622jd9lk9lxjBNreWfNCwJYwysQ9RgfF
         0xBu/licF+bTWHIonoNEL1P46GhGg/Ab/7frnX7rvP+hX2SOX40h4MiINX74HjitSE
         RXyd0HMmDL9lA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 7/7] dt-bindings: Update Documentation/arm references
Date:   Fri, 19 May 2023 10:46:07 -0600
Message-Id: <20230519164607.38845-8-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519164607.38845-1-corbet@lwn.net>
References: <20230519164607.38845-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Arm documentation has moved to Documentation/arch/arm; update
references under arch/arm64 to match.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
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

