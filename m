Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F54217E61
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jul 2020 06:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgGHEbb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jul 2020 00:31:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41078 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgGHEbb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 00:31:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id g67so20156512pgc.8;
        Tue, 07 Jul 2020 21:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w74eNERLG2pgyjUdSRcYW9SUoyc7gG8Z+LPaMqm+zH4=;
        b=bGr877LUdCQ0kuSTd6Jzf41uJHQKYxSNHoRUTRR4j8FtJtlOyW0FoOwCvJ0t/mozML
         9fOZVHGHIAIbjMyLZ5VM5fRv3stTWKk7HF0lUxN31Qo/mFTe5Ut9rSku6IXj4n2wJM6K
         jRqY4pu+DIOuIYgJGMOqyQROrz4ULc6SXGN0zIvDNqz/VX4OSlAk9OI13oUJdMhZUjTr
         qZgqSTZw5FOEBGtJoz/pGXZj0m6zw5LLFpapPHSoVx6UcuJ7qzaaFud0REjTTWVhI14S
         rCO2SGeobH8T5XoDsIg9G7ylBOjEFE1WfZP3pDWJ4TPg+VZ9fVXHT0Vf3ax++zbqU7ve
         sHdA==
X-Gm-Message-State: AOAM530ICR02122zUYQomrMS4iQ1qTHs/XZYJDQeu7GC25eX8vFqkuWi
        ghI+l8FtpVk6T3WVUxjSv2U=
X-Google-Smtp-Source: ABdhPJxHZU8n57bHyUA87/h7IOAVFo14RjremkjbHa0piNVeEl4DjqKtxGu5JTtc4Tf00fVU/dHDDQ==
X-Received: by 2002:a05:6a00:2c1:: with SMTP id b1mr40074651pft.159.1594182690346;
        Tue, 07 Jul 2020 21:31:30 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w9sm3745302pja.39.2020.07.07.21.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 21:31:29 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A30C1400DB; Wed,  8 Jul 2020 04:31:28 +0000 (UTC)
Date:   Wed, 8 Jul 2020 04:31:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
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
        will@kernel.org, monstr@monstr.eu,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com,
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
Subject: Re: [PATCH v5 01/12] vmlinux.lds.h: add linker section for KUnit
 test suites
Message-ID: <20200708043128.GY4332@42.do-not-panic.com>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-2-brendanhiggins@google.com>
 <202006261416.F4EAAE47E3@keescook>
 <CAFd5g47vu5vmrXnS0sLu+hdC2HmYz7GY82sE8rhcHfNkuC1NRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47vu5vmrXnS0sLu+hdC2HmYz7GY82sE8rhcHfNkuC1NRw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 26, 2020 at 02:22:11PM -0700, Brendan Higgins wrote:
> On Fri, Jun 26, 2020 at 2:20 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Jun 26, 2020 at 02:09:06PM -0700, Brendan Higgins wrote:
> > > Add a linker section where KUnit can put references to its test suites.
> > > This patch is the first step in transitioning to dispatching all KUnit
> > > tests from a centralized executor rather than having each as its own
> > > separate late_initcall.
> > >
> > > Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> > > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> > >  include/asm-generic/vmlinux.lds.h | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > > index db600ef218d7d..4f9b036fc9616 100644
> > > --- a/include/asm-generic/vmlinux.lds.h
> > > +++ b/include/asm-generic/vmlinux.lds.h
> > > @@ -881,6 +881,13 @@
> > >               KEEP(*(.con_initcall.init))                             \
> > >               __con_initcall_end = .;
> > >
> > > +/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
> >
> > Nit on naming:
> >
> > > +#define KUNIT_TEST_SUITES                                            \
> >
> > I would call this KUNIT_TABLE to maintain the same names as other things
> > of this nature.
> >
> > > +             . = ALIGN(8);                                           \
> > > +             __kunit_suites_start = .;                               \
> > > +             KEEP(*(.kunit_test_suites))                             \
> > > +             __kunit_suites_end = .;
> > > +
> > >  #ifdef CONFIG_BLK_DEV_INITRD
> > >  #define INIT_RAM_FS                                                  \
> > >       . = ALIGN(4);                                                   \
> > > @@ -1056,6 +1063,7 @@
> > >               INIT_CALLS                                              \
> > >               CON_INITCALL                                            \
> > >               INIT_RAM_FS                                             \
> > > +             KUNIT_TEST_SUITES                                       \
> > >       }
> >
> > Nack: this must be in INIT_DATA, not in INIT_DATA_SECTION. Not all
> > architectures use the INIT_DATA_SECTION macro (e.g. arm64), but everything
> > uses INIT_DATA.
> 
> Oh, maybe that would eliminate the need for the other linkerscript
> patches? That would be nice.

Curious, did changing it as Kees suggest fix it for m68k?

  Luis
