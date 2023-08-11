Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B05F77914A
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 16:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjHKODq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 10:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjHKODo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 10:03:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075932D7F;
        Fri, 11 Aug 2023 07:03:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B6FC67362;
        Fri, 11 Aug 2023 14:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC40BC43397;
        Fri, 11 Aug 2023 14:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762623;
        bh=z8lCn6cz4GCn6Uq4H3sjrBefukkYhIMpxI1IVSZWGJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtkAWn1JseFw7rCDuZ09oj36A4qZezPTUkEYFMdyFm6L6ObW+GMDhEYwjfDmQQRbh
         dnL++isRsNuiVxHziHxysl6eqouottx9ipVIGDKUtMlK6pGr00WENW+bFIFYP7Wqw5
         fGxRu+SULyHOcH7xwKg+UXmcgBrp5CsxucrDtyWDzgMexLf4HhXLX0qif3hAWJFN3v
         ONq3tW9fXCAy4owKYNeAk5yak2ep8o1rLoa2IHoFbmoCDgmdAf6tHTwq4mGITR1N7i
         ilCodlg7TbC5ErdLXZSvVR0RAVkSaoXpta86cNUEaCcYfkTv/tZk+sdzqZDBFsYo3O
         qQAuufMyksFtg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 2/9] Kbuild: consolidate warning flags in scripts/Makefile.extrawarn
Date:   Fri, 11 Aug 2023 16:03:20 +0200
Message-Id: <20230811140327.3754597-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811140327.3754597-1-arnd@kernel.org>
References: <20230811140327.3754597-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Warning options are enabled and disabled in inconsistent ways and
inconsistent locations. Start rearranging those by moving all options
into Makefile.extrawarn.

This should not change any behavior, but makes sure we can group them
in a way that ensures that each warning that got temporarily disabled
is turned back on at an appropriate W=1 level later on.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Makefile                   | 88 -------------------------------------
 scripts/Makefile.extrawarn | 90 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 88 deletions(-)

diff --git a/Makefile b/Makefile
index 991c02f8e9ac0..781ff496f4aed 100644
--- a/Makefile
+++ b/Makefile
@@ -563,14 +563,6 @@ KBUILD_CFLAGS += -funsigned-char
 KBUILD_CFLAGS += -fno-common
 KBUILD_CFLAGS += -fno-PIE
 KBUILD_CFLAGS += -fno-strict-aliasing
-KBUILD_CFLAGS += -Wall
-KBUILD_CFLAGS += -Wundef
-KBUILD_CFLAGS += -Werror=implicit-function-declaration
-KBUILD_CFLAGS += -Werror=implicit-int
-KBUILD_CFLAGS += -Werror=return-type
-KBUILD_CFLAGS += -Werror=strict-prototypes
-KBUILD_CFLAGS += -Wno-format-security
-KBUILD_CFLAGS += -Wno-trigraphs
 
 KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_RUSTFLAGS := $(rust_common_flags) \
@@ -823,10 +815,6 @@ endif # may-sync-config
 endif # need-config
 
 KBUILD_CFLAGS	+= -fno-delete-null-pointer-checks
-KBUILD_CFLAGS	+= $(call cc-disable-warning,frame-address,)
-KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
-KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
-KBUILD_CFLAGS	+= $(call cc-disable-warning, address-of-packed-member)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
 KBUILD_CFLAGS += -O2
@@ -857,40 +845,15 @@ ifdef CONFIG_READABLE_ASM
 KBUILD_CFLAGS += -fno-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining
 endif
 
-ifneq ($(CONFIG_FRAME_WARN),0)
-KBUILD_CFLAGS += -Wframe-larger-than=$(CONFIG_FRAME_WARN)
-endif
-
 stackp-flags-y                                    := -fno-stack-protector
 stackp-flags-$(CONFIG_STACKPROTECTOR)             := -fstack-protector
 stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
 
 KBUILD_CFLAGS += $(stackp-flags-y)
 
-KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
-KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
-KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
-
 KBUILD_RUSTFLAGS-$(CONFIG_WERROR) += -Dwarnings
 KBUILD_RUSTFLAGS += $(KBUILD_RUSTFLAGS-y)
 
-ifdef CONFIG_CC_IS_CLANG
-# The kernel builds with '-std=gnu11' so use of GNU extensions is acceptable.
-KBUILD_CFLAGS += -Wno-gnu
-else
-
-# gcc inanely warns about local variables called 'main'
-KBUILD_CFLAGS += -Wno-main
-endif
-
-# These warnings generated too much noise in a regular build.
-# Use make W=1 to enable them (see scripts/Makefile.extrawarn)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
-
-# These result in bogus false positives
-KBUILD_CFLAGS += $(call cc-disable-warning, dangling-pointer)
-
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
 KBUILD_RUSTFLAGS += -Cforce-frame-pointers=y
@@ -1025,51 +988,12 @@ endif
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc
 
-# Variable Length Arrays (VLAs) should not be used anywhere in the kernel
-KBUILD_CFLAGS += -Wvla
-
-# disable pointer signed / unsigned warnings in gcc 4.0
-KBUILD_CFLAGS += -Wno-pointer-sign
-
-# In order to make sure new function cast mismatches are not introduced
-# in the kernel (to avoid tripping CFI checking), the kernel should be
-# globally built with -Wcast-function-type.
-KBUILD_CFLAGS += $(call cc-option, -Wcast-function-type)
-
 # To gain proper coverage for CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE,
 # the kernel uses only C99 flexible arrays for dynamically sized trailing
 # arrays. Enforce this for everything that may examine structure sizes and
 # perform bounds checking.
 KBUILD_CFLAGS += $(call cc-option, -fstrict-flex-arrays=3)
 
-# disable stringop warnings in gcc 8+
-KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
-
-# We'll want to enable this eventually, but it's not going away for 5.7 at least
-KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
-
-# Another good warning that we'll want to enable eventually
-KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
-
-# Enabled with W=2, disabled by default as noisy
-ifdef CONFIG_CC_IS_GCC
-KBUILD_CFLAGS += -Wno-maybe-uninitialized
-endif
-
-# The allocators already balk at large sizes, so silence the compiler
-# warnings for bounds checks involving those possible values. While
-# -Wno-alloc-size-larger-than would normally be used here, earlier versions
-# of gcc (<9.1) weirdly don't handle the option correctly when _other_
-# warnings are produced (?!). Using -Walloc-size-larger-than=SIZE_MAX
-# doesn't work (as it is documented to), silently resolving to "0" prior to
-# version 9.1 (and producing an error more recently). Numeric values larger
-# than PTRDIFF_MAX also don't work prior to version 9.1, which are silently
-# ignored, continuing to default to PTRDIFF_MAX. So, left with no other
-# choice, we must perform a versioned check to disable this warning.
-# https://lore.kernel.org/lkml/20210824115859.187f272f@canb.auug.org.au
-KBUILD_CFLAGS-$(call gcc-min-version, 90100) += -Wno-alloc-size-larger-than
-KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
-
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= -fno-strict-overflow
 
@@ -1081,18 +1005,6 @@ ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS   += -fconserve-stack
 endif
 
-# Prohibit date/time macros, which would make the build non-deterministic
-KBUILD_CFLAGS   += -Werror=date-time
-
-# enforce correct pointer usage
-KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
-
-# Require designated initializers for all marked structures
-KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
-
-# Warn if there is an enum types mismatch
-KBUILD_CFLAGS	+= $(call cc-option,-Wenum-conversion)
-
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 40cd13eca82e8..9cc0e52ebd7eb 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -6,6 +6,96 @@
 # They are independent, and can be combined like W=12 or W=123e.
 # ==========================================================================
 
+# Default set of warnings, always enabled
+KBUILD_CFLAGS += -Wall
+KBUILD_CFLAGS += -Wundef
+KBUILD_CFLAGS += -Werror=implicit-function-declaration
+KBUILD_CFLAGS += -Werror=implicit-int
+KBUILD_CFLAGS += -Werror=return-type
+KBUILD_CFLAGS += -Werror=strict-prototypes
+KBUILD_CFLAGS += -Wno-format-security
+KBUILD_CFLAGS += -Wno-trigraphs
+KBUILD_CFLAGS += $(call cc-disable-warning,frame-address,)
+KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
+KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
+KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
+
+ifneq ($(CONFIG_FRAME_WARN),0)
+KBUILD_CFLAGS += -Wframe-larger-than=$(CONFIG_FRAME_WARN)
+endif
+
+KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
+KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
+KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
+
+ifdef CONFIG_CC_IS_CLANG
+# The kernel builds with '-std=gnu11' so use of GNU extensions is acceptable.
+KBUILD_CFLAGS += -Wno-gnu
+else
+
+# gcc inanely warns about local variables called 'main'
+KBUILD_CFLAGS += -Wno-main
+endif
+
+# These warnings generated too much noise in a regular build.
+# Use make W=1 to enable them (see scripts/Makefile.extrawarn)
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
+
+# These result in bogus false positives
+KBUILD_CFLAGS += $(call cc-disable-warning, dangling-pointer)
+
+# Variable Length Arrays (VLAs) should not be used anywhere in the kernel
+KBUILD_CFLAGS += -Wvla
+
+# disable pointer signed / unsigned warnings in gcc 4.0
+KBUILD_CFLAGS += -Wno-pointer-sign
+
+# In order to make sure new function cast mismatches are not introduced
+# in the kernel (to avoid tripping CFI checking), the kernel should be
+# globally built with -Wcast-function-type.
+KBUILD_CFLAGS += $(call cc-option, -Wcast-function-type)
+
+# disable stringop warnings in gcc 8+
+KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
+
+# We'll want to enable this eventually, but it's not going away for 5.7 at least
+KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
+
+# Another good warning that we'll want to enable eventually
+KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
+
+# Enabled with W=2, disabled by default as noisy
+ifdef CONFIG_CC_IS_GCC
+KBUILD_CFLAGS += -Wno-maybe-uninitialized
+endif
+
+# The allocators already balk at large sizes, so silence the compiler
+# warnings for bounds checks involving those possible values. While
+# -Wno-alloc-size-larger-than would normally be used here, earlier versions
+# of gcc (<9.1) weirdly don't handle the option correctly when _other_
+# warnings are produced (?!). Using -Walloc-size-larger-than=SIZE_MAX
+# doesn't work (as it is documented to), silently resolving to "0" prior to
+# version 9.1 (and producing an error more recently). Numeric values larger
+# than PTRDIFF_MAX also don't work prior to version 9.1, which are silently
+# ignored, continuing to default to PTRDIFF_MAX. So, left with no other
+# choice, we must perform a versioned check to disable this warning.
+# https://lore.kernel.org/lkml/20210824115859.187f272f@canb.auug.org.au
+KBUILD_CFLAGS-$(call gcc-min-version, 90100) += -Wno-alloc-size-larger-than
+KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
+
+# Prohibit date/time macros, which would make the build non-deterministic
+KBUILD_CFLAGS += -Werror=date-time
+
+# enforce correct pointer usage
+KBUILD_CFLAGS += $(call cc-option,-Werror=incompatible-pointer-types)
+
+# Require designated initializers for all marked structures
+KBUILD_CFLAGS += $(call cc-option,-Werror=designated-init)
+
+# Warn if there is an enum types mismatch
+KBUILD_CFLAGS += $(call cc-option,-Wenum-conversion)
+
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 
 # backward compatibility
-- 
2.39.2

