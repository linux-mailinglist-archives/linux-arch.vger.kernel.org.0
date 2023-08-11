Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A068177915A
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 16:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjHKOEK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 10:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbjHKOEF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 10:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69432D78;
        Fri, 11 Aug 2023 07:04:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B6076735E;
        Fri, 11 Aug 2023 14:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FE0C433CC;
        Fri, 11 Aug 2023 14:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762641;
        bh=DhAl8HXBxHnrafao1NZ+4HVKfS5+Q+yRkDdvMwW757U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UBTE4peUFMl8fwF6tR3VJPzYHvfo3jb8bZ+yRNVQnXQGLDZEN1Swf9sM0erOcJR0y
         PpmV8zhkk6ArFJDNH9zv+TL3rp8FIZHMSU/X8x2JBBr/cYfMNkTELTNIQguT2zvqWl
         0QVL9k4OJz0DhHtiWIVw/t1+epfnq0QthNNrpuUoDJqmxrnHHYtRjLUCF+p4SDc7zH
         d2fx76ieptOkXuqscbtuiA777WspE0SMX8JKMoeN4I++xaSK8rGVcwfqQ/rktBMvKh
         t6bmHPI0qTDn99Akt9Q+3xJxoeyMbXStVufQCfYyf7RG8iJ4u0PWK8m0+hH3CKe2ep
         PPWw7tnoLYRrQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 9/9] [RFC] extrawarn: enable more W=1 warnings by default
Date:   Fri, 11 Aug 2023 16:03:27 +0200
Message-Id: <20230811140327.3754597-10-arnd@kernel.org>
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

A number of warning options from the W=1 set are completely clean in current
kernels, so we should just enable them by default, including a lot of warnings
that are part of -Wextra, so just turn on -Wextra by default.

The -Woverride-init, -Wvoid-pointer-to-enum-cast and
-Wmissing-format-attribute warnings are part of -Wextra but still produce
some legitimate warnings that need to be fixed, so leave them at the
W=1 level but turn them off otherwise.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 1e6822b22c260..9185d69727542 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -72,6 +72,12 @@ KBUILD_CFLAGS += $(call cc-option,-Werror=designated-init)
 # Warn if there is an enum types mismatch
 KBUILD_CFLAGS += $(call cc-option,-Wenum-conversion)
 
+KBUILD_CFLAGS += -Wextra
+KBUILD_CFLAGS += -Wunused -Wno-unused-parameter
+KBUILD_CFLAGS += -Wold-style-definition
+KBUILD_CFLAGS += -Wmissing-include-dirs
+KBUILD_CFLAGS += $(call cc-option, -Wpacked-not-aligned)
+
 # backward compatibility
 KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
 
@@ -86,16 +92,11 @@ export KBUILD_EXTRA_WARN
 #
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
 
-KBUILD_CFLAGS += -Wextra -Wunused -Wno-unused-parameter
 KBUILD_CFLAGS += -Wmissing-declarations
-KBUILD_CFLAGS += $(call cc-option, -Wrestrict)
 KBUILD_CFLAGS += -Wmissing-format-attribute
 KBUILD_CFLAGS += -Wmissing-prototypes
-KBUILD_CFLAGS += -Wold-style-definition
-KBUILD_CFLAGS += -Wmissing-include-dirs
 KBUILD_CFLAGS += $(call cc-option, -Wunused-but-set-variable)
 KBUILD_CFLAGS += $(call cc-option, -Wunused-const-variable)
-KBUILD_CFLAGS += $(call cc-option, -Wpacked-not-aligned)
 KBUILD_CFLAGS += $(call cc-option, -Wformat-overflow)
 KBUILD_CFLAGS += $(call cc-option, -Wformat-truncation)
 KBUILD_CFLAGS += $(call cc-option, -Wstringop-overflow)
@@ -110,8 +111,7 @@ else
 # Suppress them by using -Wno... except for W=1.
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
-KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
+KBUILD_CFLAGS += $(call cc-disable-warning, missing-format-attribute)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
@@ -131,12 +131,10 @@ ifeq ($(call clang-min-version, 120000),y)
 KBUILD_CFLAGS += -Wformat-insufficient-args
 endif
 endif
-KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
-KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
-KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
-KBUILD_CFLAGS += $(call cc-disable-warning, cast-function-type-strict)
+KBUILD_CFLAGS += -Wno-void-pointer-to-enum-cast
 else
 KBUILD_CFLAGS += -Wno-main
+KBUILD_CFLAGS += -Wno-override-init
 endif
 
 endif
-- 
2.39.2

