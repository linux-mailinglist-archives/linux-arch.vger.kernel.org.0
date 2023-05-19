Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224A4709CB0
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 18:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjESQqZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 12:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjESQqX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 12:46:23 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA7FD;
        Fri, 19 May 2023 09:46:20 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 748AE199D;
        Fri, 19 May 2023 16:46:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 748AE199D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684514780; bh=yC21aSJ9Ksz4u7SK0ZsLWlkzX/cIS/360Ea9jar6d3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gsXqpnjmlXUntcNuwafml/Q5P2x7g1L+jUcZ0L5WcBfl3LYT9uGKPAlR6s0N0mwGS
         /Ha4tiSwvuQkmhSQDLOtk+jB7EHxFS3LRO0qQ26nleT7R/yfyKrxt/e+bxGpqXuYJ+
         Vz+Weq3haOJ3iIpifC3PRikcJ8j0hFGkehpI9WtYNynmZC2m4HpTY2ddkGhsaebvPD
         dR//DICCkwH28k0vRnSwOAB+TZVmsOPvNiXOC9aSztyz02d5YRjtWDKyKNAqHqA6o+
         TsbE8IuMdB9O+ahKXD0z8E00WiQwekE6p4qlh4MPnbMIq9/l5sofQ2gAQbFAJB9K+t
         TgvbHxyZU+tUg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 3/7] arm64: Update Documentation/arm references
Date:   Fri, 19 May 2023 10:46:03 -0600
Message-Id: <20230519164607.38845-4-corbet@lwn.net>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 arch/arm64/Kconfig          | 2 +-
 arch/arm64/kernel/kuser32.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1201d25a8a4..377f50dda2de 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1619,7 +1619,7 @@ config KUSER_HELPERS
 	  the system. This permits binaries to be run on ARMv4 through
 	  to ARMv8 without modification.
 
-	  See Documentation/arm/kernel_user_helpers.rst for details.
+	  See Documentation/arch/arm/kernel_user_helpers.rst for details.
 
 	  However, the fixed address nature of these helpers can be used
 	  by ROP (return orientated programming) authors when creating
diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
index 692e9d2e31e5..af046ceac22d 100644
--- a/arch/arm64/kernel/kuser32.S
+++ b/arch/arm64/kernel/kuser32.S
@@ -10,7 +10,7 @@
  * aarch32_setup_additional_pages() and are provided for compatibility
  * reasons with 32 bit (aarch32) applications that need them.
  *
- * See Documentation/arm/kernel_user_helpers.rst for formal definitions.
+ * See Documentation/arch/arm/kernel_user_helpers.rst for formal definitions.
  */
 
 #include <asm/unistd.h>
-- 
2.40.1

