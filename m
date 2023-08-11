Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90799779153
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 16:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjHKOEA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 10:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjHKOD7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 10:03:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7F930DB;
        Fri, 11 Aug 2023 07:03:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C24B6735E;
        Fri, 11 Aug 2023 14:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4017EC433C8;
        Fri, 11 Aug 2023 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762636;
        bh=GmdrJTF67LqqSDhqJe2Ev839NzUGDS7J99o002Hoczw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9C+58jE/avwtKmSfjqOdvA2khscq1q/teSn07CaTH6PyhLjoRB2wkfe/U3mkZnRg
         ImSQvQoNp0wMlKDwOr2UIqWkaDYbggRiG+vqbbz33C91Byk8dtrPyEQh8sJKByAN2c
         zuOrurOHfKWVj9ioh818xRLy9tPTtWWFlyKXQs8SCkYS3s3Lw8Ty/5NbrVpNWgKlC1
         CqvjlUJCPP0UZFZKCvqad7+KRz7CvuA6J+5yEub7JJ1hh0r8gG4U9hjlvc9kLjSTLP
         CfPHYS+cIIKyPPdnCGFtO/0yIyo/eVSp4VxCQENiRwOIT1kH5NClwRUAOSdMGMRw/D
         GDQbfwDskPPcg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 7/9] extrawarn: do not disable -Wmain at W=1 level
Date:   Fri, 11 Aug 2023 16:03:25 +0200
Message-Id: <20230811140327.3754597-8-arnd@kernel.org>
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

There is only one function in architecture independent code that has
a local variable named main(), and it seems fine to warn about this
at the W=1 level, so move it there to declutter the normal command
line slightly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 8abe90270b335..8fd76da9042f8 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -29,10 +29,6 @@ KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
 ifdef CONFIG_CC_IS_CLANG
 # The kernel builds with '-std=gnu11' so use of GNU extensions is acceptable.
 KBUILD_CFLAGS += -Wno-gnu
-else
-
-# gcc inanely warns about local variables called 'main'
-KBUILD_CFLAGS += -Wno-main
 endif
 
 # These warnings generated too much noise in a regular build.
@@ -143,6 +139,8 @@ KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
 KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
 KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
 KBUILD_CFLAGS += $(call cc-disable-warning, cast-function-type-strict)
+else
+KBUILD_CFLAGS += -Wno-main
 endif
 
 endif
-- 
2.39.2

