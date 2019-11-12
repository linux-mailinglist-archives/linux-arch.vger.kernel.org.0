Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A158F8FF3
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2019 13:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfKLMvT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Nov 2019 07:51:19 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:53981 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfKLMvS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Nov 2019 07:51:18 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id xACCp8Kp030082;
        Tue, 12 Nov 2019 21:51:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com xACCp8Kp030082
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573563069;
        bh=pERbu/D6TsAoFYrJhhErJt2I5IFldM4FmNpzx6W3OhY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hhAwl8VuQ3Yd0T/pN6/IlaZnHDDCkMvn4AkJaBnukC253y9L8B9fG++arcrdl5Z5R
         /9rD9bJPmjSLxO4qwDHCLEV1+DZeFXxu3i2pTz9FzfFEuMpTsZ5NY1K3MvQBvltwM+
         EuM3IMQqTzCGj/Cgeds+eBcPGUtyWxj1+j8IMM6wFlWw7ZidfuOGGAdUtCZdA13bf2
         fdxUCJHu4eK/2YdS1rZHCeYr3wjmX6o/CROPeuUQ5kq1iFGodfCrbDdgRtuMyikDuj
         hNfP1Bi0zXdRSJR15wzOsmWUxaF0G47IS5Fzkm3WNVYy3T96Ijn7eqyHXvZN29ek67
         XKVfuzxXV1s+Q==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id c25so10695270vsp.0;
        Tue, 12 Nov 2019 04:51:08 -0800 (PST)
X-Gm-Message-State: APjAAAUBMt2tRJdM3Qw3Hl3Xo3ar2p6dmK6gXkvCDmY08DTjdi3o0AQC
        ULTuaWkZHeVyN1rAEOyfryjjnCVnXWwyT4/HC84=
X-Google-Smtp-Source: APXvYqyKv1Pax9ObNkX0Q8oo8KGbX362oyxIELZQWqG9wmUAWx11VYikJ/OkCb3aLcrg3/hvdZodvoJImefldmOkHNE=
X-Received: by 2002:a05:6102:726:: with SMTP id u6mr21481694vsg.179.1573563067515;
 Tue, 12 Nov 2019 04:51:07 -0800 (PST)
MIME-Version: 1.0
References: <1da2db04-da6a-cedb-e85a-6ded68dada82@163.com> <20191112123125.GD17835@willie-the-truck>
In-Reply-To: <20191112123125.GD17835@willie-the-truck>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Nov 2019 21:50:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
Message-ID: <CAK7LNARA99UUTY2v6rS=Nb4Cg5pB4RsR0PogLqdT9uNLcH20ew@mail.gmail.com>
Subject: Re: Question about "asm/rwonce.h: No such file or directory"
To:     Will Deacon <will@kernel.org>
Cc:     Xiao Yang <ice_yangxiao@163.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 12, 2019 at 9:31 PM Will Deacon <will@kernel.org> wrote:
>
> [+lkml, Masahiro, Alexei and Daniel]
>
> On Tue, Nov 12, 2019 at 04:56:39PM +0800, Xiao Yang wrote:
> > With your patch[1], I alway get the following error when building
> > tools/bpf:
>
> In case people want to reproduce this, my branch is here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=lto
>
> > ----------------------------------------------------------------------------------
> >
> > make -C tools/bpf/
> > make: Entering directory
> > '/usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf'
> >
> > Auto-detecting system features:
> > ... libbfd: [ on ]
> > ... disassembler-four-args: [ OFF ]
> >
> > CC bpf_jit_disasm.o
> > CC bpf_dbg.o
> > In file included from
> > /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/uapi/linux/filter.h:9:0,
> > from
> > /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/tools/bpf/bpf_dbg.c:41:
> > /usr/src/perf_selftests-x86_64-rhel-7.6-642a312d47ceb54603630d9d04f5052f3b46d9a3/include/linux/compiler.h:247:24:
> > fatal error: asm/rwonce.h: No such file or directory
> > #include <asm/rwonce.h>
> > ^
> > compilation terminated.
> > Makefile:61: recipe for target 'bpf_dbg.o' failed
> > make: *** [bpf_dbg.o] Error 1
> > make: *** Waiting for unfinished jobs....
> > make: Leaving directory
> >
> > ----------------------------------------------------------------------------------
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=lto&id=642a312d47ceb54603630d9d04f5052f3b46d9a3
> >
> > It seems that include/linux/compiler.h cannot find the asm/rwonce.h because
> > tools/bpf/Makefile doesn't include arch/*/include/generated/asm/rwonce.h.
>
> The problem with referring to the generated files is that they don't exist
> unless you've configured the main source directory. The real problem here
> seems to be that tools/bpf/ refers directly to header files in the kernel
> sources without any understanding of kbuild, and therefore mandatory-y
> headers simply don't exist when it goes looking for them.

Please note tools/ is out of scope of Kbuild.
The tools/ created a completely different build system.


tools/bpf/ looks like a host program.
Does it include a kernel-space header
of the target architecture?

I see a lots of header duplication in tools/include/,
but I am not sure if
tools/include/linux/filter.h is the correct header
to include.



>
> Perhaps it's possible to introduce a dependency on a top-level "make
> asm-generic" so that we can reference the generated headers from the arch
> directly. Thoughts?
>
> Will


-- 
Best Regards
Masahiro Yamada
