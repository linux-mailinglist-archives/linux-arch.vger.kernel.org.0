Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB87549936
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 18:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiFMQkH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jun 2022 12:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiFMQjJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 12:39:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73DB1DF111;
        Mon, 13 Jun 2022 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655130497; x=1686666497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KP/RtJ4ZbidU6pQAsuDuxGJHOq1DZRgu4MLwVnb1vSc=;
  b=nZ4f2sDTG15jrz1DGLOnhQHXv3GhUXrvyz47ym57C/DAuKNt7wDDJ0Se
   3mE8LSmvW3SiDyFth8uXdNANq09zBAuCoOgjLdJJUiKsfKG1NtMEqCquY
   nYqHUtutoc5XrVutVvFOyshKO4JgjkA5XFWO3YSlFi2gAf67tsEltOHUN
   duLUeSdv2TbTx6amjXiBl0UKruQtKhj18TsVACiZ+wQ5iMjaqrvnb2Aup
   RliFsKqg11hMzvijo5XML9KuoVYmHkYKVcRBXohqEad+jVWjII1p/8t/m
   Ps+PBQIzFVQS7Wv8C/+uKjqiJOQkPt6S/UVilueZMfqJkw6C2zYFbtszk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303696222"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="303696222"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 07:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="651457890"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2022 07:28:06 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25DES5uk026148;
        Mon, 13 Jun 2022 15:28:05 +0100
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] bitops: let optimize out non-atomic bitops on compile-time constants
Date:   Mon, 13 Jun 2022 16:26:45 +0200
Message-Id: <20220613142645.1176423-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAMuHMdUZCaPN2B6bvmja9rDm3qCc4mYYAOSEB2W0R0pws8peqw@mail.gmail.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jun 2022 09:35:16 +0200

> Hi Alexander,
> 
> On Fri, Jun 10, 2022 at 1:35 PM Alexander Lobakin
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
> >         baz |=3D BIT(BAZ_BIT);
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
> > doesn't blow up anymore, so that we now can e.g. use fixed bitmaps
> > in compile-time assertions etc.
> >
> > The series has been in intel-next for a while with no reported issues.
> >
> > From v1[1]:
> > * change 'gen_' prefixes to '_generic' to disambiguate from
> >   'generated' etc. (Mark);
> > * define a separate 'const_' set to use in the optimization to keep
> >   the generic test_bit() atomic-safe (Marco);
> > * unify arch_{test,__*}_bit() as well and include them in the type
> >   check;
> > * add more relevant and up-to-date bloat-o-meter results, including
> >   ARM64 (me, Mark);
> > * pick a couple '*-by' tags (Mark, Yury).
> 
> Thanks for the update!
> 
> On m68k, using gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04), this
> blows up immediately with:

Yeah I saw the kernel bot report already, sorry for that >_< Fixed
in v3 already, will send in 1-2 days.

> 
>   CC      kernel/bounds.s
> In file included from include/linux/bits.h:22,

[...]

>       | ^~~~~~~~~~~~~~~~
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
