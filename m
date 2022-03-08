Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78BE4D1A1B
	for <lists+linux-arch@lfdr.de>; Tue,  8 Mar 2022 15:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbiCHONh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Mar 2022 09:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346397AbiCHONg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2022 09:13:36 -0500
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25625140FB
        for <linux-arch@vger.kernel.org>; Tue,  8 Mar 2022 06:12:37 -0800 (PST)
Received: from localhost.localdomain ([106.133.35.112])
        by smtp.orange.fr with ESMTPA
        id RaZInDouy9VRxRaZcnRk3S; Tue, 08 Mar 2022 15:12:35 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: MDU0YmViZGZmMDIzYiBlMiM2NTczNTRjNWZkZTMwOGRiOGQ4ODf3NWI1ZTMyMzdiODlhOQ==
X-ME-Date: Tue, 08 Mar 2022 15:12:35 +0100
X-ME-IP: 106.133.35.112
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2] linux/bits.h: GENMASK_INPUT_CHECK: reduce W=2 noise by 31% treewide
Date:   Tue,  8 Mar 2022 23:12:01 +0900
Message-Id: <20220308141201.2343757-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch silences a -Wtypes-limits warning in GENMASK_INPUT_CHECK()
which is accountable for 31% of all warnings when compiling with W=2.

Indeed, GENMASK_INPUT_CHECK() will generate some warnings at W=2 level
if invoked with an unsigned integer and zero. For example, this:

| #include <linux/bits.h>
| unsigned int foo(unsigned int bar)
| { return GENMASK(bar, 0); }

would yield 30 lines of warning. Extract:

| In file included from ./include/linux/bits.h:22,
|                  from ./foo.c:1:
| foo.c: In function 'foo':
| ./include/linux/bits.h:25:36: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
|    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
|       |                                    ^

This pattern is harmless (false positive) and for that reason,
-Wtypes-limits was moved to W=2. c.f. [1].

However because it occurs in header files (example: find_first_bit()
from linux/find.h [2]), GENMASK_INPUT_CHECK() is accountable for
roughly 31% (164714/532484) of all W=2 warnings for an
allyesconfig. This is an issue because that noise makes it harder to
triage and find relevant W=2 warnings.

Reference (using gcc 11.2, linux v5.17-rc6 on x86_64):

| $ make allyesconfig
| $ sed -i '/CONFIG_WERROR/d' .config
| $ make W=2 -j8 2> kernel_w2.log > /dev/null
| $ grep "\./include/linux/bits\.h:.*: warning" kernel_w2\.log | wc -l
| 164714
| $ grep ": warning: " kernel_w2.log | wc -l
| 532484

In this patch, we silence this warning by:

  * replacing the comparison > by and logical and && in the first
    argument of __builtin_choose_expr().

  * casting the high bit of the mask to a signed integer in the second
    argument of __builtin_choose_expr().

[1] https://lore.kernel.org/lkml/20200708190756.16810-1-rikard.falkeborn@gmail.com/
[2] https://elixir.bootlin.com/linux/v5.17-rc6/source/include/linux/find.h#L119

Link: https://lore.kernel.org/lkml/cover.1590017578.git.syednwaris@gmail.com/
Link: https://lore.kernel.org/lkml/20220304124416.1181029-1-mailhol.vincent@wanadoo.fr/
Fixes: 295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
* Changelog *

v1 -> v2:

  * Rewrote the commit message to make it less verbose
  * Add in CC all people from:
  https://lore.kernel.org/lkml/cover.1590017578.git.syednwaris@gmail.com/
---
 include/linux/bits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 87d112650dfb..542e9a8985b1 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -22,7 +22,7 @@
 #include <linux/build_bug.h>
 #define GENMASK_INPUT_CHECK(h, l) \
 	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-		__is_constexpr((l) > (h)), (l) > (h), 0)))
+		__is_constexpr((h)) && __is_constexpr((l)), (l) > (int)(h), 0)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
-- 
2.34.1

