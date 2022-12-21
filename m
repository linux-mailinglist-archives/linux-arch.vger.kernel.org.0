Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8E665331C
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 16:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLUPXG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 10:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLUPXF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 10:23:05 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8018022299;
        Wed, 21 Dec 2022 07:23:04 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so19526063fac.2;
        Wed, 21 Dec 2022 07:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vAbeixt0uJZ/ZtL8e7tbr2BILgwudnmu8+lBsU8ZDYM=;
        b=Ws4TLLPl33Vj1O35MNzOh4l13iO+hsE9JYHKBYbr211PI1V6Uaa6//ZYGV4pl+KgcG
         MbaTROiSvSHcf/+ourGFKwJ1F/1PzSI6yD8TFMj9+cQiwzdqYDfIFm2Mgdq6TAHzWgmO
         2GGOP+NRUtX7OpoYsCKU6tRJoOjYDeCppvj2QGpIZKdDal11EJRJRO0mMGCosG+BL/re
         eTY5xJNhhA21szPCW7/AHSKTpcZ2cnV+b0RbWKUn6NLajMepf0PiXH+bbCzD4SecF9VS
         6ESg5yZ4GM/q3tccWS8ZygdyWi9cRBoDS4JhgQdn+iyX0Q6y/oAWvDoXT6QzlEmu/3+W
         I/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vAbeixt0uJZ/ZtL8e7tbr2BILgwudnmu8+lBsU8ZDYM=;
        b=Idw8gi7LI50Rskrk67QDLNF1AYlfEJhCrN6IK4YpxQ/Tk1QMlhsEU2RpHO5Ea98gtu
         t7MMLec3pola0b1BPTqjIzJ/LWG2eMnrCthImax25UsPVY1/wsjyOm1M5sLDu1uXNS+Q
         R+iwB2yghtYLShpSzUzmuiH9jctDqhM+UUpO+3Y9expPE9gb5azb0vJ+YgHWGNczbL6/
         RUT8u/013Vp9yiACJxSoz2YJm+j6AT8erodHyiN89MqkU3NlOhg7FNJbGSOzKWogDivt
         gpQ3IUMd4OrqRf+NZqLRyJI1t51eToGeyu+yGasxxwwxnLY39r4tgyBgVLjSXEaRpQT6
         lgLw==
X-Gm-Message-State: AFqh2kpWyrhU+hXJlOCMCgSjgkUwVIVyAjMyUk2xMkmAAM4n51sn6XXP
        Br+KPt0mz1Lm4LLDCFaDvE8=
X-Google-Smtp-Source: AMrXdXuTsEv4ix+ZalG/Z+Z5KogVxyFAECJzI4TEWTexW9Ik7j44XI6yHc6KfaohVsLi7zMLgRyx0A==
X-Received: by 2002:a05:6870:f699:b0:148:41a7:eb35 with SMTP id el25-20020a056870f69900b0014841a7eb35mr7708587oab.12.1671636182930;
        Wed, 21 Dec 2022 07:23:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h21-20020a4abb95000000b0049f8b4b2095sm6195278oop.44.2022.12.21.07.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 07:23:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Dec 2022 07:23:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
Message-ID: <20221221152300.GA2468105@roeck-us.net>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net>
 <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
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

On Wed, Dec 21, 2022 at 04:05:45PM +0100, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Wed, Dec 21, 2022 at 3:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Wed, Oct 19, 2022 at 02:30:34PM -0600, Jason A. Donenfeld wrote:
> > > Recently, some compile-time checking I added to the clamp_t family of
> > > functions triggered a build error when a poorly written driver was
> > > compiled on ARM, because the driver assumed that the naked `char` type
> > > is signed, but ARM treats it as unsigned, and the C standard says it's
> > > architecture-dependent.
> > >
> > > I doubt this particular driver is the only instance in which
> > > unsuspecting authors make assumptions about `char` with no `signed` or
> > > `unsigned` specifier. We were lucky enough this time that that driver
> > > used `clamp_t(char, negative_value, positive_value)`, so the new
> > > checking code found it, and I've sent a patch to fix it, but there are
> > > likely other places lurking that won't be so easily unearthed.
> > >
> > > So let's just eliminate this particular variety of heisensign bugs
> > > entirely. Set `-funsigned-char` globally, so that gcc makes the type
> > > unsigned on all architectures.
> > >
> > > This will break things in some places and fix things in others, so this
> > > will likely cause a bit of churn while reconciling the type misuse.
> > >
> >
> > There is an interesting fallout: When running the m68k:q800 qemu emulation,
> > there are lots of warning backtraces.
> >
> > WARNING: CPU: 0 PID: 23 at crypto/testmgr.c:5724 alg_test.part.0+0x7c/0x326
> > testmgr: alg_test_descs entries in wrong order: 'adiantum(xchacha12,aes)' before 'adiantum(xchacha20,aes)'
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 23 at crypto/testmgr.c:5724 alg_test.part.0+0x7c/0x326
> > testmgr: alg_test_descs entries in wrong order: 'adiantum(xchacha20,aes)' before 'aegis128'
> >
> > and so on for pretty much every entry in the alg_test_descs[] array.
> >
> > Bisect points to this patch, and reverting it fixes the problem.
> >
> > It looks like the problem is that arch/m68k/include/asm/string.h
> > uses "char res" to store the result of strcmp(), and char is now
> > unsigned - meaning strcmp() will now never return a value < 0.
> > Effectively that means that strcmp() is broken on m68k if
> > CONFIG_COLDFIRE=n.
> >
> > The fix is probably quite simple.
> >
> > diff --git a/arch/m68k/include/asm/string.h b/arch/m68k/include/asm/string.h
> > index f759d944c449..b8f4ae19e8f6 100644
> > --- a/arch/m68k/include/asm/string.h
> > +++ b/arch/m68k/include/asm/string.h
> > @@ -42,7 +42,7 @@ static inline char *strncpy(char *dest, const char *src, size_t n)
> >  #define __HAVE_ARCH_STRCMP
> >  static inline int strcmp(const char *cs, const char *ct)
> >  {
> > -       char res;
> > +       signed char res;
> >
> >         asm ("\n"
> >                 "1:     move.b  (%0)+,%2\n"     /* get *cs */
> >
> > Does that make sense ? If so I can send a patch.
> 
> Thanks, been there, done that
> https://lore.kernel.org/all/bce014e60d7b1a3d1c60009fc3572e2f72591f21.1671110959.git.geert@linux-m68k.org
> 
> Note that we detected other issues with the m68k strcmp(), so
> probably that patch wouldn't go in as-is.
> 

So anything non-Coldfire is and will remain broken on m68k for the time
being ? Wouldn't it be better to fix the acute problem now and address
the long-standing problem(s) separately ? 

Thanks,
Guenter
