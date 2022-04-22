Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A3E50C558
	for <lists+linux-arch@lfdr.de>; Sat, 23 Apr 2022 02:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiDVXtm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Apr 2022 19:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiDVXtm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2022 19:49:42 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC10D4CA4;
        Fri, 22 Apr 2022 16:46:47 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e67799d278so6411437fac.11;
        Fri, 22 Apr 2022 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WSqoJagxi812Uz/UbsiFaQztPn6lgwcsPHidF2EdEMc=;
        b=l3pwTAgBWaPEGR+5Y4Ms2ka1ENpCMRUFU584ArSAe3jbl3rcvvrbM9kesOnaO3DmNg
         GE8Cr6V+d97pe/CxxOeTQ0VFJQHU2m1eeL7009IJ8hPqC8p6AvVPVPx3frBGxKIOtvoT
         bTi0q5iqLfM2+HF9WHGZ1sgSQinN4ZzQNHTe6xHdbHlWszgRkye3OsSGX4ECNOYv13eL
         BZvRbwccaKgH7r9BhTEobkGUmQkgrCHaL8Pkq8wDIzJQhoiNjCZU8LnsMkES/BFuIHzK
         UP3uOZzngv3BDzJpbtCXQuSPESSnIEY7bA0QTWXbTp/o4Ak1aIAw4Yk/p/RTly6bGsfJ
         Iatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WSqoJagxi812Uz/UbsiFaQztPn6lgwcsPHidF2EdEMc=;
        b=s/rEmVQUvPTEjJAHKLcmx/l8Awy5Zl6Epcc/GyI/WgBYHXmDd86lS8rE+FrXqO+vOm
         sVlZrXps/LYuSArFVf+thOzwQvMHpZLCOQz5l6kobevWvQCoe0EhbOKElhnp6f+W0KjP
         9iOiMkxXlnpaFwIMB9OJj723GRCgJnkbYpKmDj/grejEpSxKDXqrG7f/qa+C35xsHDua
         s8KQYBX80A8guffwAasELlszJnIEYXpyXH0bXUoXoP6Pw8YTjO3O3V1lvB3FbhNzXwL0
         X1ee4qO8joWj91hgiqLrg2nsYBV55ed445zdyruCTYMv2N37ggwOeZevYoyF3bBJl2Fp
         +n+w==
X-Gm-Message-State: AOAM531sbIexrBbXbXdVigRnJXAVZuRDFEa5tCsYmTs76mXsaUVizJ+u
        StzR6FNaq59SYG9zjMHpR2U=
X-Google-Smtp-Source: ABdhPJzsuurtmrnZ4So2zOMzTz1Yl+C7CeLKiq1mrBLhvhxG9vsoxjvivMhjHyrDEvyQmm/86mXvfQ==
X-Received: by 2002:a05:6870:b39c:b0:d1:4a9f:35f9 with SMTP id w28-20020a056870b39c00b000d14a9f35f9mr2867661oap.119.1650671206541;
        Fri, 22 Apr 2022 16:46:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q12-20020a4ad54c000000b003245ac0a745sm1347747oos.22.2022.04.22.16.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 16:46:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 22 Apr 2022 16:46:44 -0700
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
Message-ID: <20220422234644.GB3442771@roeck-us.net>
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

I applied your branch to my 'testing' branch. It will build tonight.
We should have results by tomorrow morning.

> your various tests and does all the toolchain things right, so I can
> just point it at that tree and iterate?
> 

Sorry, my system isn't that fancy. I don't mind running tests like this one,
though.

Guenter
