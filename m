Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C43C3212D3
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2019 06:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfEQEY4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 May 2019 00:24:56 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:49060 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfEQEY4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 May 2019 00:24:56 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x4H4OW2a016993;
        Fri, 17 May 2019 13:24:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x4H4OW2a016993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558067073;
        bh=XSdURHr+DFj73XgjlE8DVqoSorih7QO9jSg+HW1D8TM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MjmYEj/7xZIYGboJToCEBgv5PN/8CD6sDWZgip2cIfkO7e3Ii9sfP5C3OkJ+w+bmf
         nV6cmWzKaBSSjsZhyrn4bys5Y4Q6I+OEw7Kw5shBSlS1idFvlydMF1XAeStprazHXe
         YEbmOvO03hshhgHZXMzPoXOKrUM23BsqSOjE9eL/rkptHR8OUhQKwyp/IklD0+/Dl9
         owyazsPp24tpqnpga80RjHHMgFR00FgPaqDWKyOVGScKcv6zoiLl/Anuo6IiuxTxjf
         qbtJQzYFIsrlK27Oe+MJKRLUUuHhjaC4kJm7cNQh1CbYjHyDzVm4085SMLX6fx2uBd
         H18+0yFykqaGg==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id o10so3750740vsp.12;
        Thu, 16 May 2019 21:24:32 -0700 (PDT)
X-Gm-Message-State: APjAAAUM7tMr8SHSizjNRn02KJyzLHVXpwOUD1M81+T2t10lCH1GD3ZS
        gOrlhGZjT2w8LXvKFSaC90rpzIRamTE26OnpgKU=
X-Google-Smtp-Source: APXvYqwRom2nfToM4jL1gKybhnXBZPLM/8GRypEcR2drcSxkNBd5y+Id9rfE+eiIpAnAfm5gkg5AbPeOHdYPagE+d9M=
X-Received: by 2002:a67:ad0f:: with SMTP id t15mr7896301vsl.179.1558067071748;
 Thu, 16 May 2019 21:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
 <20190423034959.13525-5-yamada.masahiro@socionext.com> <aa73f81d-5d5a-a1d2-5239-3e8eb1278ec4@redhat.com>
In-Reply-To: <aa73f81d-5d5a-a1d2-5239-3e8eb1278ec4@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 17 May 2019 13:23:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAST5y9Khg0BBz6W0mekPpuLPwWa9nPvvVENidWhHZ-avw@mail.gmail.com>
Message-ID: <CAK7LNAST5y9Khg0BBz6W0mekPpuLPwWa9nPvvVENidWhHZ-avw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 04/11] s390/cpacf: mark scpacf_query() as __always_inline
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mathieu Malaterre <malat@debian.org>, X86 ML <x86@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 17, 2019 at 8:01 AM Laura Abbott <labbott@redhat.com> wrote:
>
> On 4/22/19 8:49 PM, Masahiro Yamada wrote:
> > This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> > place. We need to eliminate potential issues beforehand.
> >
> > If it is enabled for s390, the following error is reported:
> >
> > In file included from arch/s390/crypto/des_s390.c:19:
> > ./arch/s390/include/asm/cpacf.h: In function 'cpacf_query':
> > ./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably doesn't match constraints
> >    asm volatile(
> >    ^~~
> > ./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'asm'
> >
>
> This also seems to still be broken, again with gcc 9.1.1
>
> BUILDSTDERR: In file included from arch/s390/crypto/prng.c:29:
> BUILDSTDERR: ./arch/s390/include/asm/cpacf.h: In function 'cpacf_query_func':
> BUILDSTDERR: ./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably doesn't match constraints
> BUILDSTDERR:   170 |  asm volatile(
> BUILDSTDERR:       |  ^~~
> BUILDSTDERR: ./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'asm'
>
> I realized we're still carrying a patch to add -fno-section-anchors
> but it's a similar failure to powerpc.


Christophe had already pointed out potential issues for "i" constraint,
and I have fixups in hand:

See
https://lkml.org/lkml/2019/5/3/459


My plan was to send it after all of my base patches
were merged.

This s390 cparf.h is included in the TODO list.

Will fix soon.

Thanks.

-- 
Best Regards
Masahiro Yamada
