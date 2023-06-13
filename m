Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA9472DE23
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbjFMJrE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 05:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbjFMJqz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 05:46:55 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3BB1BE9;
        Tue, 13 Jun 2023 02:46:32 -0700 (PDT)
Received: from tp8.. (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 95F6F77D;
        Tue, 13 Jun 2023 09:46:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 95F6F77D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1686649589; bh=3D+PguzS4TXh42c031J2y3Uw3/ednR923UHurOmvS98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZK1PnYZqJpWnDb1BSqQeus2JOzvGlw0lv0mFoOldcSwZ2HlRxG2iVmKzOv7B8rJO
         Frfx5gDenDIsj4z499uG9oZBqNKntl9huHJpAG5UE3jY32YW25adiDJ3Utx77Tudp7
         KG9jSVWctMFERne2ze86WUfNPep0OwOdbpsNJwact6FCyweg+d98yyuLLD5csR4q5m
         GOpcDJOLU8W3sdmjcsuO9XaGsYhxTp7qanblBFINo55O3VxTybgFVtqKZBnOv+7Zgs
         86GnXk8mLmPNZlqlePoUQasPnbTwc7RoCEHDLqjjYIyH4OOWF9ypifi0jcjKMFcgCQ
         Ik+GvOcEj35dg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: fix dangling Documentation/arm64 reference
Date:   Tue, 13 Jun 2023 03:46:03 -0600
Message-Id: <20230613094606.334687-3-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613094606.334687-1-corbet@lwn.net>
References: <20230613094606.334687-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The arm64 documentation has move under Documentation/arch/ fix a reference
to match.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/devicetree/bindings/cpu/idle-states.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpu/idle-states.yaml b/Documentation/devicetree/bindings/cpu/idle-states.yaml
index b8cc826c9501..b3a5356f9916 100644
--- a/Documentation/devicetree/bindings/cpu/idle-states.yaml
+++ b/Documentation/devicetree/bindings/cpu/idle-states.yaml
@@ -259,7 +259,7 @@ description: |+
       http://infocenter.arm.com/help/index.jsp
 
   [5] ARM Linux Kernel documentation - Booting AArch64 Linux
-      Documentation/arm64/booting.rst
+      Documentation/arch/arm64/booting.rst
 
   [6] RISC-V Linux Kernel documentation - CPUs bindings
       Documentation/devicetree/bindings/riscv/cpus.yaml
-- 
2.40.1

