Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C744D50C5D4
	for <lists+linux-arch@lfdr.de>; Sat, 23 Apr 2022 02:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiDWA4G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Apr 2022 20:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiDWA4G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2022 20:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6C51738CA;
        Fri, 22 Apr 2022 17:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ECB860FBB;
        Sat, 23 Apr 2022 00:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80106C385A8;
        Sat, 23 Apr 2022 00:53:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="apuirUnw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650675185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BtroWoypB74RmLGCXy/EXj5t2W95zgqhXYB+W+c3LYE=;
        b=apuirUnwiClPZkngdFTOM+QfyFKtnvlwA/luZqphpx2jlS66JX3i7wtN4EjErQfzF+Wktq
        ULcCQOdPLrsKonuld9pW6IPmx9nMIzMW7PE9KuqHSJGOFnvd19RTov2l7N8+riDdxwSkTx
        A6j27PAa97zJfQyvB5+w6Yd/uXjGpFg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d8f036cc (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 23 Apr 2022 00:53:05 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2f7bb893309so21450917b3.12;
        Fri, 22 Apr 2022 17:53:03 -0700 (PDT)
X-Gm-Message-State: AOAM530iWDSISiRD3YBdkGykYJ/YnCGEUfI1ouUWPhL11sHhAKJKSFan
        JTgq/eVTPulaHhhsazS8WWseWBJtiltryO6zkFg=
X-Google-Smtp-Source: ABdhPJyfQC4xfW2/BqRv5HoqgN8AV6BTcIbuJH0uSB8n2Edr3sir/FlqIFAQgMkIMlNc41QBK/E+q+G0PIuXFxD7crQ=
X-Received: by 2002:a81:1d4:0:b0:2eb:1b10:f43e with SMTP id
 203-20020a8101d4000000b002eb1b10f43emr7705887ywb.100.1650675181900; Fri, 22
 Apr 2022 17:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162848.303601-1-Jason@zx2c4.com> <20220322155820.GA1745955@roeck-us.net>
 <YjoUU+8zrzB02pW7@sirena.org.uk> <0d20fb04-81b8-eeee-49ab-5b0a9e78c9f8@roeck-us.net>
 <YjsOHmvDgAxwLFMg@sirena.org.uk> <ebafdf77-5d96-556b-0197-a172b656bb01@roeck-us.net>
 <CAK8P3a1hzmXTTMsGcCA2ekEHnff+M7GrYSQDN4bVfVk6Ui=Apw@mail.gmail.com>
In-Reply-To: <CAK8P3a1hzmXTTMsGcCA2ekEHnff+M7GrYSQDN4bVfVk6Ui=Apw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 23 Apr 2022 02:52:51 +0200
X-Gmail-Original-Message-ID: <CAHmME9pMFMk6Uu1p4z9SzdAwg2q52FnH3fcsGXCK0OZod=YwLw@mail.gmail.com>
Message-ID: <CAHmME9pMFMk6Uu1p4z9SzdAwg2q52FnH3fcsGXCK0OZod=YwLw@mail.gmail.com>
Subject: Re: [PATCH v1] random: block in /dev/urandom
To:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Kinard <kumba@gentoo.org>,
        David Laight <David.Laight@aculab.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hey Arnd/Guenter,

On Wed, Mar 23, 2022 at 4:53 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Mar 23, 2022 at 3:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 3/23/22 05:10, Mark Brown wrote:
> > > On Tue, Mar 22, 2022 at 02:54:20PM -0700, Guenter Roeck wrote:
> > > Kind of academic given that Jason seems to have a handle on what the
> > > issues are but for KernelCI it's variations on mach-virt, plus
> > > versatile-pb.  There's a physical cubietruck as well, and BeagleBone
> > > Blacks among others.  My best guess would be systems with low RAM are
> > > somehow more prone to issues.
> >
> > I don't think it is entirely academic. versatile-pb fails for me;
> > if it doesn't fail at KernelCI, I'd like to understand why - not to
> > fix it in my test environment, but to make sure that I _don't_ fix it.
> > After all, it _is_ a regression. Even if that regression is triggered
> > by bad (for a given definition of "bad") userspace code, it is still
> > a regression.
>
> Maybe kernelci has a virtio-rng device assigned to the machine
> and you don't? That would clearly avoid the issue here.

Indeed it's probably something like that. Or maybe they're networked
with something that has a steady stream of interrupts. I say this
because I was able to reproduce Guenter's findings using the
versatilepb machine with the versatile_defconfig config and the
versatile-pb.dtb file. Indeed this board doesn't have a cycle counter.
However, I did have success using the fallback timer and the other
patches in the jd/for-guenter branch, so at least for versatile's
nuances, I think (hope?) there's a reasonable success story here.

Jason
