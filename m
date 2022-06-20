Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72630551E4A
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 16:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349002AbiFTOBY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 10:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352967AbiFTN5V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 09:57:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B0437A1A;
        Mon, 20 Jun 2022 06:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655731392; x=1687267392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8KQlo1GaidK62joql7rVf5HOV1doJhcv4ni0UcMrcSg=;
  b=f2NPgY3X6sqcrC0EQ1hnOZ9NcLKh0IGmf/IcK3zraY9D7+5aB91fiDlO
   oEbT5jCu1hsPh2hUgRawP4E6YjbCg6/9d3DU3JHszCHocoF8oJOVIPZRT
   WLiidAjQavb5/mZ2LMSfviYs4uxdwOMSktWzf8R1rRVl6dRHh2HGClu57
   SQbQXl5rbyVoPkHoOptb00aeHBMV9L24NxsVdd5YumQ4J2YU4L/VfgR67
   t3LhFL8PgMK6esoyjQY7V3QKQyOYdT+24rA6gSiWEe+1mzn//t4OfjSeq
   B5t9ktYnkx9uFwTgK++1vjYTzngJtaiVfpd6su7ZL5peYvdQeP4r51xkS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279943101"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="279943101"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 06:22:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="676537059"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2022 06:22:30 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25KDMSqF029562;
        Mon, 20 Jun 2022 14:22:28 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] bitops: let optimize out non-atomic bitops on compile-time constants
Date:   Mon, 20 Jun 2022 15:22:17 +0200
Message-Id: <20220620132217.2628130-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAMuHMdXYmtTf=e++fArH4K=vUtRxFd6=toD8An5KxrkRDkkOwg@mail.gmail.com>
References: <20220617144031.2549432-1-alexandr.lobakin@intel.com> <CAMuHMdXYmtTf=e++fArH4K=vUtRxFd6=toD8An5KxrkRDkkOwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Jun 2022 14:07:27 +0200

> Hi Olek,

Hey!

> 
> On Fri, Jun 17, 2022 at 6:51 PM Alexander Lobakin
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
> > The savings are architecture, compiler and compiler flags dependent,
> > for example, on x86_64 -O2:
> >
> > GCC 12: add/remove: 78/29 grow/shrink: 332/525 up/down: 31325/-61560 (-30235)
> > LLVM 13: add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)
> > LLVM 14: add/remove: 10/3 grow/shrink: 93/138 up/down: 3705/-6992 (-3287)
> >
> > and ARM64 (courtesy of Mark[0]):
> >
> > GCC 11: add/remove: 92/29 grow/shrink: 933/2766 up/down: 39340/-82580 (-43240)
> > LLVM 14: add/remove: 21/11 grow/shrink: 620/651 up/down: 12060/-15824 (-3764)
> >
> > And the following:
> >
> >         DECLARE_BITMAP(flags, __IP_TUNNEL_FLAG_NUM) = { };
> >         __be16 flags;
> >
> >         __set_bit(IP_TUNNEL_CSUM_BIT, flags);
> >
> >         tun_flags = cpu_to_be16(*flags & U16_MAX);
> >
> >         if (test_bit(IP_TUNNEL_VTI_BIT, flags))
> >                 tun_flags |= VTI_ISVTI;
> >
> >         BUILD_BUG_ON(!__builtin_constant_p(tun_flags));
> >
> > doesn't blow up anymore (which is being checked now at build time),
> > so that we can now e.g. use fixed bitmaps in compile-time assertions
> > etc.
> >
> > The series has been in intel-next for a while with no reported issues.
> >
> > From v2[1]:
> > * collect several Reviewed-bys (Andy, Yury);
> > * add a comment to generic_test_bit() that it is atomic-safe and
> >   must always stay like that (the first version of this series
> >   errorneously tried to change this) (Andy, Marco);
> > * unify the way how architectures define platform-specific bitops,
> >   both supporting instrumentation and not: now they define only
> >   'arch_' versions and asm-generic includes take care of the rest;
> > * micro-optimize the diffstat of 0004/0007 (__check_bitop_pr())
> >   (Andy);
> > * add compile-time tests to lib/test_bitmap to make sure everything
> >   works as expected on any setup (Yury).
> 
> Thanks for the update!
> 
> Still seeing
> add/remove: 49/13 grow/shrink: 280/137 up/down: 6464/-3328 (3136)

Meh. What about -O2 (OPTIMIZE_FOR_PERFORMANCE)? I have a thought to
make it depend on the config option above, but that would make code
behave differently, so it's not safe.
Are those 3 Kb critical for m68k machines? I'm asking because for
some embedded systems they are :)
Another thing, this could happen due to inlining rebalance. E.g.
the compiler could inline or uninline some functions due to
resolving bit{maps,ops} to compile-time constants. I was seeing
such in the past several times. Also, IIRC you already sent some
bloat-o-meter results here, and that was the case.
On the other hand, if lib/test_bitmap.o builds successfully (I
assume it does), the series works as expected.

> 
> on m68k atari_defconfig (i.e.CONFIG_CC_OPTIMIZE_FOR_SIZE=y)
> with gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04).
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
