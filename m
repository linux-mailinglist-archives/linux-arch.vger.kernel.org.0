Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD450CADC
	for <lists+linux-arch@lfdr.de>; Sat, 23 Apr 2022 15:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiDWN7f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 23 Apr 2022 09:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiDWN7c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Apr 2022 09:59:32 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442A8EA9;
        Sat, 23 Apr 2022 06:56:34 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id v65so7407161oig.10;
        Sat, 23 Apr 2022 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9R0Eg/CRNtKLpWzpMCYm6Btgzdkg1gctUTsNegEGWlM=;
        b=Wr8k4l382g+3NU7GdO4bZQhLS3tkaq1xWN4EwUxxIC2X32IoWloyzSF3bdOwXZq+yj
         iNswazFUaRowyji9sL/LuelCUvvtzXUpvqFq+6vfUYpu334rdp0GfptWrDAw1zR4rb/L
         zPXKQITLjC5OIdeSujAJ6P08/UmUY5LWbho81OWNsZimhmx8U12cW3ACEXwW1NO/Pn1Q
         Kth1QGm/58HjB9TeLpsQToaeemTn1dURh0BZBxi0KUWq7hNccVVwdLyU3V6veR5JpqZ0
         /0k1EURXc/NB7aUkZLQYt9Zd08y4Bzqo75FwNisafvkLPlELIoVCTZ6iDlgCROcD0reW
         nmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9R0Eg/CRNtKLpWzpMCYm6Btgzdkg1gctUTsNegEGWlM=;
        b=SHhwMQTn+H7ExRfqEUFx8tR/ZP2jkm7rWgIUA+FR0qwiroCKINNL6Sd/BVTQHMYpMJ
         DxaQ3xsQy+DN6jHjBmaqDx0+uR86FD8USne5pBbb/pk/b4GgCPl5hIzabKbFzOj5kzi1
         NaVCbGrGitOi8DxOa60hUwo0rX9qp24IzSKPEWF3HhWQnPNSguIx/5VfGlZXx3wiWh/N
         4cnKCOHqdx+TEhvcmlzCGc9L9aPeYYGTN6Y6M4XVW8A+Eylc+kXKBAo1C32TUDg8im2B
         wD3adgyZZhs1BQxKYafBWxMy4iRmmvU32xwIczF9t9XNFqv3/Z2N3QYzz/rQa2WP5el/
         SMeA==
X-Gm-Message-State: AOAM531W72W5VFH3XD7G5reBqVICr3NcnsVLE3GjMswadayO1Et/Hzo1
        5ve5eFZNf8Zoa+xIyThSMJk=
X-Google-Smtp-Source: ABdhPJw7YNYwCpYaxw7KrX+wjmPQlXrdJ/V++S3i2tSN/asd38+TKG6ivFWm3ZdQjwkF0Ov/sSBshg==
X-Received: by 2002:a05:6808:1992:b0:322:ca0b:cce3 with SMTP id bj18-20020a056808199200b00322ca0bcce3mr4410515oib.168.1650722193655;
        Sat, 23 Apr 2022 06:56:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 1-20020a05687011c100b000de98359b43sm1631885oav.1.2022.04.23.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:56:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Apr 2022 06:56:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
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
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v1] random: block in /dev/urandom
Message-ID: <20220423135631.GB3958174@roeck-us.net>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net>
 <YjoC5kQMqyC/3L5Y@zx2c4.com>
 <d5c23f68-30ba-a5eb-6bea-501736e79c88@roeck-us.net>
 <CAHmME9rmeQAD2DwG=APTmDxuVxFDH=6GXoKpgPrU9rc9oXrmxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rmeQAD2DwG=APTmDxuVxFDH=6GXoKpgPrU9rc9oXrmxQ@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 22, 2022 at 03:42:46PM +0200, Jason A. Donenfeld wrote:
> Hey Guenter,
> 
> On Tue, Mar 22, 2022 at 6:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 3/22/22 10:09, Jason A. Donenfeld wrote:
> > > Hey Guenter,
> > >
> > > On Tue, Mar 22, 2022 at 08:58:20AM -0700, Guenter Roeck wrote:
> > >> On Thu, Feb 17, 2022 at 05:28:48PM +0100, Jason A. Donenfeld wrote:
> > >>> This topic has come up countless times, and usually doesn't go anywhere.
> > >>> This time I thought I'd bring it up with a slightly narrower focus,
> > >>> updated for some developments over the last three years: we finally can
> > >>> make /dev/urandom always secure, in light of the fact that our RNG is
> > >>> now always seeded.
> > >>>
> > >>
> > >> [ ... ]
> > >>
> > >> This patch (or a later version of it) made it into mainline and causes a
> > >> large number of qemu boot test failures for various architectures (arm,
> > >> m68k, microblaze, sparc32, xtensa are the ones I observed). Common
> > >> denominator is that boot hangs at "Saving random seed:". A sample bisect
> > >> log is attached. Reverting this patch fixes the problem.
> > >
> > > As Linus said, it was worth a try, but I guess it just didn't work. For
> > > my own curiosity, though, do you have a link to those QEMU VMs you could
> > > share? I'd sort of like to poke around, and if we do ever reattempt this
> > > sometime down the road, it seems like understanding everything about why
> > > the previous time failed might be a good idea.
> > >
> >
> > Everything - including the various root file systems - is at
> > git@github.com:groeck/linux-build-test.git. Look into rootfs/ for the
> > various boot tests. I'll be happy to provide some qemu command lines
> > if needed.
> 
> I've been playing with a few things, and I'm wondering how close I am
> to making this problem go away. I just made this branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/log/?h=jd/for-guenter
> 
> Any interest in setting your tests on that and seeing if it still
> breaks? Or, perhaps better, do you have a single script that runs all

Looks like your code is already in -next; I see the same failures in
your tree and there.

openrisc generates a warning backtrace.

WARNING: CPU: 0 PID: 0 at drivers/char/random.c:1006 rand_initialize+0x148/0x174
Missing cycle counter and fallback timer; RNG entropy collection will consequently suffer.

parisc crashes.

[    0.000000] Kernel Fault: Code=15 (Data TLB miss fault) at addr 00000000
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0-rc3-32bit+ #1
[    0.000000]
[    0.000000]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
[    0.000000] PSW: 00000000000001001011111100001110 Not tainted
[    0.000000] r00-03  0004bf0e 10f2c978 10773aa0 10e74300
[    0.000000] r04-07  00000004 10e74208 10e869d0 10e83978
[    0.000000] r08-11  f0023b90 f0023390 0004000e 10104f68
[    0.000000] r12-15  00000002 00000000 00000008 fffffff9
[    0.000000] r16-19  00000028 00080000 00000000 10dc6364
[    0.000000] r20-23  10dc6364 00000000 00000000 fefefeff
[    0.000000] r24-27  00000000 00000004 00000000 10dc6178
[    0.000000] r28-31  0073a08d 80000000 10e74340 00000000
[    0.000000] sr00-03  00000000 00000000 00000000 00000000
[    0.000000] sr04-07  00000000 00000000 00000000 00000000
[    0.000000]
[    0.000000] IASQ: 00000000 00000000 IAOQ: 1024d09c 1024d0a0
[    0.000000]  IIR: 0f401096    ISR: 00000000  IOR: 00000000
[    0.000000]  CPU:        0   CR30: 10e869d0 CR31: 00000000
[    0.000000]  ORIG_R28: 10e83ce8
[    0.000000]  IAOQ[0]: random_get_entropy_fallback+0x18/0x38
[    0.000000]  IAOQ[1]: random_get_entropy_fallback+0x1c/0x38
[    0.000000]  RP(r2): add_device_randomness+0x30/0xc8
[    0.000000] Backtrace:
[    0.000000]  [<10773aa0>] add_device_randomness+0x30/0xc8
[    0.000000]  [<10108734>] collect_boot_cpu_data+0x44/0x270
[    0.000000]  [<10104f28>] setup_arch+0x98/0xd4
[    0.000000]  [<10100a90>] start_kernel+0x8c/0x6d0

s390 crashes silently, no crash log.

Hope that helps,
Guenter
