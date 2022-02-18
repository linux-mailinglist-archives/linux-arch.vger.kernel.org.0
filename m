Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F215F4BB560
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 10:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiBRJVO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 04:21:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiBRJVO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 04:21:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A52245A8;
        Fri, 18 Feb 2022 01:20:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8253461ADA;
        Fri, 18 Feb 2022 09:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D5AC34101;
        Fri, 18 Feb 2022 09:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645176057;
        bh=iKhg0GBIaPe+CQxdRyb4Yd6fYvnOL1KGipyOpowy2ho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qrzVx9uS01f/Wj0cFTg/+0LSWhE1G7FN6TwYhpUGHAfRFXkIpmBM4F8J0dk50pwkS
         wKyObRAaCrLX377JCN9FqH7Kvh/1cBMDdQ9Fjl4a3lK+Eyuc/W9Ce2RzgwmHPVRzsr
         3j4FGxlx7lZ6K6w7D7wAQsHsLFhAT1CPEWL3AgKOjYatwwZ+xb00t40/49j3taYxi7
         gRGFGpqJndNBvH9elSM9uplg5tkpex37l+LNXc8C5bEpjwPDfEuZXV6BzcjuhIjM6I
         kPpps+g+oF8SDzjL1o/OiI+AT3LkK+UOezRIAS0FwKI07/pNdUg4V02kqmHkVrKU4l
         dfD2eBhw3uwOw==
Received: by mail-wr1-f42.google.com with SMTP id f3so13289879wrh.7;
        Fri, 18 Feb 2022 01:20:56 -0800 (PST)
X-Gm-Message-State: AOAM530/8ynQ2Sox3qdd+hljEgevuVWg2ebkSe+jjxBmuyrX0wWjudhE
        1rPXf/WK8PQwkS3/XqRT6jePEgeW1SI6q4RrXDs=
X-Google-Smtp-Source: ABdhPJyGR3PQRCwNo0b6q27n8W/CBFQ1qGTyO2eZuzZDzHloL87fpnteJNso35Jub1TB9UHbj8TuXAAIoiRTkKAAdXc=
X-Received: by 2002:a5d:59a3:0:b0:1e9:542d:1a35 with SMTP id
 p3-20020a5d59a3000000b001e9542d1a35mr816366wrr.192.1645176055050; Fri, 18 Feb
 2022 01:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
 <CAK8P3a3_dPbjB23QffnYMtw+5ojfwChrVC8LLMQqNctU7Nh+mQ@mail.gmail.com> <Yg8CjZwjWYIibrsd@zeniv-ca.linux.org.uk>
In-Reply-To: <Yg8CjZwjWYIibrsd@zeniv-ca.linux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 18 Feb 2022 10:20:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0_uJQXshn5N0o4J_8dVPNCw885xGHqnKj3i5kYB+GtBg@mail.gmail.com>
Message-ID: <CAK8P3a0_uJQXshn5N0o4J_8dVPNCw885xGHqnKj3i5kYB+GtBg@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] clean up asm/uaccess.h, kill set_fs for good
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dalias@libc.org" <dalias@libc.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "will@kernel.org" <will@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "bcain@codeaurora.org" <bcain@codeaurora.org>,
        "deller@gmx.de" <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "richard@nod.at" <richard@nod.at>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "davem@davemloft.net" <davem@davemloft.net>
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

n Fri, Feb 18, 2022 at 3:21 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Feb 17, 2022 at 08:49:59AM +0100, Arnd Bergmann wrote:
>
> > Same here: architectures can already provide a __put_user_fn()
> > and __get_user_fn(), to get the generic versions of the interface,
> > but few architectures use that. You can actually get all the interfaces
> > by just providing raw_copy_from_user() and raw_copy_to_user(),
> > but the get_user/put_user versions you get from that are fairly
> > inefficient.
>
> FWIW, __{get,put}_user_{8,16,32,64} would probably make it easier to
> unify.  That's where the really variable part tends to be, anyway.
> IMO __get_user_fn() had been a mistake.

I've prototyped this now, to see what this might look like, see
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?h=generic-get_user-prototype

This adds generic inline version of {__get,get,__put,put}_user()
and converts x86 to (optionally) use it. This builds with gcc-5
through gcc-11 on 32-bit and 64-bit x86, using asm-goto with
outputs where possible, and requiring a minimum set of macro
definitions from the architecture. Compiling with clang produces
no warnings but does cause a linker issue at the moment, so
there is probably at least one bug in it.

Aside from compile-testing, I have not tried to verify if this
is correct or efficient, but let me know if you think this is headed
in the right direction.

> One thing I somewhat dislike about the series is the boilerplate in
> asm/uaccess.h instances - #include <asm-generic/access-ok.h> in
> a lot of them might make sense as a transitory state, but getting
> stuck with those indefinitely...

Christoph also complained about it, the problem for now is that
asm-generic/access_ok.h must first see the macro definitions for
architectures that override any of the contents, but access_ok()
itself is used at least in some of the asm/uaccess.h files as well,
so it must be included in the middle of it, until more of the uaccess.h
implementation is moved to linux/uaccess.h in an architecture
independent way.

Would you prefer having an asm/access_ok.h that falls back to
the asm-generic version but can have an architecture specific
override when needed (ia64, arm64, x86, um)?

>         BTW, do we need user_addr_max() anymore?  The definition in
> asm-generic/access-ok.h is the only one, so ifndef around it is pointless.

Right, the v2 changes got rid of the last override, so it could get
hardcoded to TASK_SIZE_MAX, or we can convert the five
references to just use that instead and remove it altogether:

arch/arm64/kernel/traps.c:      if (address >= user_addr_max()) {
                 \
arch/parisc/kernel/signal.c:    if (start >= user_addr_max() - sigframe_size)
arch/parisc/kernel/signal.c:            if (A(&usp[0]) >=
user_addr_max() - 5 * sizeof(int))
lib/strncpy_from_user.c:        max_addr = user_addr_max();
lib/strnlen_user.c:     max_addr = user_addr_max();

user_addr_max() first showed up in architecture-independent code in
c5389831cda3 ("sparc: Fix user_addr_max() definition."), and from that
I think the original intent is no longer useful.

          Arnd
