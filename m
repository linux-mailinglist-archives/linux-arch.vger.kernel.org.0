Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B16583B2B
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jul 2022 11:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiG1JZL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jul 2022 05:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiG1JZK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jul 2022 05:25:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297453A0;
        Thu, 28 Jul 2022 02:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C290560D40;
        Thu, 28 Jul 2022 09:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B391C433D7;
        Thu, 28 Jul 2022 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659000307;
        bh=7pq/2Z60GYWXwFYneAORoRndD27DanVgbiYGcaR6gLk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ffMQFUj302iUtf3No5xdZTKyr38PfuNjv35jUAOBYxbQpNOaYu5z1qie/PPrwudVp
         rbor1vghIWM3G77lJrAH1ar/K9X8EzGnc9e8/UWwcqBQUJClCdBAXm5ooTEhvWwumk
         nqWNMZknE4HIUKhEpEMEaSDf5b46pcxY5XBNcKVtb9D7GXve33Rx3pdiwh9bXodyFe
         XEg3bRfmARBEBSYJiMwKWc/Xd5bITzO99wuWYIPrtYKdWbh4BZVGGcGNj9G+JeF806
         5OBqXWTaqiT/tRN1vGY4LeozcX0cGiLJGgnRmws4Ijuhc3+ZSH82D/StYdeoCaOheq
         jGKkfn69WhEcg==
Received: by mail-vs1-f41.google.com with SMTP id b67so1095886vsc.1;
        Thu, 28 Jul 2022 02:25:07 -0700 (PDT)
X-Gm-Message-State: AJIora/RA0G/X6n9pwf0tjjfkUpCFfFHPThW7eZdpQ+D4nQA07Lj/Ckh
        9KDeIkT09LKsSxyMORsaGskbxZIwsrf2THvXAD8=
X-Google-Smtp-Source: AGRyM1vyH+nsbqzZjGAJ6qBx3wXBi1+dUz0jOf3JsHZ5+CvaVM8g+iopMUmY8qoZiCb4cLiRSfo3Wa34/mRjVsyJuuo=
X-Received: by 2002:a67:d599:0:b0:358:6371:4cfb with SMTP id
 m25-20020a67d599000000b0035863714cfbmr6080587vsj.78.1659000306050; Thu, 28
 Jul 2022 02:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220721130419.1904711-1-chenhuacai@loongson.cn>
 <20220721130419.1904711-4-chenhuacai@loongson.cn> <20220722091604.GD18125@willie-the-truck>
In-Reply-To: <20220722091604.GD18125@willie-the-truck>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 28 Jul 2022 17:24:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7sWvcVCNtzKscnYK5q0+MqdZiuywuy=_7oB7iLN9pQTA@mail.gmail.com>
Message-ID: <CAAhV-H7sWvcVCNtzKscnYK5q0+MqdZiuywuy=_7oB7iLN9pQTA@mail.gmail.com>
Subject: Re: [PATCH V5 3/4] mm/sparse-vmemmap: Generalise vmemmap_populate_hugepages()
To:     Will Deacon <will@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Will,

On Fri, Jul 22, 2022 at 5:16 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jul 21, 2022 at 09:04:18PM +0800, Huacai Chen wrote:
> > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > index 0abcb0a5f1b5..eafd084b8e19 100644
> > --- a/mm/sparse-vmemmap.c
> > +++ b/mm/sparse-vmemmap.c
> > @@ -694,6 +694,69 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
> >       return vmemmap_populate_range(start, end, node, altmap, NULL);
> >  }
> >
> > +void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> > +                                   unsigned long addr, unsigned long next)
> > +{
> > +}
> > +
> > +int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, int node, unsigned long addr,
> > +                                    unsigned long next)
> > +{
> > +     return 0;
> > +}
> > +
> > +int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
> > +                                      int node, struct vmem_altmap *altmap)
> > +{
> > +     unsigned long addr;
> > +     unsigned long next;
> > +     pgd_t *pgd;
> > +     p4d_t *p4d;
> > +     pud_t *pud;
> > +     pmd_t *pmd;
> > +
> > +     for (addr = start; addr < end; addr = next) {
> > +             next = pmd_addr_end(addr, end);
> > +
> > +             pgd = vmemmap_pgd_populate(addr, node);
> > +             if (!pgd)
> > +                     return -ENOMEM;
> > +
> > +             p4d = vmemmap_p4d_populate(pgd, addr, node);
> > +             if (!p4d)
> > +                     return -ENOMEM;
> > +
> > +             pud = vmemmap_pud_populate(p4d, addr, node);
> > +             if (!pud)
> > +                     return -ENOMEM;
> > +
> > +             pmd = pmd_offset(pud, addr);
> > +             if (pmd_none(READ_ONCE(*pmd))) {
> > +                     void *p;
> > +
> > +                     p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> > +                     if (p) {
> > +                             vmemmap_set_pmd(pmd, p, node, addr, next);
> > +                             continue;
> > +                     } else if (altmap) {
> > +                             /*
> > +                              * No fallback: In any case we care about, the
> > +                              * altmap should be reasonably sized and aligned
> > +                              * such that vmemmap_alloc_block_buf() will always
> > +                              * succeed. If there is no more space in the altmap
> > +                              * and we'd have to fallback to PTE (highly unlikely).
>
> Can you tweak the last couple of sentences please, as they don't make sense
> to me? To be specific, I'd suggest replacing:
>
>   "If there is no more space in the altmap and we'd have to fallback to PTE
>   (highly unlikely). That could indicate an altmap-size configuration
>   issue."
>
> with something like:
>
>   "For consistency with the PTE case, return an error here as failure could
>    indicate a configuration issue with the size of the altmap."
>
> With that:
>
> Acked-by: Will Deacon <will@kernel.org>
OK, I will send V5, thanks.

Huacai
>
> Will
