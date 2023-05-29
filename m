Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB517714C61
	for <lists+linux-arch@lfdr.de>; Mon, 29 May 2023 16:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjE2Otd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 May 2023 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjE2Ota (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2023 10:49:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE86C4;
        Mon, 29 May 2023 07:49:28 -0700 (PDT)
Received: from tp8.. (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 951A77C0;
        Mon, 29 May 2023 14:49:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 951A77C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1685371768; bh=bqzP5WOjrrEXff4pgIHH/5/YP8K5mqt51+qWN4MM6yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SA1qlB8kwt16rhKUHRpaJy49mqm/KMEhSd2zJN6TpVWS4ozuB89qGaQSuf0veBama
         RxY0igfmoOfIND64VShIlShwTWX58w1azVtDGTCU7TBQom+mgGYITOtk5+eZ7Hv69W
         xSnXYJNac5/l3HbNCLmGPuiOZN07szL6mL5N0cTJw8QWOsiVlvrmIMJgqSaiUqk21x
         N1CJ0zkoPohgyQh3AJfRVE8oNNic9P09BhWlPB4pZrk8ayI7bCTgyuGLOhU5VWjZX1
         G90Cnf8vFcDijCrWaBe5yoAsNQv/1oVwDk1cE67Vq+3aHZXX2Cr65oHg27k0aQ06l7
         QUDqbWYNeLI5Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 3/7] arm64: Update Documentation/arm references
Date:   Mon, 29 May 2023 08:48:52 -0600
Message-Id: <20230529144856.102755-4-corbet@lwn.net>
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

The Arm documentation has moved to Documentation/arch/arm; update
references under arch/arm64 to match.

Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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

