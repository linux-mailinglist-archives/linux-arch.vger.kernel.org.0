Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC22F50B8DD
	for <lists+linux-arch@lfdr.de>; Fri, 22 Apr 2022 15:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448119AbiDVNqE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Apr 2022 09:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiDVNqC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2022 09:46:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD34583BA;
        Fri, 22 Apr 2022 06:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26818620E2;
        Fri, 22 Apr 2022 13:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF18C385A9;
        Fri, 22 Apr 2022 13:43:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MlmeQg3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650634981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R42MnBKkf8h8aMzJ+cq5aRlVGTDAAdFMWhjGUtpnOIw=;
        b=MlmeQg3/JN/ztJlQabbkkw8Vcws4ZxrJJbHqrroh7rKqcWjE7Yc5bQnl0asaPf2cRPMJ3/
        rNMDBgiJF8qj2EuXsJ6s5DY2dEzRFJQMjR4qgjJPGD6+9ENYshkAhJUvQHiUxMX6HPh2DG
        hqGqpWH26uIs2yIJMZyE9VhEtJ9qHVE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83ceb0e7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 22 Apr 2022 13:43:01 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id r189so14556958ybr.6;
        Fri, 22 Apr 2022 06:43:00 -0700 (PDT)
X-Gm-Message-State: AOAM532kZN3KWlfpy0pTnJJTnPZShZYo6OnV6ncjJxkZ1tqgY9E+XC7X
        nNSRr6rwIv7kaggvgw06LQAZ6imzvwGzBcuRIG8=
X-Google-Smtp-Source: ABdhPJx9K/LQrXlpklM23ol0Z3JZyNOCdXqSd2EzOTmrZn2FBUeMKgXLI+QYgcW5HOkaYMQeJS5qVmG3QVbckVtLCVU=
X-Received: by 2002:a05:6902:154d:b0:644:b2e7:146 with SMTP id
 r13-20020a056902154d00b00644b2e70146mr4512095ybu.271.1650634978328; Fri, 22
 Apr 2022 06:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162848.303601-1-Jason@zx2c4.com> <20220322155820.GA1745955@roeck-us.net>
 <YjoC5kQMqyC/3L5Y@zx2c4.com> <d5c23f68-30ba-a5eb-6bea-501736e79c88@roeck-us.net>
In-Reply-To: <d5c23f68-30ba-a5eb-6bea-501736e79c88@roeck-us.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 22 Apr 2022 15:42:46 +0200
X-Gmail-Original-Message-ID: <CAHmME9rmeQAD2DwG=APTmDxuVxFDH=6GXoKpgPrU9rc9oXrmxQ@mail.gmail.com>
Message-ID: <CAHmME9rmeQAD2DwG=APTmDxuVxFDH=6GXoKpgPrU9rc9oXrmxQ@mail.gmail.com>
Subject: Re: [PATCH v1] random: block in /dev/urandom
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
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
        Arnd Bergmann <arnd@arndb.de>,
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
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hey Guenter,

On Tue, Mar 22, 2022 at 6:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/22/22 10:09, Jason A. Donenfeld wrote:
> > Hey Guenter,
> >
> > On Tue, Mar 22, 2022 at 08:58:20AM -0700, Guenter Roeck wrote:
> >> On Thu, Feb 17, 2022 at 05:28:48PM +0100, Jason A. Donenfeld wrote:
> >>> This topic has come up countless times, and usually doesn't go anywhere.
> >>> This time I thought I'd bring it up with a slightly narrower focus,
> >>> updated for some developments over the last three years: we finally can
> >>> make /dev/urandom always secure, in light of the fact that our RNG is
> >>> now always seeded.
> >>>
> >>
> >> [ ... ]
> >>
> >> This patch (or a later version of it) made it into mainline and causes a
> >> large number of qemu boot test failures for various architectures (arm,
> >> m68k, microblaze, sparc32, xtensa are the ones I observed). Common
> >> denominator is that boot hangs at "Saving random seed:". A sample bisect
> >> log is attached. Reverting this patch fixes the problem.
> >
> > As Linus said, it was worth a try, but I guess it just didn't work. For
> > my own curiosity, though, do you have a link to those QEMU VMs you could
> > share? I'd sort of like to poke around, and if we do ever reattempt this
> > sometime down the road, it seems like understanding everything about why
> > the previous time failed might be a good idea.
> >
>
> Everything - including the various root file systems - is at
> git@github.com:groeck/linux-build-test.git. Look into rootfs/ for the
> various boot tests. I'll be happy to provide some qemu command lines
> if needed.

I've been playing with a few things, and I'm wondering how close I am
to making this problem go away. I just made this branch:
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/log/?h=jd/for-guenter

Any interest in setting your tests on that and seeing if it still
breaks? Or, perhaps better, do you have a single script that runs all
your various tests and does all the toolchain things right, so I can
just point it at that tree and iterate?

Jason
