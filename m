Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9CE26DDF6
	for <lists+linux-arch@lfdr.de>; Thu, 17 Sep 2020 16:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgIQOM1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Sep 2020 10:12:27 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:53259 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgIQOLY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Sep 2020 10:11:24 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 10:11:22 EDT
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MzQbw-1kezk02V1c-00vT3E; Thu, 17 Sep 2020 16:01:44 +0200
Received: by mail-qk1-f172.google.com with SMTP id w12so2272381qki.6;
        Thu, 17 Sep 2020 07:01:44 -0700 (PDT)
X-Gm-Message-State: AOAM5304ot5kHZJGBuPfXXyEVYJz8pFJs/lOsn8EqzaW5hHUtHPcAlhv
        G51303jxTG3cAMoantkRutHn42/6JqqP4xjlvjk=
X-Google-Smtp-Source: ABdhPJypvKt5K6vsRgjllHkNp0imyN+bOqaU9zpMG48JdwZ9KbFYFADzd403hy36sDpE2nZf6WeaV+/92apRwmmxTPo=
X-Received: by 2002:a37:a495:: with SMTP id n143mr28117696qke.394.1600351303235;
 Thu, 17 Sep 2020 07:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200916074214.995128-1-Tony.Ambardar@gmail.com>
 <20200917000757.1232850-1-Tony.Ambardar@gmail.com> <87363gpqhz.fsf@mpe.ellerman.id.au>
In-Reply-To: <87363gpqhz.fsf@mpe.ellerman.id.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Sep 2020 16:01:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3FVoDzNb1TOA6cRQDdEc+st7KkBL70t0FeStEziQG4+A@mail.gmail.com>
Message-ID: <CAK8P3a3FVoDzNb1TOA6cRQDdEc+st7KkBL70t0FeStEziQG4+A@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: fix EDEADLOCK redefinition error in uapi/asm/errno.h
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Tony Ambardar <tony.ambardar@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Rosen Penev <rosenp@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:BiDI7RSugMs1bexsxNS7YdcLk/DPBsz4XJ9rjWVFJysPhzJ6DqT
 2XQbp5EiiavA/xv3Yb1leIcOlkzG1yJV/ShPE6IGfIIqfGHbgZ8UDvALmjcNVvJvBza0wtC
 YNGjeYLC+LX8QDbxbTuk3g6R1N55bR8nMJZp997Qjl7gckYG0HrUKYD8Mau5dvuL6z4zm7e
 8fzVYGR6nqAnUv4z4Ac+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OiyOedjSjEE=:kPQxdXO/jYk+i7pGOq+NOs
 8iBpb46yH7KUPvnmxE48dZZ6h9ntMxYgASzNzDIS78c95nZkGrhBcfqrZFKAlnanMeB/6T5sb
 1K838KThHOXS9Tkz7NGxHANEUrHUnuXuQxVG8oYWY3Q6RRhr6bO2vHaAUvKaTtc7vLZsJ/gcG
 DH7Hg0rSy4YUZx+u3esU/BuNzP8w3MTRIVcX84c4Oz1awHe5kheWcw+ZEwXjoj7Bl/whbMnTr
 tHynzRcu3zUs5qSEbhwHSsRR6xEuQ+pR2vVKr2gTaUuX1qhZiEp51YmM9QonAb6F9kRdivWae
 rv4TFkHhICzJzafoRfdcomlctOy010EsRtECtBMCyLEILkPwtTAz9LrTeXj5KKLwSQSNlWVvE
 4qMHT0rEwYJovG1Cbs934v+BlZIiH/z19D5FnZl1Njspon87n+oIjlBOJKuoMJgJoiiN1zi6+
 s9SWURInct36SwarZ9xOylGKZxprzwO2/DTxUOk0vswFJwpOze6qknmwAu6CGXh0m0uYV5SOl
 lejU7G778zSvllGPGASW/6L8UUyV31kZncqlYGzV60YKMQhumjz0lEfV88L/jybqfQll+TfKa
 zbkwgOMDN+OiT011b+VI9Z9Hku8J3TVS792YmWkG/fB2daVHx8G9X0eFegK+ESmiIsMTyZwsT
 I/oHZjKsEvAuo2w/fYQQbaWQFTsqYWshuF9QOcikoIhtfz6d2K7/NlrwmO6mV6VHX92rPEu8W
 +4sWHHAZp24Cof3U8w2G0y98vNhOF5kymYr3ko4M0PLr6H9rAEiLpCkXMarurBiAuxkiOhqeC
 KD6k1NBw9RvYkEbfUofAVgwsXdg5CSyA3mw7kANq0lRqrjEvz1DPZXwLEY5Ygl9lX8mCQ02
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 17, 2020 at 1:55 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> [ Cc += linux-arch & Arnd ]
>
> Hi Tony,
>
> This looks OK to me, but I'm always a bit nervous about changes in uapi.
> I've Cc'ed linux-arch and Arnd who look after the asm-generic headers,
> which this is slightly related to, just in case.
>
> One minor comment below.
>
> Tony Ambardar <tony.ambardar@gmail.com> writes:
> > A few archs like powerpc have different errno.h values for macros
> > EDEADLOCK and EDEADLK. In code including both libc and linux versions of
> > errno.h, this can result in multiple definitions of EDEADLOCK in the
> > include chain. Definitions to the same value (e.g. seen with mips) do
> > not raise warnings, but on powerpc there are redefinitions changing the
> > value, which raise warnings and errors (if using "-Werror").
> >
> > Guard against these redefinitions to avoid build errors like the following,
> > first seen cross-compiling libbpf v5.8.9 for powerpc using GCC 8.4.0 with
> > musl 1.1.24:
> >
> >   In file included from ../../arch/powerpc/include/uapi/asm/errno.h:5,
> >                    from ../../include/linux/err.h:8,
> >                    from libbpf.c:29:
> >   ../../include/uapi/asm-generic/errno.h:40: error: "EDEADLOCK" redefined [-Werror]
> >    #define EDEADLOCK EDEADLK
> >
> >   In file included from toolchain-powerpc_8540_gcc-8.4.0_musl/include/errno.h:10,
> >                    from libbpf.c:26:
> >   toolchain-powerpc_8540_gcc-8.4.0_musl/include/bits/errno.h:58: note: this is the location of the previous definition
> >    #define EDEADLOCK       58
> >
> >   cc1: all warnings being treated as errors
> >
> > Fixes: 95f28190aa01 ("tools include arch: Grab a copy of errno.h for arch's supported by perf")
> > Fixes: c3617f72036c ("UAPI: (Scripted) Disintegrate arch/powerpc/include/asm")
>
> I suspect that's not the right commit to tag. It just moved errno.h from
> arch/powerpc/include/asm to arch/powerpc/include/uapi/asm. It's content
> was almost identical, and entirely identical as far as EDEADLOCK was
> concerned.
>
> Prior to that the file lived in asm-powerpc/errno.h, eg:
>
> $ git cat-file -p b8b572e1015f^:include/asm-powerpc/errno.h
>
> Before that it was include/asm-ppc64/errno.h, content still the same.
>
> To go back further we'd have to look at the historical git trees, which
> is probably overkill. I'm pretty sure it's always had this problem.
>
> So we should probably drop the Fixes tags and just Cc: stable, that
> means please backport it as far back as possible.

I can see that the two numbers (35 and 58) were consistent across
multiple architectures (i386, m68k, ppc32) up to linux-2.0.1, while
other architectures had two unique numbers (alpha, mips, sparc)
at the time, and sparc had BSD and Solaris compatible numbers
in addition.

In linux-2.0.2, alpha and i386 got changed to use 35 for both,
but the other architectures remained unchanged. All later
architectures followed x86 in using the same number for both.

I foudn a message about tcl breaking at compile time when
it changed:
http://lkml.iu.edu/hypermail/linux/kernel/9607.3/0500.html

The errno man page says they are supposed to be synonyms,
and glibc defines it that way, while musl uses the numbers
from the kernel.

        Arnd
