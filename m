Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BC36559B7
	for <lists+linux-arch@lfdr.de>; Sat, 24 Dec 2022 10:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiLXJsK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Dec 2022 04:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLXJsK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Dec 2022 04:48:10 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B810111A0B;
        Sat, 24 Dec 2022 01:48:08 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id bp44so2761937qtb.0;
        Sat, 24 Dec 2022 01:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHi3u0HawEEc5/OGkXGO0UddJLW+vqFAqayF1+b6YOw=;
        b=wVVy0EU2szgYyQ2r62Ys3Je+GoYcqe8MKI5dirDC8+6b6TP4O1kkRpffsOT5ouyRJ4
         xA5K7U0ro0yFb22uppmhBufqPiXDBl6loYNbG6c9EE0CFcqzQI0GOmm/ckTRgA2dw+V1
         Zh0L97+NhocpfCxbpXjT6Y9im2tEBKJT9cC2q0+aJ5IJx8fzy5tofn8HD0pZBUBb0G8K
         24wzSn1qV3T6/Mf2RNUTxQn7PxEzzKdDv133lEfht/mCjWJtkXCmZ9nxcMdMksc6VS2b
         92Su4vFf9JMO9TPsDQ1epXweFhX0j63z2+nOjpC7r9Qomm6GQQhVCOvtmE+DrdgoJ7DH
         VUsg==
X-Gm-Message-State: AFqh2kqMEzusOIUX5GNryRaEMf8wS9lPtKiy8Jydt43LmRrGXXs8cxVZ
        Q/ewwvbg4h2bIhiFGkm5/fWec95lR46UTg==
X-Google-Smtp-Source: AMrXdXv9qfcyg8MeSI2mNE6uWzS7kXIlKn/UPdNQ+HGwjA8MFIe9p/jH1hy0WSP6bCh9dUEbuXmbwg==
X-Received: by 2002:ac8:5403:0:b0:3a6:9b7f:9da7 with SMTP id b3-20020ac85403000000b003a69b7f9da7mr16233098qtq.59.1671875287656;
        Sat, 24 Dec 2022 01:48:07 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id bq38-20020a05620a46a600b00704c9015e68sm3539338qkb.116.2022.12.24.01.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 01:48:06 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id j206so7477893ybj.1;
        Sat, 24 Dec 2022 01:48:06 -0800 (PST)
X-Received: by 2002:a25:d103:0:b0:75d:3ecb:1967 with SMTP id
 i3-20020a25d103000000b0075d3ecb1967mr1000944ybg.604.1671875286069; Sat, 24
 Dec 2022 01:48:06 -0800 (PST)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net> <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
 <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk> <20221221155641.GB2468105@roeck-us.net>
 <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
 <b2144334261246aa8dc5004c5f1a58c9@AcuMS.aculab.com> <f02e0ac7f2d805020a7ba66803aaff3e31b5eeff.camel@t-online.de>
In-Reply-To: <f02e0ac7f2d805020a7ba66803aaff3e31b5eeff.camel@t-online.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 24 Dec 2022 10:47:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUzjvw3t4Q8YaGS=j+WP9Bz6NgK=di7jLXL3fHGuOZcEw@mail.gmail.com>
Message-ID: <CAMuHMdUzjvw3t4Q8YaGS=j+WP9Bz6NgK=di7jLXL3fHGuOZcEw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
To:     Holger Lubitz <holger.lubitz@t-online.de>
Cc:     David Laight <David.Laight@aculab.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Holger,

On Sat, Dec 24, 2022 at 10:34 AM Holger Lubitz
<holger.lubitz@t-online.de> wrote:
> On Thu, 2022-12-22 at 10:41 +0000, David Laight wrote:
> > I wonder how much slower it is - m68k is likely to be microcoded
> > and I don't think instruction timings are actually available.
>
> Not sure if these are in any way official, but
> http://oldwww.nvg.ntnu.no/amiga/MC680x0_Sections/mc68030timing.HTML
>
> (There's also
> http://oldwww.nvg.ntnu.no/amiga/MC680x0_Sections/mc68000timing.HTML
> but that is probably only interesting to demo coders by now)

Yes, instruction timings are available.  Unlike for e.g. x86, there
is only a very limited number of parts to consider.

> > I believe some of the other m68k asm functions are also missing
> > the "memory" 'clobber' and so could get mis-optimised.
>
> In which case would that happen? This function doesn't clobber memory
> and its result does get used. If gcc mistakenly thinks the parameters
> haven't changed and uses a previously cached result, wouldn't that
> apply to a C function too?

For a pure C inline function, the compiler knows exactly what it does.

For an external C function, the compiler assumes all odds are off.

For inline asm, the compiler doesn't know what happens with (the data
pointed to by) the pointers, unless that's described in the constraints.
We do have some inline asm that has "*ptr" in the constraints, but
that applies to a single value, not to an array.  And in case of
strings, the size of the array is not known without looking for the
zero-terminator.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
