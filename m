Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D4F53FF3E
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jun 2022 14:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243705AbiFGMp5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jun 2022 08:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiFGMp4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jun 2022 08:45:56 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0615BA57E;
        Tue,  7 Jun 2022 05:45:55 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id x18so9622340qtj.3;
        Tue, 07 Jun 2022 05:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2nmQNF/3gAoxeluRHoOdJNgK2z7f54HL004Ai8ZD6Y=;
        b=nvlJP35dK6fzVenTGcn5fVTQPiAxqhAAmQjlM5E/aWtjtLDcdd32/CbcoXXGh2Svze
         en3BlAJ68ijudKmGO9563/qfoJ3VgHpQPFr8KDh6jQQTnNDzoCnt1IRHVW5WCONOfGiF
         36uA0AOE/ejN/5h3aTdq1HnFG0EaOq753a6FiiMbHduhNN78GJbP44zgdANCi/rnu3QW
         6xNiL/uvcBuw+InFTRJsAJJdvfhraWfSOGx9hBIn0CgUwRuVx7ain0i0ro6M+0mQ+I6O
         k55guthODwTO1s0c9WaWb9tRgK07gXqYsZ7fHQU+6ZsrIatM1KtsfPVzKGPD9BbqkKBE
         goLQ==
X-Gm-Message-State: AOAM53044sEYoZKmbZpplYoEh5ZD9tMP5CGy0gQht+HwmCwfdsYPKj8A
        j6mbxrrfK42gy30nTo0jI9DPn7b1Af74CA==
X-Google-Smtp-Source: ABdhPJwoUJONUmH15CvGDJ4nIRps/19uCnej5aHaxDnPaNbFotnN+olD5r1Cb/QjRlOcPV7PgQczXw==
X-Received: by 2002:ac8:7d4b:0:b0:2f3:e185:efd4 with SMTP id h11-20020ac87d4b000000b002f3e185efd4mr22271585qtb.392.1654605954579;
        Tue, 07 Jun 2022 05:45:54 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id i16-20020ac87650000000b00304e688189fsm5890153qtr.37.2022.06.07.05.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:45:53 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-300628e76f3so173779607b3.12;
        Tue, 07 Jun 2022 05:45:53 -0700 (PDT)
X-Received: by 2002:a81:4811:0:b0:30c:8021:4690 with SMTP id
 v17-20020a814811000000b0030c80214690mr31329554ywa.47.1654605952647; Tue, 07
 Jun 2022 05:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220606114908.962562-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220606114908.962562-1-alexandr.lobakin@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Jun 2022 14:45:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXR0Nu+RENB8rFnJFiW=T0P7Kq_XAG7t1MF=fdyD6pUGw@mail.gmail.com>
Message-ID: <CAMuHMdXR0Nu+RENB8rFnJFiW=T0P7Kq_XAG7t1MF=fdyD6pUGw@mail.gmail.com>
Subject: Re: [PATCH 0/6] bitops: let optimize out non-atomic bitops on
 compile-time constants
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

Hi Alexander,

On Mon, Jun 6, 2022 at 1:50 PM Alexander Lobakin
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
> The savings on x86_64 with LLVM are insane (.text):
>
> $ scripts/bloat-o-meter -c vmlinux.{base,test}
> add/remove: 72/75 grow/shrink: 182/518 up/down: 53925/-137810 (-83885)
>
> $ scripts/bloat-o-meter -c vmlinux.{base,mod}
> add/remove: 7/1 grow/shrink: 1/19 up/down: 1135/-4082 (-2947)
>
> $ scripts/bloat-o-meter -c vmlinux.{base,all}
> add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)

Thank you!

I gave it a try on m68k, and am a bit disappointed seeing an increase
in code size:

    add/remove: 49/13 grow/shrink: 279/138 up/down: 6434/-3342 (3092)

This is atari_defconfig on a tree based on v5.19-rc1, with
m68k-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU
Binutils for Ubuntu) 2.34).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
