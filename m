Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C057172DE2B
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 11:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbjFMJrN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 05:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbjFMJrB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 05:47:01 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1387010F9;
        Tue, 13 Jun 2023 02:46:40 -0700 (PDT)
Received: from tp8.. (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1FD9A6A2;
        Tue, 13 Jun 2023 09:46:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1FD9A6A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1686649592; bh=SIo3Mnk6Ywbt2c5vULeGDpc0VLDRElbeGEbpt5REm0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYSICFIDkLND6EiVNDVOqwDb0Ai5y17oxI8ZflQBZdQ7r15NwpBGXY2l0KLRPsiIF
         /FBCbEZYkD9GJTWlV8XrqufGS8LS0IH75DQ5zmHRv9/2ET3Ak1AqQBpy22sxDT19m+
         NlpXLApGJNpN7U0MpQ6/xNpWDyECTx9SrLFFuNhY7tREQAigINbXA8ixpMjuguYfVB
         fxWZzAJMKVJCZ5v2ZbK3SfH+1+8g0XtxJi0BCojf3bM+/9HlQHfnghsyV/2BSKDAIr
         spPzBGPVjTut9fVPa6/dIdjX6e4EWhkq/3dV7slwft/kz/MR3mhXx0KlV9plCTF0pf
         K3tct3DON0nLw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH 3/5] arm64: Fix dangling references to Documentation/arm64
Date:   Tue, 13 Jun 2023 03:46:04 -0600
Message-Id: <20230613094606.334687-4-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613094606.334687-1-corbet@lwn.net>
References: <20230613094606.334687-1-corbet@lwn.net>
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

The arm64 documentation has moved under Documentation/arch/; fix up
references in the arm64 subtree to match.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 arch/arm64/Kconfig                       | 4 ++--
 arch/arm64/include/asm/efi.h             | 2 +-
 arch/arm64/include/asm/image.h           | 2 +-
 arch/arm64/include/uapi/asm/sigcontext.h | 2 +-
 arch/arm64/kernel/kexec_image.c          | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 343e1e1cae10..1746ac824b91 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1585,7 +1585,7 @@ config ARM64_TAGGED_ADDR_ABI
 	  When this option is enabled, user applications can opt in to a
 	  relaxed ABI via prctl() allowing tagged addresses to be passed
 	  to system calls as pointer arguments. For details, see
-	  Documentation/arm64/tagged-address-abi.rst.
+	  Documentation/arch/arm64/tagged-address-abi.rst.
 
 menuconfig COMPAT
 	bool "Kernel support for 32-bit EL0"
@@ -2047,7 +2047,7 @@ config ARM64_MTE
 	  explicitly opt in. The mechanism for the userspace is
 	  described in:
 
-	  Documentation/arm64/memory-tagging-extension.rst.
+	  Documentation/arch/arm64/memory-tagging-extension.rst.
 
 endmenu # "ARMv8.5 architectural features"
 
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index f86b157a5da3..ca3f72476c29 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -88,7 +88,7 @@ efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
  * guaranteed to cover the kernel Image.
  *
  * Since the EFI stub is part of the kernel Image, we can relax the
- * usual requirements in Documentation/arm64/booting.rst, which still
+ * usual requirements in Documentation/arch/arm64/booting.rst, which still
  * apply to other bootloaders, and are required for some kernel
  * configurations.
  */
diff --git a/arch/arm64/include/asm/image.h b/arch/arm64/include/asm/image.h
index c2b13213c720..c09cf942dc92 100644
--- a/arch/arm64/include/asm/image.h
+++ b/arch/arm64/include/asm/image.h
@@ -27,7 +27,7 @@
 
 /*
  * struct arm64_image_header - arm64 kernel image header
- * See Documentation/arm64/booting.rst for details
+ * See Documentation/arch/arm64/booting.rst for details
  *
  * @code0:		Executable code, or
  *   @mz_header		  alternatively used for part of MZ header
diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 656a10ea6c67..f23c1dc3f002 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -177,7 +177,7 @@ struct zt_context {
  * vector length beyond its initial architectural limit of 2048 bits
  * (16 quadwords).
  *
- * See linux/Documentation/arm64/sve.rst for a description of the VL/VQ
+ * See linux/Documentation/arch/arm64/sve.rst for a description of the VL/VQ
  * terminology.
  */
 #define SVE_VQ_BYTES		__SVE_VQ_BYTES	/* bytes per quadword */
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 5ed6a585f21f..636be6715155 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -48,7 +48,7 @@ static void *image_load(struct kimage *image,
 
 	/*
 	 * We require a kernel with an unambiguous Image header. Per
-	 * Documentation/arm64/booting.rst, this is the case when image_size
+	 * Documentation/arch/arm64/booting.rst, this is the case when image_size
 	 * is non-zero (practically speaking, since v3.17).
 	 */
 	h = (struct arm64_image_header *)kernel;
-- 
2.40.1

