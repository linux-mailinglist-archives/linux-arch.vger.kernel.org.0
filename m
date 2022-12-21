Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9E36533BA
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 16:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiLUP4q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 10:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUP4p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 10:56:45 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C9C13CF5;
        Wed, 21 Dec 2022 07:56:43 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id d2-20020a4ab202000000b004ae3035538bso1872886ooo.12;
        Wed, 21 Dec 2022 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vv0eZSneDp0SLp7Btx1IWgdM0JrFkFQy9T5wmXmOXbY=;
        b=DuW8x9Y5t1Crs5QX21m6OBOsKSxhMa4yKtSHmZcNqp8jAYNR10vCi0tmDKYG0NRauM
         PnZOndqyQSWrWE/Lb/88mC8V2KypgmZd1qXZxm+bgA9UExBJsALd3IQ3QR8M9UMSEuur
         tMn99CSDwAh5+lDVMnahtshm7q1baOKMMuDPR+t26vsQbDtfmvi97ZjR49mcmjyeWPwL
         2kL03tXCSlLAOUwjTRU4DGpdFJ84aYf2dG5WsNUWfl5fPk6m4LBT9FyFoque8z58MOHD
         lBusY4dEnqqIBjR1+GoZg7U/ARC1PtHQy8h+f9/KbGDuopQW8zm+gZo9/DLE8WdOP2Xw
         kEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vv0eZSneDp0SLp7Btx1IWgdM0JrFkFQy9T5wmXmOXbY=;
        b=QxOW2+a/jWSWK4zmWb25Gz4guog8R1FfD1TpmZc6WDMP4C0tZzf7leriIiGsJYtF+y
         o9d25b5fi2QKktJEHdSt/3pzmC70EIFs4KhxrKPsf6WwT6r2FjhrO8HGDRvBf/xFdxZN
         JxdOWGylBhc++quzKx5RrbnsvrzdMlBavhWlDZpkBi/rppboA/48Y5xdKLrVAy8eNmAh
         zmXXyfyzdM27KbzrXm8oNBBTeAzApBuX86JIvJzOSUugDGsXgPTy+CothzI15ox//Nfa
         69OR6UucfbwpnzmHIyvKME2nPw0W4PHFriaKZ4tEeOb7VwIxt6KNKDUN4WllqNJTZqvt
         dsEQ==
X-Gm-Message-State: AFqh2kqyffnau+eR5k9H70z3mdiiJodD4fyCLDDC7VdO1SVaETbvrolM
        FrYseHCIKo/LAtOMy0m0KzEtKXxIjfg=
X-Google-Smtp-Source: AMrXdXuA4YG9xBb2H/3Eu2o7oLrUDR9Hm6jdi+Ur2KHrWqSKnErxfuVjuQRVztL+tv8W1C1oNj78sw==
X-Received: by 2002:a4a:e38c:0:b0:4a4:309c:12ff with SMTP id l12-20020a4ae38c000000b004a4309c12ffmr1179450oov.4.1671638203281;
        Wed, 21 Dec 2022 07:56:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i8-20020a056820012800b004a0aac2d28fsm6226062ood.35.2022.12.21.07.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 07:56:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Dec 2022 07:56:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
Message-ID: <20221221155641.GB2468105@roeck-us.net>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net>
 <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
 <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 21, 2022 at 04:29:11PM +0100, Rasmus Villemoes wrote:
> On 21/12/2022 16.05, Geert Uytterhoeven wrote:
> > Hi Günter,
> > 
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
> 

The above assumes an unsigned char as input to strcmp(). I consider that
a hypothetical problem because "comparing" strings with upper bits
set doesn't really make sense in practice (How does one compare Günter
against Gunter ? And how about Gǖnter ?). On the other side, the problem
observed here is real and immediate.

Guenter
