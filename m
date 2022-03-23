Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173794E56A9
	for <lists+linux-arch@lfdr.de>; Wed, 23 Mar 2022 17:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbiCWQnD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Mar 2022 12:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbiCWQmv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Mar 2022 12:42:51 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754897D015;
        Wed, 23 Mar 2022 09:41:20 -0700 (PDT)
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M2OAi-1nVP5E3Are-003sH2; Wed, 23 Mar 2022 17:41:18 +0100
Received: by mail-wm1-f54.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso1231626wmz.4;
        Wed, 23 Mar 2022 09:41:18 -0700 (PDT)
X-Gm-Message-State: AOAM531Nxs/XarV9jd9ywPi9FCuU+fSNA+0hfrkLNG8pTaniV5dIm110
        LwmR/5AEa9LypK5YEAuqTMg9M76Y+GeDLwYnDAo=
X-Google-Smtp-Source: ABdhPJzQ6+sWLiXr8Hp2o8LXfAR2AuwxHJYkOgUowaeEKHIJ0SuNttg2LIiHKo5yBPCGx6C4R7ZFcmIhEjJe1vVdEm0=
X-Received: by 2002:a05:600c:4b83:b0:38c:49b5:5bfc with SMTP id
 e3-20020a05600c4b8300b0038c49b55bfcmr10553256wmp.33.1648053678343; Wed, 23
 Mar 2022 09:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162848.303601-1-Jason@zx2c4.com> <20220322155820.GA1745955@roeck-us.net>
 <YjoUU+8zrzB02pW7@sirena.org.uk> <0d20fb04-81b8-eeee-49ab-5b0a9e78c9f8@roeck-us.net>
 <YjsOHmvDgAxwLFMg@sirena.org.uk> <ebafdf77-5d96-556b-0197-a172b656bb01@roeck-us.net>
 <CAK8P3a1hzmXTTMsGcCA2ekEHnff+M7GrYSQDN4bVfVk6Ui=Apw@mail.gmail.com> <YjtIVymPEZ4t16tP@sirena.org.uk>
In-Reply-To: <YjtIVymPEZ4t16tP@sirena.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Mar 2022 17:41:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Fzryo8Wi2exbQz=qXKGOGU6yxP0FGowa-fJkr0aGJFg@mail.gmail.com>
Message-ID: <CAK8P3a0Fzryo8Wi2exbQz=qXKGOGU6yxP0FGowa-fJkr0aGJFg@mail.gmail.com>
Subject: Re: [PATCH v1] random: block in /dev/urandom
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
X-Provags-ID: V03:K1:Nrnd2roAseJI6Rsq/gsTAvzXGUaLxalm6mS+yRoH6hjNj5E+ybe
 pjtUwrVkpNs4hw53lZDlcaj0RFwRa4SZ3gERjEcy//2/PFqlwGBnQjrdJtf9YXTdJZk8sxB
 f2SwahfUlt4yZKd9WLSPAU6ultg9xJXGZbAw5nVATNXvJjkFaxSfV4XK7z7QKlRU2CSECPL
 MGJi1RdQzugAzEYfQsgDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H5ZB9EtM2mE=:eKZ97HhzMgPX+vgt44QyEU
 cG/HixN1TEXHZ6dbpln14YrmzHZznI7L8L/R1B3Papy71LcVBXW8X9RwzaVe1jCqLc25ztFjL
 vQAJDtoHkUj6fHAhJt5HeI5pFywD/GrWO5yw8Mrv2sqraj+PmNg1+WjXBKJPQVaY3HACmgWyM
 UHQ0y+NXjhuZmyBVcaBfNsSOgEmy94MW8QgaPd+nE1eZkMMc2adKrukiWC1EFsqZwhehWgNzm
 6TYeiLDYUwmhsoJ2VbjpZCRnoveOatCed9flnRco7JxVjqwXjVj45quVY4jdlaeNBqRUccc3z
 6xgcicqvgBF259e9GzOXO4+UxXcEDAQoyKjVsAveAcQSvYo1jV6+43br7XOfO9pLE7/YiOzgC
 sJiIUe8oGnPbI7mqP8BDGjQk75OOEwsk4+jr1mLtInNdbHji444z8DxleEGmVl/stwQ8KLOca
 nvZe/hQzKMlpzH0ivcukdWOUicg57BLavagWLz6Z0EgVNGKlcKKG54ZSVWwS9151yFVpzSrYv
 5+X1cqLMQ+H03MUcBkVmLnVqmHar9rkTANW0SP1cwMhY14JBnPqy5mH0fTa6DdVm08Thjhc1W
 9VWGdFSRxjB0EAeQBEwVjW3WxKv4cWuzmz4u2WwzV44i8kBMb1n869lXgcCJM3z90iMPVCjCY
 EptcvrDnvqUKnhC9FyqF2qSJCd7QEXG29sXwnaxx7Jy+VIVsH+JeEyMiAZs9odHVg2MkqR9KF
 QHWMOKNg6sWj4BD0kU9LRdkwLzZNoebv92Mk/zazs22FCxnAErhI/HiLYvR9G2SyJQp17YIDL
 Saa0DiJ4J9oOaN+e3eApFO920CWTBO00mPDVHr4cV4EZaK7lJk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 23, 2022 at 5:18 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Mar 23, 2022 at 04:53:13PM +0100, Arnd Bergmann wrote:
> > On Wed, Mar 23, 2022 at 3:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> > > I don't think it is entirely academic. versatile-pb fails for me;
> > > if it doesn't fail at KernelCI, I'd like to understand why - not to
> > > fix it in my test environment, but to make sure that I _don't_ fix it.
> > > After all, it _is_ a regression. Even if that regression is triggered
> > > by bad (for a given definition of "bad") userspace code, it is still
> > > a regression.
>
> > Maybe kernelci has a virtio-rng device assigned to the machine
> > and you don't? That would clearly avoid the issue here.
>
> No, nothing I can see in the boot log:
>
> https://storage.kernelci.org/next/master/next-20220323/arm/versatile_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-versatilepb.html
>
> and I'd be surprised if virtio devices made it through with a specific
> platform emulation.

In general they do: virtio devices appear as regular PCI devices
and get probed from there, as long as the drivers are available.

It looks like the PCI driver does not get initialized here though,
presumably because it's not enabled in versatile_defconfig.
It used to also not be enabled in multi_v5_defconfig, but I have
merged a patch from Anders that enables it in 5.18 for the
multi_v5_defconfig.

> However it looks like for that test the init
> scripts didn't do anything with the random seed (possibly due to running
> from ramdisk?) so we'd not have hit the condition.

Right.

     Arnd
