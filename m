Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B1F6532DD
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 16:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiLUPGF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 21 Dec 2022 10:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiLUPGC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 10:06:02 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D4422B00;
        Wed, 21 Dec 2022 07:05:59 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id c129so13593470oia.0;
        Wed, 21 Dec 2022 07:05:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yj6ecE1seybneSNIZzP9X59LvQcDEHmDvmMWmc3xsY=;
        b=hCxB7QPtSXOBbkev+66nYzRIve4WlGFwrSwvqMhkugCrV7tWa39BKfOjiz4WIKAc0y
         nrsB/BbdUBFi6uLHVwYPDxG38oZkSeZfcu/PAHnR1KmOurw9qb6Ej76iq4P4/Rq/EWID
         68VSkRg4ehgnENmZBipRng24oRuq+v8Xl/MKNA8YB2LsFu92KsEXfm6LqQiJ/TXOz5JH
         hrde0B15jUkAp0ux5jjfEQ0DKZ/r6utA56MKZI0N6YhM9bNWKD1rso6diN7DFwWLX+ap
         6jC0tQFjd+iKZ7SogcTAGMfa6vd9/LfRpWETWPvTYFcadQothbd0EDCm9A/aCZazLe/z
         kFKw==
X-Gm-Message-State: AFqh2kqz/OyIdp3WfekGwAZRmxuqX9kIi94mX3xhW1wXTFozoQZG4p+T
        H2Q9E0lIu+pHrVQtAy0PnFUf1tOJL0pD+g==
X-Google-Smtp-Source: AMrXdXuxjzF4z34Baylsn49f+1ycVQOPAPKI7iKJGRPEQXwYroJ0CCRakh0sU4YARfyXpf9M8pMFPQ==
X-Received: by 2002:a54:4792:0:b0:35a:dea7:f996 with SMTP id o18-20020a544792000000b0035adea7f996mr818576oic.56.1671635159015;
        Wed, 21 Dec 2022 07:05:59 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id k8-20020a05620a414800b006fc8fc061f7sm11115560qko.129.2022.12.21.07.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 07:05:58 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-43ea87d0797so186835717b3.5;
        Wed, 21 Dec 2022 07:05:58 -0800 (PST)
X-Received: by 2002:a81:a101:0:b0:3e5:f2ca:7be8 with SMTP id
 y1-20020a81a101000000b003e5f2ca7be8mr251733ywg.358.1671635157948; Wed, 21 Dec
 2022 07:05:57 -0800 (PST)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net>
In-Reply-To: <20221221145332.GA2399037@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Dec 2022 16:05:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
Message-ID: <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Günter,

On Wed, Dec 21, 2022 at 3:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Oct 19, 2022 at 02:30:34PM -0600, Jason A. Donenfeld wrote:
> > Recently, some compile-time checking I added to the clamp_t family of
> > functions triggered a build error when a poorly written driver was
> > compiled on ARM, because the driver assumed that the naked `char` type
> > is signed, but ARM treats it as unsigned, and the C standard says it's
> > architecture-dependent.
> >
> > I doubt this particular driver is the only instance in which
> > unsuspecting authors make assumptions about `char` with no `signed` or
> > `unsigned` specifier. We were lucky enough this time that that driver
> > used `clamp_t(char, negative_value, positive_value)`, so the new
> > checking code found it, and I've sent a patch to fix it, but there are
> > likely other places lurking that won't be so easily unearthed.
> >
> > So let's just eliminate this particular variety of heisensign bugs
> > entirely. Set `-funsigned-char` globally, so that gcc makes the type
> > unsigned on all architectures.
> >
> > This will break things in some places and fix things in others, so this
> > will likely cause a bit of churn while reconciling the type misuse.
> >
>
> There is an interesting fallout: When running the m68k:q800 qemu emulation,
> there are lots of warning backtraces.
>
> WARNING: CPU: 0 PID: 23 at crypto/testmgr.c:5724 alg_test.part.0+0x7c/0x326
> testmgr: alg_test_descs entries in wrong order: 'adiantum(xchacha12,aes)' before 'adiantum(xchacha20,aes)'
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 23 at crypto/testmgr.c:5724 alg_test.part.0+0x7c/0x326
> testmgr: alg_test_descs entries in wrong order: 'adiantum(xchacha20,aes)' before 'aegis128'
>
> and so on for pretty much every entry in the alg_test_descs[] array.
>
> Bisect points to this patch, and reverting it fixes the problem.
>
> It looks like the problem is that arch/m68k/include/asm/string.h
> uses "char res" to store the result of strcmp(), and char is now
> unsigned - meaning strcmp() will now never return a value < 0.
> Effectively that means that strcmp() is broken on m68k if
> CONFIG_COLDFIRE=n.
>
> The fix is probably quite simple.
>
> diff --git a/arch/m68k/include/asm/string.h b/arch/m68k/include/asm/string.h
> index f759d944c449..b8f4ae19e8f6 100644
> --- a/arch/m68k/include/asm/string.h
> +++ b/arch/m68k/include/asm/string.h
> @@ -42,7 +42,7 @@ static inline char *strncpy(char *dest, const char *src, size_t n)
>  #define __HAVE_ARCH_STRCMP
>  static inline int strcmp(const char *cs, const char *ct)
>  {
> -       char res;
> +       signed char res;
>
>         asm ("\n"
>                 "1:     move.b  (%0)+,%2\n"     /* get *cs */
>
> Does that make sense ? If so I can send a patch.

Thanks, been there, done that
https://lore.kernel.org/all/bce014e60d7b1a3d1c60009fc3572e2f72591f21.1671110959.git.geert@linux-m68k.org

Note that we detected other issues with the m68k strcmp(), so
probably that patch wouldn't go in as-is.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
