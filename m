Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C3356B605
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jul 2022 11:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbiGHJsO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jul 2022 05:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbiGHJsM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jul 2022 05:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915257E014;
        Fri,  8 Jul 2022 02:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF65D621B3;
        Fri,  8 Jul 2022 09:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42467C341C0;
        Fri,  8 Jul 2022 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657273690;
        bh=jh5gWjN504oG2VIQVhjUJ6awryeK4kG9bLyyFcKUZb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J0mN0kb8BszGexKgP2TR/Konu1FNhSKLfU1dFk8MjbV9m7dxbBYbF7wwZZqxMrDOr
         F2lUZZbiAoibyzsScrc+PqTDnUNQtvqgiIQRLx+9QXwEy71uIlZvZibgVknoklSdR3
         N5ej6+Cm1mxWT82xms9zIjE+kIojLNBIi/syuWuMiojBoq8gL4lbqP2fdR4MIRR5aC
         C3otI4srlob2HKRGqzFgtB+NkDdngWbUpx5Yan/H9nA5wO5bog/qQzNIgkjEnalQT/
         OhQHVVnJ4iu0TKhX6ULYi7/yPg+BKcMgFSIBiwxtrlrtdvCYjxTJwBxwY398mZfvn4
         ctAgmZK0ZrrCw==
Received: by mail-vs1-f49.google.com with SMTP id f68so5959428vsc.11;
        Fri, 08 Jul 2022 02:48:10 -0700 (PDT)
X-Gm-Message-State: AJIora96dsnmFzU0r+taN40ryFlyuRZC2ysrZymnKnUpyGH7oUVmtaS/
        WJe3wZB9wBVMyUjEuyR8DZkolymU3c2KFdgwpDA=
X-Google-Smtp-Source: AGRyM1trh8V62HAkUcCKd0tDx5d1m4TVW3lDdgWUkgyB2uid/kYHUhgnGZyGqTvYMyG8IlCpF+vPKmaWyo2itMFkJxg=
X-Received: by 2002:a05:6102:3543:b0:357:3ae7:bbd0 with SMTP id
 e3-20020a056102354300b003573ae7bbd0mr431000vss.84.1657273689209; Fri, 08 Jul
 2022 02:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220704112526.2492342-1-chenhuacai@loongson.cn>
 <20220704112526.2492342-4-chenhuacai@loongson.cn> <20220705092937.GA552@willie-the-truck>
 <CAAhV-H5r8HDaxt8fkO97in5-eH8X9gokVNervmUWn6km4S0e-w@mail.gmail.com> <20220706161736.GC3204@willie-the-truck>
In-Reply-To: <20220706161736.GC3204@willie-the-truck>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 8 Jul 2022 17:47:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7uY_KiLJRRjj4+8mewcWbuhvC=zDp5VAs03=BLdSMKLw@mail.gmail.com>
Message-ID: <CAAhV-H7uY_KiLJRRjj4+8mewcWbuhvC=zDp5VAs03=BLdSMKLw@mail.gmail.com>
Subject: Re: [PATCH V4 3/4] mm/sparse-vmemmap: Generalise vmemmap_populate_hugepages()
To:     Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>
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
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+Dan Williams
+Sudarshan Rajagopalan

On Thu, Jul 7, 2022 at 12:17 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jul 05, 2022 at 09:07:59PM +0800, Huacai Chen wrote:
> > On Tue, Jul 5, 2022 at 5:29 PM Will Deacon <will@kernel.org> wrote:
> > > On Mon, Jul 04, 2022 at 07:25:25PM +0800, Huacai Chen wrote:
> > > > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > > > index 33e2a1ceee72..6f2e40bb695d 100644
> > > > --- a/mm/sparse-vmemmap.c
> > > > +++ b/mm/sparse-vmemmap.c
> > > > @@ -686,6 +686,60 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
> > > >       return vmemmap_populate_range(start, end, node, altmap, NULL);
> > > >  }
> > > >
> > > > +void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> > > > +                                   unsigned long addr, unsigned long next)
> > > > +{
> > > > +}
> > > > +
> > > > +int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, int node, unsigned long addr,
> > > > +                                    unsigned long next)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
> > > > +                                      int node, struct vmem_altmap *altmap)
> > > > +{
> > > > +     unsigned long addr;
> > > > +     unsigned long next;
> > > > +     pgd_t *pgd;
> > > > +     p4d_t *p4d;
> > > > +     pud_t *pud;
> > > > +     pmd_t *pmd;
> > > > +
> > > > +     for (addr = start; addr < end; addr = next) {
> > > > +             next = pmd_addr_end(addr, end);
> > > > +
> > > > +             pgd = vmemmap_pgd_populate(addr, node);
> > > > +             if (!pgd)
> > > > +                     return -ENOMEM;
> > > > +
> > > > +             p4d = vmemmap_p4d_populate(pgd, addr, node);
> > > > +             if (!p4d)
> > > > +                     return -ENOMEM;
> > > > +
> > > > +             pud = vmemmap_pud_populate(p4d, addr, node);
> > > > +             if (!pud)
> > > > +                     return -ENOMEM;
> > > > +
> > > > +             pmd = pmd_offset(pud, addr);
> > > > +             if (pmd_none(READ_ONCE(*pmd))) {
> > > > +                     void *p;
> > > > +
> > > > +                     p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> > > > +                     if (p) {
> > > > +                             vmemmap_set_pmd(pmd, p, node, addr, next);
> > > > +                             continue;
> > > > +                     } else if (altmap)
> > > > +                             return -ENOMEM; /* no fallback */
> > >
> > > Why do you return -ENOMEM if 'altmap' here? That seems to be different to
> > > what we currently have on arm64 and it's not clear to me why we're happy
> > > with an altmap for the pmd case, but not for the pte case.
> > The generic version is the same as X86. It seems that ARM64 always
> > fallback whether there is an altmap, but X86 only fallback in the no
> > altmap case. I don't know the reason of X86, can Dan Williams give
> > some explaination?
>
> Right, I think we need to understand the new behaviour here before we adopt
> it on arm64.
Hi, Dan,
Could you please tell us the reason? Thanks.

And Sudarshan,
You are the author of adding a fallback mechanism to ARM64,  do you
know why ARM64 is different from X86 (only fallback in no altmap
case)?

Huacai

>
> Will
