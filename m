Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5497551839
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 14:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbiFTMHr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 08:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbiFTMHo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 08:07:44 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07672BD9;
        Mon, 20 Jun 2022 05:07:41 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id i17so8889698qvo.13;
        Mon, 20 Jun 2022 05:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHEiLoE3snLtuRhA2iQpp+77mHRn3s1DhVsEbxED6Ng=;
        b=mqVdwcKhOoNlnM/OgcmuPxZH7pT9JRat8DzPe3ajvvtU/1pfhrp84NF76T4RlMf5ex
         B/jH4VkgjhkLyl3UZ0BWIrIUAT8ki1zlWaO1wFPMi9WIx1XtYXhJ8xzGjCDZY/1DEyo4
         S+9gwSB0Y0T5WET7A7WfR+xWKUbPMjSBKIVy+7el31gIXGBgEv1rWZCAVwCQq7e2MmCt
         a32rliHONMsztS/flevXaZECivB6BGlNQddacaHzcxwDIMsoxTYG8XJunhz1HfpRE0T2
         SlVpG7+667Gqjn7uaRb0hfzBKR/ahfsKk4QUuGZjRMw07VBCKQBlGO8PqGTWtexEC9eT
         ZYOw==
X-Gm-Message-State: AJIora+YczagJcFL4bbpRNvAukFRc6G58cBJhdwrCX1FMW6JjP8s2zRH
        d3jn3rJT+HQFgE+6KCXsOrl1Vv+YI1mFNw==
X-Google-Smtp-Source: AGRyM1sxY8J84gWBExAC631e+R5pR14Y7Iiqz6t9TwowbKFHY7GC+0FZAsN9pUl7A8zvHZnQf/xn/g==
X-Received: by 2002:a05:622a:1011:b0:304:fdc6:411b with SMTP id d17-20020a05622a101100b00304fdc6411bmr19237020qte.307.1655726859655;
        Mon, 20 Jun 2022 05:07:39 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id d26-20020ac8535a000000b00304ef46c06dsm10429721qto.57.2022.06.20.05.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 05:07:39 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-317a66d62dfso37386247b3.7;
        Mon, 20 Jun 2022 05:07:38 -0700 (PDT)
X-Received: by 2002:a81:2401:0:b0:317:ce48:cf95 with SMTP id
 k1-20020a812401000000b00317ce48cf95mr5997207ywk.502.1655726858487; Mon, 20
 Jun 2022 05:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220617144031.2549432-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220617144031.2549432-1-alexandr.lobakin@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Jun 2022 14:07:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXYmtTf=e++fArH4K=vUtRxFd6=toD8An5KxrkRDkkOwg@mail.gmail.com>
Message-ID: <CAMuHMdXYmtTf=e++fArH4K=vUtRxFd6=toD8An5KxrkRDkkOwg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] bitops: let optimize out non-atomic bitops on
 compile-time constants
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Olek,

On Fri, Jun 17, 2022 at 6:51 PM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
> While I was working on converting some structure fields from a fixed
> type to a bitmap, I started observing code size increase not only in
> places where the code works with the converted structure fields, but
> also where the converted vars were on the stack. That said, the
> following code:
>
>         DECLARE_BITMAP(foo, BITS_PER_LONG) = { }; // -> unsigned long foo[1];
>         unsigned long bar = BIT(BAR_BIT);
>         unsigned long baz = 0;
>
>         __set_bit(FOO_BIT, foo);
>         baz |= BIT(BAZ_BIT);
>
>         BUILD_BUG_ON(!__builtin_constant_p(test_bit(FOO_BIT, foo));
>         BUILD_BUG_ON(!__builtin_constant_p(bar & BAR_BIT));
>         BUILD_BUG_ON(!__builtin_constant_p(baz & BAZ_BIT));
>
> triggers the first assertion on x86_64, which means that the
> compiler is unable to evaluate it to a compile-time initializer
> when the architecture-specific bitop is used even if it's obvious.
> I found that this is due to that many architecture-specific
> non-atomic bitop implementations use inline asm or other hacks which
> are faster or more robust when working with "real" variables (i.e.
> fields from the structures etc.), but the compilers have no clue how
> to optimize them out when called on compile-time constants.
>
> So, in order to let the compiler optimize out such cases, expand the
> test_bit() and __*_bit() definitions with a compile-time condition
> check, so that they will pick the generic C non-atomic bitop
> implementations when all of the arguments passed are compile-time
> constants, which means that the result will be a compile-time
> constant as well and the compiler will produce more efficient and
> simple code in 100% cases (no changes when there's at least one
> non-compile-time-constant argument).
> The condition itself:
>
> if (
> __builtin_constant_p(nr) &&     /* <- bit position is constant */
> __builtin_constant_p(!!addr) && /* <- compiler knows bitmap addr is
>                                       always either NULL or not */
> addr &&                         /* <- bitmap addr is not NULL */
> __builtin_constant_p(*addr)     /* <- compiler knows the value of
>                                       the target bitmap */
> )
>         /* then pick the generic C variant
> else
>         /* old code path, arch-specific
>
> I also tried __is_constexpr() as suggested by Andy, but it was
> always returning 0 ('not a constant') for the 2,3 and 4th
> conditions.
>
> The savings are architecture, compiler and compiler flags dependent,
> for example, on x86_64 -O2:
>
> GCC 12: add/remove: 78/29 grow/shrink: 332/525 up/down: 31325/-61560 (-30235)
> LLVM 13: add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)
> LLVM 14: add/remove: 10/3 grow/shrink: 93/138 up/down: 3705/-6992 (-3287)
>
> and ARM64 (courtesy of Mark[0]):
>
> GCC 11: add/remove: 92/29 grow/shrink: 933/2766 up/down: 39340/-82580 (-43240)
> LLVM 14: add/remove: 21/11 grow/shrink: 620/651 up/down: 12060/-15824 (-3764)
>
> And the following:
>
>         DECLARE_BITMAP(flags, __IP_TUNNEL_FLAG_NUM) = { };
>         __be16 flags;
>
>         __set_bit(IP_TUNNEL_CSUM_BIT, flags);
>
>         tun_flags = cpu_to_be16(*flags & U16_MAX);
>
>         if (test_bit(IP_TUNNEL_VTI_BIT, flags))
>                 tun_flags |= VTI_ISVTI;
>
>         BUILD_BUG_ON(!__builtin_constant_p(tun_flags));
>
> doesn't blow up anymore (which is being checked now at build time),
> so that we can now e.g. use fixed bitmaps in compile-time assertions
> etc.
>
> The series has been in intel-next for a while with no reported issues.
>
> From v2[1]:
> * collect several Reviewed-bys (Andy, Yury);
> * add a comment to generic_test_bit() that it is atomic-safe and
>   must always stay like that (the first version of this series
>   errorneously tried to change this) (Andy, Marco);
> * unify the way how architectures define platform-specific bitops,
>   both supporting instrumentation and not: now they define only
>   'arch_' versions and asm-generic includes take care of the rest;
> * micro-optimize the diffstat of 0004/0007 (__check_bitop_pr())
>   (Andy);
> * add compile-time tests to lib/test_bitmap to make sure everything
>   works as expected on any setup (Yury).

Thanks for the update!

Still seeing
add/remove: 49/13 grow/shrink: 280/137 up/down: 6464/-3328 (3136)

on m68k atari_defconfig (i.e.CONFIG_CC_OPTIMIZE_FOR_SIZE=y)
with gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
