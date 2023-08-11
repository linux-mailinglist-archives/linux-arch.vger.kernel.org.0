Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6166F77914E
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 16:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbjHKODx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 10:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjHKODw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 10:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA8CEA;
        Fri, 11 Aug 2023 07:03:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A18416735F;
        Fri, 11 Aug 2023 14:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C91C433C9;
        Fri, 11 Aug 2023 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762631;
        bh=StEZnUgwBbzkGTrOg3LGjjgmffFdTIC8SG8G5XNIROI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRNzmLWbEY+goLxMckredhCEwaMrn8Ei+wLNo5nytuIhvNtSnqSQkc2qtE59S0+M1
         7ra59Zz2jXvdScAu5q6ffhN1XBeTkSfuYDWkHCv5b1V4dSIAjDRv4wn2NbFer9YdXZ
         46HqpcR3Xlo45uCAw2W/juCNHlXXpSKQ+iQlUEsf0k2HyYLND37Igp6UphAMdcEibB
         r9Mri16bhi0S8Zbz+Ci31EHew97KfyD/m01GTp/YDB1d7Xx79nkZAq/GbOrjb/WM/b
         xYDA9h4q5XNqAtmxy/RWaLVeY3xOgk4IA8S/QuiI/bBuNR5HozTnjGhA3ol3u6JFlS
         uwUnRYpolbidA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 5/9] extrawarn: enable format and stringop overflow warnings in W=1
Date:   Fri, 11 Aug 2023 16:03:23 +0200
Message-Id: <20230811140327.3754597-6-arnd@kernel.org>
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

The stringop and format warnings got disabled globally when they were
newly introduced in commit bd664f6b3e376 ("disable new gcc-7.1.1 warnings
for now"), 217c3e0196758 ("disable stringop truncation warnings for now")
and 5a76021c2eff7 ("gcc-10: disable 'stringop-overflow' warning for now").

In all cases, the sentiment at the time was that the warnings are
useful, and we actually addressed a number of real bugs based on
them, but we never managed to eliminate them all because even the
build bots using W=1 builds only see the -Wstringop-truncation
warnings that are enabled at that level.

Move these into the W=1 section to give them a larger build coverage
and actually eliminate them over time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 87bfe153198f1..ec528972371fa 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -16,8 +16,6 @@ KBUILD_CFLAGS += -Werror=strict-prototypes
 KBUILD_CFLAGS += -Wno-format-security
 KBUILD_CFLAGS += -Wno-trigraphs
 KBUILD_CFLAGS += $(call cc-disable-warning,frame-address,)
-KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
-KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 
 ifneq ($(CONFIG_FRAME_WARN),0)
@@ -56,9 +54,6 @@ KBUILD_CFLAGS += -Wno-pointer-sign
 # globally built with -Wcast-function-type.
 KBUILD_CFLAGS += $(call cc-option, -Wcast-function-type)
 
-# We'll want to enable this eventually, but it's not going away for 5.7 at least
-KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
-
 # Another good warning that we'll want to enable eventually
 KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
 
@@ -111,6 +106,9 @@ KBUILD_CFLAGS += -Wmissing-include-dirs
 KBUILD_CFLAGS += $(call cc-option, -Wunused-but-set-variable)
 KBUILD_CFLAGS += $(call cc-option, -Wunused-const-variable)
 KBUILD_CFLAGS += $(call cc-option, -Wpacked-not-aligned)
+KBUILD_CFLAGS += $(call cc-option, -Wformat-overflow)
+KBUILD_CFLAGS += $(call cc-option, -Wformat-truncation)
+KBUILD_CFLAGS += $(call cc-option, -Wstringop-overflow)
 KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)
 
 KBUILD_CPPFLAGS += -Wundef
@@ -123,6 +121,9 @@ else
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
+KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
+KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
+KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
 ifdef CONFIG_CC_IS_CLANG
-- 
2.39.2

