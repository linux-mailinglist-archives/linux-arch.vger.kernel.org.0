Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18633604D5D
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 18:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiJSQ1d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 12:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiJSQ1c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 12:27:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C945E43627;
        Wed, 19 Oct 2022 09:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82681B8250F;
        Wed, 19 Oct 2022 16:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFB4C433D7;
        Wed, 19 Oct 2022 16:27:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="US7FiyUD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666196844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0lT+uEqlVaVxzDYYTi6dahuFCqqiYtCEv6lPMBO9aIk=;
        b=US7FiyUDe8pnYz6rD3uwg9fXnSMZscFIYdtfIpv4nXWoaXgeagZoP4Aq3+1ycyM4jN6PAA
        sT+vCEuPGTqjOb5tSTOdYoqhRAvMz/77p4eWWarEYDA2lmcA6GsdYvOM4SHdT534zEmMVR
        WZGPFOwIokjYZRMKO5MEMdMo3HOL2z4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f51d3b10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Oct 2022 16:27:24 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] kbuild: treat char as always signed
Date:   Wed, 19 Oct 2022 10:26:48 -0600
Message-Id: <20221019162648.3557490-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Recently, some compile-time checking I added to the clamp_t family of
functions triggered a build error when a poorly written driver was
compiled on ARM, because the driver assumed that the naked `char` type
is signed, but ARM treats it as unsigned, and the C standard says it's
architecture-dependent.

I doubt this particular driver is the only instance in which
unsuspecting authors assume that `char` with no `signed` or `unsigned`
designation is signed, because that's how the other types work. We were
lucky enough this time that that driver used `clamp_t(char,
negative_value, positive_value)`, so the new checking code found it, and
I've sent a patch to fix it, but there are likely other places lurking
that won't be so easily unearthed.

So let's just eliminate this particular variety of heisensigned bugs
entirely. Set `-fsigned-char` globally, so that gcc makes the type
signed on all architectures.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/lkml/202210190108.ESC3pc3D-lkp@intel.com/
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f41ec8c8426b..f1abcaf7110e 100644
--- a/Makefile
+++ b/Makefile
@@ -562,7 +562,7 @@ KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
 KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
 		   -Werror=implicit-function-declaration -Werror=implicit-int \
-		   -Werror=return-type -Wno-format-security \
+		   -Werror=return-type -Wno-format-security -fsigned-char \
 		   -std=gnu11
 KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_RUSTFLAGS := $(rust_common_flags) \
-- 
2.38.1

