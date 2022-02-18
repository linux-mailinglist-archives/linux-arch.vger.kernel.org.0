Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7CB4BB57F
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 10:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiBRJZ2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 04:25:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiBRJZ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 04:25:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2214229834;
        Fri, 18 Feb 2022 01:25:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF358B825C1;
        Fri, 18 Feb 2022 09:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA79C340E9;
        Fri, 18 Feb 2022 09:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645176308;
        bh=mMLLIykgh57Awf38lSwA8MWwDlZ8x8pcozF3MLrCnRg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZbqIylmo6uIMQW9t/Ad/7tK2u11mWG8WjB4qa2lfLenjhGPPxOrSXmBbl29vFdLsz
         RLSm/eXkXWAyaPeir93OV55usyXVm2w4yQlbEJGSBjhJPbxxP/WpH5jZFZohcdGJuc
         6Zfpxe/6xPCRfwA2642xwgzl3OAOgkS6RUG2lx02px9lCShpTvSBFlhAXh9Xt0WesF
         y9upM5KMvL2LkL8Lg6Wt2QOBAR4Z85feGVCvbHOzS9xm+0Yr+UJLxIFlCq0FBHO81q
         m9xWZTMnBTKzYFvFyVALCx1xdi73gd+l2HgxVcagVdTW3ua0wYvd/SpcRFCaI9A6Sk
         sF8vt4Yo6OTWg==
Received: by mail-wm1-f44.google.com with SMTP id k41so4834354wms.0;
        Fri, 18 Feb 2022 01:25:08 -0800 (PST)
X-Gm-Message-State: AOAM530YwEfNnFjEX6WbFab6a1DRIvLjalGP3UCG12QG65pIPCrQKPyt
        CuzXWckKWsR63e2KUWk1j8rHzZ4AdUZL0BOMIp0=
X-Google-Smtp-Source: ABdhPJwrWpJqc0egLA12RwkumDKsH10yWoelsJ0RehwMogjvxHhR3UEotiD7Fxqib+HetrYJWhy8e0u55+IMdrLJwD4=
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id
 l39-20020a05600c1d2700b0037c74bb2b4dmr9729968wms.82.1645176306970; Fri, 18
 Feb 2022 01:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-11-arnd@kernel.org>
 <CAMuHMdWMhP5WgZ7CvOz53SyfizaAvLkHbeuds8G+_nZkwzhWWw@mail.gmail.com>
In-Reply-To: <CAMuHMdWMhP5WgZ7CvOz53SyfizaAvLkHbeuds8G+_nZkwzhWWw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 18 Feb 2022 10:24:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2hrjxzzAWk3ut3VTD3h=ZLpDwPdvqs+uKaC4_b6+Vbfg@mail.gmail.com>
Message-ID: <CAK8P3a2hrjxzzAWk3ut3VTD3h=ZLpDwPdvqs+uKaC4_b6+Vbfg@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] m68k: fix access_ok for coldfire
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 18, 2022 at 10:00 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> >  /* We let the MMU do all checking */
> > -static inline int access_ok(const void __user *addr,
> > +static inline int access_ok(const void __user *ptr,
> >                             unsigned long size)
> >  {
> > +       unsigned long limit = TASK_SIZE;
> > +       unsigned long addr = (unsigned long)ptr;
> > +
> >         /*
> >          * XXX: for !CONFIG_CPU_HAS_ADDRESS_SPACES this really needs to check
> >          * for TASK_SIZE!
> > +        * Removing this helper is probably sufficient.
> >          */
>
> Shouldn't the above comment block be removed completely,
> as this is now implemented below?

Yes, obviously. Fixed now.

> > -       return 1;
> > +       if (IS_ENABLED(CONFIG_CPU_HAS_ADDRESS_SPACES))
> > +               return 1;

I just noticed this should have the same change that I made for the
generic version, changed it now to

+       if (IS_ENABLED(CONFIG_CPU_HAS_ADDRESS_SPACES) ||
+           !IS_ENABLED(CONFIG_MMU))

This is gone again after the cleanup patch, when the generic version
is used instead.

> > +       return (size <= limit) && (addr <= (limit - size));
> >  }
>
> Any pesky compilers that warn (or worse with -Werror) about
> "condition always true" for TASK_SIZE = 0xFFFFFFFFUL?

No, using a local variable avoids this warning.

        Arnd
