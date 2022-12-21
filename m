Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57858653473
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 17:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiLUQ52 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 11:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLUQ51 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 11:57:27 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEF5108;
        Wed, 21 Dec 2022 08:57:25 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id u10so10711449qvp.4;
        Wed, 21 Dec 2022 08:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JoTtGMDsWdhoDasCfRf0mfD1bZkJ5FH2D/JtOhme8+M=;
        b=IZFbaP0Yp+O1xom7BinCoKENWhFqesOCL5efyxG+mQDoFVPLpver6wgzXxur0ouCsI
         JxLMSXkzKr0MOWmFErixcWqNTbv31AzcR7BtHMSw69ind4kmb+TfPwwWdc2V/4Z11xun
         5huGtcLXsUAbIBNebX/CYSnq4tLo2r4v40VA6YEfX/xF+i2OBmWOv+OdTKWyJhbg1dV8
         VXBEkWvvzWeT3GdxA09ishcrj9y+G0Ee90Fvy31guQi12bF2NYIHEQqDursbby15KkVz
         fFEdUC7MRvcYbq/049KcZJ48KmLjY79CuTK1OnAYUTBqcgO65ocJkgNgmZJ3grWQMkHw
         9frg==
X-Gm-Message-State: AFqh2kpsvq6l7igLDIp2tWeIBJOFoD7ivWXDiZV39KSkdDqpi/j82daa
        cgc2XCs1BOaHXYzIhzDewBb8tzDs+iexHw==
X-Google-Smtp-Source: AMrXdXtbNBnIQwYhqMihVNE0MbHGsR8L1Cbu7ZRipnl+ds0XQrWsLjeD5Ld4pSCEkQKzGlLvmWTa2A==
X-Received: by 2002:a0c:f941:0:b0:4c7:7878:e54a with SMTP id i1-20020a0cf941000000b004c77878e54amr3355130qvo.24.1671641843990;
        Wed, 21 Dec 2022 08:57:23 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a430500b006ff8ac9acfdsm11262138qko.49.2022.12.21.08.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 08:57:23 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3b48b139b46so218897917b3.12;
        Wed, 21 Dec 2022 08:57:23 -0800 (PST)
X-Received: by 2002:a81:a101:0:b0:3e5:f2ca:7be8 with SMTP id
 y1-20020a81a101000000b003e5f2ca7be8mr295673ywg.358.1671641843155; Wed, 21 Dec
 2022 08:57:23 -0800 (PST)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net> <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
 <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk>
In-Reply-To: <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Dec 2022 17:57:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU7-01YhJ2H=7rmWvUjcnW_piy1p0ciYeaKTX8wDCW5Lg@mail.gmail.com>
Message-ID: <CAMuHMdU7-01YhJ2H=7rmWvUjcnW_piy1p0ciYeaKTX8wDCW5Lg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Rasmus,

On Wed, Dec 21, 2022 at 4:29 PM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
> On 21/12/2022 16.05, Geert Uytterhoeven wrote:
> > On Wed, Dec 21, 2022 at 3:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >> On Wed, Oct 19, 2022 at 02:30:34PM -0600, Jason A. Donenfeld wrote:
> >>> Recently, some compile-time checking I added to the clamp_t family of
> >>> functions triggered a build error when a poorly written driver was
> >>> compiled on ARM, because the driver assumed that the naked `char` type
> >>> is signed, but ARM treats it as unsigned, and the C standard says it's
> >>> architecture-dependent.
> >>>
> >>> I doubt this particular driver is the only instance in which
> >>> unsuspecting authors make assumptions about `char` with no `signed` or
> >>> `unsigned` specifier. We were lucky enough this time that that driver
> >>> used `clamp_t(char, negative_value, positive_value)`, so the new
> >>> checking code found it, and I've sent a patch to fix it, but there are
> >>> likely other places lurking that won't be so easily unearthed.
> >>>
> >>> So let's just eliminate this particular variety of heisensign bugs
> >>> entirely. Set `-funsigned-char` globally, so that gcc makes the type
> >>> unsigned on all architectures.
> >>>
> >>> This will break things in some places and fix things in others, so this
> >>> will likely cause a bit of churn while reconciling the type misuse.
> >>>
> >>
> >> There is an interesting fallout: When running the m68k:q800 qemu emulation,
> >> there are lots of warning backtraces.
> >>
> >> WARNING: CPU: 0 PID: 23 at crypto/testmgr.c:5724 alg_test.part.0+0x7c/0x326
> >> testmgr: alg_test_descs entries in wrong order: 'adiantum(xchacha12,aes)' before 'adiantum(xchacha20,aes)'
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 0 PID: 23 at crypto/testmgr.c:5724 alg_test.part.0+0x7c/0x326
> >> testmgr: alg_test_descs entries in wrong order: 'adiantum(xchacha20,aes)' before 'aegis128'
> >>
> >> and so on for pretty much every entry in the alg_test_descs[] array.
> >>
> >> Bisect points to this patch, and reverting it fixes the problem.
> >>
> >> It looks like the problem is that arch/m68k/include/asm/string.h
> >> uses "char res" to store the result of strcmp(), and char is now
> >> unsigned - meaning strcmp() will now never return a value < 0.
> >> Effectively that means that strcmp() is broken on m68k if
> >> CONFIG_COLDFIRE=n.
> >>
> >> The fix is probably quite simple.
> >>
> >> diff --git a/arch/m68k/include/asm/string.h b/arch/m68k/include/asm/string.h
> >> index f759d944c449..b8f4ae19e8f6 100644
> >> --- a/arch/m68k/include/asm/string.h
> >> +++ b/arch/m68k/include/asm/string.h
> >> @@ -42,7 +42,7 @@ static inline char *strncpy(char *dest, const char *src, size_t n)
> >>  #define __HAVE_ARCH_STRCMP
> >>  static inline int strcmp(const char *cs, const char *ct)
> >>  {
> >> -       char res;
> >> +       signed char res;
> >>
> >>         asm ("\n"
> >>                 "1:     move.b  (%0)+,%2\n"     /* get *cs */
> >>
> >> Does that make sense ? If so I can send a patch.
> >
> > Thanks, been there, done that
> > https://lore.kernel.org/all/bce014e60d7b1a3d1c60009fc3572e2f72591f21.1671110959.git.geert@linux-m68k.org
>
> Well, looks like that would still leave strcmp() buggy, you can't
> represent all possible differences between two char values (signed or
> not) in an 8-bit quantity. So any implementation based on returning the
> first non-zero value of *a - *b must store that intermediate value in
> something wider. Otherwise you'll get -128 from strcmp("\x40", "\xc0"),
> but _also_ -128 when you do strcmp("\xc0", "\x40"), which is obviously
> bogus.

So we have https://lore.kernel.org/all/87bko3ia88.fsf@igel.home ;-)

And the other issue is m68k strcmp() calls being dropped by the
optimizer, cfr. the discussion in
https://lore.kernel.org/all/b673f98db7d14d53a6e1a1957ef81741@AcuMS.aculab.com

> I recently fixed that long-standing bug in U-Boot's strcmp() and a
> similar one in nolibc in the linux tree. I wonder how many more
> instances exist.

Thanks, commit fb63362c63c7aeac ("lib: fix buggy strcmp and strncmp") in
v2023.01-rc1, which is not yet in a released version.
(and in plain C, not in asm ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
