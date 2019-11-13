Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B88FAA83
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2019 07:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfKMG6N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Nov 2019 01:58:13 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:54831 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfKMG6M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Nov 2019 01:58:12 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id xAD6vw7r003047;
        Wed, 13 Nov 2019 15:57:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com xAD6vw7r003047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573628279;
        bh=byHb37rnBYBfqef4BLf0fmIb0zqlNb4FnaUPBW8GooY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uwXSpZN8NUc3GyzgQBlE4/70/YKIXTmhaJYu2ul5EMO8sXLA0CrZYhqRTAskePU/R
         I8l70R3yGk94gchriFFqfJz3zcYq6JfVM0wtsXimIjPHoxKjjFab7HuyikBw1c7keA
         15toF60dyqTX1NpfM1soQywhewTDMPqrP1syuH5Zi1cr++AWthGUmKRHZoSR/BPcXh
         CmrC/XYd3UZL3qokDCLoPlOHU+mTIoCctXCd4yD+xH1pf5WKdGd91PkwXcueI75q7w
         eHeHe1w558JWLNMjWClw1XQsjQ5opE1BVt7bIwYrKyTeJXGG0q5xvUbat+T1FKUDZ+
         ex3Mg8oqynmVQ==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id k15so679155vsp.2;
        Tue, 12 Nov 2019 22:57:58 -0800 (PST)
X-Gm-Message-State: APjAAAUt+lX8ClEa6Ndi+l9LxVC05BbpLg0pfiDQ2DeLJz1gh2tRlJkY
        PW6ntd04ZKMIQe1JwVe5XrUtTQstxMrpL+kfmKw=
X-Google-Smtp-Source: APXvYqy/e9IEIGGmWIcpr2hzcyiala17nWKMlBf9NB3EjXCxP8HBnYqtvn01Y7Bnd4lHYIXqeViywBoYTW17vz7eukg=
X-Received: by 2002:a67:d31b:: with SMTP id a27mr985586vsj.215.1573628277943;
 Tue, 12 Nov 2019 22:57:57 -0800 (PST)
MIME-Version: 1.0
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com> <20191112123125.GD17835@willie-the-truck>
 <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
 <32a3b660-f4d2-268e-2206-d50073298c0c@iogearbox.net> <CAK7LNASR=R=gyuaMO=VzdXrY3gaQ_FVE4es60bzXf=9ASR2qUw@mail.gmail.com>
 <021e7b46-047e-d381-9dca-bd61db08e4f8@163.com>
In-Reply-To: <021e7b46-047e-d381-9dca-bd61db08e4f8@163.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 13 Nov 2019 15:57:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNARKh3-cAqsYgcxFwq9CGk-CgBfkiQgfNSULkxwO0xa2vw@mail.gmail.com>
Message-ID: <CAK7LNARKh3-cAqsYgcxFwq9CGk-CgBfkiQgfNSULkxwO0xa2vw@mail.gmail.com>
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 13, 2019 at 2:52 PM Xiao Yang <ice_yangxiao@163.com> wrote:
>
> On 11/13/19 1:28 PM, Masahiro Yamada wrote:
> > On Wed, Nov 13, 2019 at 12:13 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >> On 11/12/19 1:50 PM, Masahiro Yamada wrote:
> >>> On Tue, Nov 12, 2019 at 9:31 PM Will Deacon <will@kernel.org> wrote:
> >>>> [+lkml, Masahiro, Alexei and Daniel]
> >>>>
> >>>> On Tue, Nov 12, 2019 at 04:56:39PM +0800, Xiao Yang wrote:
> >>>>> With your patch[1], I alway get the following error when building
> >>>>> tools/bpf:
> >>>> In case people want to reproduce this, my branch is here:
> >>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=lto
> >>>>
> >>>>> ----------------------------------------------------------------------------------
> >>>>>
> >>>>> make -C tools/bpf/
> >>>>> make: Entering directory
> >>>>> '/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf'
> >>>>>
> >>>>> Auto-detecting system features:
> >>>>> ... libbfd: [ on ]
> >>>>> ... disassembler-four-args: [ OFF ]
> >>>>>
> >>>>> CC bpf_jit_disasm.o
> >>>>> CC bpf_dbg.o
> >>>>> In file included from
> >>>>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/uapi/linux/filter.h:9:0,
> >>>>> from
> >>>>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf/bpf_dbg.c:41:
> >>>>> /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/linux/compiler.h:247:24:
> >>>>> fatal error: asm/rwonce.h: No such file or directory
> >>>>> #include <asm/rwonce.h>
> >>>>> ^
> >>>>> compilation terminated.
> >>>>> Makefile:61: recipe for target 'bpf_dbg.o' failed
> >>>>> make: *** [bpf_dbg.o] Error 1
> >>>>> make: *** Waiting for unfinished jobs....
> >>>>> make: Leaving directory
> >>>>>
> >>>>> ----------------------------------------------------------------------------------
> >>>>>
> >>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=lto&id=642a312d47ceb54603630d9d04f5052f3b46d9a3
> >>>>>
> >>>>> It seems that include/linux/compiler.h cannot find the asm/rwonce.h because
> >>>>> tools/bpf/Makefile doesn't include arch/*/include/generated/asm/rwonce.h.
> >>>> The problem with referring to the generated files is that they don't exist
> >>>> unless you've configured the main source directory. The real problem here
> >>>> seems to be that tools/bpf/ refers directly to header files in the kernel
> >>>> sources without any understanding of kbuild, and therefore mandatory-y
> >>>> headers simply don't exist when it goes looking for them.
> >> Hmm, I am puzzled why that is. :/ I think there are two options, i) remove it
> >> from CFLAGS like below (at least this doesn't let the build fail in my case
> >> but requires linux headers to be installed) or ii) add a copy of filter.h to
> >> tools/include/uapi/linux/filter.h so the few tools can just reuse it. We do have
> >> bpf_common.h and bpf.h there already.
> >>
> >> diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
> >> index 5d1995fd369c..08dfd289174c 100644
> >> --- a/tools/bpf/Makefile
> >> +++ b/tools/bpf/Makefile
> >> @@ -10,7 +10,6 @@ MAKE = make
> >>    INSTALL ?= install
> >>
> >>    CFLAGS += -Wall -O2
> >> -CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/include/uapi -I$(srctree)/include
> >>
> >>    # This will work when bpf is built in tools env. where srctree
> >>    # isn't set and when invoked from selftests build, where srctree
> >>
> >
> > I think this is the most sane fix
> > to include the linux/filter.h in the system.
> >
> > (probably, it is located in /usr/include/linux/filter.h)
>
> Hi Masahiro,
>
> Is it correct for include/linux/compiler.h to include <asm/rwonce.h>?


Sorry, I really do not understand what you are doing.

include/linux/compiler.h is only for kernel-space.
Shrug if a user-land program includes it.




> On x86_64 arch, asm/rwonce.h is generated in
> ./arch/x86/include/generated/ directory and compiler.h cannot find it.
>
> Best Regards,
>
> XIao Yang
>
> >
> >
>


-- 
Best Regards
Masahiro Yamada
