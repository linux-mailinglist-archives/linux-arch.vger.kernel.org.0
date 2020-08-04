Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BCE23C074
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 22:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgHDUDt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 16:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgHDUDt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 16:03:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D92EC06174A
        for <linux-arch@vger.kernel.org>; Tue,  4 Aug 2020 13:03:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j19so23028553pgm.11
        for <linux-arch@vger.kernel.org>; Tue, 04 Aug 2020 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tyCti51MVo3/kuT1rPkqCk0xB52TNyjHHa6DSwsUNE=;
        b=BOdgCj/xpXMzUyWMGEdpzY6ZsQLT6U1zlPfAPITO0x8Q+IA84yaBeEIndq7bl+FiEy
         rVofD3aSCUoec+wrpHeiogm589AaN3VpZbkBQE7NZqI5FvytwjB1Yp60483xaA3xgLMO
         UBDpAP3zTIiNlOsPu1N3gKftDScSUUWDQ9W6XxffoSYkTrJT2kheOv9byV5yy13NmLug
         UQheG5KFf+dFlxyd3rFo+P3YzwT2ZhDOtcHr1ctJzHc/7NQO06/W4jyKBRbGazVz/3I3
         IJiBkJKghWCr6TKL1uBvZlfxIjBG91lq+/qNadwzNsbGIKychykGD6Lcoc2mCDM5fqhc
         bcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tyCti51MVo3/kuT1rPkqCk0xB52TNyjHHa6DSwsUNE=;
        b=WTboZXNO1ytEAeZMwUEHmCr3k/j06lEfh6FLWCbx17loh1qH1sHjRJywTJWTKTTbWn
         zsEOO5+Cgtg8h4aQss6Mada4r814NCGZzO/t+AWjdpGbuso2+dn9+KZYa62Jf4eAtpkA
         Aym2bNfZMp+euu2mjygHsxRwx0XDpSnNlgLywF0PTudG3X6MJB/wYylsqR+H4ZcqW4TE
         tOFI0TuOmaBMmm1dF1vzCGyXJL2jL8XD8P+PiuEXX6R3e5zA8AeH9A9uPWZpdsa8nCR0
         Uh8fDw/SH+hJFuNziQQ+Esao2wmLTb7ywCmwMlz8OGAVvUOGlx5fUCxRZewIpK03A3jT
         Ht8g==
X-Gm-Message-State: AOAM5321luWVAStsg6BcrfYjhnrjfYGgwxU/uZAWv407mq4QMXHL9UJ+
        HTQDGnfraHRr5HKpv142dt4XkZMmvC70qtNrCnmd3w==
X-Google-Smtp-Source: ABdhPJy+MBYkgA2v8x4+gwT9U43GgNgeh+L0qXB/DHG00vCnQTifheBrsiLPSxqExmeMgwXHXtu3Iucv1z/JFuZl1PU=
X-Received: by 2002:aa7:9e45:: with SMTP id z5mr54937pfq.166.1596571426459;
 Tue, 04 Aug 2020 13:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-2-brendanhiggins@google.com> <202006261416.F4EAAE47E3@keescook>
 <CAFd5g47vu5vmrXnS0sLu+hdC2HmYz7GY82sE8rhcHfNkuC1NRw@mail.gmail.com> <20200708043128.GY4332@42.do-not-panic.com>
In-Reply-To: <20200708043128.GY4332@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Aug 2020 13:03:35 -0700
Message-ID: <CAFd5g45vE7CvgEKYNJeLUiyZb=6Ps52nSqQPJ35+EyC7Y3wkdw@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] vmlinux.lds.h: add linker section for KUnit test suites
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Frank Rowand <frowand.list@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Chris Zankel <chris@zankel.net>, jcmvbkbc@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 7, 2020 at 9:31 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Jun 26, 2020 at 02:22:11PM -0700, Brendan Higgins wrote:
> > On Fri, Jun 26, 2020 at 2:20 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Jun 26, 2020 at 02:09:06PM -0700, Brendan Higgins wrote:
> > > > Add a linker section where KUnit can put references to its test suites.
> > > > This patch is the first step in transitioning to dispatching all KUnit
> > > > tests from a centralized executor rather than having each as its own
> > > > separate late_initcall.
> > > >
> > > > Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> > > > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > > > ---
> > > >  include/asm-generic/vmlinux.lds.h | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > > > index db600ef218d7d..4f9b036fc9616 100644
> > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > @@ -881,6 +881,13 @@
> > > >               KEEP(*(.con_initcall.init))                             \
> > > >               __con_initcall_end = .;
> > > >
> > > > +/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
> > >
> > > Nit on naming:
> > >
> > > > +#define KUNIT_TEST_SUITES                                            \
> > >
> > > I would call this KUNIT_TABLE to maintain the same names as other things
> > > of this nature.
> > >
> > > > +             . = ALIGN(8);                                           \
> > > > +             __kunit_suites_start = .;                               \
> > > > +             KEEP(*(.kunit_test_suites))                             \
> > > > +             __kunit_suites_end = .;
> > > > +
> > > >  #ifdef CONFIG_BLK_DEV_INITRD
> > > >  #define INIT_RAM_FS                                                  \
> > > >       . = ALIGN(4);                                                   \
> > > > @@ -1056,6 +1063,7 @@
> > > >               INIT_CALLS                                              \
> > > >               CON_INITCALL                                            \
> > > >               INIT_RAM_FS                                             \
> > > > +             KUNIT_TEST_SUITES                                       \
> > > >       }
> > >
> > > Nack: this must be in INIT_DATA, not in INIT_DATA_SECTION. Not all
> > > architectures use the INIT_DATA_SECTION macro (e.g. arm64), but everything
> > > uses INIT_DATA.
> >
> > Oh, maybe that would eliminate the need for the other linkerscript
> > patches? That would be nice.

Sorry for the delayed response. I got pulled into some other things.

> Curious, did changing it as Kees suggest fix it for m68k?

It did! There are still some architectures I cannot test due to a lack
of GCC or QEMU support, but it seems to work on everything else now.
