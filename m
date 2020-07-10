Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A136A21AF8E
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 08:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGJGjN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 02:39:13 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38310 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgGJGjN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jul 2020 02:39:13 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jtmgN-0006JT-Ro; Fri, 10 Jul 2020 16:38:52 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Jul 2020 16:38:51 +1000
Date:   Fri, 10 Jul 2020 16:38:51 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v4 1/2] linux/bits.h: fix unsigned less than zero warnings
Message-ID: <20200710063851.GA2056@gondor.apana.org.au>
References: <20200621054210.14804-1-rikard.falkeborn@gmail.com>
 <20200709123011.GA18734@gondor.apana.org.au>
 <CAHk-=wibAAcH2+hk+X9mBp0h1B6oYv+Pjzq1XB+EXJhgshu-Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wibAAcH2+hk+X9mBp0h1B6oYv+Pjzq1XB+EXJhgshu-Xg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 09, 2020 at 11:13:31AM -0700, Linus Torvalds wrote:
> On Thu, Jul 9, 2020 at 5:30 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > I'm still getting the same warning even with the patch, for example:
> 
> Are you building with W=1?
> 
> There's a patch to move that broken -Wtype-limits thing to W=2.
> 
>     https://lore.kernel.org/lkml/20200708190756.16810-1-rikard.falkeborn@gmail.com/
> 
> does that work for you?

Yes that should work too.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
