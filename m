Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81855402B8
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jun 2022 17:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245638AbiFGPtL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jun 2022 11:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiFGPtK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jun 2022 11:49:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C9CF33A0;
        Tue,  7 Jun 2022 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654616945; x=1686152945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MXX2ICA24DJPqQzW39/5fG5pFbojGgZxe/8CqlkXkBI=;
  b=PkhJnhqps2uB12NK+cyc0/ShuH7ez432ZaLpkBXO0I5s4vswn8TxVY82
   hs82WehNFHGtgZ9mhZhPByI9SuPgaRNivDY0qhirO0nE9tC5N4TfJ+ZYn
   3SjIm5oaodeV4MXbLKDyfWjG/TqC4/3RkE/tWZPUVYHUUUqEqZ2mSZqYP
   cO5EiO8vm6igOCSUP+2SZsO7tsvznQg9L/iSrT+090k1NFtL95etiZ6L9
   HEDec69s2sAJOBq+o1SBaqGKHj5j8pEK+PEx//luekBy7yIUiPpjLImnh
   PuikC4MNVLM0etHaq7Q2HfCNrHWfHw6tz4IueY1nXVpL3BKuzZUthHvXm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="276767769"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="276767769"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 08:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="648084807"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jun 2022 08:48:59 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 257FmwHR030702;
        Tue, 7 Jun 2022 16:48:58 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] bitops: let optimize out non-atomic bitops on compile-time constants
Date:   Tue,  7 Jun 2022 17:47:59 +0200
Message-Id: <20220607154759.43549-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAMuHMdXR0Nu+RENB8rFnJFiW=T0P7Kq_XAG7t1MF=fdyD6pUGw@mail.gmail.com>
References: <20220606114908.962562-1-alexandr.lobakin@intel.com> <CAMuHMdXR0Nu+RENB8rFnJFiW=T0P7Kq_XAG7t1MF=fdyD6pUGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Jun 2022 14:45:41 +0200

> Hi Alexander,

Hi!

> 
> On Mon, Jun 6, 2022 at 1:50 PM Alexander Lobakin
> <alexandr.lobakin@intel.com> wrote:
> > While I was working on converting some structure fields from a fixed
> > type to a bitmap, I started observing code size increase not only in
> > places where the code works with the converted structure fields, but
> > also where the converted vars were on the stack. That said, the
> > following code:
> >
> >         DECLARE_BITMAP(foo, BITS_PER_LONG) = { }; // -> unsigned long foo[1];
> >         unsigned long bar = BIT(BAR_BIT);
> >         unsigned long baz = 0;
> >
> >         __set_bit(FOO_BIT, foo);
> >         baz |= BIT(BAZ_BIT);
> >
> >         BUILD_BUG_ON(!__builtin_constant_p(test_bit(FOO_BIT, foo));
> >         BUILD_BUG_ON(!__builtin_constant_p(bar & BAR_BIT));
> >         BUILD_BUG_ON(!__builtin_constant_p(baz & BAZ_BIT));
> >
> > triggers the first assertion on x86_64, which means that the
> > compiler is unable to evaluate it to a compile-time initializer
> > when the architecture-specific bitop is used even if it's obvious.
> > I found that this is due to that many architecture-specific
> > non-atomic bitop implementations use inline asm or other hacks which
> > are faster or more robust when working with "real" variables (i.e.
> > fields from the structures etc.), but the compilers have no clue how
> > to optimize them out when called on compile-time constants.
> >
> > So, in order to let the compiler optimize out such cases, expand the
> > test_bit() and __*_bit() definitions with a compile-time condition
> > check, so that they will pick the generic C non-atomic bitop
> > implementations when all of the arguments passed are compile-time
> > constants, which means that the result will be a compile-time
> > constant as well and the compiler will produce more efficient and
> > simple code in 100% cases (no changes when there's at least one
> > non-compile-time-constant argument).
> > The condition itself:
> >
> > if (
> > __builtin_constant_p(nr) &&     /* <- bit position is constant */
> > __builtin_constant_p(!!addr) && /* <- compiler knows bitmap addr is
> >                                       always either NULL or not */
> > addr &&                         /* <- bitmap addr is not NULL */
> > __builtin_constant_p(*addr)     /* <- compiler knows the value of
> >                                       the target bitmap */
> > )
> >         /* then pick the generic C variant
> > else
> >         /* old code path, arch-specific
> >
> > I also tried __is_constexpr() as suggested by Andy, but it was
> > always returning 0 ('not a constant') for the 2,3 and 4th
> > conditions.
> >
> > The savings on x86_64 with LLVM are insane (.text):
> >
> > $ scripts/bloat-o-meter -c vmlinux.{base,test}
> > add/remove: 72/75 grow/shrink: 182/518 up/down: 53925/-137810 (-83885)
> >
> > $ scripts/bloat-o-meter -c vmlinux.{base,mod}
> > add/remove: 7/1 grow/shrink: 1/19 up/down: 1135/-4082 (-2947)
> >
> > $ scripts/bloat-o-meter -c vmlinux.{base,all}
> > add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)
> 
> Thank you!
> 
> I gave it a try on m68k, and am a bit disappointed seeing an increase
> in code size:
> 
>     add/remove: 49/13 grow/shrink: 279/138 up/down: 6434/-3342 (3092)

Ufff, that sucks =\
Could you please try to compile the following code snippet (with the
series applied)?

	unsigned long map;

	bitmap_zero(&map, BITS_PER_LONG);
	__set_bit(1, &map);
	BUILD_BUG_ON(!__builtin_constant_p(map));

If it fails during the vmlinux linkage, it will mean that on your
architecture/setup the compiler is unable to optimize the generic
implementations to compile-time constants and I'll need to debug
this more (probably via some compiler explorer).
You could also check the vmlinux size after applying each patch
to see which one does this if you feel like it :)

> 
> This is atari_defconfig on a tree based on v5.19-rc1, with
> m68k-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU
> Binutils for Ubuntu) 2.34).
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

Thanks,
Olek
