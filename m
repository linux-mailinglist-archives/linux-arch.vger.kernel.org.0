Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D192E56150D
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jun 2022 10:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiF3I2S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jun 2022 04:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiF3I2N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jun 2022 04:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BFBBE3;
        Thu, 30 Jun 2022 01:28:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09F7761E54;
        Thu, 30 Jun 2022 08:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB08C341D7;
        Thu, 30 Jun 2022 08:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656577687;
        bh=SkqClHc7drj1TyPDl23yksWfycVYMTWrSPIUHoyfEwE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B7CPMIbhC1C2mpkc3aoWjdmyrIVGqtmC9zFMsPeE1twNFdxgdBwruNn9qlvq8jzmX
         b03vb4SBq2jZqMvhnz6275h/IvCA4d/VfOrPuNA5rzaHdo29eitnlBN1wIs7Nmd0CR
         t0Gkex5Mr/Gtcew15u8uW4194ALBx15jBKU/1NqqQxEExH85aA42xfX63VYP+ugC+i
         j0K069hCdHJbRgrll1Czxbqz5fUNEfMB0Punsrjm2p8Uo5vaZsWTT4nSiLhSEbYU5G
         ZQnWhtgOV9XEzpRWWmolnlYDZNX7CKsEpxY6zkvLG69hHnu/NQy3A4yHfbFmEPM4m7
         Qsg1KIf2WNBPQ==
Received: by mail-vk1-f175.google.com with SMTP id az35so8659846vkb.0;
        Thu, 30 Jun 2022 01:28:07 -0700 (PDT)
X-Gm-Message-State: AJIora+1twvNlHDCHf/sbNpTnBj1PdVCGEnQ2lKvVOzOmkUCAutAaQCk
        2Z7uy5poZ+TEv8OPUgbB3Lg8Do7B+TqwBNf3uBw=
X-Google-Smtp-Source: AGRyM1t6MEV6NE/9g+uMmfb0idguxwxwLsxO+IOwvim6D9NJDdUn8BK07k7k+g6g0DwK3bhD1CtaM6+xNPvZKqjZrrA=
X-Received: by 2002:a1f:2a86:0:b0:370:8ff3:d5f with SMTP id
 q128-20020a1f2a86000000b003708ff30d5fmr3791575vkq.35.1656577686160; Thu, 30
 Jun 2022 01:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220630043237.2059576-1-chenhuacai@loongson.cn>
 <20220630043237.2059576-4-chenhuacai@loongson.cn> <CAK8P3a1f94z4oSnMr73PuiXkMR7uGhthzY_EWVniB+G4KXBcBQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1f94z4oSnMr73PuiXkMR7uGhthzY_EWVniB+G4KXBcBQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 30 Jun 2022 16:27:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5kywXfSLaKRhobqzozOuU0UyEKcOApu3Abz+csCgJPgg@mail.gmail.com>
Message-ID: <CAAhV-H5kywXfSLaKRhobqzozOuU0UyEKcOApu3Abz+csCgJPgg@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] mm/sparse-vmemmap: Generalise vmemmap_populate_hugepages()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Thu, Jun 30, 2022 at 2:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jun 30, 2022 at 6:32 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > From: Feiyang Chen <chenfeiyang@loongson.cn>
> >
> > Generalise vmemmap_populate_hugepages() so ARM64 & X86 & LoongArch can
> > share its implementation.
>
> Sharing this function is good, thanks for consolidating this
>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>
> The Signed-off-by lines are in the wrong order, it should start with the author
> and end with the final submitter.
OK,  I will change the order.

>
> > index 33e2a1ceee72..6f2e40bb695d 100644
> > --- a/mm/sparse-vmemmap.c
> > +++ b/mm/sparse-vmemmap.c
> > @@ -686,6 +686,60 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
> >         return vmemmap_populate_range(start, end, node, altmap, NULL);
> >  }
> >
> > +void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> > +                                     unsigned long addr, unsigned long next)
> > +{
> > +}
> > +
> > +int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, int node, unsigned long addr,
> > +                                      unsigned long next)
> > +{
> > +       return 0;
> > +}
> > +
>
> I think inline functions would be better here, both for compiler optimization
> and to make it easier to track the code flow. The normal way we do these
> in architecture specific headers is to override the functions by defining a
> macro of the same name.
In my opinion, weak functions are suitable for overriding if they are
only used in a single .c file (this case). If we don't use weak
functions, this series needs as many as 4 #ifdefs, for pud_init(),
pmd_init(), vmemmap_set_pmd() and  vmemmap_check_pmd() respectively,
which increase the difficulty of maintain (just my own opinion, maybe
not a objective fact).

Huacai
>
>
>         Arnd
