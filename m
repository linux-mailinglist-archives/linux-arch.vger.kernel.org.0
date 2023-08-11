Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB07779156
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbjHKOEG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 10:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbjHKOEF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 10:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B05710E4;
        Fri, 11 Aug 2023 07:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C408D67368;
        Fri, 11 Aug 2023 14:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F368CC433C9;
        Fri, 11 Aug 2023 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762639;
        bh=1bMXyvoJWAnWRA0OT2v/oEuLQrJAr/mI1Zeo9rXeZ1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFg49Hu5DNwyNGwn6+X5k4CSMpFKXl6HdAY+m8LjwiTMyHb+RyUGus60FLoEucFF+
         ke+hqsgNP3iphbK7yObfbhFB7/1yyR/e1WP1SlSE9yIpfymznvgV65vP9SkuFDnoat
         EHoh+buXPp4/etPuIK918VZRX4tV4CMJW/MNmX/Yqy49wB8zoLPrU74VlTBjK2f49E
         XqAQ1VMkJZmZp+lq7e/hKsKwqI3NQRjChWacO2SZlhtBeJ8050mvCpA2WSUtQcazJw
         K4Z4LJPX36Pd5y81rtsVicZuJtBj4nsHMUHtBY9R0Z39m3hu9fsO1LoxXOhnNDk68r
         0CUTOvNcxLz2w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 8/9] extrawarn: enable more warnings in W=2
Date:   Fri, 11 Aug 2023 16:03:26 +0200
Message-Id: <20230811140327.3754597-9-arnd@kernel.org>
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

These four warning options are always disabled, but actually meet the
criteria for W=2, as they are sometimes useful and not prohibitively
noisy:

 -Wformat-security
 -Wframe-address
 -Waddress-of-packed-member
 -Wtrigraphs

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 8fd76da9042f8..1e6822b22c260 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -13,10 +13,6 @@ KBUILD_CFLAGS += -Werror=implicit-function-declaration
 KBUILD_CFLAGS += -Werror=implicit-int
 KBUILD_CFLAGS += -Werror=return-type
 KBUILD_CFLAGS += -Werror=strict-prototypes
-KBUILD_CFLAGS += -Wno-format-security
-KBUILD_CFLAGS += -Wno-trigraphs
-KBUILD_CFLAGS += $(call cc-disable-warning,frame-address,)
-KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 
 ifneq ($(CONFIG_FRAME_WARN),0)
 KBUILD_CFLAGS += -Wframe-larger-than=$(CONFIG_FRAME_WARN)
@@ -157,6 +153,10 @@ KBUILD_CFLAGS += -Wmissing-field-initializers
 KBUILD_CFLAGS += -Wtype-limits
 KBUILD_CFLAGS += $(call cc-option, -Wmaybe-uninitialized)
 KBUILD_CFLAGS += $(call cc-option, -Wunused-macros)
+KBUILD_CFLAGS += $(call cc-option, -Waddress-of-packed-member)
+KBUILD_CFLAGS += $(call cc-option, -Wframe-address)
+KBUILD_CFLAGS += -Wformat-security
+KBUILD_CFLAGS += -Wtrigraphs
 
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CFLAGS += -Winitializer-overrides
@@ -169,6 +169,10 @@ else
 # The following turn off the warnings enabled by -Wextra
 KBUILD_CFLAGS += -Wno-missing-field-initializers
 KBUILD_CFLAGS += -Wno-type-limits
+KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
+KBUILD_CFLAGS += $(call cc-disable-warning, frame-address)
+KBUILD_CFLAGS += -Wno-format-security
+KBUILD_CFLAGS += -Wno-trigraphs
 
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CFLAGS += -Wno-initializer-overrides
-- 
2.39.2

