Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C481377914C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 16:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjHKODw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbjHKODr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 10:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9822D78;
        Fri, 11 Aug 2023 07:03:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 434E067358;
        Fri, 11 Aug 2023 14:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7219BC433C7;
        Fri, 11 Aug 2023 14:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762625;
        bh=I/TFxqUUMSUrllQ7NnImM26eIykZcRmEoTOopHwYd+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jiFFLBBe683hDMqkrqXjki+Jgksmk3yd9MF6wrqhLw4KOlx9gi7wwJjHzfToXmdqQ
         FYrluGVxAKgtexrj4+lJlQfKgI6TPh4txEaAaWoGs75CWlAAtzUU4MXmc2ytImIGOp
         j4Fnk1Wecm7uCrN068yGLAjxpfUR4Jj/3hm0/fAdIs2Y8qtCpn5TXPPsw+Iohsldj3
         TJzB0IZauX0fOYyVXaBpEiZzU5BKmXYnIrEmEah7TezXtUnGuSooLfk+8InkgUQ9cW
         x4nNFOl6c6yQmC/ao+Ei9D9GP6bMToPpa92J/n9vAKn8daHUfjWeMBcolrc4ud6IoS
         wenSkxCe0eFVw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 3/9] Kbuild: avoid duplicate warning options
Date:   Fri, 11 Aug 2023 16:03:21 +0200
Message-Id: <20230811140327.3754597-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811140327.3754597-1-arnd@kernel.org>
References: <20230811140327.3754597-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Some warning options are disabled at one place and then conditionally
re-enabled later in scripts/Makefile.extrawarn.

For consistency, rework this file so each of those warnings only
gets etiher enabled or disabled based on the W= flags but not both.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 43 +++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 9cc0e52ebd7eb..8afbe4706ff11 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -56,20 +56,12 @@ KBUILD_CFLAGS += -Wno-pointer-sign
 # globally built with -Wcast-function-type.
 KBUILD_CFLAGS += $(call cc-option, -Wcast-function-type)
 
-# disable stringop warnings in gcc 8+
-KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
-
 # We'll want to enable this eventually, but it's not going away for 5.7 at least
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
 
 # Another good warning that we'll want to enable eventually
 KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
 
-# Enabled with W=2, disabled by default as noisy
-ifdef CONFIG_CC_IS_GCC
-KBUILD_CFLAGS += -Wno-maybe-uninitialized
-endif
-
 # The allocators already balk at large sizes, so silence the compiler
 # warnings for bounds checks involving those possible values. While
 # -Wno-alloc-size-larger-than would normally be used here, earlier versions
@@ -96,8 +88,6 @@ KBUILD_CFLAGS += $(call cc-option,-Werror=designated-init)
 # Warn if there is an enum types mismatch
 KBUILD_CFLAGS += $(call cc-option,-Wenum-conversion)
 
-KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
-
 # backward compatibility
 KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
 
@@ -122,11 +112,6 @@ KBUILD_CFLAGS += $(call cc-option, -Wunused-but-set-variable)
 KBUILD_CFLAGS += $(call cc-option, -Wunused-const-variable)
 KBUILD_CFLAGS += $(call cc-option, -Wpacked-not-aligned)
 KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)
-# The following turn off the warnings enabled by -Wextra
-KBUILD_CFLAGS += -Wno-missing-field-initializers
-KBUILD_CFLAGS += -Wno-sign-compare
-KBUILD_CFLAGS += -Wno-type-limits
-KBUILD_CFLAGS += -Wno-shift-negative-value
 
 KBUILD_CPPFLAGS += -Wundef
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN1
@@ -135,9 +120,12 @@ else
 
 # Some diagnostics enabled by default are noisy.
 # Suppress them by using -Wno... except for W=1.
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
+KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
+KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
+KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
 ifdef CONFIG_CC_IS_CLANG
-KBUILD_CFLAGS += -Wno-initializer-overrides
 # Clang before clang-16 would warn on default argument promotions.
 ifneq ($(call clang-min-version, 160000),y)
 # Disable -Wformat
@@ -151,7 +139,6 @@ ifeq ($(call clang-min-version, 120000),y)
 KBUILD_CFLAGS += -Wformat-insufficient-args
 endif
 endif
-KBUILD_CFLAGS += -Wno-sign-compare
 KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
 KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
 KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
@@ -173,8 +160,25 @@ KBUILD_CFLAGS += -Wtype-limits
 KBUILD_CFLAGS += $(call cc-option, -Wmaybe-uninitialized)
 KBUILD_CFLAGS += $(call cc-option, -Wunused-macros)
 
+ifdef CONFIG_CC_IS_CLANG
+KBUILD_CFLAGS += -Winitializer-overrides
+endif
+
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN2
 
+else
+
+# The following turn off the warnings enabled by -Wextra
+KBUILD_CFLAGS += -Wno-missing-field-initializers
+KBUILD_CFLAGS += -Wno-type-limits
+KBUILD_CFLAGS += -Wno-shift-negative-value
+
+ifdef CONFIG_CC_IS_CLANG
+KBUILD_CFLAGS += -Wno-initializer-overrides
+else
+KBUILD_CFLAGS += -Wno-maybe-uninitialized
+endif
+
 endif
 
 #
@@ -196,6 +200,11 @@ KBUILD_CFLAGS += $(call cc-option, -Wpacked-bitfield-compat)
 
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN3
 
+else
+
+# The following turn off the warnings enabled by -Wextra
+KBUILD_CFLAGS += -Wno-sign-compare
+
 endif
 
 #
-- 
2.39.2

