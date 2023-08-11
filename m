Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086B7779150
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 16:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjHKODx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 10:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbjHKODv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 10:03:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E3C2D7D;
        Fri, 11 Aug 2023 07:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F05EE67368;
        Fri, 11 Aug 2023 14:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD6EC433C8;
        Fri, 11 Aug 2023 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762628;
        bh=jcJprh47OwtgCNUJpCeFBNe9idE06uF1RkKWw9KW+8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHjEwQn9seGxZDoFIyUggXp5NicGSLVnHHNn5H4v6io3AEtbzcT01UdQZqUswjN6u
         og2SuFQ+5YbpUNfNz+YwLEL6eHEtgt30iFk/ZeGPESxCVXSaz7RFIXJg3KcPDVZr3Z
         mZ38bAbL4DEP5fWtg1QO8q/QAC/k1oCMAyXB3GUEKQns9IP+jrhM1hRuAtCSJ9xyZf
         v/BOpfu/Pbxhc4PYpLZNKXa+oIrLFHSdFqhu/je1OgcsgmlU9VSxr4doAhUrxxR3uM
         kDnBsGXYaO+H7mcmn5IWN5B2fl6QQQXQXLEPgTbZlpR77ioJaA08svgoiikZo54sBp
         7SdZ3gG+A4irg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 4/9] extrawarn: don't turn off -Wshift-negative-value for gcc-9
Date:   Fri, 11 Aug 2023 16:03:22 +0200
Message-Id: <20230811140327.3754597-5-arnd@kernel.org>
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

The warning does nothing for newer versions of gcc since -fno-strict-overflow
is used, on old versions it warns about lines that would be undefined
otherwise:

fs/isofs/util.c: In function 'iso_date':
fs/isofs/util.c:40:14: error: left shift of negative value [-Werror=shift-negative-value]
    tz |= (-1 << 8);
              ^~
drivers/video/fbdev/tdfxfb.c: In function 'tdfxfb_probe':
drivers/video/fbdev/tdfxfb.c:1482:17: error: left shift of negative value [-Werror=shift-negative-value]
      (PAGE_MASK << 1);
                 ^~
drivers/tty/serial/8250/8250_core.c: In function 'serial8250_request_rsa_resource':
drivers/tty/serial/8250/8250_core.c:350:38: error: left shift of negative value [-Werror=shift-negative-value]
  unsigned long start = UART_RSA_BASE << up->port.regshift;
                                      ^~
drivers/tty/serial/8250/8250_core.c: In function 'serial8250_release_rsa_resource':
drivers/tty/serial/8250/8250_core.c:371:39: error: left shift of negative value [-Werror=shift-negative-value]
  unsigned long offset = UART_RSA_BASE << up->port.regshift;
                                       ^~
drivers/clk/mvebu/dove-divider.c: In function 'dove_set_clock':
drivers/clk/mvebu/dove-divider.c:145:14: error: left shift of negative value [-Werror=shift-negative-value]
  mask = ~(~0 << dc->div_bit_size) << dc->div_bit_start;
              ^~
drivers/block/drbd/drbd_main.c: In function 'dcbp_set_pad_bits':
drivers/block/drbd/drbd_main.c:1098:37: error: left shift of negative value [-Werror=shift-negative-value]
  p->encoding = (p->encoding & (~0x7 << 4)) | (n << 4);

Disable these conditionally to keep the command line a little shorter.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 8afbe4706ff11..87bfe153198f1 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -171,12 +171,14 @@ else
 # The following turn off the warnings enabled by -Wextra
 KBUILD_CFLAGS += -Wno-missing-field-initializers
 KBUILD_CFLAGS += -Wno-type-limits
-KBUILD_CFLAGS += -Wno-shift-negative-value
 
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CFLAGS += -Wno-initializer-overrides
 else
 KBUILD_CFLAGS += -Wno-maybe-uninitialized
+ifneq ($(call gcc-min-version, 90100),y)
+KBUILD_CFLAGS += $(call cc-disable-warning, shift-negative-value)
+endif
 endif
 
 endif
-- 
2.39.2

