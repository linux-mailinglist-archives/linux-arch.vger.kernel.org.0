Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19547550F6A
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 06:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiFTE06 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 00:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiFTE05 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 00:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3463263E1
        for <linux-arch@vger.kernel.org>; Sun, 19 Jun 2022 21:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B77BC6100C
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 04:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6D4C341C7
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 04:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655699216;
        bh=OAthta1phLKkQIKQW9+J+eds3olo6VBueIgwDcoHNwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FrzhF+9UTHmUMgHjqx/dRyRX9v4jSHYXTV6rgRGubVNnp/9PIz/LEzY1GHDoYwMCT
         FWDUTQ1Haww04lDAalm0aAREZQK6+7tuMes3kf//vRJK8UIi69sKIDcpoj2eGceSwL
         SxcB4IUOq0DUBUQuy6pCKC0B3TaGlHr1DeEpBbsCVtq9hBwcp+KuZM2kAxCxQiRJyK
         RtShmDPVnQf/ElkbcDvgUxzgyDqqvUGkfOt4HLHYWgP833UzvQn+jhIb78izB/dblP
         Ybw8i92I0afUvL/BAMbt+uYooaP6VodJHDOQZ3JLzfl05BO6neUMKNhXMax558Fz1C
         Mu4z1XKOHyN7Q==
Received: by mail-lf1-f42.google.com with SMTP id w20so15269666lfa.11
        for <linux-arch@vger.kernel.org>; Sun, 19 Jun 2022 21:26:56 -0700 (PDT)
X-Gm-Message-State: AJIora9I0EQIsCBXJpAPhx7chgfsu6I/xt3oT0IZOnYYKLZED9blCqE4
        lyihHIkhS3oNoRdZK+BAdodybSrXg1+Kf+5YTSU=
X-Google-Smtp-Source: AGRyM1uYyyQjf9Decjv0WPr7mJzVYnU+TOsVlPnJvM4Za2MdmoVcQWzOB7ITLBdGYmYg7Kh2IT1KTqP3MSGzl+OkCHc=
X-Received: by 2002:a05:6512:258a:b0:47d:bb62:910f with SMTP id
 bf10-20020a056512258a00b0047dbb62910fmr12198749lfb.447.1655699214150; Sun, 19
 Jun 2022 21:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145828.582117-1-chenhuacai@loongson.cn>
 <CAHirt9hRs_iTvAZ=UxBBK448j7p+pYxKsMVise=Jj2qCtNky2Q@mail.gmail.com>
 <CAAhV-H4=04qygAFqm36RBM-ktXhO7M8HMBeCPBOnB8xYz268Zw@mail.gmail.com> <94bebe28-5988-d6b6-bf82-03ef5901cd69@xen0n.name>
In-Reply-To: <94bebe28-5988-d6b6-bf82-03ef5901cd69@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 20 Jun 2022 12:26:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4-=T5hA1UwFq2uN=PU0L9KV9jU9jkDQh9UuyyuUr=zEQ@mail.gmail.com>
Message-ID: <CAAhV-H4-=T5hA1UwFq2uN=PU0L9KV9jU9jkDQh9UuyyuUr=zEQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add vDSO syscall __vdso_getcpu()
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     hev <r@hev.cc>, Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

On Sat, Jun 18, 2022 at 8:56 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 6/18/22 17:10, Huacai Chen wrote:
> > Hi,
> >
> > On Fri, Jun 17, 2022 at 11:35 PM hev <r@hev.cc> wrote:
> >> Hello,
> >>
> >> On Fri, Jun 17, 2022 at 10:57 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >>> We test 20 million times of getcpu(), the real syscall version take 25
> >>> seconds, while the vsyscall version take only 2.4 seconds.
> >>>
> >>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>> ---
> >>>   arch/loongarch/include/asm/vdso.h      |  4 +++
> >>>   arch/loongarch/include/asm/vdso/vdso.h | 10 +++++-
> >>>   arch/loongarch/kernel/vdso.c           | 23 +++++++++-----
> >>>   arch/loongarch/vdso/Makefile           |  3 +-
> >>>   arch/loongarch/vdso/vdso.lds.S         |  1 +
> >>>   arch/loongarch/vdso/vgetcpu.c          | 43 ++++++++++++++++++++++++++
> >>>   6 files changed, 74 insertions(+), 10 deletions(-)
> >>>   create mode 100644 arch/loongarch/vdso/vgetcpu.c
> >>>
> >>> diff --git a/arch/loongarch/include/asm/vdso.h b/arch/loongarch/include/asm/vdso.h
> >>> index 8f8a0f9a4953..e76d5e37480d 100644
> >>> --- a/arch/loongarch/include/asm/vdso.h
> >>> +++ b/arch/loongarch/include/asm/vdso.h
> >>> @@ -12,6 +12,10 @@
> >>>
> >>>   #include <asm/barrier.h>
> >>>
> >>> +typedef struct vdso_pcpu_data {
> >>> +       u32 node;
> >>> +} ____cacheline_aligned_in_smp vdso_pcpu_data;
> >>> +
> >>>   /*
> >>>    * struct loongarch_vdso_info - Details of a VDSO image.
> >>>    * @vdso: Pointer to VDSO image (page-aligned).
> >>> diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/asm/vdso/vdso.h
> >>> index 5a01643a65b3..94055f7c54b7 100644
> >>> --- a/arch/loongarch/include/asm/vdso/vdso.h
> >>> +++ b/arch/loongarch/include/asm/vdso/vdso.h
> >>> @@ -8,6 +8,13 @@
> >>>
> >>>   #include <asm/asm.h>
> >>>   #include <asm/page.h>
> >>> +#include <asm/vdso.h>
> >>> +
> >>> +#if PAGE_SIZE < SZ_16K
> >>> +#define VDSO_DATA_SIZE SZ_16K
> >> Whether we add members to the vdso data structure or extend
> >> SMP_CACHE_BYTES/NR_CPUS, the static VDSO_DATA_SIZE may not match, and
> >> there is no assertion checking to help us catch bugs early. So I
> >> suggest defining VDSO_DATA_SIZE as ALIGN_UP(sizeof (struct vdso_data),
> >> PAGE_SIZE).
> > VSYSCALL usage is very limited (you know, VSYSCALL appears for so many
> > years, but the number nearly doesn't increase until now), so I think
> > 16KB is enough in the future.
>
> I don't think omitting compile-time assertions for *correctness* is
> worth the negligible improvement in brevity and ease of maintenance. In
> fact, static checks for correctness actually *lightens* maintenance
> burden, by explicitly calling out the assumptions so that newcomers
> (i.e. me or some other random linux/arch developer refactoring code)
> would find them very helpful.
>
> So I'm in support for declaring the VDSO_DATA_SIZE explicitly in terms
> of sizeof(struct vdso_data) and PAGE_SIZE.
I'll use hev's method, thank you.

Huacai
