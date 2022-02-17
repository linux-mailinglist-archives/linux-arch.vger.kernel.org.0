Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9494B9A11
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 08:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbiBQHud (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 02:50:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiBQHuc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 02:50:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF46A27F29A;
        Wed, 16 Feb 2022 23:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 800BF61A6A;
        Thu, 17 Feb 2022 07:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5882C340F6;
        Thu, 17 Feb 2022 07:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645084217;
        bh=mjFs6zWH8/AqiitYOR0rg+8IkEbypYLpH0MSBavFTDs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KcQXvGa6ufTjq00Joyx9C3HRfsSGVDhmAWnfuai4piutHWEZTONgSlJ36qJk0w305
         PL6xOd5cUC+4mKD4d4yRE4a85vuRW7inj41M4WlJ4NLhwiKrmht5Rppfu7HTodcxxO
         muZcHf0Avewz4g0zsaE2L3uDESfxksZnGC+zgC//UboQHkePPQNFjX0MhRIBawkNza
         RY+2WdQoYRF2d9hYiLImoqDwMoIfh1hzRHwtwyyi2JTBlJ2aQ0EE6mUfLA+MeQEnLM
         aWF5NyrIDLQ3IgLsmOekx21DOqzG7U0dAHBe+enVZeDpShNR7ggyHvCHaU5ZNjz0An
         wyUChekSodH2A==
Received: by mail-wm1-f53.google.com with SMTP id w13so2118120wmi.2;
        Wed, 16 Feb 2022 23:50:17 -0800 (PST)
X-Gm-Message-State: AOAM533uj+5mtx8xx/fYcrakRh/VLSDGl9gPsDwKd7mbgO29Q8oorWDZ
        pSl+TOatIkAwiv4PyhRyC7lNrTZQbb7gc6sIzQM=
X-Google-Smtp-Source: ABdhPJxVHiNpam6v+gNoOoH0mO2de38FsGKKulVVSeiH+uDoJW6u9JTqRXgzs52TA7IQLSGpUpbHMUpXX+Sk75rMI5w=
X-Received: by 2002:a05:600c:2108:b0:34e:870:966e with SMTP id
 u8-20020a05600c210800b0034e0870966emr4902681wml.173.1645084215917; Wed, 16
 Feb 2022 23:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
In-Reply-To: <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 17 Feb 2022 08:49:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3_dPbjB23QffnYMtw+5ojfwChrVC8LLMQqNctU7Nh+mQ@mail.gmail.com>
Message-ID: <CAK8P3a3_dPbjB23QffnYMtw+5ojfwChrVC8LLMQqNctU7Nh+mQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] clean up asm/uaccess.h, kill set_fs for good
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 17, 2022 at 8:20 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 16/02/2022 =C3=A0 14:13, Arnd Bergmann a =C3=A9crit :
> >
> > Christoph Hellwig and a few others spent a huge effort on removing
> > set_fs() from most of the important architectures, but about half the
> > other architectures were never completed even though most of them don't
> > actually use set_fs() at all.
> >
> > I did a patch for microblaze at some point, which turned out to be fair=
ly
> > generic, and now ported it to most other architectures, using new gener=
ic
> > implementations of access_ok() and __{get,put}_kernel_nocheck().
> >
> > Three architectures (sparc64, ia64, and sh) needed some extra work,
> > which I also completed.
> >
> > The final series contains extra cleanup changes that touch all
> > architectures. Please review and test these, so we can merge them
> > for v5.18.
>
> As a further cleanup, have you thought about making a generic version of
> clear_user() ? On almost all architectures, clear_user() does an
> access_ok() then calls __clear_user() or similar.

This already exists in include/asm-generic/uaccess.h, but that file is
currently not as easy to use as it should be. I've previously looked into
what it would take to get more architectures to use common code
in that file, but I currently have no plans to work on that.

> Maybe also the same with put_user() and get_user() ? After all it is
> just access_ok() followed by __put_user() or __get_user() ? It seems
> more tricky though, as some architectures seems to have less trivial
> stuff there.

Same here: architectures can already provide a __put_user_fn()
and __get_user_fn(), to get the generic versions of the interface,
but few architectures use that. You can actually get all the interfaces
by just providing raw_copy_from_user() and raw_copy_to_user(),
but the get_user/put_user versions you get from that are fairly
inefficient.

> I also see all architectures have a prototype for strncpy_from_user()
> and strnlen_user(). Could be a common prototype instead when we have
> GENERIC_STRNCPY_FROM_USER / GENERIC_STRNLEN_USER
>
> And we have also
> user_access_begin()/user_read_access_begin()/user_write_access_begin()
> which call access_ok() then do the real work. Could be made generic with
> call to some arch specific __user_access_begin() and friends after the
> access_ok() and eventually the might_fault().

In my opinion, the biggest win would be to move the type-agnostic part of
get_user/put_user into completely generic code, this is what architectures
get wrong the most, see patch 02/18 in this series for instance.

What I'd like to see is that architectures only provide fixed-length
versions of unsafe_get_user()/unsafe_put_user(), with the type-agnostic
versions (get_user(), __get_user(), unsafe_get_user() and their put
versions) all defined once in include/linux/uaccess.h based on those.

I tried implementing this in the past, but unfortunately the resulting
object code from my generalized implementation was worse than
what we have today, so I did not continue that work.

      Arnd
