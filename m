Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6FA48D4E8
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jan 2022 10:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiAMJUo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jan 2022 04:20:44 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:59653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiAMJUm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jan 2022 04:20:42 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MlfGs-1mgof43AAc-00inrB; Thu, 13 Jan 2022 10:20:41 +0100
Received: by mail-oi1-f180.google.com with SMTP id t9so6843120oie.12;
        Thu, 13 Jan 2022 01:20:40 -0800 (PST)
X-Gm-Message-State: AOAM5309Am4C7Ak8K+4vRYlLmBxjFPE9AZiGxHkmC8EmTg8NLMRwExKO
        imvqyI0gNcE7BFKrk8rGOF/HrPSyXVhwOFJiBuI=
X-Google-Smtp-Source: ABdhPJw9+sCKYhHzyp1SjVHQavgwg3xIxUzgyxX6RsrySwH2wFeDTJ1T3t7YMMfyZxN6MRO8Ewq0Ipi6aU3H326Gjfc=
X-Received: by 2002:a05:6808:148b:: with SMTP id e11mr2473817oiw.84.1642065639264;
 Thu, 13 Jan 2022 01:20:39 -0800 (PST)
MIME-Version: 1.0
References: <Ydm7ReZWQPrbIugn@gmail.com> <CAK8P3a1emGYHPcjTfLqd-yyU8_9w88=2g_B_vfhbKeDtDHMM-w@mail.gmail.com>
 <CAK8P3a3SpYe101RSFD5rzbTQNyQyfG1eb1sCY+rBO-DKVqBdBw@mail.gmail.com> <Yd/idffvv8QIQcEU@gmail.com>
In-Reply-To: <Yd/idffvv8QIQcEU@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Jan 2022 10:20:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3FahVogb3wfbXSaCpnUsRBGmO9M56M+Cay=skc9rUzjw@mail.gmail.com>
Message-ID: <CAK8P3a3FahVogb3wfbXSaCpnUsRBGmO9M56M+Cay=skc9rUzjw@mail.gmail.com>
Subject: Re: [ANNOUNCE] "Fast Kernel Headers" Tree -v2
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EJRNkxkjcNuYS/MNewZ+ngsEukuMG7fye3sHDkyotWrl8QxsgXq
 MbFp3zRlMFtXxdYTOHLFxrbo49+cf2B/qxjJxh/aby7StOeRwVZm5JhYKFf+V6eKWwgdEsK
 jpqW7rLbHOtkuPea5Soh4f088jwDN++Ft+YNjU6jfr22EQNgR0vI1/AyJhU+1gSpOIIogbf
 yiqAiR+xSYEOWRrgJCZmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VeBm1rRsM4c=:xjc1ggGaBB5k8wJtac3JFj
 FZfTXDX60irBPCg1eIJA1cJzH3bjpKootu8z40jR5v9UC8LmHdO4+cXWMQjbV7/V4KWk9Hu7X
 WLoCtMq5vl2yDPZOA6Gd2NoBm8hZRc+EuRozhTNkbx1SGZVf8K9X3OvpdOXm87DfPrvxQxMpG
 YzC8tp1vcwECozZjnpCgTaeqbifFtCbbLpY74xeMlP+VU2QLIRLFgidZLth82gd2mvnQ2H8QQ
 MCOK2XjmiNhxHJZMY4T9uIdwufKg7yoQO8g5aTpgLo2RTs9z6qzpbVvJy/G0PROI7F5mtZrWq
 M4XGKPl22O7xMIgHiVQ/+sHdPdUrhoZq6yEVMpjYbt1heqbYVwtrf2L2TNYcNHZHHY4zBWLA/
 h85tK2Q+cgegCyaF7dIZWwimLlat96qyCJ3pcErKlCHkH5zTCQSLrrs2GQQozgjl4BBisWOf0
 reKkmw+0mQNPv9QMF5OElU5gq4TmpA/Aky5ow3654Kygl7YOc6bT8wo2v0A1IhiHXCzxvKLzp
 /NoKfbtNactDAVam6Wt3SgQL7vZvpr+KLHLHp+/oua9jxbFYT/xwLOtTtWotg+v8nNrQPY8ZF
 vZv34f9gJPwiM66saarApO6OcifKYMmItWvUI7ATDPXkplGFv1S/u8jVBnoY5l3tRNNXPsyCh
 nyexnbjSzDRf7RgHCoCpxSZNQmhMAhyToOxDkBXzD2Nbu1WvT4pKIAp81gEtaeO8/PH136VR1
 ApAb9xdhDyISgZrkAWEQI64Q6DUYfi8/v7KwnW2MI44k1D3sL8qOpcUOWPcpnUOu0PVQcep1a
 SMKrCK0AE7bKKCT2R80gVkcsXmKctQMTXMc3uFdaimXJjvr8rU=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 13, 2022 at 9:27 AM Ingo Molnar <mingo@kernel.org> wrote:
> * Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jan 10, 2022 at 11:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Sat, Jan 8, 2022 at 5:26 PM Ingo Molnar <mingo@kernel.org> wrote:
> > > I've started building randconfig kernels for arm64 and x86, and fixing
> > > up things that come up, a few things I have noticed out so far:
> >
> > I have run into a couple more specific issues:
> >
> > * net/smc/smc_ib.c:824:26: error: implicit declaration of function
> > 'cache_line_size' [-Werror=implicit-function-declaration]
> > cache_line_size is generally provided by linux/cache.h, which includes
> > asm/cache.h.
> > This works on arm64, but not on x86, where asm/cache.h would have to include
> > asm/cpufeature.h, and but it would be good to avoid that because of the implicit
> > linux/percpu.h and linux/bitops.h inclusions. Also, if I add the
> > include, I get this
> > build failure instead: include/linux/smp_types.h:88:33: error:
> > requested alignment '20'
> > is not a positive power of 2
>
> Note that this particular one should be fixed in the WIP branch, which is
> at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers

Ok.

> > * arm64 has a couple of issues around asm/memory.h, linux/mm_types.h and
> > asm/page.h that can cause loops. I think my latest version has it figured
> > out, but there is probably room for optimization.
>
> Yeah, this is like the 5th attempt at finding a robust solution. :-/

It will likely come back in another form when more architectures get
converted then. I'm currently looking at reviving my own metrics scripts
from 2020 to see if I can improve arch/arm64 further, after that I was
planning to look at arch/arm/

> > * There is no general way to get the get_order() definition, other than
> > including asm/page.h from .c files. On arm64, this shows up in a couple
> > of files after the cleanup. Only xtensa and ia64 define their own version
> > of get_order(), and I think we should just remove those and move the
> > generic version to linux/getorder.h, where any file using it can pick it
> > up. For randconfig builds, I had to add asm/page.h to
> > net/xdp/xsk_queue.c, mm/memtest.c and
> > drivers/target/iscsi/iscsi_target_nego.c, after I removed the indirect
> > include from arch/arm64/include/asm/mmu.h in the previous step.
>
> Would including <linux/mm_page_address.h> be sufficient? That already has
> an <asm/page.h> inclusion and is vaguely related.

Sure, works for me.

> I tried to avoid as many low level headers as possible from the main types
> headers - and the get_order() functionality also brings in bitops
> definitions, which I'm still hoping to be able to reduce from its current
> ~95% utilization in a distro kernel ...

Agreed, I think reducing bitops.h and atomic.h usage is fairly important,
I think these are even bigger on arm64 than on x86.

> We could add <linux/page_api.h> as well, as a standardized header. We
> already have page_types.h and et_order() is a page types API.

More generally speaking, do you have a plan for how to document which
header to include for getting a particular symbol that is provided by
a header we don't want to include directly? I think iwyu has a particular
notation for it, but when I looked at using that in 2020 I decided it wouldn't
scale to the size of the kernel. I did my own shell script with a long
list of regex patterns, but I'm not convinced about that approach either.

       Arnd
