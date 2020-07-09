Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B875721A00A
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGIMak (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 08:30:40 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36066 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgGIMak (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 08:30:40 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jtVgp-0003Uz-Kd; Thu, 09 Jul 2020 22:30:12 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Jul 2020 22:30:11 +1000
Date:   Thu, 9 Jul 2020 22:30:11 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     akpm@linux-foundation.org, andy.shevchenko@gmail.com,
        arnd@arndb.de, emil.l.velikov@gmail.com, geert@linux-m68k.org,
        keescook@chromium.org, linus.walleij@linaro.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, rikard.falkeborn@gmail.com, syednwaris@gmail.com,
        vilhelm.gray@gmail.com, yamada.masahiro@socionext.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 1/2] linux/bits.h: fix unsigned less than zero warnings
Message-ID: <20200709123011.GA18734@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621054210.14804-1-rikard.falkeborn@gmail.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:
> When calling the GENMASK and GENMASK_ULL macros with zero lower bit and
> an unsigned unknown high bit, some gcc versions warn due to the
> comparisons of the high and low bit in GENMASK_INPUT_CHECK.
> 
> To silence the warnings, only perform the check if both inputs are
> known. This does not trigger any warnings, from the Wtype-limits help:
> 
>        Warn if a comparison is always true or always false due to the
>        limited range of the data type, but do not warn for constant
>        expressions.
> 
> As an example of the warning, kindly reported by the kbuild test robot:
> 
> from drivers/mfd/atmel-smc.c:11:
> drivers/mfd/atmel-smc.c: In function 'atmel_smc_cs_encode_ncycles':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> |                            ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> 16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> |                                                              ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> 39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> |   ^~~~~~~~~~~~~~~~~~~
>>> drivers/mfd/atmel-smc.c:49:25: note: in expansion of macro 'GENMASK'
> 49 |  unsigned int lsbmask = GENMASK(msbpos - 1, 0);
> |                         ^~~~~~~
> 
> Fixes: 295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Emil Velikov <emil.l.velikov@gmail.com>
> Reported-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> v3-v4
> Added Emils Reviewed-by.

I'm still getting the same warning even with the patch, for example:

  CC [M]  drivers/crypto/inside-secure/safexcel.o
  CHECK   ../drivers/crypto/inside-secure/safexcel_hash.c
In file included from ../include/linux/bits.h:23,
                 from ../include/linux/bitops.h:5,
                 from ../include/linux/kernel.h:12,
                 from ../include/linux/clk.h:13,
                 from ../drivers/crypto/inside-secure/safexcel.c:8:
../drivers/crypto/inside-secure/safexcel.c: In function \u2018safexcel_hw_init\u2019:
../include/linux/bits.h:27:7: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
   (l) > (h), 0)))
       ^
../include/linux/build_bug.h:16:62: note: in definition of macro \u2018BUILD_BUG_ON_ZERO\u2019
 #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                              ^
../include/linux/bits.h:40:3: note: in expansion of macro \u2018GENMASK_INPUT_CHECK\u2019
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
   ^~~~~~~~~~~~~~~~~~~
../drivers/crypto/inside-secure/safexcel.c:649:11: note: in expansion of macro \u2018GENMASK\u2019
           GENMASK(priv->config.rings - 1, 0),
           ^~~~~~~
../include/linux/bits.h:27:7: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
   (l) > (h), 0)))
       ^
../include/linux/build_bug.h:16:62: note: in definition of macro \u2018BUILD_BUG_ON_ZERO\u2019
 #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                              ^
../include/linux/bits.h:40:3: note: in expansion of macro \u2018GENMASK_INPUT_CHECK\u2019
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
   ^~~~~~~~~~~~~~~~~~~
../drivers/crypto/inside-secure/safexcel.c:757:35: note: in expansion of macro \u2018GENMASK\u2019
   writel(EIP197_DxE_THR_CTRL_EN | GENMASK(priv->config.rings - 1, 0),
                                   ^~~~~~~
../include/linux/bits.h:27:7: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
   (l) > (h), 0)))
       ^
../include/linux/build_bug.h:16:62: note: in definition of macro \u2018BUILD_BUG_ON_ZERO\u2019
 #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                              ^
../include/linux/bits.h:40:3: note: in expansion of macro \u2018GENMASK_INPUT_CHECK\u2019
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
   ^~~~~~~~~~~~~~~~~~~
../drivers/crypto/inside-secure/safexcel.c:761:35: note: in expansion of macro \u2018GENMASK\u2019
   writel(EIP197_DxE_THR_CTRL_EN | GENMASK(priv->config.rings - 1, 0),
                                   ^~~~~~~

This happens when only l is const but h isn't.

Can we please just revert the original patch and work this out in
the next release?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
